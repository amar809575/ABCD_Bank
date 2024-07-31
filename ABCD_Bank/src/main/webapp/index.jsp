<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="ABCD_Bank.DatabaseConnect"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ABCD Bank</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<style>
/* General Styles */
body {
	font-family: Arial, Helvetica, sans-serif;
	background-color: #f8f9fa;
}

.container {
	padding: 20px;
}

object-fit


 


:cover




;
}
#navigation {
	background-color: #4968CA;
	border: 1px solid #adadad;
}

#navigation ul {
	list-style: none;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	text-decoration: none;
}

#navigation ul li {
	text-align: center;
	border: 1px solid #adadad;
	transition: transform 0.3s ease, color 0.3s ease;
}

#navigation ul li:hover {
	transform: scale(1.1);
	background-color: #0d6efd;
}

#navigation ul li a {
	display: block;
	padding: 10px 0;
	color: #adadad;
	text-decoration: none;
	font-weight: bold;
	trasition: transform 0.3s ease, color 0.3s ease;
}

#navigation ul li a:hover {
	color: #FFFFFF;
	/* 	transform: scale(1.1);
 */
}

button {
	transition: transform 0.3s ease, color 0.3s ease;
}

button:hover {
	transform: scale(1.1);
	background-color: #0d6efd;
}

#button {
	transition: transform 0.3s ease, color 0.3s ease;
}

#button:hover {
	transform: scale(1.1);
	background-color: #0d6efd;
}

.modal-dialog {
	max-width: 1000px;
}

.modal-body {
	padding: 20px;
}

.modal-header, .modal-footer {
	border: none;
}

.modal-title {
	font-size: 24px;
	font-weight: bold;
}

