package com.areshernandez.javaProject.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.areshernandez.javaProject.models.Recipe;
import com.areshernandez.javaProject.models.User;

public interface RecipeRepository extends CrudRepository<Recipe, Long> {
	List<Recipe> findAll();

	@Query(value = "SELECT * FROM recipes ORDER BY id DESC LIMIT 5", nativeQuery = true)
	List<Recipe> findTop5();

	List<Recipe> findByCategory(String category);

	List<Recipe> findByNameContains(String query);

	List<Recipe> findByDirectionsContains(String query);

	List<Recipe> findByCategoryContains(String query);

	List<Recipe> findBySubmitter(User submitter);
}