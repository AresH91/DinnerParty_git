package com.areshernandez.javaProject.services;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.areshernandez.javaProject.models.DinnerParty;
import com.areshernandez.javaProject.models.Participant;
import com.areshernandez.javaProject.models.Recipe;
import com.areshernandez.javaProject.models.User;
import com.areshernandez.javaProject.repositories.DinnerPartyRepository;

@Service
public class DinnerPartyService {
	@Autowired
	private DinnerPartyRepository dinnerRepo;
	@Autowired
	private UserService userService;
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private ParticipantService partService;

	public DinnerParty findParty(Long id) {
		Optional<DinnerParty> possParty = this.dinnerRepo.findById(id);
		return possParty.isPresent() ? (DinnerParty) possParty.get() : null;
	}

	public List<DinnerParty> findParties(Long id) {
		User possUser = this.userService.findOne(id);
		List<DinnerParty> newList = this.dinnerRepo.findByCreator(possUser);
		return newList;
	}

	public DinnerParty findbyCode(String code) {
		Optional<DinnerParty> possParty = this.dinnerRepo.findByCode(code);
		if (possParty.isPresent()) {
			return (DinnerParty) possParty.get();
		} else if (!possParty.isPresent()) {
			DinnerParty nulParty = new DinnerParty();
			nulParty.setName("null");
			return nulParty;
		} else {
			return null;
		}
	}

	public DinnerParty createParty(DinnerParty dinnerParty) {
		return (DinnerParty) this.dinnerRepo.save(dinnerParty);
	}

	public DinnerParty updateParty(DinnerParty dinnerParty) {
		return (DinnerParty) this.dinnerRepo.save(dinnerParty);
	}

	public void addRecipe(Long recipeId, Long partyId) {
		DinnerParty party = this.findParty(partyId);
		Recipe recipeToAdd = this.recipeService.findRecipe(recipeId);
		party.getPartyRecipes().add(recipeToAdd);
		this.dinnerRepo.save(party);
	}

	public void deleteParty(Long id) {
		this.dinnerRepo.deleteById(id);
	}

	public void removeRecipe(Long recipeId, Long dinnerId) {
		DinnerParty party = this.findParty(dinnerId);
		Recipe recipe = this.recipeService.findRecipe(recipeId);
		party.getPartyRecipes().remove(recipe);
		this.dinnerRepo.save(party);
	}

	public void removeParticipant(Long participantId, Long dinnerId) {
		DinnerParty party = this.findParty(dinnerId);
		Participant part = this.partService.findParticipant(participantId);
		part.setDinnerParty((DinnerParty) null);
		this.dinnerRepo.save(party);
	}

	public DinnerParty validCheck(DinnerParty party, BindingResult result) {
		Optional<DinnerParty> optPart = this.dinnerRepo.findByCode(party.getCode());
		if (optPart.isPresent()) {
			result.rejectValue("code", "Exists", "Code is already in use");
		}

		return (DinnerParty) this.dinnerRepo.save(party);
	}
}