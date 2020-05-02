package com.moon.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.moon.util.MediaUtils;
import com.moon.util.UploadFileUtils;

@Controller
public class UploadController {
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@RequestMapping(value = "/uploadForm", method = RequestMethod.GET)
	public void uploadForm() {
		
	}
	
	@RequestMapping(value = "/uploadForm", method = RequestMethod.POST)
	public String uploadForm(MultipartFile file, Model model) throws Exception{
		logger.info("originalName: "+file.getOriginalFilename());		
		logger.info("size: "+file.getSize());
		logger.info("contentType: "+file.getContentType());
		
		String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		
		model.addAttribute("savedName", savedName);
		
		return "uploadResult";
	}
	
	private String uploadFile(String originalName, byte[] fileData) throws Exception{
		
		UUID uid = UUID.randomUUID();
		
		String savedName = uid.toString() + "_" + originalName;
		
		File target = new File(uploadPath,savedName);
		
		FileCopyUtils.copy(fileData, target);
		
		return savedName;
	}
	
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.GET)
	public void uploadAjax() {
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception{
		logger.info("originalName: "+file.getOriginalFilename());		
		logger.info("size: "+file.getSize());
		logger.info("contentType: "+file.getContentType());
		
		return new ResponseEntity<>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
	}
	
	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName)throws Exception{
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		logger.info("FILE NAME : "+fileName);
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			/* 확장자 추출 */
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			HttpHeaders headers = new HttpHeaders();
			
			in = new FileInputStream(uploadPath+fileName);
			
			if(mType != null) {
				headers.setContentType(mType);
			}else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");				
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}		
		return entity;
	}
		
	@ResponseBody
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		logger.info("delete file: "+fileName);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		MediaType mType = MediaUtils.getMediaType(formatName); 
		
		/* 이미지 타입일 경우 썸네일 파일 제거 - 's' 를 빼서 파일을 찾은 후 삭제 */
		if(mType != null) {
			String front = fileName.substring(0,12);
			String end = fileName.substring(14);
			new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
		}
		// 기본 타입, 원본 파일 삭제 
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteAllFiles", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files){
		logger.info("delete file: "+files);
		
		if(files == null || files.length == 0) {
			return new ResponseEntity<String>("deleted",HttpStatus.OK);
		}
		
		for(String fileName : files) {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			if(mType != null) {
				String front = fileName.substring(0,12);
				String end = fileName.substring(14);
				new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
			}
			
			new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
