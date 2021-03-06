package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.BoardDto;
import com.example.demo.dto.ReplyDto;

@Mapper
public interface BoardMapper {
	
	
	List<BoardDto> selectListAll(int startRow, int endRow, String search, String category); //리스트 View
	int listCount(String category, String search);  //페이지 넘버링 - 전체 게시글 개수
	void insertWrite(BoardDto boardDto);  //글쓰기 처리 - DB저장하기
	BoardDto selectView(String postNum);   //상세페이지
	void updateHitNum(String postNum);  //조회수 1 증가처리
	BoardDto selectPreDto(String postNum);   //상세 페이지 내 - 이전글 가져오기
	BoardDto selectNextDto(String postNum);  //상세 페이지 내 - 다음글 가져오기
	BoardDto selectModifyView(String postNum);   //수정하기 - View 페이지
	void updateModify(BoardDto boardDto);  //수정하기 - DB 저장하기
	void deleteChk(String postNum);   //삭제하기
	BoardDto selectReplyView(String postNum);    //답변하기 - View 페이지
	void insertReply(BoardDto boardDto);   //답변하기 - DB 저장하기
	void updateReplyPlus(BoardDto boardDto);  //답변하기 - 현재 댓글 아래 stepNum+1 처리
	List<ReplyDto> selectReplyAll(String postNum, int reStartRow, int reEndRow);   //댓글 리스트 View
	int reListCount(String postNum);  //댓글 리스트 - 전체 댓글 개수 확인하기
	
	
	
	
	void insertReplyWrite(ReplyDto replyDto);  //댓글 쓰기 - DB 저장하기
	void updateReplyModify(ReplyDto replyDto); //댓글 수정 - DB 저장하기
	void deleteReply(String reNum, String postNum);  //댓글 삭제
	List<BoardDto> selectExcelDown(String category, String search); //엑셀 다운로드 - 리스트 출력
	void insertExcelUp(BoardDto excelData);  //엑셀 업로드
	BoardDto fileDownInfo(String postNum);  //첨부파일 다운로드
	
	
	



	
	
	
	
	
	
	
	
	

	

	

	
	
}//interface
