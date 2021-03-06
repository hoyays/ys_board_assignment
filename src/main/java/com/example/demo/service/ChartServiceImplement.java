package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.ChartDto;
import com.example.demo.mapper.ChartMapper;

@Service
public class ChartServiceImplement implements ChartService {

	@Autowired
	ChartMapper chartMapper;
	
	
	//변수선언
	List<ChartDto> list = new ArrayList<ChartDto>();
	
	
	
	//게시물 등록건수
	//일별 데이터
	@Override
	public List<ChartDto> dataPerDay(String weekAgo, String reqDate, String kind) {
		
		list = chartMapper.selectDataPerDay(weekAgo, reqDate, kind);
		return list;
	}


	//게시물 등록건수
	//월별 데이터
	@Override
	public List<ChartDto> dataPerMonth(String sixMonthAgo, String reqDate, String kind) {
		
		list = chartMapper.selectDataPerMonth(sixMonthAgo, reqDate, kind);
		return list;
	}


	
	//댓글수
	@Override
	public List<ChartDto> dataCommentCnt(String sixMonthAgo, String reqDate, String kind) {
		list = chartMapper.selectDataCommentCnt(sixMonthAgo, reqDate, kind);
		return list;
	}


	
	//조회수
	@Override
	public List<ChartDto> dataHitNumCnt(String sixMonthAgo, String reqDate, String kind) {
		list = chartMapper.selectDataHitNumCnt(sixMonthAgo, reqDate, kind);
		return list;
	}
	

}//class
