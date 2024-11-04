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
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/text.css">
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
<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css'
	rel='stylesheet'>

<title>student_registration</title>
</head>
<style>
h2, label {
	color: black;
}

.modal-header, .modal-body {
	color: black;
}

.tm-product-img-dummy {
	max-width: 50%;
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
	background: #aaa;
	border-radius: 10px;
	position: relative;
}

.tm-product-img-dummy img {
	width: 150%;
	height: 100%;
	object-fit: fill;
	border-radius: 10px;
}

.big-icon {
	font-size: 5rem; /* Adjust the font size as needed */
}
</style>
<body>
	<%@ include file="nav_bar.jsp"%>
	<div class="container">
		<div class="main_contents">
			<div id="sub_content" style="overflow: auto;">
				<form action="student_registration" method="post"
					enctype="multipart/form-data" onsubmit="return validateForm()">
					<h2 class="col-md-6 offset-md-2 mb-5 mt-4">Student
						Registration</h2>

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="studentID" class="col-md-2 col-form-label">Student
							ID</label>
						<div class="col-md-4">
							<input type="text" class="form-control" value="STU${stu_id }"
								id="studentID" disabled> <input type="hidden"
								class="form-control" value="${stu_id }" name="stu_id"
								id="studentID">
						</div>
					</div>

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="name" class="col-md-2 col-form-label">Name</label>
						<div class="col-md-4">
							<input type="text" class="form-control" id="name" name="name"
								onfocus="clearError('nameError')"> <small id="nameError"
								class="text-danger"></small>
						</div>
					</div>

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="dob" class="col-md-2 col-form-label">DOB</label>
						<div class="col-md-4">
							<input type="date" class="form-control" id="dob" name="dob"
								onfocus="clearError('dobError')"> <small id="dobError"
								class="text-danger"></small>
						</div>
					</div>

					<fieldset class="row mb-4">
						<div class="col-md-2"></div>
						<label class="col-form-label col-md-2 pt-0">Gender</label>
						<div class="col-md-4">
							<div class="form-check-inline">
								<input class="form-check-input" type="radio" name="gender"
									id="genderMale" value="Male"> <label
									class="form-check-label" for="genderMale"> Male </label>
							</div>
							<div class="form-check-inline">
								<input class="form-check-input" type="radio" name="gender"
									id="genderFemale" value="Female"> <label
									class="form-check-label" for="genderFemale"> Female </label>
							</div>
							<small id="genderError" class="text-danger"></small>
						</div>
					</fieldset>

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="phone" class="col-md-2 col-form-label">Phone</label>
						<div class="col-md-4">
							<input type="number" class="form-control" id="phone" name="phone"
								onfocus="clearError('phoneError')"> <small
								id="phoneError" class="text-danger"></small>
						</div>
					</div>

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="education" class="col-md-2 col-form-label">Education</label>
						<div class="col-md-4">
							<select class="form-select" aria-label="Education" id="education"
								name="education">
								<option value="Bachelor of Information
									Technology"
									selected>Bachelor of Information Technology</option>
								<option value="Diploma in IT">Diploma in IT</option>
								<option value="Bachelor of Computer Science">Bachelor
									of Computer Science</option>
							</select>
						</div>
					</div>

					<fieldset class="row mb-4">
						<div class="col-md-2"></div>
						<label class="col-form-label col-md-2 pt-0">Attend</label>
						<div class="col-md-4">
							<c:forEach items="${lst }" var="lst">
								<input class="form-check-input" type="checkbox"
									name="attendance" id="attend${lst.id}" value="${lst.id}">
								<label class="form-check-label" for="attend${lst.id}">${lst.name }</label>&nbsp;&nbsp;
							</c:forEach>
							<small id="attendError" class="text-danger"></small>
						</div>
					</fieldset>

					<div class="row">
						<div class="col-md-2"></div>
						<label for="photo" class="col-md-2 col-form-label">Photo</label>
						<div class="col-md-4">
							<div class="tm-product-img-dummy mx-auto">
								<img id="previewImage" src="#" alt="Preview Image"
									style="display: none;" /> <i class='bx bxs-image-add big-icon'
									onclick="document.getElementById('fileInput').click();"></i>
							</div>
							<div class="custom-file mt-3 mb-3 text-center">
								<input type="file" class="form-control" id="fileInput"
									name="imageFile" style="display: none;"
									onchange="previewFile();" /> <input type="button" name="file"
									class="btn btn-primary" id="file" value="UPLOAD"
									onclick="document.getElementById('fileInput').click();"
									onfocus="clearError()" />
							</div>
							<span id="imageError" class="text-danger"></span>
						</div>
					</div>

					<div class="row mb-4">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<button type="reset" class="btn btn-danger">Reset</button>
							<button type="button" class="btn btn-primary" id="submitButton">Add</button>

							<div class="modal fade" id="exampleModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Student
												Registration</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<h5 style="color: rgb(127, 209, 131);">Registered
												Succesfully !</h5>
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
	function previewFile() {
	    const preview = document.getElementById('previewImage');
	    const file = document.getElementById('fileInput').files[0];
	    const error = document.getElementById('imageError');

	    // Clear any previous errors
	    error.textContent = '';

	    if (file) {
	        if (file.type.startsWith('image/')) {
	            const reader = new FileReader();

	            reader.onloadend = function() {
	                preview.src = reader.result;
	                preview.style.display = 'block';
	            };

	            reader.readAsDataURL(file);
	        } else {
	            error.textContent = 'Please select a valid image file.';
	            preview.style.display = 'none';
	        }
	    } else {
	        preview.src = '';
	        preview.style.display = 'none';
	    }
	}
	
		function clearError(elementId) {
			document.getElementById(elementId).textContent = '';
		}
		
		function validateForm() {
		    let valid = true;

		    // Clear previous error messages
		    document.querySelectorAll('small.text-danger').forEach(el => el.textContent = '');

		    // Validate Name
		    const name = document.getElementById('name').value;
		    if (name.trim() === '') {
		        document.getElementById('nameError').textContent = 'Name is required.';
		        valid = false;
		    } 

		    // Validate DOB
		    const dob = document.getElementById('dob').value;
		    if (dob === '') {
		        document.getElementById('dobError').textContent = 'Date of Birth is required.';
		        valid = false;
		    }else if (!isValidDOB(dob)) {
		        document.getElementById('dobError').textContent = 'Enter a valid Date of Birth.';
		        valid = false;
		    }

		    // Validate Gender
		    const genderMale = document.getElementById('genderMale').checked;
		    const genderFemale = document.getElementById('genderFemale').checked;
		    if (!genderMale && !genderFemale) {
		        document.getElementById('genderError').textContent = 'Gender is required.';
		        valid = false;
		    }

		    // Validate Phone
		    const phone = document.getElementById('phone').value;
		    if (phone.trim() === '') {
		        document.getElementById('phoneError').textContent = 'Phone number is required.';
		        valid = false;
		    } else if (!/^\d{11}$/.test(phone)) {  // Assuming a 11-digit phone number format
		        document.getElementById('phoneError').textContent = 'Enter a valid 11-digit phone number.';
		        valid = false;
		    }

		    // Validate Education
		    const education = document.getElementById('education').value;
		    if (education === '') {
		        document.getElementById('educationError').textContent = 'Education is required.';
		        valid = false;
		    }

		    // Validate Attend
		    const attendance = document.querySelectorAll('input[name="attendance"]:checked');
		    if (attendance.length === 0) {
		        document.getElementById('attendError').textContent = 'At least one attendance option must be selected.';
		        valid = false;
		    }
		    
		 	// Validate Image
		    const fileInput = document.getElementById('fileInput');
		    const file = fileInput.files[0];
		    if (!file) {
		        document.getElementById("imageError").textContent = "Please upload an image.";
		        valid = false;
		    } else if (!file.type.startsWith('image/')) {
		        document.getElementById("imageError").textContent = "Please select a valid image file.";
		        valid = false;
		    }
		    
		    return valid;
		}
		
		function isValidDOB(dob) {
		    // Parse the date parts
		    const [year, month, day] = dob.split('-').map(Number);

		    // Check if the date is valid
		    const date = new Date(year, month - 1, day);
		    if (date.getFullYear() !== year || date.getMonth() !== month - 1 || date.getDate() !== day) {
		        return false;
		    }

		    // Check if the date is not in the future
		    const today = new Date();
		    if (date > today) {
		        return false;
		    }

		    // Optional: Check if the person is at least a certain age (e.g., 18 years)
		    const minAge = 18;
		    const age = today.getFullYear() - year;
		    const monthDiff = today.getMonth() - (month - 1);
		    const dayDiff = today.getDate() - day;

		    if (age < minAge || (age === minAge && (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)))) {
		        return false;
		    }

		    return true;
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