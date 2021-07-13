package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.AjaxDto;
import com.example.demo.service.AjaxService;

@Controller
public class AjaxController {
	
	@Autowired
	AjaxService ajaxService;
	
	
	//변수선언
	Map<String, Object> map = new HashMap<String, Object>();
	
	
	//리스트 View
	@RequestMapping("ajax/list")
	public String ajaxListView() {
		return "/ajax/list";
	}
	
	
	//전체 리스트 - DB에서 데이터 불러오기
	//검색결과 리스트
	@RequestMapping("/ajax/DoList")
	@ResponseBody
	public Map<String, Object> ajaxDoList(@Nullable String page, 
			@Nullable String category, @Nullable String search) {
		
		
		if(page == null || page.equals("")) {
			page = "1";
		}
		
		map = ajaxService.ajaxListAll(page, category, search);
		map.put("page", page);
		
		return map;
	}
	
	
	//페이징 기능
	@RequestMapping("/ajax/movePg")
	@ResponseBody
	public Map<String, Object> ajaxNextPg(String page, 
			@Nullable String category, @Nullable String search) {
		
		map = ajaxService.ajaxListAll(page, category, search);
		map.put("page", page);
		
		return map;
	}
	

	
	//쓰기,수정,답변하기 View
	@RequestMapping("/ajax/write")
	public String ajaxWrite(@RequestParam String page) {
		if(page == null || page.equals("")) {
			page = "1";
		}
		return "/ajax/write";
	}
	
	
	
	//쓰기 - DB 저장하기
	@RequestMapping("/ajax/doWrite")
	@ResponseBody
	public Map<String, Object> ajaxDoWrite(String user_id, String title_ajax, 
			String contents_ajax, String page,
			@Nullable String category, @Nullable String search) {
		
		map = ajaxService.ajaxDoWrite(user_id, title_ajax, contents_ajax, page, category, search);
		return map;
	}
	
	
	
	//상세페이지 - View
	@RequestMapping("/ajax/view")
	public String ajaxView(@RequestParam String postNum_ajax, Model model) {
		return "/ajax/view";
	}
	
	
	
	//상세 페이지 - DB에서 데이터 불러오기
	@RequestMapping("/ajax/DoView")
	@ResponseBody
	public Map<String, Object> ajaxDoView(String postNum_ajax, 
			HttpServletRequest request, HttpServletResponse response){
		
		HttpSession session = request.getSession();
		String session_user_id = (String) session.getAttribute("session_user_id");
		
		map = ajaxService.ajaxDoView(postNum_ajax, request, response);
		map.put("session_user_id", session_user_id);
		return map;
		
	}
	
	
	//글 삭제하기
	@RequestMapping("/ajax/doDelete")
	@ResponseBody
	public Map<String, Object> ajaxDoDelete(String postNum_ajax, String page,
			@Nullable String category, @Nullable String search) {
		
		map = ajaxService.ajaxDoDelete(postNum_ajax, page, category, search);
		
		return map;
	}
	
	
	//수정 - View 데이터 가져오기
	@RequestMapping("/ajax/modifyView")
	@ResponseBody
	public Map<String, Object> ajaxmodifyView(String postNum_ajax, String page) {
		
		map = ajaxService.ajaxModifyView(postNum_ajax, page);
		return map;
	}
	
	
	
	//글 수정 - DB 저장하기
	@RequestMapping("/ajax/doModify")
	@ResponseBody
	public Map<String, Object> ajaxDoModify(String postNum_ajax, 
			String title_ajax, String contents_ajax, String page){
		
		map = ajaxService.ajaxDoModify(postNum_ajax, title_ajax, contents_ajax, page);
		
		return map;
	}
	
	
	
	//답변 - DB 저장하기
	@RequestMapping("/ajax/doReply")
	@ResponseBody
	public Map<String, Object> ajaxDoReply(String user_id, String title_ajax, 
			String contents_ajax, String postNum_ajax, 
			String groupNum_ajax, String indentNum_ajax, 
			String stepNum_ajax, String page){
		
		map = ajaxService.ajaxDoReply(user_id, title_ajax, 
				contents_ajax, postNum_ajax, groupNum_ajax, 
				indentNum_ajax, stepNum_ajax, page);
		
		return map;
	}
	
	
	
	
	
	
	
	
	
}//class