.form-control, .form-select {
	margin-bottom: 10px;
}
</style>
</head>
<body
	style="background: -webkit-linear-gradient(left, #0072ff, #00c6ff);">
	<%@ include file="header.jsp"%>

	<div class="container">
		<h1 class="text-light">Welcome to ABCD Bank</h1>

		<div id="carouselExample" class="carousel slide mb-4"
			style="margin-left: 100px; margin-right: 100px" data-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img class="d-block w-100" src="images/Designer.png"
						alt="First slide" style="Height: 250px">
				</div>
				<div class="carousel-item">
					<img class="d-block w-100" src="images/Designer.png"
						alt="Second slide" style="Height: 250px">
				</div>
				<div class="carousel-item">
					<img class="d-block w-100" src="images/credit_card.png"
						alt="Third slide" style="Height: 250px">
				</div>
			</div>
			<a class="carousel-control-prev" href="#carouselExample"
				role="button" data-slide="prev"> <span
				class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#carouselExample"
				role="button" data-slide="next"> <span
				class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>

		<div class="mt-5" id="services">
			<h2 class="text-white">Our Services</h2>
			<div id="navigation" class="bg-primary">
				<ul>
					<li><a href="newAccount.jsp">NEW ACCOUNT</a></li>
					<li><a href="balance.jsp">BALANCE</a></li>
					<li><a href="deposit.jsp">DEPOSIT</a></li>
					<li><a href="withdraw.jsp">WITHDRAW</a></li>
					<li><a href="payBills.jsp">Pay Bills</a></li>
					<li><a href="transfer.jsp">TRANSFER</a></li>
					<li><a href="closeac.jsp">CLOSE A/C</a></li>
					<li><a href="#" id="reactivateButton">ACCOUNT REACTIVATION</a></li>
				</ul>
			</div>
		</div>
		<div class="row mt-5">
			<div
				class="col-lg-6 col-md-12 col-sm-12 table-bordered p-5 text-center bg-light">

				<%
				session = request.getSession(false);
				if (session != null && session.getAttribute("user_id") != null) {
					String user_id = (String) session.getAttribute("user_id");
					String name = (String) session.getAttribute("name");
				%>
				<div class="d-flex justify-content-center mt-5">
					<h2>
						Welcome,
						<%=name%></h2>
					<br />
				</div>
				<p class="">
					Click here to, <a href="logout.jsp" class="text-decoration-none">Logout</a>

				</p>

				<%
				} else {
				%>

				<h2>Login</h2>
				<form id="loginForm" method="post">
					<div class="row mt-3">
						<div
							class="col-lg-12 col-md-12 col-sm-12 d-flex justify-content-center pl-5 pr-5">
							<input type="text" placeholder="Username" name="username"
								class="form-control" />
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-lg-12 col-md-12 col-sm-12  pl-5 pr-5">
							<input type="password" placeholder="Password" name="password"
								class="form-control" />
						</div>
					</div>
					<div class="row mt-3">
						<div
							class="col-lg-12 col-md-12 col-sm-12 d-flex justify-content-center">
							<button type="submit" class="btn btn-primary">Login</button>
						</div>
						<div class="d-flex justify-content-center mt-4">
							<p>
								New User click <a href="signup.jsp" class="text-decoration-none">Here</a>
								to Sign Up.
							</p>
						</div>
					</div>
				</form>

				<%
				}
				%>

				<%
				if (request.getMethod().equalsIgnoreCase("post")) {
					String username = request.getParameter("username");
					String password = request.getParameter("password");

					try {
						DatabaseConnect database = new DatabaseConnect();
						Connection con = database.getCon();

						PreparedStatement ps = con.prepareStatement("SELECT * FROM user_table WHERE username=? AND password=?");
						ps.setString(1, username);
						ps.setString(2, password);

						ResultSet rs = ps.executeQuery();

						if (rs.next()) {
					String accNumber = rs.getString("account_number");
					String sql = "SELECT * FROM account_creation_new WHERE account_number = ?";
					ps = con.prepareStatement(sql);
					ps.setString(1, accNumber);

					ResultSet rs1 = ps.executeQuery();

					if (rs1.next()) {
						String status = rs1.getString("status");

						if (status.equals("Activated")) {
							String user_id = rs.getString("user_id");
							String name = rs.getString("name");

							session = request.getSession();
							session.setAttribute("user_id", user_id);
							session.setAttribute("name", name);

							response.sendRedirect("index.jsp");
						} else {
				%>
				<script>
					alert('Your account is deactivated. You cannot login');
				</script>
				<%
				}
				} else {
				request.setAttribute("error", "Invalid username or password");
				}
				} else {
				request.setAttribute("error", "Invalid username or password");
				}

				rs.close();
				ps.close();
				con.close();
				} catch (SQLException e) {
				e.printStackTrace();
				out.println(e);
				}
				}
				%>

			</div>

			<div class="col-lg-6 col-md-12 col-sm-12 table-bordered p-5 bg-light">
				<h3>Latest Offers</h3>

				<div id="carouselExampleControls" class="carousel slide"
					data-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<div class="offer p-5">
								<h4>1. Cashback Bonanza</h4>
								<p>Earn up to 5% cashback on all your purchases using ABCD
									Bank credit cards. Limited time offer!</p>
							</div>
						</div>
						<div class="carousel-item">
							<div class="offer p-5">
								<h4>2. Savings Super Saver</h4>
								<p>Open a new savings account and enjoy a high-interest rate
									of 2.5% for the first six months.</p>
							</div>
						</div>
						<div class="carousel-item">
							<div class="offer p-5">
								<h4>3. Home Loan Festival</h4>
								<p>Avail of special interest rates on home loans starting
									from just 6.99% APR. Don't miss out!</p>
							</div>
						</div>
						<div class="carousel-item">
							<div class="offer p-5">
								<h4>4. Credit Card Rewards Galore</h4>
								<p>Apply for ABCD Bank's premium credit card and unlock
									exclusive rewards, travel perks, and discounts.</p>
							</div>
							<div class="p-3">
								<button class="btn btn-primary">Apply for Credit Card</button>
							</div>
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleControls"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleControls"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
		<div>




			<div class="modal fade modal-centered" id="reactivateModal"
				tabindex="-1" aria-labelledby="reactivateModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-lg p-5"
					role="document">
					<div class="modal-content">
						<div class="modal-header"
							style="background: -webkit-linear-gradient(left, #0072ff, #00c6ff);">
							<h5 class="modal-title text-white" id="reactivateModalLabel">Account
								Reactivation</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>

						<%
						session = request.getSession(false);
						if (session != null && session.getAttribute("user_id") != null) {
							String user_id = (String) session.getAttribute("user_id");
						%>
						<div class="d-flex justify-content-center mt-5 mb-5">
							<h2>Your account is already activated!!!</h2>
							<br />
						</div>


						<%
						} else {
						%>
						<form method="get" id="accountreactivationForm">
							<div class="modal-body">
								<h3>Please confirm your details in order to reactivate your
									account.</h3>
								<div class="row mt-5">
									<div class="col-md-4" style="max-width: 30%">Account
										Number:</div>
									<div class="col-md-6">
										<input type="number" name="accountNumber" id="accountNumber"
											class="form-control" placeholder="Enter Account Number"
											required />
									</div>
								</div>
								<div class="row mt-3">

									<div class="col-md-2" style="max-width: 15%">Full Name:</div>
									<div class="col-md-3">

										<input type="text" name="firstname" id="firstname"
											class="form-control" placeholder="First Name" required />
									</div>

									<div class="col-md-3">

										<input type="text" name="middlename" id="middlename"
											class="form-control" placeholder="Middle Name" />
									</div>
									<div class="col-md-3">

										<input type="text" name="lastname" id="lastname"
											class="form-control" placeholder="Last Name" required />
									</div>
								</div>

								<div class="row mt-3">
									<div class="col-md-2" style="max-width: 15%">DOB:</div>
									<div class="col-md-3">

										<input type="date" name="dob" id="dob" class="form-control"
											placeholder="DOB" required />
									</div>

									<div class="col-md-3 ml-3" style="max-width: 12%">Gender:</div>

									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender"
											id="maleGender" value="Male" /> <label
											class="form-check-label" for="maleGender">Male</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender"
											id="female" value="Female" /> <label
											class="form-check-label" for="female">Female</label>
									</div>

									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender"
											id="otherGender" value="Others" /> <label
											class="form-check-label" for="otherGender">Other</label>
									</div>
								</div>

								<div class="row mt-3">
									<div class="col-md-4" style="max-width: 15%">Email:</div>
									<div class="col-md-5">
										<input type="email" name="email" id="email"
											class="form-control" placeholder="Enter Email" required />
									</div>


								</div>
								<div class="row mt-3">
									<div class="col-md-4" style="max-width: 15%">Telephone:</div>
									<div class="col-md-5">
										<input type="number" name="phone1" id="phone1"
											class="form-control" placeholder="Applicant's Mobile Number"
											required />
									</div>
								</div>

								<div class="row mt-5">
									<div class="col-md-4" style="max-width: 15%">Account
										Type:</div>
									<div class="col-md-5">
										<select class="form-select form-control" id="account_type"
											name="account_type">
											<option>Select Account Type</option>
											<option value="Current Account">Current Account</option>
											<option value="Savings Account">Savings Account</option>
											<option value="Fixed Account">Fixed Account</option>
										</select>
									</div>



								</div>
							</div>
							<div class="modal-footer d-flex justify-content-center"
								style="background: -webkit-linear-gradient(left, #0072ff, #00c6ff);">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
								<input type="submit" class="btn btn-primary"
									value="Save Changes" id="button" />
							</div>
						</form>

						<%
						}
						%>
						<%!public boolean isEqual(String param, String dbValue) {
		return (param != null && param.trim().equalsIgnoreCase(dbValue != null ? dbValue.trim() : ""));
	}%>

						<%
						if (request.getMethod().equalsIgnoreCase("GET")) {
							String accNumber = request.getParameter("accountNumber");
							String first_name = request.getParameter("firstname");
							String middle_name = request.getParameter("middlename");
							String last_name = request.getParameter("lastname");
							String dob = request.getParameter("dob");
							String gender = request.getParameter("gender");
							String email = request.getParameter("email");
							String phone1 = request.getParameter("phone1");
							String status = "Activated";

							try {
								DatabaseConnect database = new DatabaseConnect();
								Connection con = database.getCon();
								PreparedStatement ps = null;
								String activationQuery = "SELECT * FROM account_creation_new WHERE account_number = ?";
								ps = con.prepareStatement(activationQuery);
								ps.setString(1, accNumber);

								ResultSet rs = ps.executeQuery();

								if (rs.next()) {
							try {

								String firstName = rs.getString("FIRST_NAME");
								String middleName = rs.getString("MIDDLE_NAME");
								String lastName = rs.getString("LAST_NAME");
								String dOB = rs.getString("dob");
								String genderCheck = rs.getString("gender");
								String emailCheck = rs.getString("email");
								String phoneCheck = rs.getString("PHONE_NUMBER");

								String statusCheck = rs.getString("status");

								if (status.equals(statusCheck)) {
									out.println("<script>alert('Your account has been already activated.');</script>");

								} else {

									if (isEqual(first_name, firstName) && isEqual(middle_name, middleName)
											&& isEqual(last_name, lastName) && isEqual(dob, dOB) && isEqual(gender, genderCheck)
											&& isEqual(email, emailCheck) && isEqual(phone1, phoneCheck)) {

										String UPDATE_QUERY = "UPDATE account_creation_new SET status = ? WHERE account_number = ?";
										ps = con.prepareStatement(UPDATE_QUERY);
										ps.setString(1, status);
										ps.setString(2, accNumber);

										int rowsAffected = ps.executeUpdate();
										if (rowsAffected > 0) {
											out.println(
													"<script>alert('Your account has been reactivated.'); window.location.href='index.jsp';</script>");
										} else {
											out.println(
													"<script>alert('Failed to reactivate account. Please try again.'); window.location.href='index.jsp';</script>");
										}
									} else {
										out.println(
												"<script>alert('Provided details do not match our records.'); window.location.href='index.jsp';</script>");
									}
								}
							} catch (Exception e) {
								e.printStackTrace();
								System.out.println("No account found with the provided account number.");

							}
								}
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}
						%>

					</div>
				</div>
			</div>

		</div>

		<script>
			window.onload = function() {
				document.getElementById('reactivateButton').addEventListener(
						'click', function() {
							$('#reactivateModal').modal('show');
						});

			}
		</script>


		<%
		String message = request.getParameter("alert");
		if (message != null && !message.isEmpty()) {
		%>
		<script>
    alert("<%=message%>
			");
		</script>
		<%
		}
		%>

	</div>


	<%@ include file="footer.html"%>





	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
