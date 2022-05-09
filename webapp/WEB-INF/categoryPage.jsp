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
						/&nbsp; Categories&nbsp;<i class='bi bi-tag'></i>
					</li>
				</ol>
			</nav>
			<div>
				<div
					class='row row-cols-2 row-cols-lg-6 g-2 g-lg-3 py-4 d-flex flex-wrap'>

					<a href='/recipe/category/beef'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013372858-beef.jpeg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Beef</b>
						</div>
					</a> <a href='/recipe/category/burgers'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013873488-burgers.jpeg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Burgers</b>
						</div>
					</a> <a href='/recipe/category/casseroles'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651015775447-Casseroles.jpeg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Casseroles</b>
						</div>
					</a> <a href='/recipe/category/other'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651015839347-viewmorecat.jpeg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Other</b>
						</div>
					</a> <a href='/recipe/category/pasta'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651015921013-pasta1.jpeg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Pasta</b>
						</div>
					</a> <a href='/recipe/category/pizza'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651015988938-pizza.jpeg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Pizza</b>
						</div>
					</a> <a href='/recipe/category/pork'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013353536-pork.webp"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Pork</b>
						</div>
					</a> <a href='/recipe/category/sandwich'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013421616-sandwich.jpg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Sandwich</b>
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
					</a> <a href='/recipe/category/Sides'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651016227955-sides.jpeg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Side Dishes</b>
						</div>
					</a><a href='/recipe/category/Vegetarian'
						class='category__a href text-center'>
						<div class='category__img shadow category__link'>
							<img
								src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651013269242-vegetarian.jpeg"
								alt="" />
						</div>
						<div class='pt-1'>
							<b>Vegetarian</b>
						</div>
					</a><a href='/recipe/category/SlowCooker' class='category__a href text-center'>
				<div class='category__img shadow category__link'>
					<img src="https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651016285317-slowcook.webp" alt="" />
				</div>
				<div class='pt-1'>
					<b>Slow Cooker</b>
				</div>
			</a>






				</div>
				<div class='px-4 py-5 my-5 text-center'>
					<img class='d-block mx-auto mb-4 img-fluid' loading='lazy'
				src='https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651018899842-Untitled.png'></img>
				</div>
			</div>
			)
		</div>

	</div>
</body>
</html>