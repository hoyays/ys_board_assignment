package com.example.demo.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
		
		//System.out.println(selectedDate);
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChartDto> list = new ArrayList<ChartDto>();
		
		//매겨변수로 넘어온, 선택된 날짜 ==> Date로 세팅
		int year = Integer.parseInt(selectedDate.substring(0,4));
		int month = Integer.parseInt(selectedDate.substring(4,6));
		int day = Integer.parseInt(selectedDate.substring(6,8));
		
		Calendar cal = Calendar.getInstance();
		cal.set(year, month-1, day);  //매겨변수로 넘어온, 선택된 날짜로 세팅
		
		//세팅된 날짜 기준, 일주일전 날짜 확인
		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMdd");
		cal.add(Calendar.DAY_OF_MONTH, -6);
		String weekAgo = sdf.format(cal.getTime());
		
		//검색대상 일주일 날짜, 배열저장
		String [] week = new String[7];  //검색대상 일주일 날짜 저장
		cal.set(year, month-1, day);
		week[0] = sdf.format(cal.getTime());
		for(int i=1; i<=6; i++) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
			week[i] = sdf.format(cal.getTime());
		}
		
		//7일간 데이터 가져오기
		list = chartService.dataPerDay(weekAgo);
		
		//0 데이터 포함한 경우 확인
		List<ChartDto> tempList = new ArrayList<ChartDto>();
		int cnt = 0;
		
		for(int i=0; i<week.length; i++) {
			ChartDto tempDto = new ChartDto();
//			System.out.println("바깥 for, i : "+i);
			
			tempDto.setResultDate(week[i]);
			tempDto.setBoardCnt(0);
			tempList.add(i, tempDto);
//			System.out.println(i+"번째, 날짜 : "+tempDto.getResultDate());
//			System.out.println(i+"번째, 데이터 : "+tempDto.getBoardCnt());
			
			for(int j=cnt; j<list.size(); j++) {
//				System.out.println("안쪽 for, j : "+j);
				
				ChartDto chartDto = list.get(j);
//				System.out.println(j+"번째, DB 날짜 : "+chartDto.getResultDate());
//				System.out.println(j+"번째, DB 데이터 : "+chartDto.getBoardCnt());
				
				
				if(week[i].equals(chartDto.getResultDate())) {
					tempDto.setResultDate(chartDto.getResultDate());
					tempDto.setBoardCnt(chartDto.getBoardCnt());
//					System.out.println(j+"번째, 가공처리된 날짜(if문) : "+tempDto.getResultDate());
//					System.out.println(j+"번째, 가공처리된 데이터 건수(if문) : "+tempDto.getBoardCnt());
//					System.out.println("=================================");
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
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChartDto> list = new ArrayList<ChartDto>();
		
//		System.out.println("넘어온 날짜 : "+selectedDate);
		
		//매겨변수로 넘어온, 선택된 날짜 ==> Date로 세팅
		int year = Integer.parseInt(selectedDate.substring(0,4));
		int month = Integer.parseInt(selectedDate.substring(4,6));
		int day = Integer.parseInt(selectedDate.substring(6,8));
		
		Calendar cal = Calendar.getInstance();
		cal.set(year, month-1, day);  //매겨변수로 넘어온, 선택된 날짜로 세팅
//		System.out.println("선택된 날짜 : "+cal.getTime());
		
		//세팅된 날짜 기준, 7개월 전 날짜 확인
		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMdd");
		cal.add(Calendar.DAY_OF_MONTH, -180);
		String sixMonthAgo = sdf.format(cal.getTime()).substring(0, 6);
//		System.out.println("선택된 날짜 기준, 6개월 전 : "+sixMonthago);
		
		
		//검색대상 6개월, 배열저장
		String [] sixMonth = new String[7];  //검색대상 6개월 저장
		cal.set(year, month-1, day);
		sixMonth[0] = sdf.format(cal.getTime()).substring(0, 6);
		for(int i=1; i<=6; i++) {
			cal.add(Calendar.DAY_OF_MONTH, -30);
			sixMonth[i] = sdf.format(cal.getTime()).substring(0, 6);
		}
		
		//6개월 저장 확인
//		for(String i : sixMonth) {
//			System.out.println(i);
//		}
		
		
		//6개월간 데이터 가져오기
		list = chartService.dataPerMonth(sixMonthAgo);
		
		
		
		//0 데이터 포함한 경우 확인
		List<ChartDto> tempList = new ArrayList<ChartDto>();
		int cnt = 0;
		
		for(int i=0; i<sixMonth.length; i++) {
			ChartDto tempDto = new ChartDto();
//			System.out.println("바깥 for, i : "+i);
			
			tempDto.setResultDate(sixMonth[i]);
			tempDto.setBoardCnt(0);
			tempList.add(i, tempDto);
//			System.out.println(i+"번째, 날짜 : "+tempDto.getResultDate());
//			System.out.println(i+"번째, 데이터 : "+tempDto.getBoardCnt());
			
			for(int j=cnt; j<list.size(); j++) {
//				System.out.println("안쪽 for, j : "+j);
				
				ChartDto chartDto = list.get(j);
//				System.out.println(j+"번째, DB 날짜 : "+chartDto.getResultDate());
//				System.out.println(j+"번째, DB 데이터 : "+chartDto.getBoardCnt());
				
				
				if(sixMonth[i].equals(chartDto.getResultDate())) {
					tempDto.setResultDate(chartDto.getResultDate());
					tempDto.setBoardCnt(chartDto.getBoardCnt());
//					System.out.println(j+"번째, 가공처리된 날짜(if문) : "+tempDto.getResultDate());
//					System.out.println(j+"번째, 가공처리된 데이터 건수(if문) : "+tempDto.getBoardCnt());
//					System.out.println("=================================");
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
