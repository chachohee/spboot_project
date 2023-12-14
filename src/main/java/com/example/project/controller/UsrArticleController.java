package com.example.project.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project.service.ArticleService;
import com.example.project.service.BoardService;
import com.example.project.service.MemberService;
import com.example.project.service.ReplyService;
import com.example.project.util.Util;
import com.example.project.vo.Article;
import com.example.project.vo.Board;
import com.example.project.vo.Member;
import com.example.project.vo.Reply;
import com.example.project.vo.Rq;

@Controller
public class UsrArticleController {

	private ArticleService articleService;
	private MemberService memberService;
	private BoardService boardService;
	private ReplyService replyService;
	
	private Rq rq;

	@Autowired
	public UsrArticleController(ArticleService articleService, MemberService memberService, BoardService boardService, ReplyService replyService, Rq rq) {
		this.articleService = articleService;
		this.memberService = memberService;
		this.boardService = boardService;
		this.replyService = replyService;
		
		this.rq = rq;
	}
	
	@RequestMapping("/usr/article/write")
	public String write(Model model, int boardId) {
				
		if(rq.getLoginedMemberId() == 0) {
			return  rq.jsReturnOnView(Util.f("게시물 작성 권한이 없습니다."));
		}

		Member member = memberService.getMemberById(rq.getLoginedMemberId());
		
		model.addAttribute("member", member);
		model.addAttribute("boardId", boardId);
		
		return "usr/article/write";
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(int boardId, String title, String body) {

		if (Util.empty(title)) {
			return Util.jsHistoryBack("제목을 입력해주세요.");
		}

		if (Util.empty(body)) {
			return Util.jsHistoryBack("내용을 입력해주세요.");
		}

		articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);

		int id = articleService.getLastInsertId();

		return Util.jsReplace(Util.f("%d번 게시글을 작성했습니다.", id), Util.f("detail?id=%d", id));
	}

	@RequestMapping("/usr/article/list")
	public String showList(Model model, 
			@RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "title") String searchKeywordType,
			@RequestParam(defaultValue = "1") int page) {
		
		if(page <= 0) {
			return rq.jsReturnOnView("페이지 번호가 올바르지 않습니다.");
		}
		
		Board board = boardService.getBoardById(boardId);
		
		if(board == null) {
			return rq.jsReturnOnView("존재하지않는 게시판입니다.");
		}
		
		int articlesCnt = articleService.getArticlesCnt(boardId, searchKeyword, searchKeywordType);
		
		int itemsInAPage = 10;
		
		int pagesCnt = (int) Math.ceil((double) articlesCnt / itemsInAPage);
		
		List<Article> articles = articleService.getArticles(boardId, searchKeyword, searchKeywordType, itemsInAPage, page);

		model.addAttribute("articles", articles);
		model.addAttribute("articlesCnt", articlesCnt);
		model.addAttribute("board", board);
		model.addAttribute("pagesCnt", pagesCnt);
		model.addAttribute("page", page);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchKeywordType", searchKeywordType);
		
		return "usr/article/list";
	}

	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, HttpServletResponse resp, Model model, int id) {
		
		Cookie oldCookie = null;
		Cookie[] cookies = req.getCookies();//세션은 하나의 객체이고, 쿠키는 받아왔을 때 하나가 아닐 수도 있기 때문에 배열로 받음.
		
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("hitCnt")) {
					oldCookie = cookie;
				}
			}
		}
		
		if(oldCookie != null) {
			if(!oldCookie.getValue().contains("[" + id + "]")) {
				articleService.increaseHitCnt(id);
				oldCookie.setValue(oldCookie.getValue() + "_[" + id + "]");
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60 * 24);
				resp.addCookie(oldCookie);
			}
		} else {
			articleService.increaseHitCnt(id);
			Cookie newCookie = new Cookie("hitCnt", "[" + id + "]");
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60 * 24);
			resp.addCookie(newCookie);
		}
		
		Article article = articleService.getForPrintArticle(id);
		
		List<Reply> replies = replyService.getReplies("article", id);

		model.addAttribute("article", article);
		model.addAttribute("replies", replies);

		return "usr/article/detail";
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id, int boardId) {

		Article foundArticle = articleService.getArticleById(id);

		if (foundArticle == null) {
			return Util.jsHistoryBack(Util.f("%d번 게시글은 존재하지 않습니다.", id));
		}

		if (foundArticle.getMemberId() != rq.getLoginedMemberId()) {
			return Util.jsHistoryBack("해당 게시물에 대한 권한이 없습니다.");
		}

		articleService.deleteArticle(id);

		return Util.jsReplace(Util.f("%d번 게시글을 삭제했습니다.", id), "list?boardId=" + boardId);
	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) {
		
		Article article = articleService.getForPrintArticle(id);

		if(article == null) {
			return rq.jsReturnOnView(Util.f("%d번 게시물은 존재하지 않습니다.", id));
		}
		
		if(rq.getLoginedMemberId() != article.getMemberId()) {
			return rq.jsReturnOnView(Util.f("해당 게시물에 대한 권한이 없습니다."));
		}
		
		model.addAttribute("article", article);
		
		return "usr/article/modify";
	}

	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return Util.jsHistoryBack(Util.f("%d번 게시글은 존재하지 않습니다.", id));
		}

		if (rq.getLoginedMemberId() != article.getMemberId()) {
			return Util.jsHistoryBack("해당 게시글에 대한 권한이 없습니다.");
		}

		articleService.modifyArticle(id, title, body);

		return Util.jsReplace(Util.f("%d번 게시글을 수정했습니다.", id), Util.f("detail?id=%d", id));
	}

}
