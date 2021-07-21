package com.example.demo.service;

import java.util.List;

import com.example.demo.dto.ChartDto;

public interface ChartService {

	List<ChartDto> dataPerDay(String weekAgo);   //일별 데이터
	List<ChartDto> dataPerMonth(String sixMonthAgo);  //월별 데이터

}//interface
