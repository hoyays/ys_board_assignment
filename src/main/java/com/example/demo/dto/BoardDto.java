package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardDto {

	private String postNum;
	private String user_id;
	private String title;
	private String contents;
	private String boardDate;
	private String fileName;
	private String groupNum;
	private String indentNum;
	private String hitNum;
	private String stepNum;
	private int reCnt;
	private String originFileName;
	private String fileSize;
	
}//class
