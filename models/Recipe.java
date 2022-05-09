package com.areshernandez.javaProject.models;


import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "recipes")
public class Recipe {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@NotEmpty(message = "Name is required!")
	@Size(min = 3, max = 60, message = "Name must be between 3 and 60 characters")
	private String name;
	@Column(columnDefinition = "TEXT")
	@NotEmpty(message = "Directions are required!")
	@Size(min = 3, message = "Please enter some directions for your dish.")
	private String directions;
	@Column(columnDefinition = "TEXT")
	@NotEmpty(message = "Ingredients are required!")
	@Size(min = 3, message = "Please enter some ingredients for your dish.")
	private String ingredients;
	@NotNull(message = "Category required")
	@Size(min = 1, message = "Category required")
	private String category;
	private String image;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "submitter_id")
	private User submitter;
	@OneToMany(mappedBy = "participantRecipe", fetch = FetchType.LAZY)
	private List<Participant> participants;
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "partyRecipes", joinColumns = {@JoinColumn(name = "recipe_id")}, inverseJoinColumns = {
			@JoinColumn(name = "dinnerParty_id")})
	private List<DinnerParty> party;
	@Column(updatable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedAt;

	@PrePersist
	protected void onCreated() {
		this.createdAt = new Date();
	}

	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}

	public Recipe() {
	}

	public Recipe(String name, String directions, String ingredients, String image) {
		this.name = name;
		this.directions = directions;
		this.ingredients = ingredients;
		this.image = image;
	}

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

	public String getDirections() {
		return this.directions;
	}

	public void setDirections(String directions) {
		this.directions = directions;
	}

	public String getCategory() {
		return this.category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Date getCreatedAt() {
		return this.createdAt;
	}

	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getIngredients() {
		return this.ingredients;
	}

	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}

	public User getSubmitter() {
		return this.submitter;
	}

	public void setSubmitter(User submitter) {
		this.submitter = submitter;
	}

	public List<Participant> getParticipants() {
		return this.participants;
	}

	public void setParticipants(List<Participant> participants) {
		this.participants = participants;
	}

	public List<DinnerParty> getParty() {
		return this.party;
	}

	public void setParty(List<DinnerParty> party) {
		this.party = party;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return this.updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
}