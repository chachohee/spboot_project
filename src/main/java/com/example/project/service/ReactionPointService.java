package com.example.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.dao.ReactionPointDao;
import com.example.project.vo.ReactionPoint;

@Service
public class ReactionPointService {
	
	private ReactionPointDao reactionPointDao;
	
	@Autowired
	public ReactionPointService(ReactionPointDao reactionPointDao) {
		this.reactionPointDao = reactionPointDao;
	}

	public ReactionPoint getReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		return reactionPointDao.getReactionPoint(loginedMemberId, relTypeCode, relId);
	}

	public void doInsertReactionPoint(int loginedMemberId, String relTypeCode, int relId, int point) {
		reactionPointDao.doInsertReactionPoint(loginedMemberId, relTypeCode, relId, point);
	}

	public void doDeleteReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		reactionPointDao.doDeleteReactionPoint(loginedMemberId, relTypeCode, relId);
	}

}
