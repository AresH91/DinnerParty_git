package com.areshernandez.javaProject.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.areshernandez.javaProject.models.DinnerParty;
import com.areshernandez.javaProject.models.Participant;
import com.areshernandez.javaProject.services.DinnerPartyService;
import com.areshernandez.javaProject.services.ParticipantService;
import com.areshernandez.javaProject.services.UserService;

@Controller
public class DinnerPartyController {
	@Autowired
	private UserService userService;
	@Autowired
	private DinnerPartyService dinnerService;
	@Autowired
	private ParticipantService participantService;

	@GetMapping({"/create/dinnerparty"})
	public String createDinnerParty(Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/";
		} else {
			model.addAttribute("dinnerParty", new DinnerParty());
			return "dinnerPartyform.jsp";
		}
	}

	@PostMapping({"/create/dinnerparty"})
	public String createDinnerPartyPost(@Valid @ModelAttribute("dinnerParty") DinnerParty dinnerParty,
			BindingResult result, @RequestParam("creator") Long creator_id) {
		this.dinnerService.validCheck(dinnerParty, result);
		return result.hasErrors() ? "dinnerPartyform.jsp" : "redirect:/dashboard";
	}

	@GetMapping({"/code/search"})
	public String searchByCode(@RequestParam("query") String query, Model model) {
		DinnerParty party = this.dinnerService.findbyCode(query);
		if (party.getName() != "null") {
			model.addAttribute("party", party);
			model.addAttribute("participants", party.getPartyParticipants());
			model.addAttribute("recipes", party.getPartyRecipes());
			return "guestDash.jsp";
		} else {
			return "redirect:/";
		}
	}

	@GetMapping({"/dinnerparty/dashboard/{id}"})
	public String partydash(@PathVariable("id") Long id, Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/";
		} else {
			DinnerParty party = this.dinnerService.findParty(id);
			model.addAttribute("party", party);
			model.addAttribute("participant", new Participant());
			model.addAttribute("participants", party.getPartyParticipants());
			model.addAttribute("recipes", party.getPartyRecipes());
			return "PartyDashboard.jsp";
		}
	}

	@PostMapping({"/dinnerparty/addparticipant/"})
	public String addPart(@Valid @ModelAttribute("participant") Participant participant, BindingResult result,
			@RequestParam("partyId") Long partyid) {
		if (result.hasErrors()) {
			return "PartyDashboard.jsp";
		} else {
			Participant newPart = this.participantService.createParticipant(participant);
			DinnerParty dp = this.dinnerService.findParty(partyid);
			newPart.setDinnerParty(dp);
			this.participantService.updateParticipant(newPart);
			return "redirect:/dinnerparty/dashboard/" + partyid;
		}
	}

	@PutMapping({"/addto/party"})
	public String addToParty(@RequestParam("recipeId") Long recipeId, @RequestParam("partyID") Long partyID) {
		this.dinnerService.addRecipe(recipeId, partyID);
		return "redirect:/dinnerparty/dashboard/" + partyID;
	}

	@PutMapping({"/assign/recipe"})
	public String assignRecipe(@RequestParam("recipeID") Long recipeId, @RequestParam("guestID") Long guestID,
			@RequestParam("partyId") Long partyId) {
		this.participantService.assignRecipe(guestID, recipeId);
		return "redirect:/dinnerparty/dashboard/" + partyId;
	}

	@DeleteMapping({"/delete/{id}/party"})
	public String deleteParty(@PathVariable("id") Long id) {
		this.dinnerService.deleteParty(id);
		return "redirect:/dashboard";
	}

	@GetMapping({"/edit/party/{id}"})
	public String editForm(Model model, HttpSession session, @PathVariable("id") Long id) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/";
		} else {
			model.addAttribute("dinnerParty", this.dinnerService.findParty(id));
			return "editParty.jsp";
		}
	}

	@PostMapping({"/edit/party/{id}"})
	public String editParty(@Valid @ModelAttribute("dinnerParty") DinnerParty dinnerParty, BindingResult result,
			@PathVariable("id") Long id) {
		if (result.hasErrors()) {
			return "editParty.jsp";
		} else {
			this.dinnerService.updateParty(dinnerParty);
			return "redirect:/dashboard";
		}
	}

	@PutMapping({"/party/{id}/remove/recipe/{recipeId}"})
	public String removeRecipe(@PathVariable("id") Long dinnerId, @PathVariable("recipeId") Long recipeId) {
		this.dinnerService.removeRecipe(recipeId, dinnerId);
		return "redirect:/dinnerparty/dashboard/" + dinnerId;
	}

	@PutMapping({"/party/{id}/remove/participant/{participantId}"})
	public String removeParticipant(@PathVariable("id") Long dinnerId,
			@PathVariable("participantId") Long participantId) {
		this.dinnerService.removeParticipant(participantId, dinnerId);
		return "redirect:/dinnerparty/dashboard/" + dinnerId;
	}
}