package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Gacha {

	private int id;
	private int stock;
	private String orgName;
	private String regDate;
	private int memberId;
	private String grantDate;
	private String savedName;
	private String savedPath;
	
}
