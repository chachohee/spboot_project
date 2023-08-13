package com.example.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.dao.BoardDao;
import com.example.project.vo.Board;

@Service
public class BoardService {
	
	private BoardDao boardDao;
	
	@Autowired
	BoardService(BoardDao boardDao){
		this.boardDao = boardDao;
	}

	public Board getBoardById(int boardId) {
		return boardDao.getBoardById(boardId);
	}

}
