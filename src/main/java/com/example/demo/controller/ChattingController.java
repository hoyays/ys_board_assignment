package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ChattingController{
	

	@RequestMapping("/chatting")
	public String chatting() {
		return "/chatting/chatting";
	}
	
	
	
	
	
}//class
