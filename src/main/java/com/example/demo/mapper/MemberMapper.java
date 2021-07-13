package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.MemberDto;

@Mapper
public interface MemberMapper {

	int insertJoin(MemberDto memberDto);  //회원가입
	int selectIdDoubleChk(String user_id);  //아이디 중복 - DB 확인하기
	MemberDto selectPwCheck(String user_id, String user_pw);   //회원정보 수정 - 비밀번호 확인하기
	int updateModify(MemberDto memberDto);   //회원정보 수정 - DB 업데이트
	
	

}//class


