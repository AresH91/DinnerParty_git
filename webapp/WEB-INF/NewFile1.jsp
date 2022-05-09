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
				<h1 class="mb-4">
					<c:out value="${party.name }" />
					Dashboard!
				</h1>
				<h3>Party Code: <c:out value="${party.code }"/></h3>
				<div class="d-flex flex-row justify-content-center gap-2">
				<form action="/delete/party/${party.id }" method="post">
					<input type="hidden" name="_method" value="delete" />
					<button class="btn btn-danger btn-sm mb-5">Delete Party</button>
				</form>
				<a href="/edit/party/${party.id }"><button class="btn btn-outline-dark btn-sm btn-light text-danger">Edit Party</button></a>
				</div>
				<a href="#recipes"
					class="mt-5 text-decoration-none text-danger formbox p-1">View
					Recipes</a>
			</div>


		</div>
		<div class='d-flex flex-column justify-content-center dashbox'>
			<div class='col-lg text-center dashbox'>

				<form:form action="/dinnerparty/addparticipant/" method="post"
					modelAttribute="participant" class="formbox p-3">
					<h3>Add Participant!</h3>
					<div class="form-group">
						<input type="hidden" name="partyId" value="${party.id }">
						<form:label path="name" class="form-label">Participant Name:</form:label>
						<form:input path="name" class="form-control" />
						<form:errors path="name" class="text-danger" />
					</div>
					<button class="btn btn-outline-danger mt-1">Add</button>
				</form:form>

			</div>
			<div class='col-lg dashbox formbox p-3'>

				<h3>Tips:</h3>
				<ul>
					<li>Add your party participants!</li>
					<li>Assign their recipes from the ones you've selected</li>
					<li>Share your unique Code with your participants so they can
						find their recipe!</li>
					<li>Enjoy a dinner where everyone knows what to make and how
						to do so!</li>
				</ul>

			</div>
		</div>
		<div class='pb-4 pt-4 border-bottom mb-2'>
			<div class='col-12'>
				<h3>Participants</h3>

				<div
					class='row row-cols-2 row-cols-lg-5 g-2 g-lg-3 d-flex flex-wrap mt-4'>
					<c:forEach var="guest" items="${participants }">
						<div class='col text-center category__link2 mb-5'>
							<div class='category__img category__img--large2 shadow'>
								<h3>
									<c:out value="${guest.name }" />
								</h3>

							</div>
							<div class="pt-1">
								<p>
									<b>Currently Assigned:</b>
								</p>
								<c:choose>
									<c:when test="${guest.participantRecipe.id != null}">
										<a href='/recipe/${guest.participantRecipe.id }'
											class='category__a href text-center'>
											<div class='category__img shadow category__link'>

												<img src="${guest.participantRecipe.image }" alt="" />
											</div>
											<div class='pt-1'>
												<b><c:out value="${guest.participantRecipe.name }" /></b>
											</div>
										</a>
									</c:when>
									<c:otherwise>
										<div class='category__a href text-center'>
											<div class='category__img shadow category__link'>

												<h2>Assign a recipe</h2>
											</div>

										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div class='pt-1 mt-3 border rounded p-4'>
								<h3>Assign Recipe</h3>
								<form action="/assign/recipe" method="post" class="">
									<input type="hidden" name="_method" value="put" /> <input
										type="hidden" name="partyId" value="${party.id }" /> <input
										type="hidden" value="${guest.id }" name="guestID" /> <select
										name="recipeID" class="form-control">
										<c:forEach var="recipe" items="${recipes }">

											<option value="${recipe.id }"><c:out
													value="${recipe.name }" />
											</option>

										</c:forEach>
									</select>
									<button class="btn btn-small btn-danger mt-1">Assign
										Recipe</button>
								</form>
							</div>
						</div>

					</c:forEach>
				</div>


			</div>

			<div class='col-12 mt-5'>

				<h3>
					<a id="recipes">All Party Recipes</a>
				</h3>
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