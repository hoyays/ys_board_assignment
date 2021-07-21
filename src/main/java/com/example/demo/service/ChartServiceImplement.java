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
	
	
	//일별 데이터
	@Override
	public List<ChartDto> dataPerDay(String weekAgo) {
		
		list = chartMapper.selectDataPerDay(weekAgo);
		return list;
	}


	//월별 데이터
	@Override
	public List<ChartDto> dataPerMonth(String sixMonthAgo) {
		
		list = chartMapper.selectDataPerMonth(sixMonthAgo);
		return list;
	}

}//class
