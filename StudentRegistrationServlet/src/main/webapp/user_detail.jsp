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
<title>User Detail</title>

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
	background-color:;
	color: black;
	padding-top: 15px;
	padding-left: 15px;
	padding-right: 15px;
	padding-bottom: 15px;
	width: 79%;
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

/* Set a fixed size for the image cell */
td.image-cell {
	width: 75px; /* Set this to your preferred width */
	height: 75px; /* Set this to your preferred height */
	text-align: center;
	vertical-align: middle;
}

/* Make the image fit the cell */
td.image-cell img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* Cover the cell while maintaining aspect ratio */
	border-radius: 10px;
}
</style>
<body>
	<%@ include file="nav_bar.jsp"%>
	<div class="container">
		<div class="main_contents">
			<div id="sub_content" style="padding-top: 30px; overflow: auto;">
				<div class="table-container row">
					<div class="stuTable col-md-7">
						<div class="head">
							<h4 style="text-align: left;">Student List</h4>
						</div>
						<br>
						<table id="stuTable" class="table table-striped table-bordered"
							style="width: 100%; border-radius:10px;">
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
								<c:forEach items="${stu_list }" var="lst">
									<tr>
										<td class="text-center" style="padding:35px;">STU${lst.stu_id }</td>
										<td class="image-cell"><img
											src="data:image/jpeg;base64,${lst.image}" alt="Preview">
										</td>
										<td class="text-center" style="padding:35px;">${lst.name }</td>
										<td class="text-center" style="padding:35px;">${lst.gender }</td>
										<td class="text-center" style="padding:35px;">${lst.create_date }</td>
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
								style="width: 100%">
								<thead>
									<tr>
										<th class="text-center">Name</th>
										<th class="text-center">Registered Date</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${cou_list }" var="lst">
										<tr>
											<td class="text-center">${lst.name }</td>
											<td class="text-center">${lst.create_date }</td>
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
			$('#stuTable').DataTable({
				"searching" : false
			});
		});
		$(document).ready(function() {
			$('#couTable').DataTable({
				"searching" : false
			});
		});
	</script>
</body>
</html>
