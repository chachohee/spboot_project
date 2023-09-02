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

import com.example.project.service.GachaService;
import com.example.project.util.Util;
import com.example.project.vo.Gacha;
import com.example.project.vo.Rq;

@Controller
public class AdmGachaController {
	private GachaService gachaService;
	private Rq rq;

	@Autowired
	public AdmGachaController(GachaService gachaService, Rq rq) {
		this.gachaService = gachaService;
		this.rq = rq;
	}

	@RequestMapping("/adm/gacha/upload")
	@ResponseBody
	public String uploadFile(List<MultipartFile> files) throws IOException {
		
		if (rq.getLoginedMemberId() == 0) {
			return Util.jsHistoryBack("로그인 후 이용해주세요.");
		}
		
		if (rq.getLoginedMember().getAuthLevel() != 3) {
			return Util.jsHistoryBack("관리자만 업로드 가능합니다.");
		}
		
		if(files.isEmpty()) {
			return Util.jsHistoryBack("업로드할 파일을 선택해주세요.");
		}

		try {
			gachaService.saveFile(files);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return Util.jsReplace("파일 업로드 성공", "list");
	}

	@RequestMapping("/adm/gacha/list")
	public String view(Model model, @RequestParam(defaultValue = "0") int stock,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "memberId,id,orgName") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword) {		
		
		int gachaTotalCnt = gachaService.getGachaTotalCnt();
		int gachaStockCnt = gachaService.getGachaStockCnt();
		int gachaSoldOutCnt = gachaService.getGachaSoldOutCnt();
		
		if (page <= 0) {
			return rq.jsReturnOnView("페이지번호가 올바르지 않습니다");
		}

		int getGachasCnt = gachaService.getGachasCnt(stock, searchKeywordType, searchKeyword);
		int itemsInAPage = 5;
		int pagesCnt = (int) Math.ceil((double) getGachasCnt / itemsInAPage);
		
		List<Gacha> files = gachaService.getFiles(stock, searchKeywordType, searchKeyword, itemsInAPage, page);

		model.addAttribute("gachaTotalCnt", gachaTotalCnt);
		model.addAttribute("gachaStockCnt", gachaStockCnt);
		model.addAttribute("gachaSoldOutCnt", gachaSoldOutCnt);
		model.addAttribute("files", files);
		model.addAttribute("pagesCnt", pagesCnt);
		model.addAttribute("page", page);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchKeywordType", searchKeywordType);
		model.addAttribute("stock", stock);

		return "adm/gacha/list";
	}

	@RequestMapping("/adm/gacha/file/{fileId}")
	@ResponseBody
	public Resource downloadImage(@PathVariable("fileId") int id, Model model) throws IOException {

		Gacha gacha = gachaService.getFileById(id);

		return new UrlResource("file:" + gacha.getSavedPath());
	}
	
}