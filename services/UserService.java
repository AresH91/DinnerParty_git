package com.areshernandez.javaProject.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.areshernandez.javaProject.models.LoginUser;
import com.areshernandez.javaProject.models.User;
import com.areshernandez.javaProject.repositories.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepo;

	public User save(User user) {
		return (User) this.userRepo.save(user);
	}

	public User register(User newUser, BindingResult result) {
		Optional<User> optUser = this.userRepo.findByEmail(newUser.getEmail());
		if (optUser.isPresent()) {
			result.rejectValue("email", "Exists", "Account with that email already exists");
		}

		if (!newUser.getPassword().equals(newUser.getConfirm())) {
			result.rejectValue("password", "Matches", "Passwords do not match");
		}

		Optional<User> optUser2 = this.userRepo.findByName(newUser.getName());
		if (optUser2.isPresent()) {
			result.rejectValue("name", "Exists", "That Username is already taken!");
		}

		if (result.hasErrors()) {
			return null;
		} else {
			String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashed);
			return (User) this.userRepo.save(newUser);
		}
	}

	public User login(LoginUser loginUser, BindingResult result) {
		Optional<User> optUser = this.userRepo.findByEmail(loginUser.getEmail());
		if (!optUser.isPresent()) {
			result.rejectValue("email", "Match", "Email does not exist");
			return null;
		} else {
			User user = (User) optUser.get();
			if (!BCrypt.checkpw(loginUser.getPassword(), user.getPassword())) {
				result.rejectValue("password", "Match", "Email or Password is incorrect");
				return null;
			} else {
				return result.hasErrors() ? null : user;
			}
		}
	}

	public User findOne(Long ID) {
		Optional<User> possUser = this.userRepo.findById(ID);
		return possUser.isPresent() ? (User) possUser.get() : null;
	}

	public List<User> findAll() {
		return this.userRepo.findAll();
	}
}