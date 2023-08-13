package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int boardId;
	private String writerName;
	private String title;
	private String body;
	private int hitCnt;
	private int sumReactionPoint;
	private int goodReactionPoint;
	private int badReactionPoint;
	
	private boolean actorCanChangeData;
	
	public String getForPrintBody() {
		return this.body.replaceAll("\n", "<br />");
	}

}
