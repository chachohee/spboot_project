package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileVO {
	private int id;
	private String orgNm;
	private String savedNm;
	private String savedPath;
	private String regDate;
	private int memberId;
	private String writerName;

}
