package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.ChartDto;

@Mapper
public interface ChartMapper {

	List<ChartDto> selectDataPerDay(String weekago);  //일별 데이터

}//interface
