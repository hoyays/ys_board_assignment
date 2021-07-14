package com.example.demo.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;

import com.example.demo.dto.AjaxCommentDto;
import com.example.demo.dto.AjaxDto;

public interface AjaxService {

	Map<String, Object> ajaxListAll(String page, String category, String search); //리스트 View
	Map<String, Object> ajaxDoWrite(String user_id, String title_ajax, String contents_ajax, 
									String page, String category, String search);  //글쓰기
	
	Map<String, Object> ajaxDoView(String postNum_ajax, HttpServletRequest request, HttpServletResponse response);  //상세 페이지
	Map<String, Object> ajaxDoDelete(String postNum_ajax, String page, String category, String search);  //삭제하기
	Map<String, Object> ajaxModify(String postNum_ajax, String page);  //수정하기 View
	Map<String, Object> ajaxDoModify(String postNum_ajax, String title_ajax, String contents_ajax, String page);   //수정하기
	Map<String, Object> ajaxDoReply(String user_id, String title_ajax, String contents_ajax, String postNum_ajax, 
									String groupNum_ajax, String indentNum_ajax, String stepNum_ajax, String page);  //답변하기
	Map<String, Object> ajaxDoComWrite(AjaxCommentDto ajaxCommentDto, String page); //댓글쓰기 - DB 저장하기
	Map<String, Object> ajaxDoComDelete(String comNum_ajax, String postNum_ajax);  //댓글 삭제하기
	Map<String, Object> ajaxComModify(String comNum_ajax, String postNum_ajax);  //댓글 수정 View

	
	
	
	
	
	
	
	
	
	

}//interface
