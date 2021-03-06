package com.example.demo.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.AjaxCommentDto;
import com.example.demo.dto.AjaxDto;
import com.example.demo.mapper.AjaxMapper;

@Service
public class AjaxServiceImplement implements AjaxService{

	@Autowired
	AjaxMapper ajaxMapper;
	@Autowired
	AjaxPageNumbering pageNumbering;
	
	//변수선언
	Map<String, Object> map = new HashMap<String, Object>();
	List<AjaxDto> list = new ArrayList<AjaxDto>();
	
	
	
	//리스트 View
	@Override
	public Map<String, Object> ajaxListAll(String listPage, String category, String search) {
		
		
		int page = 1;    //첫 페이지 초기화
		int limit = 10;  //1개 페이지에 노출되는 게시글 수(10개씩)
		
		//매개변수 listPage 데이터가 있으면 데이터 적용
		if (listPage != null && listPage != "") {
			page = Integer.parseInt(listPage);
		}
		
		int startRow = (page-1)*limit+1;   //선택한 페이지의 첫번째 줄 => 1, 11, 21...
		int endRow = startRow+limit-1;   //선택한 페이지의 마지막 줄 => 10, 20, 30 ...
		
		//DB에서 게시판 데이터 불러오기
		List<AjaxDto> list = ajaxMapper.selectListAll(startRow, endRow, category, search);
		
		//페이지 넘버링 계산
		map = pageNumbering.pageNum(page, limit, category, search);
		
		//리스트가 공백인 경우 - 비어 있으면 true
		boolean result = list.isEmpty(); 
		
		//map에 담기
		map.put("list", list);
		map.put("result", result);
		
		return map;
	}
	

	//글쓰기
	//====== 참고 ======
	//1. 몰입코딩 - ajax 관련 강좌
	//https://www.youtube.com/watch?v=lQtOF1jY1eY
	//https://www.youtube.com/watch?v=MSyulawQ8s0
	
	//2. ajax 부모창 자식창 값 전달
	//https://pjsprogram.tistory.com/8
	
	//3. w3school - ajax, post, get
	//https://www.w3schools.com/jquery/jquery_ajax_get_post.asp
	@Override
	public String ajaxDoWrite(AjaxDto ajaxDto, String listPage, String category, String search) {
		
		int resultChk = ajaxMapper.insertWrite(ajaxDto);
		
		String msg = "";
		if(resultChk == 1) {
			msg = "정상적으로 등록되었습니다.";
		}
		
		return msg;
	}


	
	//상세 페이지
	@Override
	public AjaxDto ajaxDoView(AjaxDto ajaxDto, 
			HttpServletRequest request, HttpServletResponse response) {
		
		String postNum_ajax = ajaxDto.getPostNum_ajax()+"";
		
		//새로고침 조회수 증가 막기 처리 - 쿠키이용
		//저장된 쿠키 불러오기
		Cookie cookies[] = request.getCookies();
		Map mapCookie = new HashMap<String, Object>();
		if(request.getCookies() != null) {
			for(int i=0; i<cookies.length; i++) {
				Cookie obj = cookies[i];
				mapCookie.put(obj.getName(), obj.getValue());
			}//for
		}//if
		
		//저장된 쿠키중에 read_count만 불러오기
		String cookie_read_count = (String) mapCookie.get("read_count");
		//저장될 새로운 쿠키값 생성
		String new_cookie_read_count = "|" + postNum_ajax;
		
		//저장된 쿠키에 새로운 쿠키값이 존재하는지 검사
		if(StringUtils.indexOfIgnoreCase(cookie_read_count, new_cookie_read_count) == -1) {
			//없을 경우 쿠키 생성
			Cookie cookie = new Cookie("read_count", cookie_read_count+new_cookie_read_count);
			response.addCookie(cookie);
			
			//조회수 1증가 처리
			ajaxMapper.updateHitNum(postNum_ajax);
			
		}
		
		//상세 페이지 내용 불러오기
		AjaxDto ajaxDtoResult = ajaxMapper.selectView(postNum_ajax);
		
		return ajaxDtoResult;
	}


	
	//삭제하기
	@Override
	public String ajaxDoDelete(String postNum_ajax, String listPage, 
			String category, String search) {
		
		int resultChk = ajaxMapper.deleteView(postNum_ajax);
		
		String msg = "";
		if(resultChk == 1) {
			msg = "정상적으로 삭제되었습니다.";
		}
		
		return msg;
	}


	
	
