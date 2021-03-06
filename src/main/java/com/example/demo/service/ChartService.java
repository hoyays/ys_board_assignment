package com.example.demo.service;

import java.util.List;

import com.example.demo.dto.ChartDto;

public interface ChartService {

	
	//게시물 등록건수
	List<ChartDto> dataPerDay(String weekAgo, String reqDate, String kind);   //일별 데이터
	List<ChartDto> dataPerMonth(String sixMonthAgo, String reqDate, String kind);  //월별 데이터
	
	
	//댓글수, 조회수
	List<ChartDto> dataCommentCnt(String sixMonthAgo, String paramDate, String kind);   //댓글수
	List<ChartDto> dataHitNumCnt(String sixMonthAgo, String paramDate, String kind);    //조회수
	

}//interface
