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
<title>Sign Up</title>
<style>
#button {
	transition: transform 0.3s ease, color 0.3s ease;
}

#button:hover {
	transform: scale(1.1);
	background-color: #0d6efd;
}

#button-reset:hover {
	transform: scale(1.1);
}
</style>

</head>
<body
	style="background: -webkit-linear-gradient(left, #0072ff, #00c6ff);">
	<%@ include file="header.jsp"%>
	<div class="container mb-5">
		<div class="bg-light">
			<fieldset class="mt-5 p-3">
				<legend>
					<h3>Sign Up for Internet Banking</h3>
				</legend>
				<form action="SignUpServlet" method="get">
					<div class="row">
						<div class="col-lg-2 col-md-2 col-sm-2">Account Number:</div>
						<div class="col-lg-6 col-md-6 col-sm-6 form-group">
							<input type="text" name="accountNumber" class="form-control"
								placeholder="Enter Account Number" required />
						</div>
						<div class="col-lg-2 col-md-2 col-sm-2 form-group">
							<input type="submit" value="Fetch Details"
								class="btn btn-primary" id="button" />
						</div>
					</div>
				</form>

				<%
				String errorMessage = (String) request.getAttribute("errorMessage");
				if (errorMessage != null) {
				%>
				<script>alert('<%=errorMessage%>
					');
				</script>
				<%
				}
				%>



				<form action="SignUpServlet" method="post">

					<div id="accountNumberMessage">

						<div class="row mt-5">
							<div class="col-md-2">Account Number:</div>
							<div class="col-md-6">
								<label>${requestScope.accountNumber }</label> <input
									type="hidden" name="accNumber"
									value="${requestScope.accountNumber}" />
							</div>

						</div>
						<div class="row mt-3">
							<div class="col-md-2">Full Name:</div>
							<div class="col-md-6">
								<label>${requestScope.name }</label> <input type="hidden"
									name="name" value="${requestScope.name}" />

							</div>

						</div>

						<div class="row mt-3">
							<div class="col-md-2">Email:</div>
							<div class="col-md-3">
								<label>${requestScope.email }</label> <input type="hidden"
									name="email" value="${requestScope.email}" />

							</div>
							<div class="col-md-2 ml-3" style="max-width: 8%">Telephone:</div>
							<div class="col-md-3">
								<label>${requestScope.phone1 }</label> <input type="hidden"
									name="phone1" value="${requestScope.phone1}" />

							</div>
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-lg-2 col-md-2 col-sm-2">Username:</div>
						<div class="col-lg-6 col-md-6 col-sm-6 form-group">
							<input type="text" name="username" class="form-control"
								placeholder="Enter Username" required />
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-lg-2 col-md-2 col-sm-2">Password:</div>
						<div class="col-lg-6 col-md-6 col-sm-6 form-group">
							<input type="password" name="password" class="form-control"
								placeholder="Enter Password" required />
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-lg-2 col-md-2 col-sm-2">Confirm Password:</div>
						<div class="col-lg-6 col-md-6 col-sm-6 form-group">
							<input type="password" name="cpassword" class="form-control"
								placeholder="Confirm Password" required />
						</div>
					</div>

					<div class="text-center">
						<input type="submit" value="Register" class="btn btn-primary"
							id="button" /> <input type="reset" value="Reset"
							class="btn btn-warning" id="button-reset" />
					</div>



					<div class="text-center">
						<p>
							Already Registered for Internet Banking, <span
								class="text-primary text-link" onclick="redirectLoginForm()">Click
								here</span>.
						</p>
						<script>
							function redirectLoginForm() {
								window.location.href = "index.jsp#loginForm";
							}
						</script>
					</div>
				</form>
			</fieldset>
		</div>
	</div>
	<%@ include file="footer.html"%>

</body>
</html>
