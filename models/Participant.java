package com.areshernandez.javaProject.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

@Entity
@Table(name = "participants")
public class Participant {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@NotEmpty(message = "Name is required!")
	@Size(min = 3, max = 30, message = "Name must be between 3 and 30 characters")
	private String name;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "participantRecipe_id")
	private Recipe participantRecipe;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "dinnerParty_id")
	private DinnerParty dinnerParty;

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Recipe getParticipantRecipe() {
		return this.participantRecipe;
	}

	public void setParticipantRecipe(Recipe participantRecipe) {
		this.participantRecipe = participantRecipe;
	}

	public DinnerParty getDinnerParty() {
		return this.dinnerParty;
	}

	public void setDinnerParty(DinnerParty dinnerParty) {
		this.dinnerParty = dinnerParty;
	}
}