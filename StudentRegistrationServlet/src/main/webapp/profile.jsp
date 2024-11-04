<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
if (session == null || session.getAttribute("userId") == null) {
	response.sendRedirect("user_login");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Profile</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css'
	rel='stylesheet'>
<!-- Font Awesome CSS for the eye icon -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

</head>
<style>
.table-container {
	background-color: white;
	color: black;
	border: 1px solid #ced4da;
	padding-top: 15px;
	padding-left: 15px;
	padding-right: 15px;
	padding-bottom: 15px;
	width: 80%;
	border-radius: 10px;
	overflow: hidden;
}

.stuTable {
	border-radius: 10px;
	padding: 15px;
	background-color: white;
}

.couTable {
	border-radius: 10px;
	padding: 15px;
	background-color: white;
}

td.image-cell {
	width: 75px;
	height: 75px;
	text-align: center;
	vertical-align: middle;
}

td.image-cell img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 10px;
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
			<div id="sub_content" style="padding-top: 30px; overflow: auto;">
				<div class="table-container">
					<div class="row">
						<div class="col-md-3">
							<form action="photo_edit" method="post"
								enctype="multipart/form-data" onsubmit="return imageValidateForm()">
								<img id="imagePreview"
									src="data:image/jpeg;base64,${adminBean.image}" alt="Preview"
									style="max-width: 100%; height: auto; border-radius: 10px;">
								<input type="file" name="photo" class="form-control" id="photo"
									style="display: none;" onchange="previewImage()"
									accept="image/*"> <input type="button"
									class="btn btn-primary" value="UPLOAD"
									onclick="document.getElementById('photo').click();"
									style="margin-top: 10px;">
								<button type="submit" class="btn btn-primary" id="submitButton"
									style="margin-top: 10px;">Save Image</button>
							</form>
						</div>
						<div class="col-md-9">
							<div class="head">
								<h3 style="text-align: left;">Profile</h3>
							</div>
							<table>
								<tbody>
									<tr>
										<td><strong> Name </strong></td>
										<td>&nbsp;&nbsp;&nbsp;</td>
										<td class="text-primary">${adminBean.name}</td>
									</tr>
									<tr>
										<td><strong> Email </strong></td>
										<td>&nbsp;&nbsp;&nbsp;</td>
										<td class="text-primary">${adminBean.email}</td>
									</tr>
								</tbody>
							</table>
							<br>
							<div class="row">
								<div class="col-md-4">
									<button class="btn btn-primary" data-toggle="modal"
										data-target="#editModal">Edit</button>
									&nbsp;&nbsp;
									<button class="btn btn-primary" data-toggle="modal"
										data-target="#passwordModal">Change Password</button>

									<!-- edit Modal -->
									<div class="modal fade" id="editModal">
										<div class="modal-dialog modal-md">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title">Edit</h4>
													<button type="button" class="close" data-dismiss="modal">&times;</button>
												</div>
												<div class="modal-body">
													<form action="<c:url value='/useredit'/>"
														class="tm-edit-product-form" method="post"
														onsubmit="return editValidateForm()">
														<div class="mb-3 password-container">
															<input type="text" name="name" id="name"
																class="form-control validate" placeholder="Your Name"
																onclick="editClearError()">
														</div>
														<span id="nameError" class="text-danger"></span>
														<div class="modal-footer">
															<button type="reset" class="btn btn-danger">Clear</button>
															<button type="submit" class="btn btn-primary">Save</button>
														</div>
													</form>
												</div>
											</div>
										</div>
									</div>

									<!-- Password Modal -->
									<div class="modal fade" id="passwordModal">
										<div class="modal-dialog modal-md">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title">Change Password</h4>
													<button type="button" class="close" data-dismiss="modal">&times;</button>
												</div>
												<div class="modal-body">
													<form action="<c:url value='/changePassword'/>"
														class="tm-edit-product-form" method="post"
														onsubmit="return passwordValidateForm()">
														<div class="mb-3 password-container">
															<input type="password" id="oldpassword"
																class="form-control validate" placeholder="Old Password"
																onfocus="clearError()" /> <i
																class="fas fa-eye-slash toggle-password"
																onclick="togglePassword('oldpassword', this)"></i>
														</div>
														<span id="oldPasswordError" class="text-danger"></span>
														<div class="mb-3 password-container">
															<input type="password" id="newpassword"
																name="newpassword" class="form-control validate"
																placeholder="New Password" onfocus="clearError()" /> <i
																class="fas fa-eye-slash toggle-password"
																onclick="togglePassword('newpassword', this)"></i>
														</div>
														<span id="newPasswordError" class="text-danger"></span>
														<div class="mb-3 password-container">
															<input type="password" id="confirmpassword"
																class="form-control validate"
																placeholder="Confirm Password" onfocus="clearError()" />
															<i class="fas fa-eye-slash toggle-password"
																onclick="togglePassword('confirmpassword', this)"></i>
														</div>
														<span id="conPasswordError" class="text-danger"></span>
														<div class="modal-footer">
															<button type="reset" class="btn btn-danger">Clear</button>
															<button type="submit" class="btn btn-primary">Save</button>
														</div>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="table-container" style="margin-top: 10px;">
					<div class="row">
						<div class="stuTable col-md-7">
							<div class="head">
								<h4 style="text-align: left;">Student List</h4>
							</div>
							<br>
							<table id="stuTable" class="table table-striped table-bordered"
								style="width: 100%; border-radius: 10px;">
								<thead>
									<tr>
										<th class="text-center">Student ID</th>
										<th class="text-center">Photo</th>
										<th class="text-center">Name</th>
										<th class="text-center">Gender</th>
										<th class="text-center">Registered Date</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${stu_list}" var="lst">
										<tr>
											<td class="text-center" style="padding: 35px;">STU${lst.stu_id}</td>
											<td class="image-cell"><img
												src="data:image/jpeg;base64,${lst.image}" alt="Preview"></td>
											<td class="text-center" style="padding: 35px;">${lst.name}</td>
											<td class="text-center" style="padding: 35px;">${lst.gender}</td>
											<td class="text-center" style="padding: 35px;">${lst.create_date}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="col-md-4">
							<div class="couTable">
								<div class="head">
									<h4 style="text-align: left;">Course List</h4>
								</div>
								<br>
								<table id="couTable" class="table table-striped table-bordered"
									style="width: 100%; border-radius: 10px;">
									<thead>
										<tr>
											<th class="text-center">Name</th>
											<th class="text-center">Registered Date</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${cou_list}" var="lst">
											<tr>
												<td class="text-center">${lst.name}</td>
												<td class="text-center">${lst.create_date}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="testfooter">
		<span style="color: black;">Copyright &#169; ACE Inspiration
			2024</span>
	</div>

	<!-- JavaScript and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

	<script>
		$(document).ready(function() {
			$('#stuTable').DataTable({
				"searching" : false
			});
		});
		$(document).ready(function() {
			$('#couTable').DataTable({
				"searching" : false
			});
		});

		let originalImageData;

        window.onload = function() {
            const imageElement = document.getElementById('imagePreview');
            originalImageData = imageElement.src;
            document.getElementById('submitButton').disabled = true;
        };

        function previewImage() {
            var input = document.getElementById('photo');
            var preview = document.getElementById('imagePreview');
            var submitButton = document.getElementById('submitButton');

            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    submitButton.disabled = false;  // Enable the submit button when a new image is selected
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.src = originalImageData; // Reset to original image if no file is selected
                submitButton.disabled = true;    // Disable the submit button if no new image is selected
            }
        }

        function imageValidateForm() {
            const imageElement = document.getElementById('imagePreview');
            if (imageElement.src === originalImageData) {
                alert('Please select a new image.');
                return false;
            } else if (!imageElement.type.startsWith('image/')) {
		        alert("Please select a valid image file.");
		        valid = false;
		    }
            return true;
        }

		function passwordValidateForm() {
			let isValid = true;
			const oldpassword = document.getElementById('oldpassword').value
					.trim();
			const newpassword = document.getElementById('newpassword').value
					.trim();
			const confirmpassword = document.getElementById('confirmpassword').value
					.trim();

			if (oldpassword === '') {
				document.getElementById('oldPasswordError').textContent = 'Password is required.';
				isValid = false;
			} else if (oldpassword !== ${lst.password}) {
				document.getElementById('oldPasswordError').textContent = 'Incorrect password.';
				isValid = false;
			}

			if (newpassword === '') {
				document.getElementById('newPasswordError').textContent = 'Password is required.';
				isValid = false;
			} else if (newpassword.length < 6) {
				document.getElementById('newPasswordError').textContent = 'Password must be at least 6 characters long.';
				isValid = false;
			} else if (newpassword === oldpassword) {
				document.getElementById('newPasswordError').textContent = 'New password cannot be as the same as the old password';
				isValid = false;
			}

			if (confirmpassword === '') {
				document.getElementById('conPasswordError').textContent = 'Password is required.';
				isValid = false;
			} else if (confirmpassword !== newpassword) {
				document.getElementById('conPasswordError').textContent = 'Passwords do not match.';
				isValid = false;
			}

			return isValid;
		}

		function clearError() {
			document.getElementById('oldPasswordError').textContent = '';
			document.getElementById('newPasswordError').textContent = '';
			document.getElementById('conPasswordError').textContent = '';
		}

		function editValidateForm() {
			const name = document.getElementById('name').value.trim();
			if (name === '') {
				document.getElementById('nameError').textContent = 'Name is required.';
				return false;
			} else if (!isNaN(name)) {
				document.getElementById('nameError').textContent = 'Invalid name. Name cannot be a number.';
				return false;
			}else if (name === '${lst.name}') {
				document.getElementById('nameError').textContent = 'New name cannot be as the same as the old name.';
				return false;
			}
			return true;
		}

		function editClearError() {
			document.getElementById('nameError').textContent = '';
		}

		function togglePassword(fieldId, icon) {
			const passwordField = document.getElementById(fieldId);
			const type = passwordField.type === 'password' ? 'text' : 'password';
			passwordField.type = type;
			icon.classList.toggle('fa-eye-slash');
			icon.classList.toggle('fa-eye');
		}
	</script>
</body>
</html>

