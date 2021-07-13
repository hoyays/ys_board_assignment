package com.example.demo.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.MemberDto;
import com.example.demo.mapper.LoginMapper;

@Service
public class LoginServiceImplement implements LoginService {
	
	@Autowired
	LoginMapper loginMapper;

	
	//로그인 체크
	@Override
	public Map<String, Object> login(String user_id, String user_pw) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		MemberDto memberDto = loginMapper.selectLogin(user_id, user_pw);
		
		int loginCheck = -1;
		String message = "ID/PW가 일치하지 않습니다.";
		
		if(memberDto != null) {
			loginCheck = 1;
			message = "ID/PW가 일치합니다.";
		}
		
		map.put("memberDto", memberDto);
		map.put("loginCheck", loginCheck);
		map.put("message", message);
		
		return map;
	}

	
	
	
}//class
