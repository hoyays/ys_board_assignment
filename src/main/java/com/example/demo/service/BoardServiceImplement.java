package com.example.demo.service;

import java.awt.PageAttributes.MediaType;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tomcat.jni.FileInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.BoardDto;
import com.example.demo.dto.ReplyDto;
import com.example.demo.mapper.BoardMapper;

import ch.qos.logback.core.util.FileUtil;

@Service
public class BoardServiceImplement implements BoardService {
	
	@Autowired
	BoardMapper boardMapper;
	@Autowired
	BoardPageNumbering pageNumbering;
	
	//윈도우용
	@Value(value = "${resources.location}")
	private String fileUrl;
	
	//리눅스용
//	@Value(value = "${resources.linuxLocation}")
//	private String fileUrl;
	
	
	//변수선언
	Map<String, Object> map = new HashMap<String, Object>();
	
	
	//리스트 View
	@Override
	public Map<String, Object> listAll(String listPage, String category, String search) {
		
		int page = 1;    //첫 페이지 초기화
		int limit = 10;  //1개 페이지에 노출되는 게시글 수(10개씩)
		
		// 매개변수 listPage 데이터가 있으면 데이터 적용
		if (listPage != null && listPage != "") {
			page = Integer.parseInt(listPage);
		}
		
		int startRow = (page-1)*limit+1;   //선택한 페이지의 첫번째 줄 => 1, 11, 21...
		int endRow = startRow+limit-1;   //선택한 페이지의 마지막 줄 => 10, 20, 30 ...
		
		
		//검색기능
		//DB에서 게시판 리스트 불러오기
		List<BoardDto> list = new ArrayList<BoardDto>();
		list = boardMapper.selectListAll(startRow, endRow, search, category);
		
		//검색결과 list가 공백인 경우 - 비어 있으면 true
		boolean searchResult = list.isEmpty();
		
		//페이지 넘버링 계산
		map = pageNumbering.pageNum(page, limit, category, search);
		
		//map에 담기
		map.put("list", list);
		map.put("searchResult", searchResult);
		
		return map;
	}
	

	
	//글쓰기 처리 - DB 저장하기
	@Override
	public void boardWrite(BoardDto boardDto, MultipartFile file, HttpServletRequest request) {
		
		//첨부파일 처리
		String fileName = file.getOriginalFilename();  //원본파일 이름
		String filenameExtension = FilenameUtils.getExtension(fileName).toLowerCase();  //확장자명 가져오기
		long size = file.getSize()/1024;  //파일 사이즈(단위 kb)
		String fileSize = Long.toString(size);
		
		if(filenameExtension != "") {
//			String fileUrl = "C:/workspace/ys_board_assignment/src/main/resources/static/upload/";  //파일저장위치(마지막에 반드시 슬래시(/))
//			String fileUrl = "D:/workspace/externalUpload/";
			String uploadFileName = RandomStringUtils.randomAlphanumeric(32)+"."+filenameExtension;  //신규 파일 이름 - 32자리(중복방지)
			File f = new File(fileUrl+uploadFileName);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//위에서 처리한 파일이름까지 boardDto에 담아서 DB로 보낸다.
			boardDto.setFileName(uploadFileName);   //파일명 중복 방지
			boardDto.setOriginFileName(fileName);   //원본 파일명
			boardDto.setFileSize(fileSize);  		//파일 사이즈
		}else {
			boardDto.setFileName("");  //첨부파일이 없는 경우
			boardDto.setOriginFileName("");
			boardDto.setFileSize("");
		}
		
		//DB로 전송
		boardMapper.insertWrite(boardDto);
	}



