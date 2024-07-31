<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Header</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


</head>
<body>
	<nav class="navbar navbar-expand-sm navbar-dark bg-primary">
		<img class="d-block pl-3 pr-3" src="images/Bank_logo.png"
			alt="First slide" style="Height: 50px"> <a class="navbar-brand"
			href="index.jsp">ABCD Bank</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item"><a class="nav-link" href="newAccount.jsp">New
						Account</a></li>

				<li class="nav-item"><a class="nav-link" href="aboutus.jsp">About
						Us</a></li>
				<li class="nav-item"><a class="nav-link" href="contactus.jsp">Contact
						Us</a></li>

			</ul>
			<div class="navbar-nav ml-auto">
				<%
				session = request.getSession(false);
				if (session != null && session.getAttribute("user_id") != null) {
					String user_id = (String) session.getAttribute("user_id");
					String name = (String) session.getAttribute("name");
				%>

				<div class="dropdown">
					<button class="btn bg-white text-primary dropdown-toggle"
						type="button" id="dropdownMenuButton" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">
						Welcome,
						<%=name%>
					</button>
					<div class="dropdown-menu bg-white"
						aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item text-primary" href="profile.jsp">Profile</a>
						<a class="dropdown-item text-primary" href="#">Another action</a>
						<div class="dropdown-divider"></div>

						<a href="logout.jsp" class="dropdown-item text-primary" href="#">Logout</a>
					</div>
				</div>


				<%
				} else {
				%>

				<button class="btn bg-white text-primary mx-1"
					onclick="redirectToLoginForm()">Login</button>
				<a class="btn bg-white text-primary mx-1" href="signup.jsp">Sign
					Up</a>
				<%
				}
				%>
			</div>
		</div>
	</nav>

	<script>
		function redirectToLoginForm() {
			window.location.href = "index.jsp#loginForm";
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
