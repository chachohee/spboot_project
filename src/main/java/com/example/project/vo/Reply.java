package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String relTypeCode;
	private int relId;
	private String body;
	private String writerName;

	//줄바꿈을 위한 처리.
	public String getForPrintBody() {
		return this.body.replaceAll("\n", "<br />");
	}
}
