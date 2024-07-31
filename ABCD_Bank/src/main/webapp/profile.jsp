<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="ABCD_Bank.DatabaseConnect"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ABCD Bank</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background: -webkit-linear-gradient(left, #0072ff, #00c6ff);
}

.container {
	max-width: 800px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

button {
	transition: transform 0.3s ease, color 0.3s ease;
}

button:hover {
	transform: scale(1.1);
	background-color: #0d6efd;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="container">

		<%
		session = request.getSession(false);
		    if (session != null && session.getAttribute("user_id") != null) {
		        String user_id = (String) session.getAttribute("user_id");

		        DatabaseConnect database = new DatabaseConnect();
		        Connection conn = null;
		        PreparedStatement statement = null;
		        ResultSet resultSet = null;
		        
		        try {
		            conn = database.getCon();

		            String sql = "SELECT * FROM user_table " +
		                         "LEFT JOIN account_creation_new " +
		                         "ON user_table.account_number = account_creation_new.account_number " +
		                         "WHERE user_id = ?";
		            statement = conn.prepareStatement(sql);
		            statement.setString(1, user_id);

		            resultSet = statement.executeQuery();

		            if (resultSet.next()) {
			
		            	request.setAttribute("accountNumber", resultSet.getString("account_number"));
		                request.setAttribute("name", resultSet.getString("name"));
		                request.setAttribute("dob", resultSet.getString("dob"));
		                request.setAttribute("gender", resultSet.getString("gender"));
		                request.setAttribute("email", resultSet.getString("email"));
		                request.setAttribute("motherName", resultSet.getString("mother_name"));
		                request.setAttribute("fatherName", resultSet.getString("father_name"));
		                request.setAttribute("phone1", resultSet.getString("phone_number"));
		                request.setAttribute("phone2", resultSet.getString("phone_number2"));
		                request.setAttribute("address1", resultSet.getString("address_line1"));
		                request.setAttribute("address2", resultSet.getString("address_line2"));
		                request.setAttribute("city", resultSet.getString("city"));
		                request.setAttribute("state", resultSet.getString("state"));
		                request.setAttribute("country", resultSet.getString("country"));
		                request.setAttribute("pincode", resultSet.getString("zipcode"));
		                request.setAttribute("education", resultSet.getString("education"));
		                request.setAttribute("occupation", resultSet.getString("occupation"));
		                request.setAttribute("accountType", resultSet.getString("account_type"));
		                request.setAttribute("monthlySalary", resultSet.getString("monthly_salary"));
		%>
		<h1>Account Details</h1>
		<table>
			<tr>
				<th>Field</th>
				<th>Value</th>
			</tr>
			<tr>
				<td>Account Number</td>
				<td>${requestScope.accountNumber}</td>
			</tr>
			<tr>
				<td>Name</td>
				<td>${requestScope.name}</td>
			</tr>
			<tr>
				<td>Date of Birth</td>
				<td>${requestScope.dob}</td>
			</tr>
			<tr>
				<td>Gender</td>
				<td>${requestScope.gender}</td>
			</tr>
			<tr>
				<td>Email</td>
				<td>${requestScope.email}</td>
			</tr>
			<tr>
				<td>Mother's Name</td>
				<td>${requestScope.motherName}</td>
			</tr>
			<tr>
				<td>Father's Name</td>
				<td>${requestScope.fatherName}</td>
			</tr>
			<tr>
				<td>Phone 1</td>
				<td>${requestScope.phone1}</td>
			</tr>
			<tr>
				<td>Phone 2</td>
				<td>${requestScope.phone2}</td>
			</tr>
			<tr>
				<td>Address Line 1</td>
				<td>${requestScope.address1}</td>
			</tr>
			<tr>
				<td>Address Line 2</td>
				<td>${requestScope.address2}</td>
			</tr>
			<tr>
				<td>City</td>
				<td>${requestScope.city}</td>
			</tr>
			<tr>
				<td>State</td>
				<td>${requestScope.state}</td>
			</tr>
			<tr>
				<td>Country</td>
				<td>${requestScope.country}</td>
			</tr>
			<tr>
				<td>Pincode</td>
				<td>${requestScope.pincode}</td>
			</tr>
			<tr>
				<td>Education</td>
				<td>${requestScope.education}</td>
			</tr>
			<tr>
				<td>Occupation</td>
				<td>${requestScope.occupation}</td>
			</tr>
			<tr>
				<td>Account Type</td>
				<td>${requestScope.accountType}</td>
			</tr>
			<tr>
				<td>Monthly Salary</td>
				<td>${requestScope.monthlySalary}</td>
			</tr>
			<tr>

				<%
			String amountQuery = "SELECT amount FROM amount_deposit WHERE account_number = ?";
            PreparedStatement stmt = conn.prepareStatement(amountQuery);
            stmt.setString(1, resultSet.getString("account_number"));
            ResultSet amountResultSet = stmt.executeQuery();
            if (amountResultSet.next()) {
                request.setAttribute("amount", amountResultSet.getDouble("amount"));
            }
            amountResultSet.close();
            stmt.close();

			
			%>
				<td>Balance</td>
				<td>${requestScope.amount}</td>
			</tr>
		</table>
		<div class="text-center mt-4">
			<a href="index.jsp" class="btn btn-primary">Home</a>
		</div>

		<%
		
            } else {
                out.println("Error: User details not found.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            out.println("Error occurred while fetching account details.");
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    } else {
        out.println("Session expired. Please log in again.");
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