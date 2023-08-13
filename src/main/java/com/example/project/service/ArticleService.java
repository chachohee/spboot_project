package com.example.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.dao.ArticleDao;
import com.example.project.vo.Article;

@Service
public class ArticleService {
	
	private ArticleDao articleDao;
	
	@Autowired
	ArticleService(ArticleDao articleDao){
		this.articleDao = articleDao;
	}
	
	public List<Article> getArticles(int boardId, String searchKeyword, String searchKeywordType, int itemsInAPage, int page){
		
		int limitStart = (page - 1) * itemsInAPage;
		
		return articleDao.getArticles(boardId, searchKeyword, searchKeywordType, itemsInAPage, limitStart);
	}
	
	public void writeArticle(int memberId, int boardId, String title, String body) {
		articleDao.writeArticle(memberId, boardId, title, body);
	}
	
	public Article getArticleById(int id) {
		return articleDao.getArticleById(id);
	}
	
	public void deleteArticle(int id) {
		articleDao.deleteArticle(id);
	}
	
	public void modifyArticle(int id, String title, String body) {
		articleDao.modifyArticle(id, title, body);
	}

	public int getLastInsertId() {
		return articleDao.getLastInsertId();
	}

	public Article getForPrintArticle(int id) {
		return articleDao.getForPrintArticle(id);
	}

	public int getArticlesCnt(int boardId, String searchKeyword, String searchKeywordType) {
		return articleDao.getArticlesCnt(boardId, searchKeyword, searchKeywordType);
	}

	public void increaseHitCnt(int id) {
		articleDao.increaseHitCnt(id);
	}

}
