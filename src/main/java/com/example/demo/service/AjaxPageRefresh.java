package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.AjaxDto;
import com.example.demo.mapper.AjaxMapper;

@Service
public class AjaxPageRefresh {
	
	@Autowired
	AjaxMapper ajaxMapper;
	
	//변수선언
	Map<String, Object> map = new HashMap<String, Object>();
	
	
	//리스트 새롭게 불러오기
	public Map<String, Object> listRefresh(String listPage, String category, String search){
		
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
		
		//map에 답기
		map.put("list", list);
		map.put("page", page);
		map.put("limit", limit);
		
		return map;
		
	}
	
	

}//class
