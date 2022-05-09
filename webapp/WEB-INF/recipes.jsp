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
<title>Dinner Party</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/css/main.css">
<!-- change to match your file/naming structure -->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class='container-xxl px-md-5 bg-white shadow-lg'>
		<header
			class='d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 border-bottom'>
			<a href="/"
				class='d-flex align-items-center- col-md-3 mb-2 mb-md-0 text-dark text-decoration-none'><img
				src='https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651016858890-Untitled_2.png' /></a>
			<ul
				class='nav col-12 col-md-auto mb-2 justify-content-center mb-md-0 gap-3'>
				<li><a href="/"
					class='nav-a href px-2 text-dark text-decoration-none'><b>Home</b></a>
				</li>
				<li><a href="/recipes"
					class='nav-a href col-md-auto mb-2 justify-content-center mb-md-0 text-dark text-decoration-none me-1'><b>Recipes</b></a>
				</li>
				<c:choose>
					<c:when test="${ userId != null}">
						<li><a href="/recipeform"
							class='nav-a href col-md-auto mb-2 justify-content-center mb-md-0 text-dark text-decoration-none'><b>Add
									Recipe</b></a></li>
						<li><a href="/dashboard"
							class='nav-a href col-md-auto mb-2 justify-content-center mb-md-0 text-dark text-decoration-none'><b>Dashboard</b></a></li>
							<li><a href="/logout"
							class='nav-a href col-md-auto mb-2 justify-content-center mb-md-0 text-dark text-decoration-none'><b>Logout</b></a></li>
					</c:when>

					<c:otherwise>
						<li><a href="/login"
							class='nav-a href col-md-auto mb-2 justify-content-center mb-md-0 text-dark text-decoration-none'><b>
									Login / Register</b></a></li>

					</c:otherwise>
				</c:choose>

			</ul>
			<div class='col-md-3 text-end'>
				<form action="/recipe/search">
				<div class="form-group d-flex"> 
				<input type="search" class="form-control" placeholder="Search..." aria-label="Search" name="query"/>
              <button class="btn btn-sm btn-danger">Search</button>
				</div>
             
            </form>
			</div>
		</header>
		<nav aria-label='breadcrumb'>
			<ol class='breadcrumb'>
				<li class='breadcrumb-item'><a href='/'>Home</a></li>
				<li class='breadcrumb-item-active' aria-current="page">&nbsp;
					/&nbsp; View Recipes</li>
			</ol>
		</nav>
		<div>
			<div
				class='row row-cols-2 row-cols-lg-5 g-2 g-lg-3 d-flex flex-wrap mt-4'>
			<c:forEach var="recipe" items="${recipes }">
				<a href="/recipe/${recipe.id}"
					class='col text-center category__link'>
					<div class='category__img category__img--large shadow'>
						<img src=${recipe.image} alt=${recipe.name}/>
					</div>
					<div class='pt-1'>
						<b><c:out value="${recipe.name }"/></b>
					</div>
				</a>
				</c:forEach>

			</div>
			<div class='px-4 py-5 my-5 text-center'>
				<img class='d-block mx-auto mb-4 img-fluid' loading='lazy'
				src='https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651018899842-Untitled.png'></img>
			</div>
		</div>
		<div>
			<br></br>
		</div>
	</div>
</body>
</html>