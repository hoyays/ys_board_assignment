package com.example.demo.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.BoardMapper;

@Service
public class BoardPageNumbering {
	
	@Autowired
	BoardMapper boardMapper;

	//메소드
	//Board - 리스트 페이지 넘버링 계산
	public Map<String, Object> pageNum(int page, int limit, String category, String search) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		int listCount = 0;
		
		//전체 게시글 개수 확인
		listCount = boardMapper.listCount(category, search);	
			
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
		map.put("search", search);
		map.put("category", category);
		
		return map;
	}

	
	
	//댓글 페이지 넘버링
	public Map<String, Object> rePageNum(String postNum, int rePage, int reLimit) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		int reListCount = 0;
		
		//전체 게시글 개수 확인
		reListCount = boardMapper.reListCount(postNum);
		
		// 최대 페이지 수
		int reMaxPage = (int) ((double) reListCount / reLimit + 0.95);
		
		// 첫 페이지 번호
		int reStartPage = ((int) ((double) rePage / 10 + 0.9) - 1) * 10 + 1;
		
		// 마지막 페이지 번호
		int reEndPage = reMaxPage;
		// 단!!!
		// 마지막 페이지가 11이상일 경우
		if (reEndPage > reStartPage + 10 - 1) {
			reEndPage = reStartPage + 10 - 1;
		}// if
		
		map.put("rePage", rePage);
		map.put("reListCount", reListCount);
		map.put("reMaxPage", reMaxPage);
		map.put("reStartPage", reStartPage);
		map.put("reEndPage", reEndPage);
		
		return map;
	}

}//class
