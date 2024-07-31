<%@ page import="java.sql.*"%>
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
				<legend>
					<h2 class="mt-3">Money Transfer</h2>
				</legend>

				<%
try {
	String sqlQuery = "SELECT ACCOUNT_NUMBER FROM user_table WHERE user_id = ?";
	
	PreparedStatement ps =  con.prepareStatement(sqlQuery);
	ps.setString(1, user_id);
	
	ResultSet rs = ps.executeQuery();
	
	if(rs.next()) {
		request.setAttribute("account_number", rs.getString("account_number"));
	}
} catch (SQLException e) {
	e.printStackTrace();
}

%>

				<form action="TransferServlet" method="get">
					<div class="ml-5 mb-3 font-weight-bold">From Account</div>

					<div class="row d-flex justify-content-center">
						<div class="col-lg-3 col-md-4 col-sm-12">Please Confirm Your
							Account Number:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<label><h5>${requestScope.account_number }</h5></label> <input
								type="hidden" name="fromAccNum" id="fromAccNum"
								class="form-control" value="${requestScope.account_number }"
								required />
						</div>
					</div>
					<hr>

					<div class="ml-5 mb-3 font-weight-bold">To Account Details</div>
					<div class="row d-flex justify-content-center">
						<div class="col-lg-3 col-md-4 col-sm-12">Enter Account
							Number:</div>
						<div class="col-lg-6 col-md-8 col-sm-12">
							<input type="text" name="toAccNum" id="toAccNum"
								class="form-control" required />
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

					<div class="text-center mt-3">
						<input type="submit" class="btn btn-primary" value="Submit"
							id="button" /> <a href="index.jsp"
							class="btn btn-primary text-white" id="button">Home</a>
					</div>
				</form>

				<%
    String message = request.getParameter("message");
    if (message != null && !message.isEmpty()) {
%>
				<script>
    alert("<%= message %>");
</script>
				<%
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
