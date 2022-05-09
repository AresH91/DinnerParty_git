package com.areshernandez.javaProject.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.areshernandez.javaProject.models.DinnerParty;
import com.areshernandez.javaProject.models.User;

public interface DinnerPartyRepository extends CrudRepository<DinnerParty, Long> {
	List<DinnerParty> findAll();

	List<DinnerParty> findByCreator(User creator);

	Optional<DinnerParty> findByCode(String code);
}