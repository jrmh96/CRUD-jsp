<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>		
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>	
	</head>
	
	<body>
	<div class="col-xs-6">
	<h1>Login</h1>
	<br/>
	
	<spring:url value="/checklogin" var="checkLogin"/>
	
	<form:form method="post" modelAttribute="user" action="checklogin" id="loginForm">
		<spring:bind path="username">
			<div class="form-group">
				User Name:
					<form:input path="username" type="text" class="form-control"
						id="fn" placeholder="Enter Username"/>
			</div>
        </spring:bind>
        <br/><br/>
	    <button type="submit" class="btn btn-default">Login</button>
	
		<spring:bind path="password">
			<div class="form-group">
				Password:
					<form:input path="password" type="password" class="form-control"
						id="ln" placeholder="Enter Password"/>
			</div>	
		</spring:bind>	
	</form:form>
	
	
	</div>	
	</body>
	
</html>