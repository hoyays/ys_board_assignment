package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ChattingController{
	

	@RequestMapping("/chatting")
	public String chatting(HttpServletRequest request, Model model) {
		
		HttpSession httpSession = request.getSession();
		String session_user_id = (String) httpSession.getAttribute("session_user_id");
		model.addAttribute("session_user_id", session_user_id);
		
		return "/chatting/chatting";
	}
	
	
	
	
	
}//class
