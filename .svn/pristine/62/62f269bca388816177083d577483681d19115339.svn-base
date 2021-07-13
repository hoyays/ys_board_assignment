package com.example.demo.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.MemberDto;
import com.example.demo.service.LoginService;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;

	//로그인 페이지
	@RequestMapping("/login")
	public String login() {
		return "/login/login";
	}
	
	
	//로그인 처리하기
	@RequestMapping("/loginCheck")
	public String login_check(@RequestParam String user_id, @RequestParam String user_pw, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Map<String, Object> map = loginService.login(user_id, user_pw);
		
		int loginCheck = (int) map.get("loginCheck");
		if(loginCheck == 1) {
			session.setAttribute("session_flag", "success");
			session.setAttribute("session_user_id", ((MemberDto)map.get("memberDto")).getUser_id());
			session.setAttribute("session_user_name", ((MemberDto)map.get("memberDto")).getUser_name());
		}else {
			session.setAttribute("session_flag", "fail");
		}
		
		return "/login/loginResult";
	}
	
	/* 로그아웃 처리하기 */
	@RequestMapping("/logout")
	public String logout() {
		return "/login/logout";
	}
	
	
	
	
}//class
