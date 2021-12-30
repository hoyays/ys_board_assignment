package com.example.demo.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.ChartDto;
import com.example.demo.service.ChartService;

@Controller
public class ChartController {
	
	@Autowired
	ChartService chartService;
	

	@RequestMapping("/chart")
	public String chart() {
		return "/chart/chart";
	}
	
	
	//일별 게시물 등록현황
	@RequestMapping("/chart/doChartPerDay")
	@ResponseBody
	public Map<String, Object> perDay(String selectedDate) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChartDto> list = new ArrayList<ChartDto>();
		
		//매겨변수로 넘어온, 선택된 날짜 세팅
		int year = Integer.parseInt(selectedDate.substring(0,4));
		int month = Integer.parseInt(selectedDate.substring(4,6));
		int day = Integer.parseInt(selectedDate.substring(6,8));
		LocalDate basicDate = LocalDate.of(year, month, day);
		String paramDate = basicDate.format(DateTimeFormatter.BASIC_ISO_DATE);   //YYYYMMDD

		
		
		//검색대상 일주일 날짜, 배열저장
		String [] week = new String[7];  //검색대상 일주일 날짜 저장
		week[0] = paramDate;
		for(int i=1; i<7; i++) {
			week[i] = basicDate.minusDays(i).format(DateTimeFormatter.BASIC_ISO_DATE);
		}
		

		//세팅된 날짜 기준, 일주일전 날짜 확인
		String weekAgo = week[6];
		
		
		//7일간 데이터 가져오기
		list = chartService.dataPerDay(weekAgo);
		
		//0 데이터 포함한 경우 확인
		List<ChartDto> tempList = new ArrayList<ChartDto>();
		int cnt = 0;
		
		for(int i=0; i<week.length; i++) {
			ChartDto tempDto = new ChartDto();
			
			tempDto.setResultDate(week[i]);
			tempDto.setBoardCnt(0);
			tempList.add(i, tempDto);
			
			for(int j=cnt; j<list.size(); j++) {
				
				ChartDto chartDto = list.get(j);
				
				if(week[i].equals(chartDto.getResultDate())) {
					tempDto.setResultDate(chartDto.getResultDate());
					tempDto.setBoardCnt(chartDto.getBoardCnt());
					tempList.add(i, tempDto);
					cnt++;
					break;
				}//if
			}//for
		}//for
		
		
		//map에 담기
		map.put("list", tempList);
		
		return map;
	}
	
	
	
	//월별 게시물 등록현황
	@RequestMapping("/chart/doChartPerMonth")
	@ResponseBody
	public Map<String, Object> perMonth(String selectedDate){
		
		
		//변수선언
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChartDto> list = new ArrayList<ChartDto>();
		
		
		//매겨변수로 넘어온, 선택된 날짜 ==> Date로 세팅
		int year = Integer.parseInt(selectedDate.substring(0,4));
		int month = Integer.parseInt(selectedDate.substring(4,6));
		int day = Integer.parseInt(selectedDate.substring(6,8));
		LocalDate basicDate = LocalDate.of(year, month, day);
		String paramDate = basicDate.format(DateTimeFormatter.BASIC_ISO_DATE).substring(0, 6);   
		
		
		
		//검색대상 일주일 날짜, 배열저장
		String [] sixMonth = new String[7];  //검색대상 6개월 저장
		sixMonth[0] = paramDate;
		for(int i=1; i<7; i++) {
			sixMonth[i] = basicDate.minusMonths(i).format(DateTimeFormatter.BASIC_ISO_DATE).substring(0, 6);
		}
		
		
		//세팅된 날짜 기준, 7개월 전 날짜 확인
		String sixMonthAgo = sixMonth[6];
		
		
		//6개월간 데이터 가져오기
		list = chartService.dataPerMonth(sixMonthAgo);
		
		
		//0 데이터 포함한 경우 확인
		List<ChartDto> tempList = new ArrayList<ChartDto>();
		int cnt = 0;
		
		for(int i=0; i<sixMonth.length; i++) {
			ChartDto tempDto = new ChartDto();
			
			tempDto.setResultDate(sixMonth[i]);
			tempDto.setBoardCnt(0);
			tempList.add(i, tempDto);
			
			for(int j=cnt; j<list.size(); j++) {
				
				ChartDto chartDto = list.get(j);
				
				if(sixMonth[i].equals(chartDto.getResultDate())) {
					tempDto.setResultDate(chartDto.getResultDate());
					tempDto.setBoardCnt(chartDto.getBoardCnt());
					tempList.add(i, tempDto);
					cnt++;
					break;
				}//if
			}//for
		}//for
		
		
		//map에 담기
		map.put("list", tempList);
		
		return map;
	}
	
	
	
	
}//class
