<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="ABCD_Bank.DatabaseConnect"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ABCD Bank Admin Page</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: -webkit-linear-gradient(left, #0072ff, #00c6ff);
}

.table-responsive {
	overflow-x: auto;
}

table {
	width: 100%;
	max-width: 100%;
	margin-bottom: 1rem;
	background-color: transparent;
	border-collapse: collapse;
}

tbody tr:nth-child(even) {
	background-color: #9fc9ed; /* Define the color for even rows */
}

tbody tr:nth-child(odd) {
	background-color: #ffffff; /* Define the color for odd rows */
}
</style>
</head>
<body>

	<%
	session = request.getSession(false);
		String admin_id = (session != null) ? (String) session.getAttribute("admin_id") : null;

		DatabaseConnect database = new DatabaseConnect();
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
	%>

	<%
	if (admin_id != null) {
	%>
	<header>
		<nav class="navbar navbar-expand-sm navbar-dark bg-primary">
			<img class="d-block pl-3 pr-3" src="images/Bank_logo.png"
				alt="First slide" style="height: 50px;"> <a
				class="navbar-brand" href="index.jsp">ABCD Bank Admin Block</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link"
						href="javascript:void(0);" class="text-light text-decoration-none"
						onclick="redirectToAccounts()">Accounts <span class="sr-only">(current)</span></a></li>
					<li class="nav-item"><a class="nav-link"
						href="javascript:void(0);" class="text-light text-decoration-none"
						onclick="redirectToUsers()">Users</a></li>

					<li class="nav-item"><a href="javascript:void(0);"
						class="text-light text-decoration-none"
						onclick="redirectToAmount()">Users Amount Balance</a></li>
					<li class="nav-item"><a class="nav-link"
						href="javascript:void(0);" class="text-light text-decoration-none"
						onclick="redirectToTransactions()">Transactions</a></li>

				</ul>
			</div>

			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a href="?action=logout"
						class="btn bg-white text-primary">Logout</a></li>
				</ul>
			</div>
		</nav>
	</header>
	<div class="container-fluid mt-3">
		<h1 class="text-white ml-5">Welcome, Admin!</h1>
		<div class="bg-white mt-5 p-3" id="accounts"
			style="margin-bottom: 8%;">
			<h3>Accounts</h3>
			<div class="table-responsive">
				<table class="table table-stripped table-bordered">
					<thead class="bg-primary text-white">
						<tr>
							<th>ID</th>
							<th>Account Number</th>
							<th>Name</th>
							<th>DOB</th>
							<th>Gender</th>
							<th>Email</th>
							<th>Mother Name</th>
							<th>Father Name</th>
							<th>Phone Number</th>
							<th>Address</th>
							<th>Education</th>
							<th>Occupation</th>
							<th>Account Type</th>
							<th>Monthly Salary</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<%
						try {
							conn = database.getCon();

							String sql = "SELECT * FROM account_creation_new";
							statement = conn.prepareStatement(sql);

							resultSet = statement.executeQuery();
							int id = 1;

							while (resultSet.next()) {
						%>
						<tr>
							<td><%=id%></td>
							<td><%=resultSet.getString("account_number")%></td>
							<td><%=resultSet.getString("first_name") + " " + resultSet.getString("middle_name") + " "
		+ resultSet.getString("last_name")%></td>
							<td><%=resultSet.getString("dob")%></td>
							<td><%=resultSet.getString("gender")%></td>
							<td><%=resultSet.getString("email")%></td>
							<td><%=resultSet.getString("mother_name")%></td>
							<td><%=resultSet.getString("father_name")%></td>
							<td><%=resultSet.getString("phone_number") + "<br>" + resultSet.getString("phone_number2")%></td>
							<td><%=resultSet.getString("address_line1") + " " + resultSet.getString("address_line2") + ", "
		+ resultSet.getString("city") + ", " + resultSet.getString("state") + ", " + resultSet.getString("country")
		+ " - " + resultSet.getString("zipcode")%></td>
							<td><%=resultSet.getString("education")%></td>
							<td><%=resultSet.getString("occupation")%></td>
							<td><%=resultSet.getString("account_type")%></td>
							<td><%=resultSet.getString("monthly_salary")%></td>
							<td><%=resultSet.getString("status")%></td>
						</tr>
						<%
						id++;
						}
						} catch (SQLException ex) {
						ex.printStackTrace();
						out.println("Error occurred while fetching account details.");
						} finally {
						try {
						if (resultSet != null)
							resultSet.close();
						if (statement != null)
							statement.close();
						if (conn != null)
							conn.close();
						} catch (SQLException e) {
						e.printStackTrace();
						}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>


		<div class="bg-white mt-5 p-3" id="users" style="margin-bottom: 8%;">
			<h3>Users</h3>
			<div class="table-responsive">
				<table class="table table-stripped table-bordered">
					<thead class="bg-primary text-white">
						<tr>
							<th>ID</th>
							<th>Account Number</th>
							<th>Name</th>

							<th>Email</th>

							<th>Phone Number</th>

							<th>Username</th>
							<th>Password</th>
							<th>Created at</th>
						</tr>
					</thead>
					<tbody>
						<%
						try {
							conn = database.getCon();

							String sql = "SELECT * FROM user_table";
							statement = conn.prepareStatement(sql);

							resultSet = statement.executeQuery();

							while (resultSet.next()) {
						%>
						<tr>
							<td><%=resultSet.getString("user_id")%></td>
							<td><%=resultSet.getString("account_number")%></td>
							<td><%=resultSet.getString("name")%></td>

							<td><%=resultSet.getString("email")%></td>

							<td><%=resultSet.getString("phone1")%></td>
							<td><%=resultSet.getString("username")%></td>
							<td><%=resultSet.getString("password")%></td>
							<td><%=resultSet.getString("created_at")%></td>

						</tr>
						<%
						}
						} catch (SQLException ex) {
						ex.printStackTrace();
						out.println("Error occurred while fetching account details.");
						} finally {
						try {
						if (resultSet != null)
							resultSet.close();
						if (statement != null)
							statement.close();
						if (conn != null)
							conn.close();
						} catch (SQLException e) {
						e.printStackTrace();
						}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>


		<div class="bg-white mt-5 p-3" id="amount" style="margin-bottom: 8%;">
			<h3>Total Amount in Accounts</h3>
			<div class="table-responsive">
				<table class="table table-stripped table-bordered">
					<thead class="bg-primary text-white">
						<tr>
							<th>ID</th>
							<th>Account Number</th>
							<th>Balance</th>
							<th>Created at</th>
						</tr>
					</thead>
					<tbody>
						<%
						try {
							conn = database.getCon();

							String sql = "SELECT * FROM amount_deposit";
							statement = conn.prepareStatement(sql);

							resultSet = statement.executeQuery();

							while (resultSet.next()) {
						%>
						<tr>
							<td><%=resultSet.getString("amount_id")%></td>
							<td><%=resultSet.getString("account_number")%></td>
							<td><%=resultSet.getString("amount")%></td>

							<td><%=resultSet.getString("updated_at")%></td>

						</tr>
						<%
						}
						} catch (SQLException ex) {
						ex.printStackTrace();
						out.println("Error occurred while fetching account details.");
						} finally {
						try {
						if (resultSet != null)
							resultSet.close();
						if (statement != null)
							statement.close();
						if (conn != null)
							conn.close();
						} catch (SQLException e) {
						e.printStackTrace();
						}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>


		<div class="bg-white mt-5 mb-5 p-3" id="transactions">
			<h3>Total Amount in Accounts</h3>
			<div class="table-responsive">
				<table class="table table-stripped table-bordered">
					<thead class="bg-primary text-white">
						<tr>
							<th>ID</th>
							<th>Account Number</th>
							<th>Transaction Date</th>
							<th>Description</th>
							<th>Credit</th>
							<th>Debit</th>
							<th>Balance</th>
						</tr>
					</thead>
					<tbody>
						<%
						try {
							conn = database.getCon();

							String sql = "SELECT * FROM transaction_table";
							statement = conn.prepareStatement(sql);

							resultSet = statement.executeQuery();

							while (resultSet.next()) {
						%>
						<tr>
							<td><%=resultSet.getString("transaction_id")%></td>
							<td><%=resultSet.getString("account_number")%></td>
							<td><%=resultSet.getString("transaction_date")%></td>

							<td><%=resultSet.getString("transaction_reference")%></td>
							<td><%=resultSet.getString("credit")%></td>
							<td><%=resultSet.getString("debit")%></td>
							<td><%=resultSet.getString("balance")%></td>

						</tr>
						<%
						}
						} catch (SQLException ex) {
						ex.printStackTrace();
						out.println("Error occurred while fetching account details.");
						} finally {
						try {
						if (resultSet != null)
							resultSet.close();
						if (statement != null)
							statement.close();
						if (conn != null)
							conn.close();
						} catch (SQLException e) {
						e.printStackTrace();
						}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>



	</div>
	<%
	} else {
	response.sendRedirect("adminLogin.jsp");
	}
	%>

	<%
	if ("logout".equals(request.getParameter("action"))) {
		if (session != null) {
			session.removeAttribute("admin_id");
		}
		response.sendRedirect("adminLogin.jsp?messageId=logoutMessage");
	}
	%>



	<script>
    function redirectToAccounts() {
        window.location.href = "admin.jsp#accounts";
    }
    
    function redirectToUsers() {
        window.location.href = "admin.jsp#users";
    }
    
    function redirectToAmount() {
        window.location.href = "admin.jsp#amount";
    }
    
    function redirectToTransactions() {
        window.location.href = "admin.jsp#transactions";
    }
  </script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
