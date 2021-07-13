package com.example.demo.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.example.demo.dto.BoardDto;

public class BoardListExcelExporter {

	private XSSFWorkbook workbook;
	private XSSFSheet sheet;
	private List<BoardDto> list;
	

	//생성자
	public BoardListExcelExporter(List<BoardDto> list) {
		this.list = list;
		workbook = new XSSFWorkbook();
		sheet = workbook.createSheet("boardList");
	}

	
	//제목
	private void writeHeaderRow() {
		
		Row row = sheet.createRow(0);
		
		//Header - 스타일 지정
		CellStyle style = workbook.createCellStyle();
		
		//Header - font 스타일 지정
		XSSFFont font = workbook.createFont();
		font.setBold(true);
		font.setFontHeight(14);
		style.setFont(font);
		
		//Header - 테두리 스타일 지정
		style.setBorderBottom(BorderStyle.THICK);
		
		//Header - 가운데 정렬
		style.setAlignment(HorizontalAlignment.CENTER);
		
		
		//Header - each cell
		Cell cell = row.createCell(0);
		cell.setCellValue("No.");
		cell.setCellStyle(style);
		
		cell = row.createCell(1);
		cell.setCellValue("제목");
		cell.setCellStyle(style);
		
		cell = row.createCell(2);
		cell.setCellValue("작성자");
		cell.setCellStyle(style);
		
		cell = row.createCell(3);
		cell.setCellValue("작성일");
		cell.setCellStyle(style);
		
		cell = row.createCell(4);
		cell.setCellValue("조회수");
		cell.setCellStyle(style);
		
	}
	
	
	//내용
	private void writeDataRows() {
		
		int rowCount = 1;
		
		//내용 - 스타일 지정
		CellStyle style = workbook.createCellStyle();
		
		//내용 - font 스타일 지정
		XSSFFont font = workbook.createFont();
		font.setFontHeight(11);
		style.setFont(font);
		
		
		//내용 - 테두리 스타일 지정
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		
		
		//Data - each cell
		for(BoardDto boardDto : list) {
			Row row = sheet.createRow(rowCount++);
			
			Cell cell = row.createCell(0);
			cell.setCellValue(boardDto.getPostNum());
			sheet.autoSizeColumn(0);
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			cell.setCellValue(boardDto.getTitle());
			sheet.autoSizeColumn(1);
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			cell.setCellValue(boardDto.getUser_id());
			sheet.autoSizeColumn(2);
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			cell.setCellValue(boardDto.getBoardDate());
			sheet.autoSizeColumn(3);
			cell.setCellStyle(style);
			
			cell = row.createCell(4);
			cell.setCellValue(boardDto.getHitNum());
			sheet.autoSizeColumn(4);
			cell.setCellStyle(style);
			
		}
		
	}
	
	
	//엑셀 파일 생성
	public void export(HttpServletResponse response) throws IOException {
		
		writeHeaderRow();
		writeDataRows();
		
		ServletOutputStream outputStream = response.getOutputStream();
		workbook.write(outputStream);
		workbook.close();
		outputStream.close();
		
	}
	
	
	
	
	
	
	
}//class
