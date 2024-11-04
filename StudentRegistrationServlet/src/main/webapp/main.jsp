<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
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
<!-- Boxicons -->
<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css'
	rel='stylesheet'>
<title>Top Menu</title>
<style>
:root {
	--light: #f0f0f0;
	--dark: #333;
	--light-blue: #d9eaff;
	--blue: #007bff;
	--light-yellow: #fff7d9;
	--yellow: #ffc107;
	--light-orange: #ffe6d9;
	--orange: #fd7e14;
}

#sub_content .box-info {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	grid-gap: 24px;
	margin-top: 16px;
}

#sub_content .box-info li {
	padding: 20px;
	background: var(--light);
	border-radius: 20px;
	display: flex;
	align-items: center;
	grid-gap: 24px;
	background-color: white;
}

#sub_content .box-info li .bx {
	width: 100px;
	height: 100px;
	border-radius: 10px;
	font-size: 75px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#sub_content .box-info li:nth-child(1) .bx {
	background: var(--light-blue);
	color: var(--blue);
}

#sub_content .box-info li:nth-child(2) .bx {
	background: var(--light-yellow);
	color: var(--yellow);
}

#sub_content .box-info li:nth-child(3) .bx {
	background: var(--light-orange);
	color: var(--orange);
}

#sub_content .box-info li .text h4 {
	font-size: 24px;
	font-weight: 600;
	color: var(--dark);
}

#sub_content .box-info li .text p {
	color: var(--dark);
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

.stuTable {
	border-radius: 10px;
	padding: 15px;
	padding-left : 15px;
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
</style>
</head>
<body>
	<%@ include file="nav_bar.jsp"%>

	<div class="main-contents">
		<div id="contents">
			<div id="sub_content" style="overflow: auto;">
				<ul class="box-info" style="width: 80%;">
					<li><i class='bx bxs-calendar-check'></i> <span class="text">
							<h4>${courses }</h4>
							<h4>Courses</h4>
					</span></li>
					<li><i class='bx bxs-group'></i> <span class="text">
							<h4>${students }</h4>
							<h4>Students</h4>
					</span></li>
					<li><i class='bx bx-user-circle'></i> <span class="text">
							<h4>${users }</h4>
							<h4>Management</h4>
					</span></li>
				</ul>

				<div class="table-container" style="margin-top: 10px;">
					<div class="row">
						<div class="stuTable col-md-7" >
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
									<c:forEach items="${stu_lst}" var="lst">
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
											<th class="text-center">Number of Students</th>
											<th class="text-center">Registered Date</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${cou_list}" var="lst">
											<tr>
												<td class="text-center">${lst.name}</td>
												<td class="text-center">${lst.count}</td>
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
