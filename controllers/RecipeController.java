package com.areshernandez.javaProject.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.areshernandez.javaProject.models.Recipe;
import com.areshernandez.javaProject.services.AmazonClient;
import com.areshernandez.javaProject.services.DinnerPartyService;
import com.areshernandez.javaProject.services.RecipeService;
import com.areshernandez.javaProject.services.UserService;

@Controller
public class RecipeController {
	@Autowired
	private UserService userService;
	@Autowired
	private DinnerPartyService dinnerService;
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private AmazonClient amazonService;

	@GetMapping({"/recipe/{id}"})
	public String index2(@PathVariable("id") Long id, Model model, HttpSession session) {
		Recipe recipe = this.recipeService.findRecipe(id);
		String oldIngred = recipe.getIngredients();
		String[] newIngred = StringUtils.split(oldIngred, ",");
		model.addAttribute("recipe", recipe);
		model.addAttribute("ingredients", newIngred);
		if (session.getAttribute("userId") != null) {
			Long userId = (Long) session.getAttribute("userId");
			model.addAttribute("parties", this.dinnerService.findParties(userId));
		}

		return "recipe.jsp";
	}

	@GetMapping({"/recipe/search"})
	public String searchBy(@RequestParam("query") String query, Model model) {
		model.addAttribute("recipes", this.recipeService.findSearch(query));
		return "recipes.jsp";
	}

	@GetMapping({"/recipes"})
	public String allRecipes(Model model) {
		model.addAttribute("recipes", this.recipeService.findAll());
		return "recipes.jsp";
	}

	@GetMapping({"/recipe/category/{category}"})
	public String byCategory(Model model, @PathVariable("category") String category) {
		model.addAttribute("recipes", this.recipeService.findCategory(category));
		return "recipes.jsp";
	}

	@GetMapping({"/categories"})
	public String categoryPage() {
		return "categoryPage.jsp";
	}

	@GetMapping({"/recipeform"})
	public String createRecipe(Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/";
		} else {
			Long userId = (Long) session.getAttribute("userId");
			model.addAttribute("recipe", new Recipe());
			model.addAttribute("user", this.userService.findOne(userId));
			return "recipeForm.jsp";
		}
	}

	@PostMapping({"/api/recipes"})
	public String createRecipe(@Valid @ModelAttribute("recipe") Recipe recipe, BindingResult result,
			@RequestPart MultipartFile file) {
		if (result.hasErrors()) {
			return "recipeForm.jsp";
		} else {
			Recipe r = this.recipeService.createRecipe(recipe);
			r.setImage(this.amazonService.uploadFile(file));
			this.recipeService.createRecipe(r);
			return "redirect:/";
		}
	}

	@GetMapping({"/edit/recipe/{id}"})
	public String editRecipeForm(HttpSession session, Model model, @PathVariable("id") Long id) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/";
		} else {
			model.addAttribute("recipe", this.recipeService.findRecipe(id));
			return "editRecipe.jsp";
		}
	}

	@PostMapping({"/edit/recipe/{id}"})
	public String editRecipe(@Valid @ModelAttribute("recipe") Recipe recipe, BindingResult result,
			@PathVariable("id") Long id) {
		if (result.hasErrors()) {
			return "editRecipe.jsp";
		} else {
			this.recipeService.updateRecipe(recipe);
			return "redirect:/recipe/" + id;
		}
	}

	@DeleteMapping({"/delete/recipe/{id}"})
	public String deleteRecipe(@PathVariable("id") Long id) {
		this.recipeService.deleteRecipe(id);
		return "redirect:/";
	}
}