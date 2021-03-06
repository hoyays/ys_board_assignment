package com.example.demo.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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
	
	
	//커넥션이 성공했을 때 - 소켓 연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("afterConnectionEstablished : "+session);
		
		//WebSocket에 접속한 모든 세션은 고유의 Id를 갖는다. - http세션과는 다른다.
		//WebSocket에 담겨있는 모든 세션을 map에 담는다.
		String sessionId = session.getId();
		userSessions.put(sessionId, session);
		
		//JSONObject는 Json 형태의 데이터를 관리해 주는 메소드
		//json-simple 라이브러리를 추가한 후 사용가능
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", sessionId);
		
		//obj를 메소드를 이용하여 스트링 형태로 변환
		session.sendMessage(new TextMessage(obj.toJSONString()));  //WebSocket 서버에 연결된 client에게 메세지 보낸다.
	}
	
	
	
	//Socket에 메세지를 보냈을 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage : "+session+", msg : "+message);
		
		String sessionId = session.getId();
		
		//WebSocket의 message 형태는 String이 아닌 TextMessage!!!!
		//따라서 메세지의 내용은 TextMessage의 메소드 getPayload()를 이용한다.
		String msg = message.getPayload();
		
		
		//json을 파싱하는 함수를 호출한다.
		JSONObject obj = jsonToObjectParser(msg);
		
		//아래의 방법으로 메세지를 전송한 httpSession의 세션아이디를 추출할 수 있다.
//		String userName = (String) obj.get("userName");
//		System.out.println("httpSession id : "+userName);
		
		//WebSocket에 접속한 모든 User에게 메세지를 보낸다. - broadcasting
		for(String key : userSessions.keySet()) {
			WebSocketSession wsSession = userSessions.get(key);
			wsSession.sendMessage(new TextMessage(obj.toJSONString()));
			System.out.println("obj.toJsonString : "+obj.toJSONString());
		}//for
	}

	
	
	//커넥션이 끊겼을 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed : "+session+", status : "+status);
		
		//WebSocket에 담겨있는 세션정보를 삭제한다.
		userSessions.remove(session.getId());
	}
	
	
	
	//json 파일이 들어오면 파싱해 주는 함수
	private static JSONObject jsonToObjectParser(String jsonStr) {
		
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}//try-catch
		
		return obj;
	}
	
	
}//class
