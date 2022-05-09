package com.areshernandez.javaProject.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.areshernandez.javaProject.models.Participant;
import com.areshernandez.javaProject.models.Recipe;
import com.areshernandez.javaProject.repositories.ParticipantRepository;

@Service
public class ParticipantService {
	@Autowired
	private ParticipantRepository participantRepo;
	@Autowired
	private RecipeService recipeService;

	public Participant createParticipant(Participant participant) {
		return (Participant) this.participantRepo.save(participant);
	}

	public Participant findParticipant(Long id) {
		Optional<Participant> possParticipant = this.participantRepo.findById(id);
		return possParticipant.isPresent() ? (Participant) possParticipant.get() : null;
	}

	public Participant updateParticipant(Participant participant) {
		return (Participant) this.participantRepo.save(participant);
	}

	public void assignRecipe(Long guestID, Long recipeID) {
		Participant participant = this.findParticipant(guestID);
		Recipe recipe = this.recipeService.findRecipe(recipeID);
		participant.setParticipantRecipe(recipe);
		this.participantRepo.save(participant);
	}

	public void deleteParticipant(Long id) {
		this.participantRepo.deleteById(id);
	}
}