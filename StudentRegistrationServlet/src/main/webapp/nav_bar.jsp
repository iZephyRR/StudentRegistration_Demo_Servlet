<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/text.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css'
	rel='stylesheet'>
</head>
<style>
p {
	color: black;
}

.modal-header, .modal-body {
	color: black;
}

ul {
	list-style-type: none; /* Remove bullets */
	padding: 0; /* Remove padding */
	margin: 0; /* Remove margins */
}
</style>
<body>
	<div id="testheader">
		<div class="container">
			<div class=row>
				<div class="col-md-4">
					<h3 style="font-weight: bold;">
						<a href="<c:url value="user_login"/> ">Student Registration</a>
					</h3>
				</div>
				<div class="col-md-6" style="font-size: 15px; font-weight: bold;">
					<p>
						<%
						out.print("USR" + session.getAttribute("userId") + " " + session.getAttribute("userName"));
						%>
					</p>
					<p>
						Current Date :
						<%=LocalDate.now()%>
					</p>
				</div>
				<div class="col-md-2">
					<a href="<c:url value='profile' />"><img
						src="data:image/jpeg;base64,<%=session.getAttribute("userImage")%>"
						alt="Preview"
						style="max-width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"></a>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="sidenav">
			<ul class="side-menu top">
				<li>
					<button class="dropdown-btn">
						Class Management <i class="fa fa-caret-down"></i>
					</button>

					<div class="dropdown-container">
						<a href="<c:url value="course_registration"/> ">Course
							Registration </a> <a href="<c:url value="student_registration"/> ">Student
							Registration </a> <a href="<c:url value="students"/> ">Students </a>
					</div>
				</li>
				<li><a href="<c:url value="management"/> ">Users Management</a>
				</li>
			</ul>
			<ul>
				<li><a href="#" onclick="showLogoutConfirmation()"><input
						type="button" class="btn btn-danger" id="lgnout-button"
						value="Sign Out"></a></li>
			</ul>
		</div>
	</div>

	<!-- Include Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="logoutModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="logoutModalLabel" style="color: red;">Confirm
						Logout</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" onclick="closeModal()">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="color: rgb(127, 209, 131);">Are
					you sure you want to log out?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="logout()">OK</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
		var dropdown = document.getElementsByClassName("dropdown-btn");
		var i;

		for (i = 0; i < dropdown.length; i++) {
			dropdown[i].addEventListener("click", function() {
				this.classList.toggle("active");
				var dropdownContent = this.nextElementSibling;
				if (dropdownContent.style.display === "block") {
					dropdownContent.style.display = "none";
				} else {
					dropdownContent.style.display = "block";
				}
			});
		}

		function showLogoutConfirmation() {
			$('#logoutModal').modal('show');
		}
		function closeModal() {
			$('#logoutModal').modal('hide');
		}
		function logout() {
			// Redirect to Ace_Mart/logout
			window.location.href = './log_out';
		}
	</script>
</body>
</html>