<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<title>course_registration</title>
</head>
<style>
h2, label {
	color: black;
}

.modal-header, .modal-body {
	color: black;
}

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


.couTable {
	margin-left: 80px;
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
</style>
<body>
	<%@ include file="nav_bar.jsp"%>
	<div class="container">
		<div class="main_contents">
			<div id="sub_content" style="overflow:auto;">
				<form action="course_registration" method="post"
					onsubmit="return validateForm()">
					<h2 class="col-md-6 offset-md-2 mb-5 mt-4">Course Registration</h2>
					<div class="row mb-4">
						<div class="col-md-2"></div>
						<label for="name" class="col-md-2 col-form-label">Course
							Name</label>
						<div class="col-md-4">
							<input type="text" class="form-control" id="name" name="name"
								onfocus="clearError('nameError')"> <small id="nameError"
								class="text-danger">${duplicate }</small>
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
											<h5 class="modal-title" id="exampleModalLabel">Course
												Registration</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<h5 style="color: rgb(127, 209, 131);">Are you sure to
												register?</h5>
										</div>
										<div class="modal-footer">
											<button type="submit" class="btn btn-success col-md-2"
												id="submitModalButton">Ok</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>

				<div class="table-container" style="margin-top: 10px;">
					<div class="row">
						<div class="col-md-11">
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
											<th class="text-center">Number of Students</th>
											<th class="text-center">Registered Date</th>
											<th class="text-center">Action</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${cou_list}" var="lst">
											<tr>
												<td class="text-center">${lst.name}</td>
												<td class="text-center">${lst.count}</td>
												<td class="text-center">${lst.create_date}</td>
												<td class="text-center"><c:choose>
														<c:when test="${lst.is_delete == 0 }">
															<a
																href="<c:url value='remove_course?courseId=${lst.id }'/>">
																<button type="button" class="btn btn-danger">Disable</button>
															</a>
														</c:when>
														<c:otherwise>
															<a href="<c:url value='add_course?courseId=${lst.id }'/>">
																<button type="submit" class="btn btn-primary">Enable</button>
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
			var nameInput = document.getElementById('name').value.trim();

			if (nameInput === "") {
				document.getElementById('nameError').textContent = "Course name cannot be empty.";
				return false;
			}

			document.getElementById('nameError').textContent = ""; // Clear any previous error message
			return true; // Allow form submission
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
