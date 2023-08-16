package com.example.project.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.service.FileService;
import com.example.project.util.Util;
import com.example.project.vo.FileVO;

@Controller
public class FileUploadController {
	private FileService fileService;

	@Autowired
	public FileUploadController(FileService fileService) {
		this.fileService = fileService;
	}

	@RequestMapping("/usr/gacha/upload")
	@ResponseBody
	public String uploadFile(MultipartFile file, int memberId) {

		try {
			fileService.saveFile(file, memberId);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return Util.jsReplace("파일 업로드 성공", "/");
	}

	@RequestMapping("/usr/gacha/view")
	public String view(Model model) {		

		List<FileVO> files = fileService.getFiles();

		model.addAttribute("files", files);

		return "usr/gacha/view";
	}

	@RequestMapping("/usr/gacha/file/{fileId}")
	@ResponseBody
	public Resource downloadImage(@PathVariable("fileId") int id, Model model) throws IOException {

		FileVO fileVo = fileService.getFileById(id);

		return new UrlResource("file:" + fileVo.getSavedPath()); 
	}

}