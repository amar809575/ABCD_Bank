<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="ABCD_Bank.DatabaseConnect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ABCD Bank</title>
<style>
#button {
	transition: transform 0.3s ease, color 0.3s ease;
}

#button:hover {
	transform: scale(1.1);
	background-color: #0d6efd;
}
</style>
</head>
<body
	style="background: -webkit-linear-gradient(left, #0072ff, #00c6ff);">
	<%@ include file="header.jsp"%>
	<div class="container mb-5">

		<%
        session = request.getSession(false);
                if (session != null && session.getAttribute("user_id") != null) {
                    String user_id = (String) session.getAttribute("user_id");
                    String name = (String) session.getAttribute("name");
                    
                    DatabaseConnect database = new DatabaseConnect();
                    Connection con = database.getCon();
        %>

		<div class="bg-light">
			<fieldset class="mt-5 p-5">

				<legend class="mt-3" Style="font-size: 35px; font-weight: 500;">
					Deposit </legend>
				<%
try {
	String sqlQuery = "SELECT ACCOUNT_NUMBER FROM user_table WHERE user_id = ?";
	
	PreparedStatement ps =  con.prepareStatement(sqlQuery);
	ps.setString(1, user_id);
	
	ResultSet rs = ps.executeQuery();
	
	if(rs.next()) {
		request.setAttribute("account_number", rs.getString("ACCOUNT_NUMBER"));
	}
} catch (SQLException e) {
	e.printStackTrace();
}

%>

				<form action="" method="get" class="mb-4">
					<div class="row d-flex justify-content-center">
						<div class="col-lg-3 col-md-4 col-sm-12">Please Confirm Your
							Account Number:</div>


						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5>${requestScope.account_number }</h5></label> <input
								type="hidden" name="account_number" id="account_number"
								class="form-control" value="${requestScope.account_number }"
								required />
						</div>

					</div>

					<div class="row mt-3 d-flex justify-content-center">
						<div class="col-lg-3 col-md-4 col-sm-12">Account Type:</div>

						<div class="col-lg-6 col-md-8 col-sm-12">
							<select class="form-select form-control" id="account_type"
								name="account_type">
								<option>Select Account Type</option>
								<option value="Current Account">Current Account</option>
								<option value="Savings Account">Savings Account</option>
								<option value="Fixed Account">Fixed Account</option>
							</select>
						</div>

					</div>

					<div class="row d-flex justify-content-center mt-3">
						<div class="col-lg-3 col-md-4 col-sm-12">Enter Amount :</div>

						<div class="col-lg-6 col-md-8 col-sm-12">
							<input type="text" name="amount" id="amount" class="form-control"
								required />
						</div>

					</div>


					<div class="row d-flex justify-content-center mt-3">
						<div class="col-lg-3 col-md-4 col-sm-12">Select Deposit
							Method:</div>

						<div class="col-lg-6 col-md-8 col-sm-12">
							<select id="depositMethod" class="form-select form-control"
								name="depositMethod" required>
								<option value="">Select Method</option>
								<option value="Cash">Cash</option>
								<option value="Check">Check</option>
								<option value="Online">Online</option>
							</select>
						</div>

					</div>

					<div class="text-center mt-3">
						<input type="submit" class="btn btn-primary" value="Submit"
							id="button" /> <a href="index.jsp"
							class="btn btn-primary text-white" id="button">Home</a>
					</div>
				</form>
				
				<%
if (request.getMethod().equalsIgnoreCase("get")) {
    String accNumber = request.getParameter("account_number");
    String accType = request.getParameter("account_type");
    String amount = request.getParameter("amount");
    String depositMethod = request.getParameter("depositMethod");

    try {
        String selectAccountQuery = "SELECT ACCOUNT_TYPE FROM account_creation_new WHERE ACCOUNT_NUMBER=? AND ACCOUNT_TYPE=?";
        try (PreparedStatement psSelectAccount = con.prepareStatement(selectAccountQuery)) {
            psSelectAccount.setString(1, accNumber);
            psSelectAccount.setString(2, accType);
            try (ResultSet rsAccount = psSelectAccount.executeQuery()) {
                if (rsAccount.next()) {
                    String selectAmountQuery = "SELECT * FROM amount_deposit WHERE ACCOUNT_NUMBER=?";
                    try (PreparedStatement psSelectAmount = con.prepareStatement(selectAmountQuery)) {
                        psSelectAmount.setString(1, accNumber);
                        try (ResultSet rsAmount = psSelectAmount.executeQuery()) {
                            String sql;
                            if (rsAmount.next()) {
                                Double currentBalance = rsAmount.getDouble("amount");
                                sql = "UPDATE amount_deposit SET AMOUNT = AMOUNT + ?, updated_at=NOW() WHERE account_number = ?";
                            
                                try (PreparedStatement psUpdateAmount = con.prepareStatement(sql)) {
                                    double newAmount = Double.parseDouble(amount);
                                    psUpdateAmount.setDouble(1, newAmount);
                                    psUpdateAmount.setString(2, accNumber);
                                    int rowsAffected = psUpdateAmount.executeUpdate();
                                    if (rowsAffected > 0) {
                                        out.println("<h2>Amount updated successfully</h2>");

                                        String insertTransactionQuery = "INSERT INTO transaction_table (ACCOUNT_NUMBER, TRANSACTION_DATE, TRANSACTION_REFERENCE, CREDIT, DEBIT, BALANCE) VALUES (?, NOW(), ?, ?, ?, ?)";
                                        try (PreparedStatement psInsertTransaction = con.prepareStatement(insertTransactionQuery)) {
                                            psInsertTransaction.setString(1, accNumber);
                                            psInsertTransaction.setString(2, "Deposit - " + depositMethod);
                                            psInsertTransaction.setDouble(3, newAmount);
                                            psInsertTransaction.setDouble(4, 0);
                                            psInsertTransaction.setDouble(5, currentBalance + newAmount);
                                            psInsertTransaction.executeUpdate();
                                        }
                                    }
                                }
                            } else {
                                sql = "INSERT INTO amount_deposit (ACCOUNT_NUMBER, AMOUNT, UPDATED_AT) VALUES (?, ?, NOW())";
                            
                                try (PreparedStatement psUpdateAmount = con.prepareStatement(sql)) {
                                    double newAmount = Double.parseDouble(amount);
                                    psUpdateAmount.setString(1, accNumber);
                                    psUpdateAmount.setDouble(2, newAmount);
                                    int rowsAffected = psUpdateAmount.executeUpdate();
                                    if (rowsAffected > 0) {
                                        out.println("<h2>Amount inserted successfully</h2>");

                                        String insertTransactionQuery = "INSERT INTO transaction_table (ACCOUNT_NUMBER, TRANSACTION_DATE, TRANSACTION_REFERENCE, CREDIT, DEBIT, BALANCE) VALUES (?, NOW(), ?, ?, ?, ?)";
                                        try (PreparedStatement psInsertTransaction = con.prepareStatement(insertTransactionQuery)) {
                                            psInsertTransaction.setString(1, accNumber);
                                            psInsertTransaction.setString(2, "Deposit - " + depositMethod);
                                            psInsertTransaction.setDouble(3, Double.parseDouble(amount));
                                            psInsertTransaction.setDouble(4, 0);
                                            psInsertTransaction.setDouble(5, newAmount);
                                            psInsertTransaction.executeUpdate();
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                }
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
        out.println("<h2>Error: Unable to insert/update amount.</h2>");
        out.println(ex);
    } catch (NumberFormatException ex) {
        out.println("<h2>Error: Invalid amount format.</h2>");
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("<h2>Error: An unexpected error occurred.</h2>");
        out.println(ex);
    }
}
%>
				
			</fieldset>
		</div>

		

		<%
        } else {
        %>
		<div class="d-flex justify-content-center mt-5">
			<h2 class="mt-5">Your Session Expired. Please login again</h2>
		</div>
		<%
        }
        %>
	</div>

	<%@ include file="footer.html"%>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
