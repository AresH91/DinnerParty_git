package com.areshernandez.javaProject.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.areshernandez.javaProject.services.AmazonClient;

@RestController
@RequestMapping({"/storage/"})
public class BucketController {
	private AmazonClient amazonClient;

	@Autowired
	BucketController(AmazonClient amazonClient) {
		this.amazonClient = amazonClient;
	}

	@PostMapping({"/uploadFile"})
	public String uploadFile(@RequestPart("file") MultipartFile file) {
		return this.amazonClient.uploadFile(file);
	}

	@DeleteMapping({"/deleteFile"})
	public String deleteFile(@RequestPart("url") String fileUrl) {
		return this.amazonClient.deleteFileFromS3Bucket(fileUrl);
	}
}