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
	
	
	//Chart Main 페이지
	@RequestMapping("/chartMain")
	public String chartMain() {
		return "/chart/chartMain";
	}
	
	///////////////////////////////////////////
	///////////////// 일반게시판 ///////////////// 
	///////////////////////////////////////////
	//게시물 등록 현황
	@RequestMapping("/chart")
	public String chart() {
		return "/chart/chart";
	}
	
	//댓글수,조회수 현황
	@RequestMapping("/chart2")
	public String chart2() {
		return "/chart/chart2";
	}
	
	
	
	/////////////////////////////////////////////
	///////////////// AJAX 게시판 ///////////////// 
	/////////////////////////////////////////////
	
	//게시물 등록 현황
	@RequestMapping("/chartAjax")
	public String chartAjax() {
		return "/chart/chartAjax";
	}
	
	//댓글수,조회수 현황
	@RequestMapping("/chartAjax2")
	public String chartAjax2() {
		return "/chart/chartAjax2";
	}
	
	
	
	
	
	
	
	//날짜 세팅 Method
	//검색대상 시작 ~ 끝에 해당되는 7개 날짜데이터 가공
	public String[] dataPeriodChk(String selectedDate, String type) {
		
		//변수선언
		String [] period = new String[7];
		String paramDate = null;
		
		//매개변수 selectedDate, 날짜 세팅
		int year = Integer.parseInt(selectedDate.substring(0,4));
		int month = Integer.parseInt(selectedDate.substring(4,6));
		int day = Integer.parseInt(selectedDate.substring(6,8));
		LocalDate basicDate = LocalDate.of(year, month, day);
		
		
		//(일간) basedOnDay의 경우 날짜 형태     : yyyyMMdd
		if(type.equals("basedOnDay")) {
			paramDate = basicDate.format(DateTimeFormatter.BASIC_ISO_DATE);
			period[0] = paramDate;
			for(int i=1; i<7; i++) {
				period[i] = basicDate.minusDays(i).format(DateTimeFormatter.BASIC_ISO_DATE);
			}
			
		//(월간) basedOnMonth의 경우 날짜 형태 : yyyyMM
		}else if(type.equals("basedOnMonth")) {
			paramDate = basicDate.format(DateTimeFormatter.BASIC_ISO_DATE).substring(0, 6);
			period[0] = paramDate;
			for(int i=1; i<7; i++) {
				period[i] = basicDate.minusMonths(i).format(DateTimeFormatter.BASIC_ISO_DATE).substring(0, 6);
			}
			
		}//if
		
		return period;
		
	}//dataPeriodChk()
	
	
	
	
	
	//DB에서 넘어온 데이터를 가공
	//월별 0 데이터를 가진 경우에 해당됨
	public List<ChartDto> makeDataPretty(String [] period, List<ChartDto> list){
		
		List<ChartDto> tempList = new ArrayList<ChartDto>();
		int cnt = 0;
		
		for(int i=0; i<period.length; i++) {
			ChartDto tempDto = new ChartDto();
			
			tempDto.setResultDate(period[i]);
			tempDto.setBoardCnt(0);
			tempList.add(i, tempDto);
			
			for(int j=cnt; j<list.size(); j++) {
				
				ChartDto chartDto = list.get(j);
				
				if(period[i].equals(chartDto.getResultDate())) {
					tempDto.setResultDate(chartDto.getResultDate());
					tempDto.setBoardCnt(chartDto.getBoardCnt());
					tempList.add(i, tempDto);
					cnt++;
					break;
				}//if
			}//for
		}//for
		
		return tempList;
		
	}//makeDataPretty()
	
	
	
	
	
	//일별 게시물 등록현황
	@RequestMapping("/chart/doChartPerDay")
	@ResponseBody
	public Map<String, Object> perDay(String selectedDate, String kind){
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChartDto> list = new ArrayList<ChartDto>();
		String [] week = new String[7];  //검색대상 7개 날짜 저장

		//검색대상 시작 ~ 끝 날짜 세팅
		week = dataPeriodChk(selectedDate, "basedOnDay");
		
		//7일간 데이터 가져오기
		//매개변수(매개변수 날짜 기준 7일전, 매개변수 날짜, 게시판종류)
		list = chartService.dataPerDay(week[6], week[0], kind);
		
		
		//DB데이터 가공 - 0데이터 포함된 경우에 해당
		List<ChartDto> tempList = new ArrayList<ChartDto>();
		tempList = makeDataPretty(week, list);
		
		//map에 담기
		map.put("list", tempList);
		
		
		return map;
	}
	
	
	
	
	//월별 게시물 등록현황
	@RequestMapping("/chart/doChartPerMonth")
	@ResponseBody
	public Map<String, Object> perMonth(String selectedDate, String kind){
		
		//변수선언
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChartDto> list = new ArrayList<ChartDto>();
		String [] sixMonth = new String[7];  //검색대상 6개월 저장
		
		//검색대상 시작 ~ 끝 날짜 세팅
		sixMonth = dataPeriodChk(selectedDate, "basedOnMonth");
		
		
		//7개월간 데이터 가져오기
		//매개변수(매개변수 날짜 기준 7개월전, 매개변수 월, 게시판종류)
		list = chartService.dataPerMonth(sixMonth[6], sixMonth[0], kind);
		
		
		//DB데이터 가공 - 0데이터 포함된 경우에 해당
		List<ChartDto> tempList = new ArrayList<ChartDto>();
		tempList = makeDataPretty(sixMonth, list);
		
		//map에 담기
		map.put("list", tempList);
		
		return map;
	}
	
	
	
	
	
	//댓글수, 조회수 현황
	@RequestMapping("/chart2/doChartMultiAxis")
	@ResponseBody
	public Map<String, Object> multiAxisChart(String selectedDate, String kind){
		
		
		//변수선언
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChartDto> listComment = new ArrayList<ChartDto>();
		List<ChartDto> listHitNum = new ArrayList<ChartDto>();
		String [] sixMonth = new String[7];  //검색대상 6개월 저장
		
		
		//검색대상 시작 ~ 끝 날짜 세팅
		sixMonth = dataPeriodChk(selectedDate, "basedOnMonth");
		
		
		//7개월간 데이터 가져오기
		//매개변수(매개변수 날짜 기준 7개월전, 매개변수 월, 게시판종류)
		listComment = chartService.dataCommentCnt(sixMonth[6], sixMonth[0], kind);   //댓글수
		listHitNum = chartService.dataHitNumCnt(sixMonth[6], sixMonth[0], kind);     //조회수
		
		
		
		//DB데이터 가공 - 0데이터 포함된 경우에 해당
		List<ChartDto> tempList_commentCnt = new ArrayList<ChartDto>();
		List<ChartDto> tempList_htiNumCnt = new ArrayList<ChartDto>();
		tempList_commentCnt = makeDataPretty(sixMonth, listComment);       //댓글수
		tempList_htiNumCnt = makeDataPretty(sixMonth, listHitNum);         //조회수
		
		
		//map에 담기
		map.put("listComment", tempList_commentCnt);
		map.put("listHitNum", tempList_htiNumCnt);
		
		
		return map;
		
		
	}
	
	
	
	
	
}//class
