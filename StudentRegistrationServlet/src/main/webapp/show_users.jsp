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

<style>
.table-container {
	background-color: white;
	color: black;
	border: 1px solid #ced4da;
	padding: 15px;
	width: 80%;
	border-radius: 10px;
	overflow: auto;
	max-height: 80vh;
}
</style>
</head>
<body>
	<%@ include file="nav_bar.jsp"%>
	<div class="container">
		<div class="main_contents">
			<div id="sub_content" style="padding-top: 30px;">

				<form class="row g-3 mt-3 ms-2" method="post" action="user_search"
					onsubmit="return validateForm()">
					<div class="col-auto">
						<input type="text" class="form-control" id="userId" name="userId"
							placeholder="User ID"> <small id="idError"
							class="text-danger"></small>
					</div>
					<div class="col-auto">
						<input type="text" class="form-control" id="username" name="name"
							placeholder="User Name"> <small id="nameError"
							class="text-danger"></small>
					</div>
					<div class="col-auto">
						<button type="submit" class="btn btn-primary mb-3">Search</button>
					</div>
					<div class="col-auto">
						<a href="<c:url value='user_registration'/>">
							<button type="button" class="btn btn-secondary">Add</button>
						</a>
					</div>
					<div class="col-auto">
						<button type="reset" class="btn btn-danger mb-3">Reset</button>
					</div>
				</form>

				<div class="table-container">
					<table id="example" class="table table-striped table-bordered"
						style="width: 100%; border-radius: 10px;">
						<thead>
							<tr>
								<th class="text-center">User ID</th>
								<th class="text-center">User Name</th>
								<th class="text-center">Register Date</th>
								<th class="text-center">Detail</th>
								<th class="text-center">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${users_lst }" var="lst">
								<tr>
									<td class="text-center">USR${lst.user_id }</td>
									<td class="text-center">${lst.name }</td>
									<td class="text-center">${lst.date }</td>
									<td class="text-center"><a
										href="<c:url value='user_detail?userId=${lst.id }'/>">
											<button type="button" class="btn btn-primary">See
												More</button>
									</a></td>
									<td class="text-center"><c:choose>
											<c:when test="${loginUserRole == 0}">
												<c:choose>
													<c:when test="${lst.is_delete == 0 }">
														<a href="<c:url value='remove_user?userId=${lst.id }'/>">
															<button type="button" class="btn btn-danger">Disable</button>
														</a>
													</c:when>
													<c:otherwise>
														<a href="<c:url value='add_user?userId=${lst.id }'/>">
															<button type="submit" class="btn btn-primary">Enable</button>
														</a>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
                                                &nbsp;
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

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

	<script>
		$(document).ready(function() {
			$('#example').DataTable({
				"searching" : false
			});
		});

		function validateForm() {
			const id = document.getElementById('userId').value.trim();
			const name = document.getElementById('username').value.trim();

			let isValid = true;

			if (id === '' && name === '') {
				document.getElementById('idError').textContent = 'Please enter at least one field';
				document.getElementById('nameError').textContent = 'Please enter at least one field';
				isValid = false;
			} else {
				document.getElementById('idError').textContent = '';
				document.getElementById('nameError').textContent = '';
			}
			return isValid;
		}
	</script>
</body>
</html>
