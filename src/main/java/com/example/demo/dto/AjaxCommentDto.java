package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AjaxCommentDto {

	private int comNum_ajax;
	private String user_id;
	private String comContents_ajax;
	private String comDate_ajax;
	private int comGroupNum_ajax;
	private int comIndentNum_ajax;
	private int comStepNum_ajax;
	private String comSecret_ajax;
	private int postNum_ajax;
	
	
	
}//class
