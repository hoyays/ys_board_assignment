package com.example.demo.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.MemberDto;
import com.example.demo.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	
	
	//==========> 회원가입 <========== 
	
	//회원가입 View
	@RequestMapping("/join")
	public String join() {
		return "member/join";
	}
	
	
	//아이디 중복검사 - 팝업창
	@RequestMapping("/idDoubleChk")
	public String idDoubleChk(@RequestParam @Nullable String idChkResult, @RequestParam @Nullable String user_id, Model model) {
		
		model.addAttribute("idChkResult", idChkResult);
		model.addAttribute("user_id", user_id);
		return "/member/idDoubleChk";
	}
	
	
	//아이디 중복 - DB 확인하기
	@RequestMapping("/ConfirmIdDoubleChk")
	public String ConfirmIdDoubleChk(@RequestParam String user_id, Model model) {
		
		int chk_num = memberService.idDoubleChk(user_id);
		model.addAttribute("chk_num", chk_num);
		model.addAttribute("user_id", user_id);
		return "/member/idDoubleChkResult";
	}
	
	
	//회원가입 처리 - DB 저장하기
	@RequestMapping("/joinCheck")
	public String joinCheck(MemberDto memberDto, Model model) {
		
		int check = memberService.joinCheck(memberDto);
		model.addAttribute("check", check);
		
		return "/member/joinComplete";
	}
	
	
	//회원가입 결과 처리
	@RequestMapping("/joinComplete")
	public String joinComplete() {
		return "/member/joinComplete";
	}
	
	
	
	
	
	//==========> 회원정보 수정 <==========
	
	//회원정보 수정 - pw 확인 페이지
	@RequestMapping("/modifyPwCheck")
	public String modifyPwCheck() {
		
		return "/member/modifyPwCheck";
	}
	
	//회원정보 수정 - 비밀번호 확인
	@RequestMapping("/pwCheck")
	public String pwCheck(@RequestParam String user_id, @RequestParam String user_pw, Model model) {
		
		Map<String, Object> map = memberService.modify_pwCheck(user_id, user_pw);
		model.addAttribute("map", map);
		
		return "/member/modify";
	}
	
	//회원정보 수정 - view 페이지
	@RequestMapping("/member_join/member_info_modify")
	public String member_info_modify() {
		return "/member_join/member_info_modify";
	}
	
	//회원정보 수정 - DB 업데이트
	@RequestMapping("/modifyCheck")
	public String modifyCheck(MemberDto memberDto, Model model) {
		
		int chk = memberService.modify_check(memberDto);
		
		model.addAttribute("chk", chk);
		return "member/modifyResult";
	}
	
	
}//class
