<%@ page import="java.sql.*"%>
<%@ page import="ABCD_Bank.DatabaseConnect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ABCD Bank</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<style type="text/css">
#billButtons {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 20px;
	width: 120px;
	height: 120px
}

#billButtons i {
	font-size: 2em;
}

#billButtons span {
	margin-top: 10px;
	font-size: 1em;
}

button {
	transition: transform 0.3s ease, color 0.3s ease;
}

button:hover {
	transform: scale(1.1);
	background-color: #0d6efd;
}

@media screen and (max-width: 768px) {
    #billButtons {
        display: flex;
        flex-wrap: wrap;
        width: 100%;
        margin-bottom: 10px;
    }
}

</style>
</head>
<body
	style="background: -webkit-linear-gradient(left, #0072ff, #00c6ff);">
	<jsp:include page="header.jsp" />
	<div class="container mb-5">
		<%
		session = request.getSession(false);
		if (session != null && session.getAttribute("user_id") != null) {
			String user_id = (String) session.getAttribute("user_id");
			String name = (String) session.getAttribute("name");

			DatabaseConnect database = new DatabaseConnect();
			Connection con = database.getCon();
		%>
		<div class="bg-light pb-5">
			<fieldset class="mt-5 p-5">
				<legend>
					<h2 class="mt-3">Pay Your Bills</h2>
				</legend>
				<div class="d-flex justify-content-center mt-4 flex-wrap">
					<button class="btn btn-primary mx-2" id="billButtons"
						onclick="showForm('mobile')">
						<i class="fas fa-mobile-alt"></i> <span>Mobile Recharge</span>
					</button>
					<button class="btn btn-primary mx-2" id="billButtons"
						onclick="showForm('dth')">
						<i class="fas fa-tv"></i> <span>DTH Recharge</span>
					</button>
					<button class="btn btn-primary mx-2" id="billButtons"
						onclick="showForm('electricity')">
						<i class="fas fa-bolt"></i> <span>Electricity Bills</span>
					</button>
					<button class="btn btn-primary mx-2" id="billButtons"
						onclick="showForm('lpgBill')">
						<i class="fas fa-gas-pump"></i> <span>LPG Bill</span>
					</button>
					<button class="btn btn-primary mx-2" id="billButtons"
						onclick="showForm('broadband')">
						<i class="fas fa-wifi"></i> <span>Broadband</span>
					</button>

				</div>

				<%
				try {
					String sqlQuery = "SELECT ACCOUNT_NUMBER FROM user_table WHERE user_id = ?";
					PreparedStatement ps = con.prepareStatement(sqlQuery);
					ps.setString(1, user_id);
					ResultSet rs = ps.executeQuery();
					if (rs.next()) {
						request.setAttribute("account_number", rs.getString("ACCOUNT_NUMBER"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				%>

				<div class="form-container mt-4" id="form-container">
					<form action="BillPaymentServlet" method="post">
						<div id="mobile" style="display: none;">
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="mobileNumber">Mobile Number</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="mobileNumber"
										name="mobileNumber" required />
								</div>
							</div>
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="amount">Recharge Amount</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="amount"
										name="amount" required />
								</div>
							</div>
							<input type="hidden" id="type" name="type"
								value="Mobile Recharge" />
							<button type="submit" class="btn btn-primary mt-3"
								id="submitButton" style="display: block; margin: 0 auto;">Recharge</button>
						</div>

						<div id="dth" style="display: none;">
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="dthId">DTH ID:</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="dthId" name="dthId"
										required />
								</div>
							</div>
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="amount">Recharge Amount</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="amount"
										name="amount" required />
								</div>
							</div>
							<input type="hidden" id="type" name="type" value="DTH Recharge" />
							<button type="submit" class="btn btn-primary mt-3"
								id="submitButton" style="display: block; margin: 0 auto;">Recharge</button>
						</div>

						<div id="electricity" style="display: none;">
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="electricity">Electricity Account Number:</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="electricity"
										name="electricity" required />
								</div>
							</div>
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="amount">Bill Amount</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="amount"
										name="amount" required />
								</div>
							</div>
							<input type="hidden" id="type" name="type"
								value="Electricity Bill" />
							<button type="submit" class="btn btn-primary mt-3"
								id="submitButton" style="display: block; margin: 0 auto;">Pay
								Electricity Bill</button>
						</div>

						<div id="lpgBill" style="display: none;">
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="lpgNumber">LPG Consumer Number:</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="lpgNumber"
										name="lpgNumber" required />
								</div>
							</div>
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="amount">LPG Bill Amount:</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="amount"
										name="amount" required />
								</div>
							</div>
							<input type="hidden" id="type" name="type" value="LPG Bill" />
							<button type="submit" class="btn btn-primary mt-3"
								id="submitButton" style="display: block; margin: 0 auto;">Pay
								LPG Bill</button>
						</div>

						<div id="broadband" style="display: none;">
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="broadbandNumber">Broadband ID Number:</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="broadbandNumber"
										name="broadbandNumber" required />
								</div>
							</div>
							<div class="row d-flex justify-content-center mt-3 form-group">
								<div class="col-lg-3 col-md-4 col-sm-12">
									<label for="amount">Broadband Bill Amount:</label>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12">
									<input type="text" class="form-control" id="amount"
										name="amount" required />
								</div>
							</div>
							<input type="hidden" id="type" name="type" value="Broadband Bill" />
							<button type="submit" class="btn btn-primary mt-3"
								id="submitButton" style="display: block; margin: 0 auto;">Pay
								Broadband Bill</button>
						</div>
					</form>
				</div>
				<%
				String message = request.getParameter("message");
				if (message != null && !message.isEmpty()) {
				%>

				<h3><%=message%></h3>

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
	<jsp:include page="footer.html" />


	<script>
	function showForm(type) {
	    let forms = ['mobile', 'dth', 'electricity', 'lpgBill', 'broadband'];
	    forms.forEach(function(form) {
	        let div = document.getElementById(form);
	        let inputs = div.getElementsByTagName('input');
	        for (let input of inputs) {
	            input.disabled = true;
	        }
	        div.style.display = 'none';
	    });

	    let selectedDiv = document.getElementById(type);
	    let selectedInputs = selectedDiv.getElementsByTagName('input');
	    for (let input of selectedInputs) {
	        input.disabled = false;
	    }
	    selectedDiv.style.display = 'block';
	}
	</script>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
