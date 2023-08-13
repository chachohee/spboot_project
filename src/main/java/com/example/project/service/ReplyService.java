package com.example.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.dao.ReplyDao;
import com.example.project.vo.Reply;

@Service
public class ReplyService {
	
	private ReplyDao replyDao;

	@Autowired
	public ReplyService(ReplyDao replyDao) {
		this.replyDao = replyDao;
	}

	public void writeReply(int loginedMemberId, String relTypeCode, int relId, String body) {
		replyDao.writeReply(loginedMemberId, relTypeCode, relId, body);
	}

	public List<Reply> getReplies(String relTypeCode, int relId) {
		return replyDao.getReplies(relTypeCode, relId);
	}

	public Reply getReply(int id) {
		return replyDao.getReply(id);
	}

	public void deleteReply(int id) {
		replyDao.deleteReply(id);
	}

	public void modifyReply(int id, String body) {
		replyDao.modifyReply(id, body);		
	}

}
