package com.example.demo.service;

import java.util.List;
import java.util.Map;

import com.example.demo.dto.MemberDto;

public interface MemberService {

	int joinCheck(MemberDto memberDto);   //회원가입
	int idDoubleChk(String user_id);   //아이디 중복확인
	Map<String, Object> modify_pwCheck(String user_id, String user_pw);   //회원정보 수정 - 비밀번호 확인
	int modify_check(MemberDto memberDto);   //회원정보 수정 - DB 업데이트
	

	

}//interface