	//상세 페이지
	@Override
	public Map<String, Object> boardView(String postNum, String page, String reListPage, 
			HttpServletRequest request, HttpServletResponse response) {
		
		//새로고침 조회수 증가 막기 처리 - 쿠키이용
		//저장된 쿠키 불러오기
		Cookie cookies[] = request.getCookies();
		Map mapCookie = new HashMap<String, Object>();
		if(request.getCookies() != null) {
			for(int i=0; i<cookies.length; i++) {
				Cookie obj = cookies[i];
				mapCookie.put(obj.getName(), obj.getValue());
			}//for
		}//if
		
		//저장된 쿠키중에 read_count만 불러오기
		String cookie_read_count = (String) mapCookie.get("read_count");
		//저장될 새로운 쿠키값 생성
		String new_cookie_read_count = "|" + postNum;
		
		//저장된 쿠키에 새로운 쿠키값이 존재하는지 검사
		if(StringUtils.indexOfIgnoreCase(cookie_read_count, new_cookie_read_count) == -1) {
			//없을 경우 쿠키 생성
			Cookie cookie = new Cookie("read_count", cookie_read_count+new_cookie_read_count);
			response.addCookie(cookie);
			
			//조회수 1증가 처리
			boardMapper.updateHitNum(postNum);
			
		}
		
		
		//상세 페이지 내용 불러오기
		BoardDto boardDto = boardMapper.selectView(postNum);
		
		//이전글, 다음글 불러오기
		BoardDto preDto = boardMapper.selectPreDto(postNum);
		BoardDto nextDto = boardMapper.selectNextDto(postNum);
		
		int rePage = 1;    //첫 페이지 초기화
		int reLimit = 5;  //1개 페이지에 노출되는 게시글 수(5개씩)
		
		//매개변수 reListPage 데이터가 있으면 데이터 적용
		if (reListPage != null && reListPage != "") {
			rePage = Integer.parseInt(reListPage);
		}
		
		int reStartRow = (rePage-1)*reLimit+1;   //선택한 페이지의 첫번째 줄 => 1, 6, 11...
		int reEndRow = reStartRow+reLimit-1;   //선택한 페이지의 마지막 줄 => 5, 10, 15 ...
		
		//댓글 리스트 불러오기
		List<ReplyDto> list = boardMapper.selectReplyAll(postNum, reStartRow, reEndRow);
		
		//댓글 페이지 넘버링
		map = pageNumbering.rePageNum(postNum, rePage, reLimit);
		
		//리스트가 공백인 경우(즉, 댓글이 없는 경우) - 비어 있으면 true
		boolean result = list.isEmpty(); 
		
		//첨부파일 경로 설정
		String filePath = fileUrl+boardDto.getFileName();
		
		map.put("boardDto", boardDto);
		map.put("preDto", preDto);
		map.put("nextDto", nextDto);
		map.put("postNum", postNum);
		map.put("page", page);
		map.put("list", list);
		map.put("result", result);
		map.put("filePath", filePath);
		return map;
	}



	//수정하기 - View 페이지
	@Override
	public Map<String, Object> boardModifyView(String postNum, String page) {
		
		BoardDto boardDto = boardMapper.selectModifyView(postNum);
		
		//첨부파일 경로 설정
		String filePath = fileUrl+boardDto.getFileName();
				
		map.put("boardDto", boardDto);
		map.put("page", page);
		map.put("filePath", filePath);
		
		return map;
	}



	//수정하기 - DB 저장하기
	@Override
	public void modifyChk(BoardDto boardDto, MultipartFile file) {
		
		//첨부파일 처리
		String fileName = file.getOriginalFilename();  //원본파일 이름
		String filenameExtension = FilenameUtils.getExtension(fileName).toLowerCase();  //확장자명 가져오기
		long size = file.getSize()/1024;  //파일 사이즈(단위 kb)
		String fileSize = Long.toString(size);
		
		if(filenameExtension != "") {
//			String fileUrl = "C:/workspace/ys_board_assignment/src/main/resources/static/upload/";  //파일저장위치(마지막에 반드시 슬래시(/))
//			String fileUrl = "D:/workspace/externalUpload/";
			String uploadFileName = RandomStringUtils.randomAlphanumeric(32)+"."+filenameExtension;  //신규 파일 이름 - 32자리(중복방지)
			File f = new File(fileUrl+uploadFileName);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//위에서 처리한 파일이름까지 boardDto에 담아서 DB로 보낸다.
			boardDto.setFileName(uploadFileName);   //파일명 중복 방지
			boardDto.setOriginFileName(fileName);   //원본 파일명
			boardDto.setFileSize(fileSize);  		//파일 사이즈
		}else {
			//첨부파일이 없는 경우
			boardDto.setFileName(boardDto.getFileName());
			boardDto.setOriginFileName(boardDto.getOriginFileName());
			boardDto.setFileSize(boardDto.getFileSize());
		}
		
		//DB 전송
		boardMapper.updateModify(boardDto);
	}


	//삭제하기
	@Override
	public void deleteChk(String postNum) {
		
		boardMapper.deleteChk(postNum);
	}



	//답변하기 - View 페이지
	@Override
	public BoardDto boardReplyView(String postNum) {
		
		BoardDto boardDto = boardMapper.selectReplyView(postNum);
		return boardDto;
	}


