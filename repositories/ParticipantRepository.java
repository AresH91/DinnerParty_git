package com.areshernandez.javaProject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.areshernandez.javaProject.models.Participant;

public interface ParticipantRepository extends CrudRepository<Participant, Long> {
	List<Participant> findAll();
}
