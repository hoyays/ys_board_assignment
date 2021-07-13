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

import com.example.demo.dto.AjaxDto;
import com.example.demo.mapper.AjaxMapper;

@Service
public class AjaxServiceImplement implements AjaxService{

	@Autowired
	AjaxMapper ajaxMapper;
	@Autowired
	AjaxPageNumbering pageNumbering;
	@Autowired
	AjaxPageRefresh pageRefresh;
	
	
	//변수선언
	Map<String, Object> map = new HashMap<String, Object>();
	List<AjaxDto> list = new ArrayList<AjaxDto>();
	
	
	
	//리스트 View
	@Override
	public Map<String, Object> ajaxListAll(String listPage, String category, String search) {
		
		//리스트 불러오기
		map = pageRefresh.listRefresh(listPage, category, search);
		int page = (int) map.get("page");
		int limit = (int) map.get("limit");
		list = (List<AjaxDto>) map.get("list");
		
		//페이지 넘버링 계산
		map = pageNumbering.pageNum(page, limit, category, search);
		
		//map에 담기
		map.put("list", list);
		
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
	public Map<String, Object> ajaxDoWrite(String user_id, String title_ajax, 
			String contents_ajax, String listPage, String category, String search) {
		
		int resultChk = ajaxMapper.insertWrite(user_id, title_ajax, contents_ajax);
		
		String msg = "";
		if(resultChk == 1) {
			msg = "정상적으로 등록되었습니다.";
		}
		
		
		//리스트 새롭게 불러오기
		map = pageRefresh.listRefresh(listPage, category, search);
		int page = (int) map.get("page");
		int limit = (int) map.get("limit");
		list = (List<AjaxDto>) map.get("list");
		
		//페이지 넘버링 계산
		map = pageNumbering.pageNum(page, limit, category, search);
		
		//map에 담기
		map.put("list", list);
		map.put("msg", msg);
		
		return map;
	}


	
	//상세 페이지
	@Override
	public Map<String, Object> ajaxDoView(String postNum_ajax, 
			HttpServletRequest request, HttpServletResponse response) {
		
		
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
		AjaxDto ajaxDto = ajaxMapper.selectView(postNum_ajax);
		
		//map에 담기
		map.put("ajaxDto", ajaxDto);
		
		return map;
	}


	
	//삭제하기
	@Override
	public Map<String, Object> ajaxDoDelete(String postNum_ajax, String listPage, 
			String category, String search) {
		
		int resultChk = ajaxMapper.deleteView(postNum_ajax);
		
		String msg = "";
		if(resultChk == 1) {
			msg = "정상적으로 삭제되었습니다.";
		}
		
		
		//리스트 새롭게 불러오기
		map = pageRefresh.listRefresh(listPage, category, search);
		int page = (int) map.get("page");
		int limit = (int) map.get("limit");
		list = (List<AjaxDto>) map.get("list");
		
		//페이지 넘버링 계산
		map = pageNumbering.pageNum(page, limit, category, search);
		
		
		//map에 담기
		map.put("list", list);
		map.put("msg", msg);
		
		return map;
	}


	
	
	//글 수정하기 View
	@Override
	public Map<String, Object> ajaxModifyView(String postNum_ajax, String page) {
		
		AjaxDto ajaxDto = ajaxMapper.selectView(postNum_ajax);
		map.put("ajaxDto", ajaxDto);
		map.put("page", page);
		
		return map;
	}

	
	
	
	//글 수정 - DB 저장하기
	@Override
	public Map<String, Object> ajaxDoModify(String postNum_ajax, 
			String title_ajax, String contents_ajax, String page) {
		
		int resultChk = ajaxMapper.updateModify(postNum_ajax, title_ajax, contents_ajax);
		
		String msg = "";
		if(resultChk == 1) {
			msg = "정상적으로 수정되었습니다.";
		}
		
		//수정된 내용 불러오기
		AjaxDto ajaxDto = ajaxMapper.selectView(postNum_ajax);
		
		//map에 담기
		map.put("msg", msg);
		map.put("ajaxDto", ajaxDto);
		
		return map;
	}


	
	//답변 - DB 저장하기
	@Override
	public Map<String, Object> ajaxDoReply(String user_id, String title_ajax, 
			String contents_ajax, String postNum_ajax, 
			String groupNum_ajax, String indentNum_ajax, 
			String stepNum_ajax, String page) {
		
		//댓글 처리이므로
		//지금 저장되는 댓글 밑에 글들은 stepNum+1 처리한다.
		ajaxMapper.updateReplyPlus(groupNum_ajax, stepNum_ajax);
		
		
		int resultChk = ajaxMapper.insertReply(user_id, title_ajax, contents_ajax, groupNum_ajax, indentNum_ajax, stepNum_ajax);
		
		//방금 입력한 내용 불러오기
		AjaxDto ajaxDto = ajaxMapper.selectReplyView(groupNum_ajax);
		
		
		String msg = "";
		if(resultChk == 1) {
			msg = "답변등록이 완료되었습니다.";
		}
		
		
		//map에 담기
		map.put("msg", msg);
		map.put("ajaxDto", ajaxDto);
		
		
		return map;
	}


	
	
	
	


	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}//class
