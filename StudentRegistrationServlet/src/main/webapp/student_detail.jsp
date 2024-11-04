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
<title>Student Detail</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">

<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css'
	rel='stylesheet'>

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
	width: 79%;
	border-radius: 10px;
	overflow: hidden;
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
								enctype="multipart/form-data" onsubmit="return validateForm()">
								<!-- Preview image area -->
								<img id="imagePreview"
									src="data:image/jpeg;base64,${stu_detail.image}" alt="Preview"
									style="max-width: 100%; height: auto; border-radius: 10px;">

								<!-- File input field -->
								<input type="file" name="photo" class="form-control" id="photo"
									style="display: none;" onchange="previewImage()"
									accept="image/*">

								<!-- Button to trigger file input -->
								<input type="button" class="btn btn-primary "
									value="UPLOAD"
									onclick="document.getElementById('photo').click();"
									style="margin-top: 10px;"> <input type="hidden"
									name="stuId" value="${stu_detail.id}">
								<button type="submit" class="btn btn-primary"
									style="margin-top: 10px;">Save Image</button>
							</form>
						</div>

						<div class="col-md-9">
							<table>
								<tbody>
									<tr>
										<td><strong> Register Date : </strong></td>
										<td class="text-primary">${stu_detail.create_date}</td>
									</tr>
									<tr>
										<td><strong> Last Update Date : </strong></td>
										<td class="text-primary">${stu_detail.update_date} By
											${stu_detail.updater }</td>
									</tr>
									<tr>
										<td><strong> Student ID : </strong></td>
										<td class="text-primary">STU${stu_detail.stu_id}</td>
									</tr>
									<tr>
										<td><strong> Name : </strong></td>
										<td class="text-primary">${stu_detail.name}</td>
									</tr>
									<tr>
										<td><strong> DOB : </strong></td>
										<td class="text-primary">${stu_detail.dob}</td>
									</tr>
									<tr>
										<td><strong> Gender : </strong></td>
										<td class="text-primary">${stu_detail.gender}</td>
									</tr>
									<tr>
										<td><strong> Phone : </strong></td>
										<td class="text-primary">${stu_detail.phone}</td>
									</tr>
									<tr>
										<td><strong> Education : </strong></td>
										<td class="text-primary">${stu_detail.education}</td>
									</tr>
									<tr>
										<td><strong> Attend : </strong></td>
										<td class="text-primary">${stu_detail.courses_name}</td>
									</tr>
								</tbody>
							</table>
							<br>
							<div class="row">
								<div class="col-md-4">
									<a href="<c:url value='edit_student?stuId=${stu_detail.id}'/> ">
										<button type="submit" class="btn btn-primary">Edit
											Detail</button>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- end table container -->
			</div>
		</div>
	</div>
	<div id="testfooter">
		<span style="color: black;">Copyright &#169; ACE Inspiration
			2024</span>
	</div>


	<script>
		window.onload = function() {
			const imageElement = document.getElementById('imagePreview');
			originalImageData = imageElement.src;
			document.getElementById('submitButton').disabled = true; // Initially disable the submit button
		};

		function previewImage() {
			var input = document.getElementById('photo');
			var preview = document.getElementById('imagePreview');

			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					preview.src = e.target.result;
				};
				reader.readAsDataURL(input.files[0]);
			} else {
				preview.src = ''; // Clear the image preview
			}
		}

		function validateForm() {
			const submitButton = document.getElementById('submitButton');
			const imageElement = document.getElementById('imagePreview');

			// Check if the image has been changed
			if (imageElement.src === originalImageData) {
				alert('Please select a new image before submitting.');
				return false; // Prevent form submission
			} else if (!imageElement.type.startsWith('image/')) {
		        alert("Please select a valid image file.");
		        valid = false;
		    }

			return true; // Allow form submission
		}
	</script>
</body>
</html>
