<%@ page import="java.sql.*"%>
<%@ page import="ABCD_Bank.DatabaseConnect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ABCD Bank</title>
<style type="text/css">
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
				<legend>
					<h2 class="mt-3">Amount Withdraw</h2>
				</legend>
				<%
				try {
					String sqlQuery = "SELECT ACCOUNT_NUMBER FROM user_table WHERE user_id = ?";
					
					PreparedStatement ps = con.prepareStatement(sqlQuery);
					ps.setString(1, user_id);
					
					ResultSet rs = ps.executeQuery();
					
					if(rs.next()) {
						request.setAttribute("account_number", rs.getString("account_number"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				%>
				<form method="post">
					<div class="row d-flex justify-content-center">
						<div class="col-lg-3 col-md-4 col-sm-12">Please Confirm Your
							Account Number:</div>

						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5><%= request.getAttribute("account_number") %></h5></label>
							<input type="hidden" name="account_number" id="account_number"
								class="form-control"
								value="<%= request.getAttribute("account_number") %>" required />
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
						<div class="col-lg-3 col-md-4 col-sm-12">Select Withdraw
							Method:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<select id="depositMethod" class="form-select form-control"
								name="depositMethod" required>
								<option value="">Select Method</option>
								<option value="Cash">Cash</option>
								<option value="ATM">ATM</option>
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
				if (request.getMethod().equalsIgnoreCase("post")) {
					String accNumber = request.getParameter("account_number");
					String accType = request.getParameter("account_type");
					String amount = request.getParameter("amount");
					String withdrawMethod = request.getParameter("depositMethod");

					PreparedStatement ps = null;
					ResultSet rs = null;
					try {
						ps = con.prepareStatement("SELECT account_type FROM account_creation_new WHERE account_number=? AND account_type=?");
						ps.setString(1, accNumber);
						ps.setString(2, accType);
						rs = ps.executeQuery();

						if (rs.next()) {
							double withdrawalAmount = Double.parseDouble(amount);
							PreparedStatement balancePs = con
									.prepareStatement("SELECT amount FROM amount_deposit WHERE account_number = ?");
							balancePs.setString(1, accNumber);
							ResultSet balanceRs = balancePs.executeQuery();

							if (balanceRs.next()) {
								double currentBalance = balanceRs.getDouble("amount");

								if (currentBalance >= withdrawalAmount) {
									double newBalance = currentBalance - withdrawalAmount;
									PreparedStatement updatePs = con
											.prepareStatement("UPDATE amount_deposit SET amount = ? WHERE account_number = ?");
									updatePs.setDouble(1, newBalance);
									updatePs.setString(2, accNumber);
									int affectedRows = updatePs.executeUpdate();
									
									if(affectedRows > 0) {
										PreparedStatement insertTransactionPs = con.prepareStatement(
											"INSERT INTO transaction_table (account_number, transaction_date, transaction_reference, credit, debit, balance) VALUES (?, NOW(), ?, ?, ?, ?)");
										insertTransactionPs.setString(1, accNumber);
										insertTransactionPs.setString(2, "Withdrawal - " + withdrawMethod);
										insertTransactionPs.setDouble(3, 0);
										insertTransactionPs.setDouble(4, withdrawalAmount);
										insertTransactionPs.setDouble(5, newBalance);
										insertTransactionPs.executeUpdate();

										out.println("<h2>Withdrawal successful!</h2>");
									}
								} else {
									out.println("<h2>Error: Insufficient balance.</h2>");
								}
							} else {
								out.println("<h2>Error: Account number not found.</h2>");
							}
						} else {
							out.println("<h2>Error: Account number or type does not match.</h2>");
						}
					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						try {
							if (rs != null)
								rs.close();
							if (ps != null)
								ps.close();
							if (con != null)
								con.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
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
