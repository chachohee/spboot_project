package com.example.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project.service.GachaService;
import com.example.project.util.Util;
import com.example.project.vo.Gacha;
import com.example.project.vo.Rq;

@Controller
public class UsrGachaController {
	
	private GachaService gachaService;
	private Rq rq;
	
	@Autowired
	public UsrGachaController(GachaService gachaService, Rq rq) {
		super();
		this.gachaService = gachaService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/gacha/gacha")
	public String gacha() {
		return "usr/gacha/gacha";
	}
	
	@RequestMapping("/usr/gacha/getGacha")
	@ResponseBody
	public String getGacha() {
		
		if (rq.getLoginedMemberId() == 0) {
			return Util.jsHistoryBack("로그인 후 이용해주세요.");
		}
		
		int gachaId = gachaService.getGachaId(); //랜덤으로 가챠 하나 가져오기
		
		gachaService.updateGachaInfo(gachaId, rq.getLoginedMemberId()); //가챠 정보 업데이트
		
		return Util.jsReplace("가챠 얻기 성공!", "myCollection");
	}
	
	@RequestMapping("/usr/gacha/myCollection")
	public String showMyCollection(Model model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "grantDate,id,orgName") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword) {
		
		if (page <= 0) {
			return rq.jsReturnOnView("페이지번호가 올바르지 않습니다");
		}

		int myGachasCnt = gachaService.getMyGachasCnt(rq.getLoginedMemberId(), searchKeywordType, searchKeyword);
		int itemsInAPage = 5;
		int pagesCnt = (int) Math.ceil((double) myGachasCnt / itemsInAPage);
		
		List<Gacha> myGachas = gachaService.getMyGachas(rq.getLoginedMemberId(), searchKeywordType, searchKeyword, itemsInAPage, page);

		model.addAttribute("myGachasCnt", myGachasCnt);
		model.addAttribute("myGachas", myGachas);
		model.addAttribute("pagesCnt", pagesCnt);
		model.addAttribute("page", page);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchKeywordType", searchKeywordType);
		
		return "usr/gacha/myCollection";
	}

}
