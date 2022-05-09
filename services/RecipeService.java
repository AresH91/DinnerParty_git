package com.areshernandez.javaProject.services;

import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.areshernandez.javaProject.models.Recipe;
import com.areshernandez.javaProject.models.User;
import com.areshernandez.javaProject.repositories.RecipeRepository;

@Service
public class RecipeService {
	@Autowired
	private RecipeRepository recipeRepo;
	@Autowired
	private UserService userService;

	public Recipe createRecipe(Recipe recipe) {
		return (Recipe) this.recipeRepo.save(recipe);
	}

	public List<Recipe> findtop() {
		return this.recipeRepo.findTop5();
	}

	public Recipe findRecipe(Long id) {
		Optional<Recipe> recipe = this.recipeRepo.findById(id);
		return recipe.isPresent() ? (Recipe) recipe.get() : null;
	}

	public List<Recipe> findAll() {
		return this.recipeRepo.findAll();
	}

	public List<Recipe> findCategory(String category) {
		return this.recipeRepo.findByCategory(category);
	}

	public List<Recipe> findSearch(String query) {
		List<Recipe> newList = this.recipeRepo.findByNameContains(query);
		List<Recipe> list2 = this.recipeRepo.findByCategoryContains(query);
		Iterator var5 = list2.iterator();

		while (var5.hasNext()) {
			Recipe recipe = (Recipe) var5.next();
			if (!newList.contains(recipe)) {
				newList.add(recipe);
			}
		}

		List<Recipe> list3 = this.recipeRepo.findByDirectionsContains(query);
		Iterator var6 = list3.iterator();

		while (var6.hasNext()) {
			Recipe recipe = (Recipe) var6.next();
			if (!newList.contains(recipe)) {
				newList.add(recipe);
			}
		}

		return newList;
	}

	public List<Recipe> findUserRecipes(Long id) {
		User user = this.userService.findOne(id);
		List<Recipe> list = this.recipeRepo.findBySubmitter(user);
		return list;
	}

	public Recipe updateRecipe(Recipe recipe) {
		return (Recipe) this.recipeRepo.save(recipe);
	}

	public void deleteRecipe(Long id) {
		this.recipeRepo.deleteById(id);
	}
}