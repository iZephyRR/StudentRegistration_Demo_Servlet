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
<title>student_registration</title>
</head>
<style>
h2, label {
	color: black;
}

.modal-header, .modal-body {
	color: black;
}
</style>
<body>
	<%@ include file="nav_bar.jsp"%>
	<div class="container">
		<div class="main_contents">
			<div id="sub_content" style="overflow: auto;">
				<form action="student_update" method="post" onsubmit="return validateForm()">
					<h2 class="col-md-6 offset-md-2 mb-5 mt-4">Student
						Registration</h2>

					<input type="hidden" class="form-control" value="${student.id }"
						name="stuId" id="studentID">

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="name" class="col-md-2 col-form-label">Name</label>
						<div class="col-md-4">
							<input type="text" class="form-control" id="name" name="name"
								value="${student.name }" onfocus="clearError('nameError')">
							<div>
								<small id="nameError" class="text-danger"></small>
							</div>
						</div>
					</div>

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="dob" class="col-md-2 col-form-label">DOB</label>
						<div class="col-md-4">
							<input type="date" class="form-control" id="dob" name="dob"
								value="${student.dob }" onfocus="clearError('dobError')">
							<div>
								<small id="dobError" class="text-danger"></small>
							</div>
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
							<div>
								<small id="genderError" class="text-danger"></small>
							</div>
						</div>
					</fieldset>

					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="phone" class="col-md-2 col-form-label">Phone</label>
						<div class="col-md-4">
							<input type="number" class="form-control" id="phone" name="phone"
								value="${student.phone }" onfocus="clearError('phoneError')">
							<div>
								<small id="phoneError" class="text-danger"></small>
							</div>
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
									name="attendance" id="attend${lst.id}" value="${lst.id}"
									<c:if test="${enrolledCourses.contains(lst.id)}">checked</c:if>>
								<label class="form-check-label" for="attend${lst.id}">${lst.name }</label>
							</c:forEach>
							<div>
								<small id="attendError" class="text-danger"></small>
							</div>
						</div>
					</fieldset>

					<div class="row mb-4">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<button type="button" class="btn btn-primary" id="submitButton">Update</button>
							<button type="reset" class="btn btn-danger">Reset</button>
							<a href="<c:url value='student_detail?stuId=${student.id }'/>"><button type="button" class="btn btn-primary">Back</button></a>

							<div class="modal fade" id="exampleModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Update
												Student Detail</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<h5 style="color: rgb(127, 209, 131);">Updated
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
		    } else if (!isValidDOB(dob)) {
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