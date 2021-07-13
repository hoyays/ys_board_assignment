package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.MemberDto;
import com.example.demo.mapper.MemberMapper;

@Service
public class MemberServiceImplement implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;

	
	//회원가입 처리하기
	@Override
	public int joinCheck(MemberDto memberDto) {

		int chk = memberMapper.insertJoin(memberDto);
		return chk;
	}
	
	
	//아이디 중복 - DB 확인하기
	@Override
	public int idDoubleChk(String user_id) {
		
		int chk_num = memberMapper.selectIdDoubleChk(user_id);
		return chk_num;
	}

	
	//회원정보 수정 - 비밀번호 확인
	@Override
	public Map<String, Object> modify_pwCheck(String user_id, String user_pw) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		MemberDto memberDto = memberMapper.selectPwCheck(user_id, user_pw);
		
		int chk_num = -1;
		if(memberDto != null) {
			chk_num = 1;
		}
		
		map.put("chk_num", chk_num);
		map.put("memberDto", memberDto);
		
		return map;
	}


	//회원정보 수정 - DB 업데이트
	@Override
	public int modify_check(MemberDto memberDto) {
		
		int chk = memberMapper.updateModify(memberDto);
		return chk;
	}


	

	

}//class
