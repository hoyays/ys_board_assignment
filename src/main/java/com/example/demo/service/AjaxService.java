package com.example.demo.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;

import com.example.demo.dto.AjaxCommentDto;
import com.example.demo.dto.AjaxDto;

public interface AjaxService {

	Map<String, Object> ajaxListAll(String page, String category, String search); //리스트 View
	String ajaxDoWrite(AjaxDto ajaxDto, String page, String category, String search);  //글쓰기
	AjaxDto ajaxDoView(AjaxDto ajaxDto, HttpServletRequest request, HttpServletResponse response);  //상세 페이지
	String ajaxDoDelete(String postNum_ajax, String page, String category, String search);  //삭제하기
	Map<String, Object> ajaxModify(String postNum_ajax, String page);  //수정하기 View
	String ajaxDoModify(AjaxDto ajaxDto, String page);   //수정하기
	Map<String, Object> ajaxDoReply(AjaxDto ajaxDto, String page);  //답변하기
	void ajaxDoComWrite(AjaxCommentDto ajaxCommentDto, String page); //댓글쓰기 - DB 저장하기
	String ajaxDoComDelete(AjaxCommentDto ajaxCommentDto);  //댓글 삭제하기
	AjaxCommentDto ajaxComModify(AjaxCommentDto ajaxCommentDto);  //댓글 수정 View
	void ajaxDoComModify(AjaxCommentDto ajaxCommentDto, String page);  //댓글 수정 - 저장하기
	
	
	
	
	
	
	//Map<String, Object> ajaxCommentListAll(String postNum_ajax);   //댓글 리스트 불러오기
	Map<String, Object> ajaxCommentListAll(String postNum_ajax, String comPage);   //댓글 리스트 불러오기

	
	
	
	
	
	
	
	
	
	

}//interface
