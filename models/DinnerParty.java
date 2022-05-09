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
@Table(name = "dinnerparties")
public class DinnerParty {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@NotEmpty(message = "Name is required!")
	@Size(min = 3, max = 100, message = "Name must be between 3 and 100 characters")
	private String name;
	@NotNull(message = "Missing Party Code Error")
	@Size(min = 3, max = 100, message = "Unique code must be more than 3 characters")
	private String code;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "creator_id")
	private User creator;
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "partyRecipes", joinColumns = {@JoinColumn(name = "dinnerParty_id")}, inverseJoinColumns = {
			@JoinColumn(name = "recipe_id")})
	private List<Recipe> partyRecipes;
	@OneToMany(mappedBy = "dinnerParty", fetch = FetchType.LAZY)
	private List<Participant> partyParticipants;
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

	public DinnerParty() {
	}

	public DinnerParty(Long id, String name, String code, List<Recipe> partyRecipes,
			List<Participant> partyParticipants) {
		this.name = name;
		this.code = code;
		this.partyRecipes = partyRecipes;
		this.partyParticipants = partyParticipants;
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

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List<Recipe> getPartyRecipes() {
		return this.partyRecipes;
	}

	public void setPartyRecipes(List<Recipe> partyRecipes) {
		this.partyRecipes = partyRecipes;
	}

	public List<Participant> getPartyParticipants() {
		return this.partyParticipants;
	}

	public void setPartyParticipants(List<Participant> partyParticipants) {
		this.partyParticipants = partyParticipants;
	}

	public Date getCreatedAt() {
		return this.createdAt;
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

	public User getCreator() {
		return this.creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}
}
