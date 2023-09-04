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
import org.springframework.web.bind.annotation.RequestParam;
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
	public String uploadFile(MultipartFile file, int memberId) throws IOException {
		
		if (rq.getLoginedMemberId() == 0) {
			return Util.jsHistoryBack("로그인 후 이용해주세요.");
		}
		
		if(file.isEmpty()) {
			return Util.jsHistoryBack("업로드할 파일을 선택해주세요.");
		}

		try {
			fileService.saveFile(file, memberId);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return Util.jsReplace("파일 업로드 성공", "gallery");
	}

	@RequestMapping("/usr/gacha/gallery")
	public String view(Model model, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "writerName") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword) {
		
		int filesCnt = fileService.getFilesCnt();
		
		if (page <= 0) {
			return rq.jsReturnOnView("페이지번호가 올바르지 않습니다");
		}

		int itemsInAPage = 5;
		int pagesCnt = (int) Math.ceil((double) filesCnt / itemsInAPage);

		List<FileVO> files = fileService.getFiles(searchKeywordType, searchKeyword, itemsInAPage, page);

		model.addAttribute("files", files);
		model.addAttribute("pagesCnt", pagesCnt);
		model.addAttribute("page", page);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchKeywordType", searchKeywordType);

		return "usr/gacha/gallery";
	}

	@RequestMapping("/usr/gacha/file/{fileId}")
	@ResponseBody
	public Resource downloadImage(@PathVariable("fileId") int id, Model model) throws IOException {

		FileVO fileVo = fileService.getFileById(id);

		return new UrlResource("file:" + fileVo.getSavedPath());
	}
	
	@RequestMapping("/usr/gacha/file/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		FileVO foundFile = fileService.getFileById(id);

		if (foundFile == null) {
			return Util.jsHistoryBack(Util.f("%d번 파일은 존재하지 않습니다.", id));
		}

		if (foundFile.getMemberId() != rq.getLoginedMemberId()) {
			return Util.jsHistoryBack("해당 파일에 대한 권한이 없습니다.");
		}

		fileService.deleteFile(id);

		return Util.jsReplace(Util.f("%d번 파일을 삭제했습니다.", id), "/usr/gacha/gallery");
	}
	
}