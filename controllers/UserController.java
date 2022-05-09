package com.areshernandez.javaProject.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.areshernandez.javaProject.models.LoginUser;
import com.areshernandez.javaProject.models.User;
import com.areshernandez.javaProject.services.DinnerPartyService;
import com.areshernandez.javaProject.services.RecipeService;
import com.areshernandez.javaProject.services.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private DinnerPartyService dinnerService;
	@Autowired
	private RecipeService recipeService;

	@GetMapping({"/login"})
	public String index(Model model, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			return "redirect:/";
		} else {
			model.addAttribute("newUser", new User());
			model.addAttribute("newLogin", new LoginUser());
			return "login.jsp";
		}
	}

	@PostMapping({"/register"})
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {
		this.userService.register(newUser, result);
		if (result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "login.jsp";
		} else {
			session.setAttribute("userId", newUser.getId());
			return "redirect:/dashboard";
		}
	}

	@PostMapping({"/login"})
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {
		User user = this.userService.login(newLogin, result);
		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "login.jsp";
		} else {
			session.setAttribute("userId", user.getId());
			return "redirect:/dashboard";
		}
	}

	@GetMapping({"/logout"})
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping({"/"})
	public String index(Model model) {
		model.addAttribute("topRecipes", this.recipeService.findtop());
		return "index.jsp";
	}

	@GetMapping({"/dashboard"})
	public String dashboard(Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/";
		} else {
			Long id = (Long) session.getAttribute("userId");
			model.addAttribute("user", this.userService.findOne(id));
			model.addAttribute("parties", this.dinnerService.findParties(id));
			model.addAttribute("recipes", this.recipeService.findUserRecipes(id));
			return "dashboard.jsp";
		}
	}
}