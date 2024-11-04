<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
if (session == null || session.getAttribute("userId") == null) {
	if (session != null && (int) session.getAttribute("user_role") == 1) {
		response.sendRedirect("management");
		return;
	} else {
		response.sendRedirect("user_login");
		return;
	}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/text.css">
<!-- Font Awesome CSS for the eye icon -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<title>User Registration</title>

</head>
<style>
h2, label {
	color: black;
}

.modal-header, .modal-body {
	color: black;
}

.password-container {
	position: relative;
}

.password-container input[type="password"], .password-container input[type="text"]
	{
	width: 100%;
	padding-right: 40px;
}

.password-container .toggle-password {
	color: black;
	position: absolute;
	right: 25px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
	position: absolute;
}
</style>
<body>
	<%@ include file="nav_bar.jsp"%>
	<div class="container">
		<div class="main_contents">
			<div id="sub_content">
				<form action="user_registration" method="post"
					onsubmit="return validateForm()">
					<h2 class="col-md-6 offset-md-2 mb-5 mt-4">User Registration</h2>
					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="userId" class="col-md-2 col-form-label">User
							ID</label>
						<div class="col-md-4">
							<input type="text" class="form-control" value="USR${user_id }"
								disabled> <input type="hidden" class="form-control"
								value="${user_id }" name="user_id" id="userId">
						</div>
					</div>
					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="name" class="col-md-2 col-form-label">Name</label>
						<div class="col-md-4">
							<input type="text" class="form-control" name="name" id="name"
								onfocus="clearError('nameError')"> <small id="nameError"
								class="text-danger"></small>
						</div>
					</div>

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="email" class="col-md-2 col-form-label">Email</label>
						<div class="col-md-4">
							<input type="email" class="form-control" name="email" id="email"
								onfocus="clearError('emailError')"> <small
								id="emailError" class="text-danger">${already }</small>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="password" class="col-md-2 col-form-label">Password</label>
						<div class="col-md-4 password-container">
							<input type="password" class="form-control" name="password"
								id="password" value="123456"
								onfocus="clearError('passwordError')"> <i
								class="fas fa-eye-slash toggle-password"
								onclick="togglePassword()"></i> <small id="passwordError"
								class="text-danger"></small>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="role" class="col-md-2 col-form-label">User
							Role</label>
						<div class="col-md-4">
							<select class="form-select" name="role" id="role">
								<option value="1" selected>User</option>
								<option value="0">ADMIN</option>
							</select>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col-md-4"></div>
						<div class="col-md-6">
							<button type="button" class="btn btn-primary" id="submitButton">Add
							</button>

							<div class="modal fade" id="exampleModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Student
												Registration</h5>
										</div>
										<div class="modal-body">
											<h5 id="modalMessage" style="color: rgb(127, 209, 131);">Are you sure to register?</h5>
										</div>
										<div class="modal-footer">
											<button type="submit" class="btn btn-success col-md-2"
												data-bs-dismiss="modal">Ok</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="testfooter">
		<span style="color: black;">Copyright &#169; ACE Inspiration
			2024</span>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


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

		function clearError(elementId) {
			document.getElementById(elementId).textContent = '';
		}

		function validateForm() {
			let isValid = true;

			// Get form elements
			const name = document.getElementById('name').value.trim();
			const email = document.getElementById('email').value.trim();
			const password = document.getElementById('password').value.trim();
			/* const confirmPassword = document.getElementById('confirmPassword').value
					.trim(); */

			// Name validation
			if (name === '') {
				document.getElementById('nameError').textContent = 'Name is required.';
				isValid = false;
			}

			// Email validation
			const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (email === '') {
				document.getElementById('emailError').textContent = 'Email is required.';
				isValid = false;
			} else if (!emailPattern.test(email)) {
				document.getElementById('emailError').textContent = 'Enter a valid email.';
				isValid = false;
			}

			// Password validation
			if (password === '') {
				document.getElementById('passwordError').textContent = 'Password is required.';
				isValid = false;
			} else if (password.length < 6) {
				document.getElementById('passwordError').textContent = 'Password must be at least 6 characters long.';
				isValid = false;
			}

			return isValid;
		}

		document.getElementById("submitButton").addEventListener("click",
				function() {
					if (validateForm()) {
						$('#exampleModal').modal('show');
					}
				});
	</script>
</body>
</html>


