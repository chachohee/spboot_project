package com.example.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.project.service.GachaService;
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
	
	

}
