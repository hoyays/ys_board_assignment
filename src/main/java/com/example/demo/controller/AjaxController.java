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

import com.example.demo.dto.AjaxCommentDto;
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
	@RequestMapping("/ajax/doList")
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
	public Map<String, Object> ajaxDoWrite(AjaxDto ajaxDto, String page,
			@Nullable String category, @Nullable String search) {
		
		String msg = ajaxService.ajaxDoWrite(ajaxDto, page, category, search);
		
		//리스트 새롭게 불러오기
		map = ajaxService.ajaxListAll(page, category, search);
		
		//map에 담기
		map.put("msg", msg);
		
		return map;
	}
	
	
	
	//상세페이지 - View
	@RequestMapping("/ajax/view")
	public String ajaxView(@RequestParam String postNum_ajax) {
		return "/ajax/view";
	}
	
	
	
	//상세 페이지 - DB에서 데이터 불러오기
	@RequestMapping("/ajax/doView")
	@ResponseBody
	public Map<String, Object> ajaxDoView(AjaxDto ajaxDto, String comPage,
			HttpServletRequest request, HttpServletResponse response){
		
		//세션값 확인하기
		HttpSession session = request.getSession();
		String session_user_id = (String) session.getAttribute("session_user_id");
		
		//상세 페이지 내용 불러오기
		AjaxDto ajaxDtoResult = ajaxService.ajaxDoView(ajaxDto, request, response);
		
		//댓글 리스트 + 댓글 페이징
		String postNum_ajax = ajaxDto.getPostNum_ajax()+"";
		if(comPage == null || comPage.equals("")) {
			comPage = "1";
		}
		map = ajaxService.ajaxCommentListAll(postNum_ajax, comPage);

		
		//map에 담기
		map.put("session_user_id", session_user_id);
		map.put("ajaxDto", ajaxDtoResult);
		return map;
		
	}
	
	
	//글 삭제하기
	@RequestMapping("/ajax/doDelete")
	@ResponseBody
	public Map<String, Object> ajaxDoDelete(String postNum_ajax, String page,
			@Nullable String category, @Nullable String search) {
		
		String msg = ajaxService.ajaxDoDelete(postNum_ajax, page, category, search);
		
		//리스트 새롭게 불러오기
		map = ajaxService.ajaxListAll(page, category, search);
		
		//map에 담기
		map.put("msg", msg);
		
		return map;
	}
	
	
	
	//수정 - View 데이터 가져오기
	@RequestMapping("/ajax/modify")
	@ResponseBody
	public Map<String, Object> ajaxModify(String postNum_ajax, String page) {
		
		map = ajaxService.ajaxModify(postNum_ajax, page);
		return map;
	}
	
	
	
	//글 수정 - DB 저장하기
	@RequestMapping("/ajax/doModify")
	@ResponseBody
	public Map<String, Object> ajaxDoModify(AjaxDto ajaxDto, String page, 
			HttpServletRequest request, HttpServletResponse response){
		
		String msg = ajaxService.ajaxDoModify(ajaxDto, page);
		
		//수정 후 상세 페이지 불러오기
		AjaxDto ajaxDtoResult = ajaxService.ajaxDoView(ajaxDto, request, response);
		
		//map에 담기
		map.put("msg", msg);
		map.put("ajaxDto", ajaxDtoResult);
		
		
		return map;
	}
	
	
	
	//답변 - DB 저장하기
	@RequestMapping("/ajax/doReply")
	@ResponseBody
	public Map<String, Object> ajaxDoReply(AjaxDto ajaxDto, String page){
		
		map = ajaxService.ajaxDoReply(ajaxDto, page);
		
		return map;
	}
	
	
	
	
	//댓글쓰기 - DB 저장하기
	@RequestMapping("/ajax/doComWrite")
	@ResponseBody
	public Map<String, Object> ajaxDoComWrite(AjaxCommentDto ajaxCommentDto, String page, String comPage){
		
		
		if(ajaxCommentDto.getComSecret_ajax() == null || ajaxCommentDto.getComSecret_ajax().equals("")) {
			ajaxCommentDto.setComSecret_ajax("n");
		}
		
		if(page == null || page.equals("")) {
			page = "1";
		}
		
		ajaxService.ajaxDoComWrite(ajaxCommentDto, page);
		
		//댓글 리스트 불러오기
		String postNum_ajax = ajaxCommentDto.getPostNum_ajax()+"";
		map = ajaxService.ajaxCommentListAll(postNum_ajax, comPage);
		
		//map에 담기
		map.put("page", page);
		
		return map;
	}
	
	
	
	//댓글 삭제하기
	@RequestMapping("/ajax/doComDelete")
	@ResponseBody
	public Map<String, Object> ajaxDoComDelete(AjaxCommentDto ajaxCommentDto, String comPage){
		
		String msg = ajaxService.ajaxDoComDelete(ajaxCommentDto);
		
		
		//댓글 리스트 불러오기
		String postNum_ajax = ajaxCommentDto.getPostNum_ajax()+"";
		map = ajaxService.ajaxCommentListAll(postNum_ajax, comPage);
		
		//map에 담기
		map.put("msg", msg);
		
		return map;
	}
	
	
	
	//댓글 수정하기 View
	@RequestMapping("/ajax/comModify")
	@ResponseBody
	public Map<String, Object> ajaxComModify(AjaxCommentDto ajaxCommentDto, String comPage){
		
		AjaxCommentDto ajaxCommentDtoResult = ajaxService.ajaxComModify(ajaxCommentDto);
		
		
		//댓글 리스트 불러오기
		String postNum_ajax = ajaxCommentDto.getPostNum_ajax()+"";
		map = ajaxService.ajaxCommentListAll(postNum_ajax, comPage);
		
		//map에 담기
		map.put("ajaxCommentDto", ajaxCommentDtoResult);
		
		return map;
	}
	
	
	//댓글 수정 - 저장하기
	@RequestMapping("/ajax/docomModify")
	@ResponseBody
	public Map<String, Object> ajaxDoComModify(AjaxCommentDto ajaxCommentDto, String page, String comPage){
		
		if(ajaxCommentDto.getComSecret_ajax() == null || ajaxCommentDto.getComSecret_ajax().equals("")) {
			ajaxCommentDto.setComSecret_ajax("n");
		}
		
		ajaxService.ajaxDoComModify(ajaxCommentDto, page);
		
		
		//댓글 리스트 불러오기
		String postNum_ajax = ajaxCommentDto.getPostNum_ajax()+"";
		map = ajaxService.ajaxCommentListAll(postNum_ajax, comPage);
		
		//map에 담기
		map.put("page", page);
		
		return map;
	}
	
	
	
	
	
}//class
