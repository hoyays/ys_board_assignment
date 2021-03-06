package com.example.demo.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.BoardDto;
import com.example.demo.dto.ReplyDto;

public interface BoardService {
	
	Map<String, Object> listAll(String page, String category, String search);  //리스트 View
	void boardWrite(BoardDto boardDto, MultipartFile file, HttpServletRequest request);   //글쓰기 처리 - DB 저장
	Map<String, Object> boardView(String postNum, String page, String rePage, HttpServletRequest request, HttpServletResponse response);  //상세페이지
	Map<String, Object> boardModifyView(String postNum, String page); //수정하기 - View 페이지
	void modifyChk(BoardDto boardDto, MultipartFile file);  //수정하기 - DB 저장하기
	void deleteChk(String postNum);  //삭제하기
	BoardDto boardReplyView(String postNum);   //답변하기 - View 페이지
	void replyChk(BoardDto boardDto, MultipartFile file);  //답변하기 - DB 저장하기
	void replyWrite(ReplyDto replyDto);   //댓글 쓰기 - DB 저장하기
	void replyModify(ReplyDto replyDto);  //댓글 수정 - DB 저장하기
	void replyDelete(String reNum, String postNum);  //댓글 삭제
	List<BoardDto> listExcelDown(String category, String search);  //엑셀 다운로드 - 리스트 출력
	void listExcelUp(MultipartFile file) throws IOException;  //엑셀 업로드
	void fileDown(String postNum, HttpServletRequest request, HttpServletResponse response) throws IOException;  //첨부파일 다운로드
	
	

}//interface
