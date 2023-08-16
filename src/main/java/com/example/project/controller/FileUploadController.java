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
import com.example.project.vo.Rq;

@Controller
public class FileUploadController {
	private FileService fileService;
	private Rq rq;

	@Autowired
	public FileUploadController(FileService fileService, Rq rq) {
		this.fileService = fileService;
		this.rq = rq;
	}

	@RequestMapping("/usr/gacha/upload")
	@ResponseBody
	public String uploadFile(MultipartFile file, int memberId) {
		
		if (rq.getLoginedMemberId() == 0) {
			return Util.jsHistoryBack("로그인 후 이용해주세요.");
		}
		if(Util.empty(file)) {
			return Util.jsHistoryBack("업로드할 파일을 선택해주세요.");
		}

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
		
//		List<FileVO> resizeFiles = new ArrayList<>();
//		for (FileVO file : files) {
//			
//		}

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
