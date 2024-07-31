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

				<legend class="h2"> Balance </legend>

				<%
				try {
					String sqlQuery = "SELECT ACCOUNT_NUMBER FROM user_table WHERE user_id = ?";

					PreparedStatement ps = con.prepareStatement(sqlQuery);
					ps.setString(1, user_id);

					ResultSet rs = ps.executeQuery();

					if (rs.next()) {
						request.setAttribute("account_number", rs.getString("account_number"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				%>
				<form action="" method="post">
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



					<div class="text-center mt-4">
						<input type="submit" class="btn btn-primary" value="Submit"
							id="button" /> <a href="index.jsp"
							class="btn btn-primary text-white" id="button">Home</a>

					</div>

				</form>

				<div class="mt-5 d-flex justify-content-center">
					<%
					if (request.getMethod().equalsIgnoreCase("post")) {
						String accountno = request.getParameter("account_number");
						try {

							PreparedStatement ps = con.prepareStatement(
							"SELECT * FROM amount_deposit LEFT JOIN account_creation_new ON 								amount_deposit.account_number = account_creation_new.account_number WHERE 								amount_deposit.account_number=? ");
							ps.setString(1, accountno);
							ResultSet rs = ps.executeQuery();

							if (rs.next()) {
					%>
					<div>

						<h5>
							Account Number:
							<%=rs.getString("account_number")%></h5>
						<h5>
							Name:
							<%=rs.getString("first_name")%>
							<%=rs.getString("middle_name")%>
							<%=rs.getString("last_name")%></h5>
						<h5>
							Your Current Balance: &#x20B9;
							<%=rs.getString("amount")%>.00
						</h5>
					</div>

					<%
					} else {
					out.println("<p>No data found for the specified account number.</p>");
					}

					} catch (SQLException e) {
					out.println("Error executing SQL query: " + e.getMessage());
					}
					} else {
					}
					%>
				</div>


			</fieldset>
		</div>


		<div class="bg-light">
			<fieldset class="mt-5 p-5">
				<legend class="h2"> Statement </legend>
				<%
				try {
					String sqlQuery = "SELECT ACCOUNT_NUMBER FROM user_table WHERE user_id = ?";

					PreparedStatement ps = con.prepareStatement(sqlQuery);
					ps.setString(1, user_id);

					ResultSet rs = ps.executeQuery();

					if (rs.next()) {
						request.setAttribute("account_number", rs.getString("account_number"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				%>
				<form action="" method="get">
					<div class="row d-flex justify-content-center">
						<div class="col-lg-3 col-md-4 col-sm-12">Please Confirm Your
							Account Number:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5>${requestScope.account_number }</h5></label> <input
								type="hidden" name="accountNumber" id="accountNumber"
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
					<div class="text-center mt-3 mb-5">
						<input type="submit" class="btn btn-primary" value="Submit"
							id="button" /> <a href="index.jsp"
							class="btn btn-primary text-white" id="button">Home</a>

					</div>
				</form>
				<%
    if (request.getMethod().equalsIgnoreCase("get")) {
        String accNumber = request.getParameter("accountNumber");
        String accType = request.getParameter("account_type");

        if (accNumber != null && !accNumber.isEmpty()) {
            try {

                PreparedStatement ps = con.prepareStatement("SELECT * FROM transaction_table "
                    + "LEFT JOIN amount_deposit ON transaction_table.account_number = amount_deposit.account_number "
                    + "LEFT JOIN user_table ON amount_deposit.account_number = user_table.account_number "
                    + "WHERE transaction_table.account_number=?");
                ps.setString(1, accNumber);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    out.println("<div class='row'>");
                    out.println("<div class='col-lg-4 col-md-4 col-sm-12'>");
                    out.println("<h5>Acc No.: " + rs.getString("account_number") + "</h5>");
                    out.println("</div>");
                    out.println("<div class='col-lg-4 col-md-4 col-sm-12 text-center'>");
                    out.println("<h5>Name: " + rs.getString("name") + "</h5>");
                    out.println("</div>");

                    out.println("<div class='col-lg-4 col-md-4 col-sm-12 text-right'>");
                    out.println("<h5>Balance: &#x20B9;" + rs.getString("amount") + "</h5>");
                    out.println("</div>");

                    out.println("</div> <br />");
                    out.println("<div>");

                    int transaction_id = 1;

                    out.println("<table class='table table-bordered table-stripped table-center'>"
                            + "<thead class='table bg-primary text-white'><tr><th>Transaction ID</th><th>Date</th><th>Transaction Reference</th><th>Credit</th><th>Debit</th><th>Balance</th></tr></thead>"
                            + "<tbody>");

                    do {
                        out.println("<tr><td>" + transaction_id + "</td>");
                        out.println("<td>" + rs.getString("transaction_date") + "</td>");
                        out.println("<td>" + rs.getString("transaction_reference") + "</td>");
                        out.println("<td>" + rs.getString("credit") + "</td>");
                        out.println("<td>" + rs.getString("debit") + "</td>");
                        out.println("<td>" + rs.getString("balance") + "</td></tr>");
                        transaction_id++;
                    } while (rs.next());

                    out.println("</tbody></table>");
                    out.println("</div>");

                } else {
                    out.println("<p>No transactions found for the specified account number.</p>");
                }

            } catch (SQLException e) {
                out.println("Error: " + e);
            } finally {
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
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
