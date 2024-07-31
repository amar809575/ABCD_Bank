<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Account</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">

<script>
	function showMessage() {
		var message = document.getElementById("accountNumberMessage");
		message.style.display = "block";
	}
</script>

<style>
@media ( max-width : 767px) {
	.col-md-2, .col-md-3, .col-md-6 {
		max-width: 100%;
	}
}
</style>

</head>
<body
	style="background: -webkit-linear-gradient(left, #0072ff, #00c6ff);">
	<%@ include file="header.jsp"%>
	<div class="container">
		<div class="mt-5 mb-5 bg-light p-3">

			<fieldset>
				<legend class="fw-bold">
					<h3>Create New Account</h3>
				</legend>
				<div class="d-flex justify-content-center align-items-center">
					<form action="NewAccountServlet" method="get"
						enctype="multipart/form-data">
						<div class="form-group row">
							<label for="accountNumber" class="col-md-2 col-form-label">Account
								Number:</label>
							<div class="col-md-10">
								<input type="number" name="accountNumber" id="accountNumber"
									class="form-control" onfocus="showMessage()"
									placeholder="Enter Account Number" required /> <span
									id="accountNumberMessage" class="text-muted mt-2"
									style="display: none;"> Please enter a 10-digit number
									in the following format: <strong>YYYYMMDDNXXX</strong><br>
									- <strong>YYYYMMDD:</strong> Today's date (e.g., 20200101 for
									January 01, 2020)<br> - <strong>N:</strong> Any single
									digit from 0 to 9<br> - <strong>XXX:</strong> Last three
									digits of your mobile number<br> <br> Example: For
									January 10, 2024, with a digit '9' and mobile number ending in
									'999', enter: <strong>202401109999</strong>
								</span>
							</div>
						</div>
						<fieldset class="border p-3 mt-4">
							<legend>Personal Details</legend>
							<div class="form-group row">
								<label for="firstname" class="col-md-2 col-form-label">Full
									Name:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<input type="text" name="firstname" id="firstname"
										class="form-control" placeholder="First Name" required />
								</div>
								<div class="col-md-3 mb-2 mb-md-0">
									<input type="text" name="middlename" id="middlename"
										class="form-control" placeholder="Middle Name" />
								</div>
								<div class="col-md-3">
									<input type="text" name="lastname" id="lastname"
										class="form-control" placeholder="Last Name" required />
								</div>
							</div>
							<div class="form-group row">
								<label for="dob" class="col-md-2 col-form-label">DOB:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<input type="date" name="dob" id="dob" class="form-control"
										required />
								</div>
								<label class="col-md-2 col-form-label">Gender:</label>
								<div class="col-md-4">
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
							</div>
							<div class="form-group row">
								<label for="email" class="col-md-2 col-form-label">Email:</label>
								<div class="col-md-10">
									<input type="email" name="email" id="email"
										class="form-control" placeholder="Enter Email" required />
								</div>
							</div>
							<div class="form-group row">
								<label for="motherName" class="col-md-2 col-form-label">Mother's
									Name:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<input type="text" name="motherName" id="motherName"
										class="form-control" placeholder="Mother's Name" required />
								</div>
								<label for="fatherName" class="col-md-2 col-form-label">Father's
									Name:</label>
								<div class="col-md-4">
									<input type="text" name="fatherName" id="fatherName"
										class="form-control" placeholder="Father's Name" required />
								</div>
							</div>
							<div class="form-group row">
								<label for="phone1" class="col-md-2 col-form-label">Telephone:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<input type="number" name="phone1" id="phone1"
										class="form-control" placeholder="Applicant's Mobile Number"
										required />
								</div>
								<label for="Phone2" class="col-md-2 col-form-label">Telephone
									2: <span class="text-muted">(Optional)</span>
								</label>
								<div class="col-md-4">
									<input type="text" name="phone2" id="Phone2"
										class="form-control" placeholder="Another Mobile Number" />
								</div>
							</div>
						</fieldset>

						<fieldset class="border p-3 mt-4">
							<legend>Address</legend>
							<div class="form-group row">
								<label for="address1" class="col-md-2 col-form-label">Address
									Line 1:</label>
								<div class="col-md-10">
									<input type="text" name="address1" id="address1"
										class="form-control"
										placeholder="House/Residency, Street/Road" required />
								</div>
							</div>
							<div class="form-group row">
								<label for="address2" class="col-md-2 col-form-label">Address
									Line 2:</label>
								<div class="col-md-10">
									<input type="text" name="address2" id="address2"
										class="form-control" placeholder="Area/Locality, Landmark"
										required />
								</div>
							</div>
							<div class="form-group row">
								<label for="city" class="col-md-2 col-form-label">City:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<input type="text" name="city" id="city" class="form-control"
										placeholder="City" required />
								</div>
								<label for="state" class="col-md-2 col-form-label">State:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<input type="text" name="state" id="state" class="form-control"
										placeholder="State" required />
								</div>
							</div>

							<div class="form-group row">
								<label for="country" class="col-md-2 col-form-label">Country:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<input type="text" name="country" id="country"
										class="form-control" placeholder="Country" required />
								</div>
								<label for="zipcode" class="col-md-2 col-form-label">Zipcode:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<input type="number" name="zipcode" id="zipcode"
										class="form-control" placeholder="Postal code" required />
								</div>
							</div>

						</fieldset>

						<fieldset class="border p-3 mt-4">
							<legend>Education & Occupation</legend>
							<div class="form-group row">
								<label class="col-md-2 col-form-label">Education:</label>
								<div class="col-md-10">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="education"
											id="education1" value="High School or Below" /> <label
											class="form-check-label" for="education1">High School
											or Below</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="education"
											id="education2" value="Undergraduate" /> <label
											class="form-check-label" for="education2">Undergraduate</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="education"
											id="education3" value="Masters Degree" /> <label
											class="form-check-label" for="education3">Masters
											Degree</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="education"
											id="education4" value="PhD" /> <label
											class="form-check-label" for="education4">PhD</label>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label for="occupation" class="col-md-2 col-form-label">Occupation:</label>
								<div class="col-md-10">
									<select class="form-select form-control" id="occupation"
										name="occupation">
										<option>Select Occupation</option>
										<option value="Own Business">Own Business</option>
										<option value="Self Employment">Self Employed</option>
										<option value="Student">Student</option>
										<option value="Retired">Retired</option>
										<option value="Unemployment">Unemployed</option>
										<option value="Employee">Employed</option>
									</select>
								</div>
							</div>
							<div class="form-group row mt-4">
								<label for="account_type" class="col-md-2 col-form-label">Account
									Type:</label>
								<div class="col-md-4 mb-2 mb-md-0">
									<select class="form-select form-control" id="account_type"
										name="account_type">
										<option>Select Account Type</option>
										<option value="Current Account">Current Account</option>
										<option value="Savings Account">Savings Account</option>
										<option value="Fixed Account">Fixed Account</option>
									</select>
								</div>
								<label for="salary" class="col-md-2 col-form-label">Monthly
									Salary:</label>
								<div class="col-md-4">
									<input type="number" name="salary" id="salary"
										class="form-control" placeholder="Monthly Salary" required />
								</div>
							</div>
						</fieldset>

						<div class="text-center mt-5">
							<button type="submit" class="btn btn-primary">Create New
								Account</button>
						</div>
					</form>
				</div>
			</fieldset>
		</div>
	</div>
	<%@ include file="footer.html"%>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
