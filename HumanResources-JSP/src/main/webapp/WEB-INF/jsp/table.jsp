<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">

<head>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css"></link>
	
</head>

<body>

<h2>Employees:</h2>
	<div style="text-align:right"><a href="/create" class="btn btn-success">Create New Employee</a>
	 <a href="/logout" class="btn btn-danger">Logout</a>
	</div><br/>
	<table id="hr-table" class="display">
		<c:forEach var="emp" items="${employees}">
			<c:out value="${firstName}"/>
			<c:out value="${lastName}"/>
		</c:forEach>			
	</table>
	
	<div class="container">
		<table class="table table-striped">
		<thead>
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Job</th>
				<th>Department ID</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
		</thead>
		
		<c:forEach var="emp" items="${employees}">
		<tr>
			<td>${emp.firstName}</td>
			<td>${emp.lastName}</td>
			<td>${emp.jobTitle}</td>
			<td>${emp.departmentID}</td>
			<td>
			<spring:url value="/users/${emp.ID}/update" var="updateURL"/> 
			<a class="btn btn-success" href="/update?id=${emp.ID}">Update</a>
			</td>
			<td>
			<spring:url value="/users/${emp.ID}/delete" var="deleteURL"/>
			<a class="btn btn-danger" href="/deleteEmployee?id=${emp.ID}">Delete</a>
			</td>
		</tr>
		</c:forEach>
		
		</table>		
	</div>

</body>

</html>