	//글 수정하기 View
	@Override
	public Map<String, Object> ajaxModify(String postNum_ajax, String page) {
		
		AjaxDto ajaxDto = ajaxMapper.selectView(postNum_ajax);
		map.put("ajaxDto", ajaxDto);
		map.put("page", page);
		
		return map;
	}

	
	
	
	//글 수정 - DB 저장하기
	@Override
	public String ajaxDoModify(AjaxDto ajaxDto, String page) {
		
		int resultChk = ajaxMapper.updateModify(ajaxDto);
		
		String msg = "";
		if(resultChk == 1) {
			msg = "정상적으로 수정되었습니다.";
		}
		
		return msg;
	}


	
	//답변 - DB 저장하기
	@Override
	public Map<String, Object> ajaxDoReply(AjaxDto ajaxDto, String page) {
		
		//댓글 처리이므로
		//지금 저장되는 댓글 밑에 글들은 stepNum+1 처리한다.
		ajaxMapper.updateReplyPlus(ajaxDto);
		
		
		int resultChk = ajaxMapper.insertReply(ajaxDto);
		
		//방금 입력한 내용 불러오기
		AjaxDto ajaxDtoResult = ajaxMapper.selectReplyView(ajaxDto);
		
		String msg = "";
		if(resultChk == 1) {
			msg = "답변등록이 완료되었습니다.";
		}
		
		//map에 담기
		map.put("msg", msg);
		map.put("ajaxDto", ajaxDtoResult);
		
		return map;
	}
	
	
	
	//댓글 리스트 불러오기
	@Override
	public Map<String, Object> ajaxCommentListAll(String postNum_ajax, String comListPage) {
		
		int comPage = 1;    //첫 페이지 초기화
		int comLimit = 5;  //1개 페이지에 노출되는 게시글 수(5개씩)
		
		//매개변수 comListPage 데이터가 있으면 데이터 적용
		if (comListPage != null && comListPage != "") {
			comPage = Integer.parseInt(comListPage);
		}
		
		int comStartRow = (comPage-1)*comLimit+1;   //선택한 페이지의 첫번째 줄 => 1, 6, 11...
		int comEndRow = comStartRow+comLimit-1;   //선택한 페이지의 마지막 줄 => 5, 10, 15 ...
		
		//댓글 전체 리스트 불러오기
		List<AjaxCommentDto> comList = ajaxMapper.selectCommentListAll(postNum_ajax, comStartRow, comEndRow);
		
		//댓글 페이지 넘버링
		map = pageNumbering.comPageNum(postNum_ajax, comPage, comLimit);
		
		//리스트가 공백인 경우(즉, 댓글이 없는 경우) - 비어 있으면 true
		boolean result = comList.isEmpty(); 
		
		//map에 담기
		map.put("result", result);
		map.put("comList", comList);
		
		return map;
	}


	
	//댓글쓰기 - DB 저장하기
	@Override
	public void ajaxDoComWrite(AjaxCommentDto ajaxCommentDto, String page) {
		
		ajaxMapper.insertComWrite(ajaxCommentDto);
	}


	
	//댓글 삭제하기
	@Override
	public String ajaxDoComDelete(AjaxCommentDto ajaxCommentDto) {
		
		int resultChk = ajaxMapper.deleteComment(ajaxCommentDto);
		
		String msg = "";
		if(resultChk == 1) {
			msg = "정상적으로 삭제되었습니다.";
		}
		return msg;
	}


	
	//댓글 수정 View
	@Override
	public AjaxCommentDto ajaxComModify(AjaxCommentDto ajaxCommentDto) {
		
		AjaxCommentDto ajaxCommentDtoResult = ajaxMapper.selectComment(ajaxCommentDto);
		
		return ajaxCommentDtoResult;
	}


	
	//댓글 수정 저장하기
	@Override
	public void ajaxDoComModify(AjaxCommentDto ajaxCommentDto, String page) {
		
		//댓글 수정 - 저장하기
		ajaxMapper.updateComModify(ajaxCommentDto);
		
	}




	
	

}//class
