package com.example.demo.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.example.demo.dto.MemberDto;

public class ChatWebSocketHandler extends TextWebSocketHandler{
	
	/*
	 * ===> WebSocket 핸들러 <===
	 * 웹소켓 연결, 메세지전송, 연결 끊기를 관리한다.
	 */
	
	

	//WebSocket 세션을 담을 리스트
	Map<String, WebSocketSession> userSessions = new HashMap<>();  //WebSocket에 접속한 모든 session을 map에 담는다.
	
	
	//커넥션이 성공했을 때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("afterConnectionEstablished : "+session);
		
		//WebSocket에 접속한 모든 세션은 고유의 Id를 갖는다. - http세션과는 다른다.
		//WebSocket에 담겨있는 모든 세션을 map에 담는다.
		String senderId = session.getId();
		userSessions.put(senderId, session);
	}
	
	
	
	//Socket에 메세지를 보냈을 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage : "+session+", msg : "+message);
		
		
		String senderId = session.getId();
		
		//WebSocket의 message 형태는 String이 아닌 TextMessage!!!!
		//따라서 메세지의 내용은 TextMessage의 메소드 getPayload()를 이용한다.
		String msg = message.getPayload();
		
		
		//WebSocket에 접속한 모든 User에게 메세지를 보낸다. - broadcasting
		for(String key : userSessions.keySet()) {
			WebSocketSession wsSession = userSessions.get(key);
			wsSession.sendMessage(new TextMessage(msg));
		}//for
		
	}
	
	//커넥션이 끊겼을 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed : "+session+", status : "+status);
		
		//WebSocket에 담겨있는 세션정보를 삭제한다.
		userSessions.remove(session.getId());
	}
	
	
	
}//class
