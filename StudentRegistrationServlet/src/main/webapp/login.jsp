<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<!-- Font Awesome CSS for the eye icon -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/text.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/passwordToggle.css">
<title>Student Registration</title>
</head>
<body class="login-page-body">

	<div class="login-page">
		<div class="form">
			<div class="login">
				<div class="login-header">
					<h1>Welcome!</h1>
					<!-- <p>Please check your data again.</p> -->
				</div>
				<span class="text-danger" style="color: red;">${errorMessage }</span>
			</div>
			<form class="login-form" action="user_login" method="post"
				name="confirm" onsubmit="return validateForm()">
				<div class="col-auto password-container">
					<input type="email" id="email" placeholder="Email" name="email"
						onfocus="clearError()" />
				</div>
				<div>
					<span id="emailError" class="text-danger" style="color: red;">
					</span>
				</div>
				<div class="col-auto password-container">
					<input type="password" id="password" placeholder="Password"
						name="password" onfocus="clearError()" /> <i
						class="fas fa-eye-slash toggle-password"
						onclick="togglePassword()"></i>
				</div>
				<div>
					<span id="passwordError" class="text-danger" style="color: red;"></span>
				</div>
				<button type="submit">Login</button>
				<!-- <p class="message">
					Not registered? <a href="user_registration.jsp">Create an
						account</a>
				</p> -->
			</form>

		</div>
	</div>


	<script>
		function togglePassword() {
			const passwordField = document.getElementById('password');
			const toggleIcon = document.querySelector('.toggle-password');
			if (passwordField.type === 'password') {
				passwordField.type = 'text';
				toggleIcon.classList.remove('fa-eye-slash');
				toggleIcon.classList.add('fa-eye');
			} else {
				passwordField.type = 'password';
				toggleIcon.classList.remove('fa-eye');
				toggleIcon.classList.add('fa-eye-slash');
			}
		}

		function validateForm() {
			// Get the form fields
			var email = document.getElementById("email").value;
			var password = document.getElementById("password").value;

			// Get the error message spans
			var emailError = document.getElementById("emailError");
			var passwordError = document.getElementById("passwordError");

			// Initialize a flag to track validation status
			var isValid = true;

			// Clear previous error messages
			emailError.textContent = "";
			passwordError.textContent = "";

			// Validate email
			if (email.trim() === "") {
				emailError.textContent = "Email is required.";
				isValid = false;
			} else if (!validateEmail(email)) {
				emailError.textContent = "Please enter a valid email address.";
				isValid = false;
			}

			// Validate password
			if (password.trim() === "") {
				passwordError.textContent = "Password is required.";
				isValid = false;
			} else if (password.length < 6) {
				passwordError.textContent = "Password must be at least 6 characters long.";
				isValid = false;
			}

			// Return the validation status
			return isValid;
		}

		function validateEmail(email) {
			// Simple email validation regex
			var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			return re.test(email);
		}

		function clearError() {
			emailError.textContent = "";
			passwordError.textContent = "";
		}
	</script>
</body>
</html>