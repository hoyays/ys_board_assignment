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
		String weekago = sdf.format(cal.getTime());
		
		//검색대상 일주일 날짜, 배열저장
		String [] week = new String[7];  //검색대상 일주일 날짜 저장
		week[0] = sdf.format(cal.getTime());
		for(int i=1; i<=6; i++) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
			week[i] = sdf.format(cal.getTime());
		}
		
		//7일간 데이터 가져오기
		list = chartService.dataPerDay(weekago);
		
		//가공전
//		for(int i=0; i<list.size(); i++) {
//			ChartDto c = list.get(i);
//			System.out.println(i+"번째 날짜 : "+c.getResultDate());
//			System.out.println(i+"번째 데이터 : "+c.getBoardCnt());
//			System.out.println();
//		}
		
		
		
		
		//0 데이터 포함한 경우 확인
		String [] zeroDate = new String[7];
		ChartDto tempDto = new ChartDto();
		
		for(int i=0; i<list.size(); i++) {
			for(int j=0; j<week.length; j++) {
				ChartDto chartDto = list.get(i);
				if(week[j].equals(chartDto.getResultDate())) {
					tempDto.setResultDate(week[j]);
					tempDto.setBoardCnt(chartDto.getBoardCnt());
					list.add(tempDto);
					list.remove(i);
					break;
				}else {
					tempDto.setResultDate(week[j]);
					tempDto.setBoardCnt(0);
					list.add(tempDto);
				}
			}//for
		}//for

		
		for(int i=0; i<list.size(); i++) {
			ChartDto c = list.get(i);
			System.out.println(i+"번째 날짜 : "+c.getResultDate());
			System.out.println(i+"번째 데이터 : "+c.getBoardCnt());
			System.out.println();
		}
		
		
		//map에 담기
		map.put("list", list);
		
		return map;
	}
	
	
	
	
}//class
