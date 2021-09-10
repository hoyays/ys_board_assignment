package com.example.demo.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.BoardDto;
import com.example.demo.dto.ReplyDto;
import com.example.demo.service.BoardListExcelExporter;
import com.example.demo.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	//변수선언
	Map<String, Object> map = new HashMap<String, Object>();
	
	
	//리스트
	@RequestMapping("/board/list")
	public String boardList(@RequestParam @Nullable String page, 
			@RequestParam @Nullable String category,
			@RequestParam @Nullable String search, Model model) {
		
		Map<String, Object> map = boardService.listAll(page, category, search);
		model.addAttribute("map", map);
		return "/board/list";
	}
	
	
	
	
	//엑셀 다운로드
	//참고 유튜브 : https://www.youtube.com/watch?v=BtUdl9pZwR0
	//참고 블로그 : https://jhhan009.tistory.com/67
	@GetMapping("/excelDown")
	public void excelDown(@RequestParam @Nullable String page, 
			@RequestParam @Nullable String category,
			@RequestParam @Nullable String search, 
			HttpServletResponse response) throws IOException {
		
		//컨텐츠 타입 지정
		response.setContentType("application/octet-stream");
		String headerKey = "Content-Disposition";
		
		//엑셀 파일명 - 다운로드 한 시각 추가표시
		DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HHmmss");
		String currentDateTime = dateFormatter.format(new Date());
		String fileName = "boardList_" + currentDateTime + ".xlsx";
		String headerValue = "attachment; filename="+fileName;
		response.setHeader(headerKey, headerValue);

		
		//엑셀 파일로 출력할 Data 가져오기
		List<BoardDto> list = boardService.listExcelDown(category, search);
		
		
		//엑셀 추출 및 가공(디자인 포함) - class 호출
		BoardListExcelExporter excelExporter = new BoardListExcelExporter(list);
		excelExporter.export(response);
		
	}
	
	
	
	//엑셀 업로드
	@RequestMapping("/excelUp")
	public String excelUp(MultipartFile file, Model model) throws IOException{
		
		boardService.listExcelUp(file);
		model.addAttribute("map", map);
		
		return "redirect:/board/list";
	}
	
	

	
	//상세 페이지
	@RequestMapping("/board/view")
	public String boardView(@RequestParam String postNum, 
			@RequestParam @Nullable String page, 
			@RequestParam @Nullable String rePage,
			@RequestParam @Nullable String search, 
			@RequestParam @Nullable String category,  
			HttpServletRequest request, HttpServletResponse response, Model model) {
		
		if(rePage == null || rePage.equals("")) {
			rePage = "1";
		}
		
		Map<String, Object> map = boardService.boardView(postNum, page, rePage, request, response);
		map.put("search", search);
		map.put("category", category);
		model.addAttribute("map", map);
		return "/board/view";
	}
	
	
	
	//글쓰기 - View
	@RequestMapping("/board/write")
	public String boardWrite(Model model) {
		
		BoardDto boardDto = null;
		map.put("boardDto", boardDto);
		map.put("replyView", "0");
		map.put("formAction", "/writeChk");
		model.addAttribute("map", map);
		
		return "/board/write";
	}
	
	//글쓰기 처리 - DB 저장
	@RequestMapping("/writeChk")
	public String writeChk(BoardDto boardDto, 
			@RequestPart MultipartFile file, HttpServletRequest request, Model model) {
		
		//log.info(">>>> write 저장, 내용 확인 : "+boardDto.getContents());
		boardService.boardWrite(boardDto, file, request);
		model.addAttribute("map", map);
		return "redirect:/board/list";
	}
	
	
	//수정하기 - View 페이지
	@RequestMapping("board/modify")
	public String boardModify(HttpServletRequest request,
			@RequestParam String postNum, @RequestParam @Nullable String page, Model model) {
		
		Map<String, Object> map = boardService.boardModifyView(postNum, page);
		map.put("formAction", "/modifyChk");
		model.addAttribute("map", map);
		
		return "/board/write";
	}
	
	
	//수정하기 - DB 저장하기
	@RequestMapping("/modifyChk")
	public String modifyChk(BoardDto boardDto, @RequestParam @Nullable String page, 
			@RequestPart MultipartFile file, Model model) {
		
		boardService.modifyChk(boardDto, file);
		map.put("page", page);
		model.addAttribute("map", map);
		
		return "redirect:/board/list?page="+page;
	}
	
	
	//삭제하기
	@RequestMapping("/deleteChk")
	public String deleteChk(@RequestParam String postNum, 
			@RequestParam @Nullable String page, Model model) {
		
		boardService.deleteChk(postNum);
		map.put("page", page);
		model.addAttribute("map", map);
		
		return "redirect:/board/list?page="+page;
	}
	
	
	
	//답변하기 - View 페이지
	@RequestMapping("/replyView")
	public String replyView(@RequestParam String postNum, @RequestParam @Nullable String page, Model model) {
		
		BoardDto boardDto = boardService.boardReplyView(postNum);
		map.put("page", page);
		map.put("boardDto", boardDto);
		map.put("replyView", "1");
		map.put("formAction", "/replyChk");
		model.addAttribute("map", map);
		
		return "/board/write";
	}
	
	
	
	//답변하기 - DB 저장하기
	@RequestMapping("/replyChk")
	public String replyChk(BoardDto boardDto, @RequestParam @Nullable String page, 
			@RequestPart MultipartFile file, Model model) {
		
		System.out.println("con, stepNum : "+boardDto.getStepNum()); //0
		boardService.replyChk(boardDto, file);
		map.put("page", page);
		model.addAttribute("map", map);
		
		return "redirect:/board/list?page="+page;
	}
	
	
	
	
	//댓글 - DB 저장하기
	@RequestMapping("/reWrite")
	public String replyChk(ReplyDto replyDto, 
			@RequestParam @Nullable String page, @RequestParam String postNum, Model model) {
		
		//비밀글 체크박스 - 설정 X
		if(replyDto.getReSecret() == null) {
			replyDto.setReSecret("n");
		}
		
		boardService.replyWrite(replyDto);
		model.addAttribute("page", page);
		model.addAttribute("postNum", postNum);
		
		return "redirect:/board/view?page="+page+"&postNum="+postNum;
	}
	
	
	
	
	//댓글 수정 View 페이지
	@RequestMapping("/commentModifyView")
	public String commentModifyView(@RequestParam @Nullable String page,
			@RequestParam @Nullable String rePage,
			@RequestParam String postNum, @RequestParam String reNum, 
			HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Map<String, Object> map = boardService.boardView(postNum, page, rePage, request, response);
		map.put("reNum", reNum);
		model.addAttribute("map", map);
		
		return "/board/commentModifyView";
	}
	
	
	//댓글 수정 - DB 저장하기
	@RequestMapping("/commentModifyChk")
	public String commentModifyChk(ReplyDto replyDto, 
			@RequestParam @Nullable String page, @RequestParam String postNum, Model model) {
		
		//비밀글 체크박스 - 설정 X
		if(replyDto.getReSecret() == null) {
			replyDto.setReSecret("n");
		}
		
		boardService.replyModify(replyDto);
		model.addAttribute("page", page);
		model.addAttribute("postNum", postNum);
		
		return "redirect:/board/view?page="+page+"&postNum="+postNum;
	}

	
	
	//댓글 삭제하기
	@RequestMapping("/commentDeleteChk")
	public String commentDeleteChk(@RequestParam String reNum, 
			@RequestParam @Nullable String page, @RequestParam String postNum, Model model) {
		
		boardService.replyDelete(reNum, postNum);
		return "redirect:/board/view?page="+page+"&postNum="+postNum;
	}
	
	
	
	
	//첨부파일 다운로드
	@RequestMapping("/fileDown")
	public void fileDown(@RequestParam @Nullable String postNum,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		boardService.fileDown(postNum, request, response);
	}
	

}//class