	//답변하기 - DB 저장하기
	@Override
	public void replyChk(BoardDto boardDto, MultipartFile file) {
		
		//첨부파일 처리
		String fileName = file.getOriginalFilename();  //원본파일 이름
		String filenameExtension = FilenameUtils.getExtension(fileName).toLowerCase();  //확장자명 가져오기
		long size = file.getSize()/1024;  //파일 사이즈(단위 kb)
		String fileSize = Long.toString(size);
		
		if(filenameExtension != "") {
//			String fileUrl = "C:/workspace/ys_board_assignment/src/main/resources/static/upload/";  //파일저장위치(마지막에 반드시 슬래시(/))
//			String fileUrl = "D:/workspace/externalUpload/";
			String uploadFileName = RandomStringUtils.randomAlphanumeric(32)+"."+filenameExtension;  //신규 파일 이름 - 32자리(중복방지)
			File f = new File(fileUrl+uploadFileName);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//위에서 처리한 파일이름까지 boardDto에 담아서 DB로 보낸다.
			boardDto.setFileName(uploadFileName);   //파일명 중복 방지
			boardDto.setOriginFileName(fileName);   //원본 파일명
			boardDto.setFileSize(fileSize);  		//파일 사이즈
		}else {
			boardDto.setFileName("");  //첨부파일이 없는 경우
			boardDto.setOriginFileName("");
			boardDto.setFileSize("");
		}
		
		
		//DB 전송
		boardMapper.insertReply(boardDto); //DB에는 1로 저장된 상태
		
		
		//댓글 처리이므로
		//지금 저장되는 댓글 밑에 글들은 stepNum+1 처리한다.
		boardMapper.updateReplyPlus(boardDto);
		
	}



	//댓글 쓰기 - DB 저장하기
	@Override
	public void replyWrite(ReplyDto replyDto) {
		
		boardMapper.insertReplyWrite(replyDto);
	}



	//댓글 수정 - DB 저장하기
	@Override
	public void replyModify(ReplyDto replyDto) {
		
		boardMapper.updateReplyModify(replyDto);
	}


	//댓글 삭제
	@Override
	public void replyDelete(String reNum, String postNum) {
		
		boardMapper.deleteReply(reNum, postNum);
	}
	
	
	
	//엑셀 다운로드 - 리스트 출력
	@Override
	public List<BoardDto> listExcelDown(String category, String search) {
		
		List<BoardDto> list = boardMapper.selectExcelDown(category, search);
		return list;
	}
	
	
	
	//엑셀 업로드
	//참고 블로그 : https://shinsunyoung.tistory.com/71
	@Override
	public void listExcelUp(MultipartFile file) throws IOException {
		
		String extension = FilenameUtils.getExtension(file.getOriginalFilename()); //엑셀파일 확장자 확인
		
		//확장자에 따라 XSSF, HSSF(세부설명 블로그 : https://blog.daum.net/asumade/117)
		Workbook workbook = null;
		if(extension.equals("xlsx")) {
			workbook = new XSSFWorkbook(file.getInputStream());
		}else if(extension.equals("xls")) {
			workbook = new HSSFWorkbook(file.getInputStream());
		}
		
		
		Sheet worksheet = workbook.getSheetAt(0);
		
		//for문을 이용하여 엑셀파일 읽기(헤더Row 부분은 제외! 즉, i=1부터)
		for(int i=1; i<worksheet.getPhysicalNumberOfRows(); i++) {
			Row row = worksheet.getRow(i);
			
			BoardDto excelData = new BoardDto();
			
			//row.getCell(0)은 글 번호 Cell 제외
			//글번호는 PK이므로 DB에 저장할 때 시퀀스를 이용하여 저장한다.
			excelData.setTitle(row.getCell(1).getStringCellValue());  //제목
			excelData.setUser_id(row.getCell(2).getStringCellValue());  //작성자
			excelData.setBoardDate(row.getCell(3).getStringCellValue()); //작성일
			excelData.setHitNum(row.getCell(4).getStringCellValue()); //조회수
			
			//Row 1개씩 엑셀파일 읽은 후 DB에 차례대로 저장한다.
			boardMapper.insertExcelUp(excelData);
			
		}//for
		
		
	}
	
	
	//첨부파일 다운로드
	//참고 블로그 : https://androphil.tistory.com/330?category=467996
	@Override
	public void fileDown(String postNum, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		if(postNum != null) {
			BoardDto boardDto = boardMapper.fileDownInfo(postNum);
			String originFileName = boardDto.getOriginFileName();  //원본파일명
			String fileName = boardDto.getFileName(); //파일명 중복방지를 위해 가공된 파일명
			
			response.setContentType("application/octet-stream");
			originFileName = new String(originFileName.getBytes("UTF-8"), "iso-8859-1");
			response.setHeader("Content-Disposition", "attachment; filename=\""+originFileName+"\"");
			
			OutputStream os = response.getOutputStream();
			
//			String fileUrl = "C:/workspace/ys_board_assignment/src/main/resources/static/upload/";
//			String fileUrl = request.getRequestURL().toString().replace(request.getRequestURI(), "")+"/upload/";
			FileInputStream fis = new FileInputStream(fileUrl + File.separator + fileName);
			
			int n = 0;
			byte [] b = new byte[512];
			while((n = fis.read(b)) != -1) {
				os.write(b, 0, n);
			}
			fis.close();
			os.close();
		}
		
		
		
	}//fileDown

	
	
}//class
