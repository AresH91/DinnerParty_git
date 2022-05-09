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
						<input type="search" class="form-control" placeholder="Search..."
							aria-label="Search" name="query" />
						<button class="btn btn-sm btn-danger">Search</button>
					</div>

				</form>
			</div>
		</header>
		<nav aria-label='breadcrumb'>
			<ol class='breadcrumb'>
				<li class='breadcrumb-item'><a href='/'>Home</a></li>
				<li class='breadcrumb-item-active' aria-current="page">&nbsp;
					/&nbsp; Submit your recipe</li>
			</ol>
		</nav>
		<div class='px-4 py-5 my-5 text-center'>
			<h1 class='display-5 fw-bold'>Submit Your Recipe</h1>
			<div class='col-lg-6 mx-auto'>
				<p class='lead'>Share your amazing recipes with your Dinner
					Party Community!! Fill out our form to get started!</p>
			</div>
		</div>

		<div class='row justify-content-center'>
			<div class='col-8 p-3'>
				<form:form action="/edit/recipe/${recipe.id}" method="post"
					modelAttribute="recipe" class="formbox p-3"
					enctype="multipart/form-data">
					<form:hidden path="submitter" value="${userId }" />
					<div class='row g-3 d-flex justify-content-center'>
						<div class='col-12'>
							<form:hidden path="image"/>
						</div>
						<div class='col-12'>
							<form:label path="name" class="form-label"> Name </form:label>
							<form:input path="name" class="form-control" />
							<form:errors path="name" class="text-danger" />
						</div>
						<div class='col-12'>
							<label class='form-label'>Recipe Category</label>
							<form:errors path="category" class="text-danger" />
							<form:select path="category" class='form-select'>
								<option value="Beef">Beef</option>
								<option value="Burgers">Burgers</option>
								<option value="Casseroles">Casseroles</option>
								<option value="Other">Other</option>
								<option value="Pasta">Pasta</option>
								<option value="Pizza">Pizza</option>
								<option value="Pork">Pork</option>
								<option value="Sandwich">Sandwich</option>
								<option value="Seafood">Seafood</option>
								<option value="Sides">Side Dishes</option>
								<option value="Vegetarian">Vegetarian</option>
								<option value="SlowCooker">Slow Cooker</option>
							</form:select>
						</div>
						<div class='col-12'>
							<form:label path="directions" class="form-label">Directions </form:label>
							<form:textarea rows="4" cols="20" path="directions"
								class="form-control" />
							<form:errors path="directions" class="text-danger" />
						</div>
						<div class='col-12 mt-2'>

							<form:label path="ingredients" class="form-label">Ingredients </form:label>
							<form:textarea rows="4" cols="20" path="ingredients"
								class="form-control" />
							<form:errors path="ingredients" class="text-danger" />
							<small>Please Separate Ingredients by a Comma! Example: 1
								Cup Flour, 1 Whole Egg, 1 Tsp Salt</small>

						</div>
						<button class='btn btn-danger mb-5 w-50'>Submit</button>
					</div>
				</form:form>
			</div>
		</div>
		<div class='text-center mt-4'>
			<h4>Thank You For Your Contribution!!</h4>
			<div class='px-4 py-5 my-5 text-center'>
				<img class='d-block mx-auto mb-4 img-fluid' loading='lazy'
					src='https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651018899842-Untitled.png'></img>
			</div>

		</div>

	</div>
</body>
</html>