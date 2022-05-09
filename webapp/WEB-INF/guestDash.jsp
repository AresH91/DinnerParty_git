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

		<div
			class='row flex-lg-row-reverse align-items-center g-5 py-4 mb-4 justify-content-around'>
			<div class='col-12 col-lg-4 form-group text-center'>
				<h1>
					<c:out value="${party.name }" />
					Dashboard!
				</h1>

			</div>


		</div>
<%-- 		<div class='d-flex justify-content-center dashbox'>
			<div class='col-lg text-center dashbox'>
				<h3>Add Participant!</h3>
				<form:form action="/dinnerparty/addparticipant/" method="post"
					modelAttribute="participant" class="form-control">
					<div class="form-group">
						<input type="hidden" name="partyId" value="${party.id }">
						<form:label path="name" class="form-label">Participant Name:</form:label>
						<form:input path="name" class="form-control" />
						<form:errors path="name" class="text-danger" />
					</div>
					<button class="btn btn-outline-danger mt-1">Add</button>
				</form:form>

			</div>
		</div> --%>
		<div class='pb-4 pt-4 border-bottom mb-2'>
			<div class='col-12'>
				<h3>Participants</h3>

				<div
					class='row row-cols-2 row-cols-lg-5 g-2 g-lg-3 d-flex flex-wrap mt-4'>
					<c:forEach var="guest" items="${participants }">
						<div class='col text-center category__link2'>
							<div class='category__img category__img--large shadow'>
								<h3>
									<c:out value="${guest.name }" />
								</h3>

							</div>
							<div class="pt-1">
								<p>
									<b>Currently Assigned:</b>
								</p>
										<a href='/recipe/${guest.participantRecipe.id }'
											class='category__a href text-center'>
											<div class='category__img shadow category__link'>

												<img src="${guest.participantRecipe.image }" alt="" />
											</div>
											<div class='pt-1'>
												<b><c:out value="${guest.participantRecipe.name }" /></b>
											</div>
										</a>
							</div>
						</div>

					</c:forEach>
				</div>


			</div>
			<div class='col-12 mt-5'>
				<h3>All Party Recipes</h3>
				<div
					class='row row-cols-2 row-cols-lg-5 g-2 g-lg-3 d-flex flex-wrap mt-4'>
					<c:forEach var="recipe" items="${recipes }">
						<a href="/recipe/${recipe.id}"
							class='col text-center category__link'>
							<div class='category__img category__img--large shadow'>
								<img src=${recipe.image } alt=${recipe.name } />
							</div>
							<div class='pt-1'>
								<b><c:out value="${recipe.name }" /></b>
							</div>
						</a>
					</c:forEach>

				</div>
			</div>
		</div>
		<div class='d-flex mb-2 align-items-center'></div>

		<div class='px-4 py-5 my-5 text-center'>
			<img class='d-block mx-auto mb-4 img-fluid' loading='lazy'
				src='https://aresdinnerparty2.s3-us-west-2.amazonaws.com/1651018899842-Untitled.png'></img>
			<h1 class='display-5 fw-bold'>Dinner Party Planning</h1>
			<div class='col-lg-6 mx-auto'>
				<p class='lead mb-4'>Organize your own Dinner Party by creating
					an account!</p>
			</div>
		</div>

	</div>
</body>
</html>