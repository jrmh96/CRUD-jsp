<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css"/>
	
	<script>
	function submitForm(){
		if($('#fn').val().length>22){
			alert("First Name should be less than 22 characters")
		}
		
		if($('#ln').val().length>22){
			alert("Last Name should be less than 22 characters")
		}
		alert('Update User?')
		$('#updateForm').submit();
	}
	
	</script>

</head>

<body>
	<div class="col-xs-6">
		<h1>Update Employee Form</h1>
		<br/>
		<spring:url value="/update-save" var="updateUserURL"/>
		<form:form method="post" modelAttribute="employee" action="updateEmployee" id="updateForm">
		<c:forEach var="emp" items="${employee}">
			<form:input type="hidden" value="${emp.ID}" path="ID"/>
			<spring:bind path="firstName">
				<div class="form-group">
					First Name:
						<form:input path="firstName" type="text" class="form-control" id="fn" value="${emp.firstName}"/>
				</div>
			</spring:bind>
			
			<spring:bind path="lastName">
				<div class="form-group">
					Last Name:
						<form:input path="lastName" type="text" class="form-control" id="ln" value="${emp.lastName}"/>
				</div>
			</spring:bind>
			
			<spring:bind path="phoneNumber">
				<div class="form-group">
					Phone:
						<form:input path="phoneNumber" type="text" class="form-control" id="phone" value="${emp.phoneNumber}"/>
				</div>
			</spring:bind>
		
			<spring:bind path="salary">
				<div class="form-group">
					Salary:
						<form:input path="salary" class="form-control" id="salary" value="${emp.salary}"/>
				</div>
			</spring:bind>
		
			<spring:bind path="departmentID">
				<div>
				Department:
					<form:select path="departmentID" name="department" class="form-group"/>
					<c:forEach items="${departments}" var="dept">
						<option selected="${emp.department}" value="${dept.DepartmentID}">${dept.deptName}</option>
					</c:forEach>
				</div>
			</spring:bind>
			
			<spring:bind path="jobID">
				<div>
					Job Title:
						<form:select path="jobID" name="jobTitle" class="form-group">
						<c:forEach items="${jobs}" var="job">
							<option selected="${currentJob}" value="${job.jobID}">${job.jobTitle}</option>
						</c:forEach>
						</form:select>	
				</div>
			</spring:bind>
			
			<div align="right">
				<a class="btn btn-danger" href="/logout">Logout</a> 
			</div>
			<button type="button" class="btn btn-success" value="Submit" id="update"> Submit </button>
			<button class="btn btn-primary" value="Reset" id="reset">Reset</button>
			
		</c:forEach>
			
		</form:form>
	</div>
	
</body>

</html>