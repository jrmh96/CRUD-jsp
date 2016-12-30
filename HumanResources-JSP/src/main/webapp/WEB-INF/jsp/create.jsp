<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css"/>
	
	<script>
	function submitForm(){
		//validation
		if ($('#fn').val().length > 20) {
			alert('first name should be within 20 chars!');
			return false;
		}
		
		if($('#ln').val().length >20){
			alert('last name should be within 20 chars!');
			return false;
		}
		
		alert('are you sure?');
		$('#submitForm').submit();
	}
	
	</script>
</head>

<body>
<div class="col-xs-6">
	<h2>New Employee Form:</h2>
	<spring:url value="/create" var="userActionURL"/>
	<form:form method="post"
		modelAttribute="employee" action="/create" id="submitForm"/>
	<!-- First Name, Last Name, Phone, Salary, Department, Job Title,  -->
	<spring:bind path="firstName">
		<div class="form-group">
			First Name:
				<form:input path="firstName" type="text" class="form-control"
					id="fn" placeholder="Enter first name" />
		
		</div>
	</spring:bind>
	
	<spring:bind path="lastName">
		<div class="form-group">
			Last Name:
				<form:input path="lastName" type="text" class="form-control"
					id="ln" placeholder="Enter last name" />
		</div>
	</spring:bind>
	
	<spring:bind path="phoneNumber">
		<div class="form-group">
			Phone Number:
				<form:input path="phoneNumber" type="tel" class="form-control"
					id="phone" maxlength="12" placeholder="Enter Phone Number"/>
		</div>
	</spring:bind>
	
	<spring:bind path="salary">
		<div class="form-group">
			Salary:
				<form:input path="salary" type="number" type="tel" class="form-control"
					id="salary" placeholder="Enter Salary"/>
		</div>
	</spring:bind>
	
	<p>
	<spring:bind path="departmentID">
		Department:
			<form:select path="departmentID" name="department" class="form-group">
			<c:forEach items="${departments}" var="dept">
				<option value="${dept.DepartmentID}">${dept.deptName}</option>
			</c:forEach>
			</form:select>
	</spring:bind>
	</p>
	
	<p>
	<spring:bind path="jobID">
		Job Title: <form:select path="jobID" name="jobTitle" class="form-group">
			<c:forEach items="${jobs}" var="job">
				<option value="${job.JobID}">${job.JobTitle}</option>
			</c:forEach>
		</form:select>
	</spring:bind>
	</p>
	<div align="right">
		<a class="btn btn-danger" href="/logout">Logout</a> 
	</div>
	
        <button class="btn btn-success" value="Submit" id="submit">Submit</button>
        <button class="btn btn-primary" value="Reset" id="reset">Reset</button>

</div>

</body>

</html>