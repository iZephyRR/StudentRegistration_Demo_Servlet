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
<title>Students</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/text.css">
</head>
<style>
.table-container {
	background-color: white;
	color: black;
	border: 1px solid #ced4da;
	padding: 15px;
	width: 80%;
	border-radius: 10px;
	overflow: hidden;
	max-height: 80vh;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

body {
	overflow-y: auto;
}
</style>
<body>
	<%@ include file="nav_bar.jsp"%>
	<div class="container">
		<div class="main_contents">
			<div id="sub_content" style="overflow: auto;">
				<form class="row g-3 mt-3 ms-2" action="student_search"
					method="post" onsubmit="return validateForm()">
					<div class="col-auto">
						<input type="text" class="form-control" id="stu_id" name="stu_id"
							placeholder="Student ID"> <small id="idError"
							class="text-danger"></small>
					</div>
					<div class="col-auto">
						<input type="text" class="form-control" id="stu_name"
							name="stu_name" placeholder="Student Name"> <small
							id="nameError" class="text-danger"></small>
					</div>
					<div class="col-auto">
						<input type="text" class="form-control" id="course" name="course"
							placeholder="Course"> <small id="courseError"
							class="text-danger"></small>
					</div>
					<div class="col-auto">
						<button type="submit" class="btn btn-success mb-3">Search</button>
					</div>
					<div class="col-auto">
						<button type="reset" class="btn btn-secondary mb-3">Reset</button>
					</div>
				</form>

				<div class="table-container">
					<table id="example" class="table table-striped table-bordered"
						style="width: 100%; border-radius: 10px;">
						<thead>
							<tr>
								<th class="text-center">Student ID</th>
								<th class="text-center">Name</th>
								<th class="text-center">Courses</th>
								<th class="text-center">Detail</th>
								<th class="text-center">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${stu_lst}" var="lst">
								<tr>
									<td class="text-center">STU${lst.stu_id}</td>
									<td class="text-center">${lst.name}</td>
									<td class="text-center">${lst.courses_name}</td>
									<td class="text-center"><a
										href="<c:url value = 'student_detail?stuId=${lst.id }'/> "><button
												type="button" class="btn btn-primary">See More</button></a></td>
									<td class="text-center"><c:choose>
											<c:when test="${lst.is_delete == 0 }">
												<a href="<c:url value='remove_student?stuId=${lst.id }'/> "><button
														type="button" class="btn btn-danger">Disable</button></a>
											</c:when>
											<c:otherwise>
												<a href="<c:url value='add_student?stuId=${lst.id }'/> ">
													<button type="button" class="btn btn-primary">Enable</button>
												</a>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div id="testfooter">
		<span style="color: black;">Copyright &#169; ACE Inspiration
			2024</span>
	</div>

	<!-- Include jQuery, Popper.js, and Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- Include DataTables JS -->
	<script
		src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

	<script>
		$(document).ready(function() {
			$('#example').DataTable({
				"paging" : true,
				"searching" : false,
				"ordering" : true,
				"info" : true,
				"autoWidth" : false,
				"responsive" : true,
				"columnDefs" : [ {
					"width" : "20%",
					"targets" : 0
				}, {
					"width" : "30%",
					"targets" : 1
				}, {
					"width" : "30%",
					"targets" : 2
				}, {
					"width" : "20%",
					"targets" : 3
				} ]
			});
		});

		function validateForm() {
			const stuId = document.getElementById('stu_id').value;
			const stuName = document.getElementById('stu_name').value;
			const course = document.getElementById('course').value;

			const idError = document.getElementById('idError');
			const nameError = document.getElementById('nameError');
			const courseError = document.getElementById('courseError');

			// Clear previous error messages
			idError.textContent = '';
			nameError.textContent = '';
			courseError.textContent = '';

			if (!stuId && !stuName && !course) {
				const errorMessage = 'Please enter at least one field';
				idError.textContent = errorMessage;
				nameError.textContent = errorMessage;
				courseError.textContent = errorMessage;
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
