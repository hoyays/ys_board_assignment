package com.example.demo.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.AjaxMapper;

@Service
public class AjaxPageNumbering {

	@Autowired
	AjaxMapper ajaxMapper;

	
	
	//리스트 페이지 넘버링 계산
	public Map<String, Object> pageNum(int page, int limit, String category, String search) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		int listCount = 0;
		
		//전체 게시글 개수 확인
		listCount = ajaxMapper.listCount(category, search);
		
		// 최대 페이지 수
		int maxPage = (int) ((double) listCount / limit + 0.95);
		
		// 첫 페이지 번호
		int startPage = ((int) ((double) page / 10 + 0.9) - 1) * 10 + 1;
		
		// 마지막 페이지 번호
		int endPage = maxPage;
		// 단!!!
		// 마지막 페이지가 11이상일 경우
		if (endPage > startPage + 10 - 1) {
			endPage = startPage + 10 - 1;
		} // if
		
		
		map.put("page", page);
		map.put("listCount", listCount);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("category", category);
		map.put("search", search);
		
		return map;
	}


	
	//댓글 페이지 넘버링 계산
	public Map<String, Object> comPageNum(String postNum_ajax, int comPage, int comLimit) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		int comListCount = 0;
		
		//전체 게시글 개수 확인
		comListCount = ajaxMapper.comListCount(postNum_ajax);
		
		
		// 최대 페이지 수
		int comMaxPage = (int) ((double) comListCount / comLimit + 0.95);
		
		// 첫 페이지 번호
		int comStartPage = ((int) ((double) comPage / 10 + 0.9) - 1) * 10 + 1;
		
		// 마지막 페이지 번호
		int comEndPage = comMaxPage;
		// 단!!!
		// 마지막 페이지가 11이상일 경우
		if (comEndPage > comStartPage + 10 - 1) {
			comEndPage = comStartPage + 10 - 1;
		} // if
		
		map.put("comPage", comPage);
		map.put("comListCount", comListCount);
		map.put("comMaxPage", comMaxPage);
		map.put("comStartPage", comStartPage);
		map.put("comEndPage", comEndPage);
		
		return map;
	}
	
	
	
	
	
	
}//class
