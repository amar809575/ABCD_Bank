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

#closeAccountBtn {
	transition: transform 0.3s ease, color 0.3s ease;
}

#closeAccountBtn:hover {
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
					<h2 class="mt-3">Please confirm you details before Closing
						Account</h2>
				</legend>

				<%
				try {
					String sqlQuery = "SELECT ACCOUNT_NUMBER FROM user_table WHERE user_id = ?";

					PreparedStatement ps = con.prepareStatement(sqlQuery);
					ps.setString(1, user_id);

					ResultSet rs = ps.executeQuery();

					if (rs.next()) {
						String accNumber = rs.getString("account_number");
						String sql = "Select * from account_creation_new where ACCOUNT_NUMBER = ?";

						ps = con.prepareStatement(sql);
						ps.setString(1, accNumber);

						ResultSet rs1 = ps.executeQuery();

						if (rs1.next()) {
					request.setAttribute("account_number", accNumber);
					request.setAttribute("name", rs1.getString("first_name") + " " + rs1.getString("middle_name") + " "
							+ rs1.getString("last_name"));
					request.setAttribute("email", rs1.getString("email"));
					request.setAttribute("phone1", rs1.getString("phone_number"));

						}
						String balanceQuery = "SELECT * FROM amount_deposit WHERE ACCOUNT_NUMBER = ?";
						ps = con.prepareStatement(balanceQuery);
						ps.setString(1, accNumber);
						ResultSet balanceRS = ps.executeQuery();

						if (balanceRS.next()) {
					request.setAttribute("currentBalance", balanceRS.getDouble("amount"));
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				%>

				<form action="CloseAccountServlet" method="post"
					id="closeAccountForm">

					<div class="row d-flex justify-content-center">
						<div class="col-lg-4 col-md-4 col-sm-12">Account Number:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5>${requestScope.account_number }</h5></label> <input
								type="hidden" name="accNumber"
								value="${requestScope.account_number}" />
						</div>
					</div>




					<div class="row mt-3  d-flex justify-content-center">
						<div class="col-lg-4 col-md-4 col-sm-12">Full Name:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5>${requestScope.name }</h5></label>
						</div>
					</div>

					<div class="row mt-3 d-flex justify-content-center">
						<div class="col-lg-4 col-md-4 col-sm-12">Email:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5>${requestScope.email }</h5></label>
						</div>
					</div>

					<div class="row mt-3 d-flex justify-content-center">
						<div class="col-lg-4 col-md-4 col-sm-12">Phone Number:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5>${requestScope.phone1 }</h5></label>
						</div>
					</div>

					<div class="row mt-3 d-flex justify-content-center">
						<div class="col-lg-4 col-md-4 col-sm-12">Current Balance:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5 id="balance">${requestScope.currentBalance }</h5></label>
						</div>
					</div>

					<div class="mt-3 text-center">
						<span class="text-danger" id="btnInfo"></span>
					</div>

					<div class="text-center mt-4">
						<input type="submit" class="btn btn-primary" id="closeAccountBtn"
							value="Close Account" onclick="return confirmCloseAccount();" />
						<a href="index.jsp" class="btn btn-primary text-white" id="button">Home</a>

					</div>
				</form>

				<script>
					function confirmCloseAccount() {
						return confirm("Are you sure you want to close your account");
					}

					document
							.addEventListener(
									"DOMContentLoaded",
									function() {
										var balanceElement = document
												.getElementById("balance");
										var closeAccountBtn = document
												.getElementById("closeAccountBtn");
										var btnInfo = document
												.getElementById("btnInfo");
										var balance = parseFloat(balanceElement.innerText
												.trim());

										console.log("Parsed balance:", balance);

										if (isNaN(balance) || balance !== 0) {
											closeAccountBtn.disabled = true;
											closeAccountBtn.style.cursor = "no-drop";
											btnInfo.innerHTML = "Your current balance is not zero, so the account cannot be closed. Please withdraw you total amount, to withdraw <a href='withdraw.jsp'>Click Here </a>.";
										} else {
											closeAccountBtn.disabled = false;
											closeAccountBtn.style.cursor = "pointer";
										}
									});
				</script>


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
