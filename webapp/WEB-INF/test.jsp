<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tacos</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/css/main.css">
<!-- change to match your file/naming structure -->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div>
		<form:form action="/api/recipes" method="post" modelAttribute="recipe"
			class="form-control" enctype="multipart/form-data">

			<div>
				<form:label path="name" class="form-label"> name </form:label>
				<form:input path="name" class="form-control" />
				<form:errors path="name" class="text-danger" />
			</div>
			<div>
				<form:label path="directions" class="form-label"> Directions </form:label>
				<form:input path="directions" class="form-control" />
				<form:errors path="directions" class="text-danger" />
			</div>
			<div>
				<form:label path="ingredients" class="form-label"> Ingredients </form:label>
				<form:input path="ingredients" class="form-control" />
				<form:errors path="ingredients" class="text-danger" />
			</div>
			<input type="file" name="file" class="custom-file-input"
					id="customFile"> <label class="custom-file-label"
					for="customFile">Product Image</label>

			<button class="btn btn-primary">Create</button>

		</form:form>
	</div>
</body>
</html>