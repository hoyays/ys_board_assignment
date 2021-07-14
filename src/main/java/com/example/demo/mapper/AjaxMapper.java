package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.AjaxCommentDto;
import com.example.demo.dto.AjaxDto;

@Mapper
public interface AjaxMapper {

	List<AjaxDto> selectListAll(int startRow, int endRow, String category, String search);  //리스트 View
	int listCount(String category, String search);  //페이징 기능 - 전체 게시글 수
	int insertWrite(String user_id, String title_ajax, String contents_ajax); //글쓰기
	AjaxDto selectView(String postNum_ajax);   //상세페이지
	void updateHitNum(String postNum_ajax);  //조회수 1 증가처리
	int deleteView(String postNum_ajax);  //삭제하기
	int updateModify(String postNum_ajax, String title_ajax, String contents_ajax);  //수정하기
	int insertReply(String user_id, String title_ajax, String contents_ajax, String groupNum_ajax, 
			String indentNum_ajax, String stepNum_ajax);  //답변하기
	AjaxDto selectReplyView(String groupNum_ajax);   //입력된 답변내용 불러오기
	void updateReplyPlus(String groupNum_ajax, String stepNum_ajax);  //답변하기 - 현재 댓글 아래 stepNum+1 처리
	List<AjaxCommentDto> selectCommentListAll(String postNum_ajax);   //댓글 내용 불러오기
	void insertComWrite(AjaxCommentDto ajaxCommentDto);  //댓글쓰기 - DB 저장하기
	int deleteComment(String comNum_ajax);   //댓글 삭제하기
	AjaxCommentDto selectComment(String comNum_ajax, String postNum_ajax);  //댓글 수정 View
	
	
	
	

}//interface
