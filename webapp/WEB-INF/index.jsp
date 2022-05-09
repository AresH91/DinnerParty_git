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

		<div class='row flex-lg-row-reverse align-items-center g-5 py-4 mb-4'>
			<div class='col-12 col-lg-6'>
				<c:choose>
					<c:when test="${ userId == null}">
						<h1 class='display-5 fw-bold mb-3'>Enjoy our selection of
							delicious recipes!</h1>
						<p class='lead'>Explore our selection of delicious recipes and
							plan your own special Dinner Party!!</p>
						<div class='d-grip gap-2 d-md-flex justify-content-center'>
							<a href="/login"><button class="btn btn-outline-danger">Login
									/ Register</button></a>

							<div class='col-md-5 text-end'>
								<form action="/code/search">
									<div class="form-group d-flex">
										<input type="search" class="form-control"
											placeholder="Find Party by Code" aria-label="Search" name="query" />
										<button class="btn btn-sm btn-danger">Find</button>
									</div>

								</form>
							</div>

						</div>
					</c:when>
					<c:otherwise>
						<h1 class='display-5 fw-bold mb-3'>Enjoy our selection of
							delicious recipes!</h1>
						<p class='lead'>Create your own Dinner Party today, and start
							assigning your recipes!!</p>
						<div class='d-grip gap-2 d-md-flex justify-content-center'>
							<a href="/create/dinnerparty">
								<button class="btn btn-outline-danger">Create a Dinner
									Party</button>
							</a>
							<div class='col-md-5 text-end'>
								<form action="/code/search">
									<div class="form-group d-flex">
										<input type="search" class="form-control"
											placeholder="Find Party by Code" aria-label="Search" name="query" />
										<button class="btn btn-sm btn-danger">Find</button>
									</div>

								</form>
							</div>
						</div>
					</c:otherwise>
				</c:choose>

			</div>
			<div class='col-12 col-lg-6'>
				<img
					src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651018009400-realdinnerparty.png"
					alt="" width='1200' height='510'
					class='d-block mx-lg-auto img-fluid' />
			</div>

		</div>
		<div class='pb-4 pt-4 border-bottom mb-2'>
			<div class='d-flex mb-2 align-items-center'>
				<h2>Latest Recipes</h2>
				<a href="/recipes" class='ms-auto'>View More</a>
			</div>

			<div class='row row-cols-2 row-cols-lg-5 g-2 g-lg-3'>
				<c:forEach var="recipe" items="${topRecipes }">
					<a href="/recipe/${recipe.id}"
						class='col text-center category__link'>
						<div class='category__img category__img--large shadow'>
							<img src="<c:out value="${recipe.image}"/>"
								alt="<c:out value="${recipe.name}"/>" />
						</div>
						<div class='pt-1'>
							<b><c:out value="${recipe.name}" /></b>
						</div>
					</a>
				</c:forEach>
			</div>


		</div>


		<div class='d-flex mb-2 align-items-center'>
			<h2>Categories</h2>
			<a href="/categories" class='ms-auto'> View More </a>
		</div>
		<div class='row row-cols-2 row-cols-lg-6 g-2 g-lg-3 py-4'>

			<a href='/recipe/category/beef' class='category__a href text-center'>
				<div class='category__img shadow category__link'>
					<img
						src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013372858-beef.jpeg"
						alt="" />
				</div>
				<div class='pt-1'>
					<b>Beef</b>
				</div>
			</a> <a href='/recipe/category/pork' class='category__a href text-center'>
				<div class='category__img shadow category__link'>
					<img
						src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013353536-pork.webp"
						alt="" />
				</div>
				<div class='pt-1'>
					<b>Pork</b>
				</div>
			</a> <a href='/recipe/category/seafood'
				class='category__a href text-center'>
				<div class='category__img shadow category__link'>
					<img
						src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013331834-seafood.webp"
						alt="" />
				</div>
				<div class='pt-1'>
					<b>Seafood</b>
				</div>
			</a> <a href='/recipe/category/sandwhich'
				class='category__a href text-center'>
				<div class='category__img shadow category__link'>
					<img
						src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013421616-sandwich.jpg"
						alt="" />
				</div>
				<div class='pt-1'>
					<b>Sandwiches</b>
				</div>
			</a> <a href='/recipe/category/vegetarian'
				class='category__a href text-center'>
				<div class='category__img shadow category__link'>
					<img
						src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013269242-vegetarian.jpeg"
						alt="" />
				</div>
				<div class='pt-1'>
					<b>Vegetarian</b>
				</div>
			</a> <a href='/categories' class='category__a href text-center'>
				<div class='category__img shadow category__link'>
					<img
						src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013116763-viewmorecat.jpeg"
						alt="" />
				</div>
				<div class='pt-1'>
					<b>View All</b>
				</div>
			</a>


		</div>



		<div class='px-4 py-5 my-5 text-center'>
			<img class='d-block mx-auto mb-4 img-fluid' loading='lazy'
				src='https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651018899842-Untitled.png'></img>
			<c:choose>
				<c:when test="${ userId == null}">
					<h1 class='display-5 fw-bold'>Dinner Party Planning</h1>
					<div class='col-lg-6 mx-auto'>
						<p class='lead mb-4'>Organize your own Dinner Party by
							creating an account!</p>
						<div class='d-grid gap-2 d-sm-flex justify-content-sm-center'>
							<a href="/login" class='btn btn-danger btn-lg'> Register </a>
						</div>
				</c:when>

				<c:otherwise>
					<h1 class='display-5 fw-bold'>Start saving recipes and make a
						Dinner Party!</h1>
					<div class='col-lg-6 mx-auto'>
						<p class='lead mb-4'>Click below to get started!!</p>
						<div class='d-grid gap-2 d-sm-flex justify-content-sm-center'>
							<a href="/create/dinnerparty" class='btn btn-danger btn-lg'>
								Create Dinner Party </a>
						</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	</div>
</body>
</html>