package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.ChartDto;

@Mapper
public interface ChartMapper {

	//게시물 등록건수
	List<ChartDto> selectDataPerDay(String weekAgo, String reqDate, String kind);        //일별 데이터
	List<ChartDto> selectDataPerMonth(String sixMonthAgo, String reqDate, String kind);  //월별 데이터
	
	
	
	//댓글수, 조회수
	List<ChartDto> selectDataCommentCnt(String sixMonthAgo, String reqDate, String kind);  //댓글수
	List<ChartDto> selectDataHitNumCnt(String sixMonthAgo, String reqDate, String kind);   //조회수

}//interface
