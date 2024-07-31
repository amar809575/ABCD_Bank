<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Us - ABCD Bank</title>

<style>
body {
	background: -webkit-linear-gradient(left, #0072ff, #00c6ff);
}

.container {
	background: #fff;
	margin-top: 2%;
	margin-bottom: 5%;
	width: 70%;
}

.contact-form {
	background: #fff;
	margin-top: 10%;
	margin-bottom: 0%;
	width: 100%;
}

.contact-form .form-control {
	border-radius: 1rem;
}

.contact-image {
	text-align: center;
}

.contact-image img {
	border-radius: 6rem;
	width: 11%;
	margin-top: -3%;
	transform: rotate(29deg);
}

.contact-form form {
	padding: 10% 14%;
}

.contact-form form .row {
	margin-bottom: -7%;
}

.contact-form h3 {
	margin-bottom: 8%;
	margin-top: -10%;
	text-align: center;
	color: #0062cc;
}

.contact-form .btnContact {
	width: 50%;
	border: none;
	border-radius: 1rem;
	padding: 1.5%;
	background: #dc3545;
	font-weight: 600;
	color: #fff;
	cursor: pointer;
}

.btnContactSubmit {
	width: 50%;
	border-radius: 1rem;
	padding: 1.5%;
	color: #fff;
	background-color: #0062cc;
	border: none;
	cursor: pointer;
}

#button {
	transition: transform 0.3s ease, color 0.3s ease;
}

#button:hover {
	transform: scale(1.1);
	background-color: #0d6efd;
}
</style>
</head>
<body style="background-color: #AED6F1">
	<%@ include file="header.jsp"%>

	<div class="container">

		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="contact-image">
					<img src="https://image.ibb.co/kUagtU/rocket_contact.png"
						alt="rocket_contact" />
				</div>
				<div class="contact-form">
					<h2>Contact Us</h2>
					<form method="post">
						<div class="form-group">
							<input type="text" class="form-control" name="txtName"
								placeholder="Your Name *" required>
						</div>
						<div class="form-group">
							<input type="email" class="form-control" name="txtEmail"
								placeholder="Your Email *" required>
						</div>
						<div class="form-group">
							<input type="tel" class="form-control" name="txtPhone"
								placeholder="Your Phone Number *" required>
						</div>
						<div class="form-group">
							<textarea class="form-control" name="txtMsg"
								placeholder="Your Message *" style="height: 150px;" required></textarea>
						</div>
						<div class="form-group text-center">
							<button type="submit" class="btn btn-contact btn-primary btn-lg"
								id="button" onclick="alert('You message has submitted');">Send
								Message</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<hr>
		<div class="text-center">
			<h6>OR</h6>
		</div>
		<hr>

		<div class="p-5">
			<h2 class="mb-4">Reach Us</h2>

			<div class="mb-3">📧 info@abcd-bank.com</div>

			<div class="mb-3">☎️ 123-456-7890</div>

			<div>🏢 123 Main Street, City, Country</div>
		</div>


		<div class="mt-5 p-5" id="faqs">
			<h2>FAQs</h2>

			<h5 class="mt-3 ml-5">1. How do I open a new account with ABCD
				Bank?</h5>
			<p class="ml-5 mr-5">
				<strong>Ans: </strong>To open a new account with ABCD Bank, you can
				visit our nearest branch or apply online through our website. You'll
				need to provide identification documents, proof of address, and
				other relevant details. Once your application is reviewed and
				approved, your account will be created, and you'll receive your
				account details.
			</p>

			<h5 class="mt-3 ml-5">2. What are the types of accounts
				available at ABCD Bank?</h5>
			<p class="ml-5 mr-5">
				<strong>Ans: </strong>ABCD Bank offers various types of accounts to
				cater to different needs, including:
			</p>
			<ul class="ml-5">
				<li>Savings Accounts</li>
				<li>Current Accounts</li>
				<li>Fixed Deposit Accounts</li>
			</ul>

			<h5 class="mt-3 ml-5">3. How can I access my account online?</h5>
			<p class="ml-5 mr-5">
				<strong>Ans: </strong> You can access your ABCD Bank account online
				through our Internet Banking portal. To get started, you need to
				register for Internet Banking by visiting our website and following
				the registration process. Once registered, you can log in using your
				credentials and manage your account, transfer funds, pay bills, and
				more.
			</p>

			<h5 class="mt-3 ml-5">4. What should I do if I lose my ATM/Debit
				card?</h5>
			<p class="ml-5 mr-5">
				<strong>Ans: </strong>If you lose your ATM/Debit card, it is
				important to report it immediately to prevent unauthorized
				transactions. You can do this by calling our customer service
				helpline or visiting the nearest ABCD Bank branch. We will block
				your lost card and issue a new one promptly.
			</p>

			<h5 class="mt-3 ml-5">5. How can I apply for a loan with ABCD
				Bank?</h5>
			<p class="ml-5 mr-5">
				<strong>Ans: </strong>Applying for a loan with ABCD Bank is simple
				and straightforward. You can apply online through our website or
				visit any of our branches. We offer various types of loans,
				including personal loans, home loans, car loans, and business loans.
				You will need to provide necessary documents and information to
				process your loan application. Our representatives will guide you
				through the process and help you choose the best loan option based
				on your needs.
			</p>


		</div>

	</div>

	<%@ include file="footer.html"%>
</body>
</html>
