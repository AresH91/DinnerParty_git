package com.areshernandez.javaProject.services;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.PutObjectRequest;


@Service
public class AmazonClient {
	private AmazonS3 s3client;
	@Value("${amazonProperties.endpointUrl}")
	private String endpointUrl;
	@Value("${amazonProperties.bucketName}")
	private String bucketName;
	@Value("${amazonProperties.accessKey}")
	private String accessKey;
	@Value("${amazonProperties.secretKey}")
	private String secretKey;
	

	@PostConstruct
	private void initializeAmazon() {
		AWSCredentials credentials = new BasicAWSCredentials(this.accessKey, this.secretKey);
		this.s3client = new AmazonS3Client(credentials);
	}

//	private File convertMultiPartToFile(MultipartFile file) throws IOException {
//		File convFile = new File(file.getOriginalFilename());
//		FileOutputStream fos = new FileOutputStream(convFile);
//		fos.write(file.getBytes());
//		fos.close();
//		return convFile;
//	}
	
//	
	private boolean deleteDir(File file) {
	     if (file.isDirectory()) {
	         String[] children = file.list();
	         for (int i = 0; i < children.length; i++) {
	            boolean success = deleteDir (new File(file, children[i]));
	            if (!success) {
	               return false;
	            }
	         }
	      }
	      return file.delete();
	}
	
	private File convertMultiPartToFile(MultipartFile file) throws IOException {
        deleteDir(new File("/var/springApp/temp/var/springApp/temp")); //delete a dir

        new File("/var/springApp/temp/var/springApp/temp").mkdir(); //create a dir

    File convFile = new File("/var/springApp/temp/var/springApp/temp/"+file.getOriginalFilename());

    FileOutputStream fos = new 
                    FileOutputStream(convFile);

    String fileName = null;

        byte[] bytes = file.getBytes();
        fileName = file.getOriginalFilename();

        if (!fileName.equals("No file")) {
            try {
                BufferedOutputStream bos = new BufferedOutputStream(
                        new FileOutputStream(new File("/var/springApp/temp/var/springApp/temp/" 
                                              + fileName)));
                bos.write(bytes);
                bos.close();
            }
              catch (FileNotFoundException fnfe) {

                }
                catch (IOException ioe) {

                }
        }
    fos.write(file.getBytes());
    fos.close();

    return convFile;
}
	
	
	
//	



	private String generateFileName(MultipartFile multiPart) {
		return (new Date()).getTime() + "-" + multiPart.getOriginalFilename().replace(" ", "_");
	}

	private void uploadFileTos3bucket(String fileName, File file) {
		s3client.putObject(
				new PutObjectRequest(bucketName, fileName, file).withCannedAcl(CannedAccessControlList.PublicRead));
	}

	public String uploadFile(MultipartFile multipartFile) {
		String fileUrl = "";

		try {
			File file = this.convertMultiPartToFile(multipartFile);
			String fileName = this.generateFileName(multipartFile);
			fileUrl = "https://aresdinnerparty2.s3-us-west-2.amazonaws.com/" + fileName;
			this.uploadFileTos3bucket(fileName, file.getAbsoluteFile());
			file.delete();
		} catch (Exception var5) {
			var5.printStackTrace();
		}

		return fileUrl;
	}

	public String deleteFileFromS3Bucket(String fileUrl) {
		String fileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
		this.s3client.deleteObject(new DeleteObjectRequest(this.bucketName + "/", fileName));
		return "Successfully deleted";
	}
}