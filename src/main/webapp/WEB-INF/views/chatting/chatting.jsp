<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>채팅 페이지</title>
  		<link rel="stylesheet" href="../css/chatting/chatting.css">
  		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		
			
			//참고 유투브 : https://www.youtube.com/watch?v=gQyRxPjssWg
			//참고 블로그 : https://myhappyman.tistory.com/101?category=873296 
			//변수선언
			var socket = null;
			var user = "${session_user_id}";   //http 세션 값, 즉 로그인 한 아이디
			
			//최초 접속 시
			$(document).ready(function(){
				
				//WebSocket 1개를 연다.
				socket = new WebSocket("ws://localhost:8000/chat");
				
				//WebSocket 인터페이스의 연결상태가 readyState ==> open으로 바뀌었을 때 호출되는 이벤트 리스너
				socket.onopen = function(){
					console.log('Info : connection opened.');
				}//onopen
				connect();
			});//jQuery
			
			
			
			function doSend(){
				
				if(!$("#message").val()){
					alert("메세지를 입력해 주세요!");
					$("#message").focus();
					return false;
				}
				send();   //메세지 전달용, To WebSocket 
				connect(); //메세지 수신용, From WebSocket
				$("#message").focus();
				
			}//doSend()
			
			
			function connect(){
				
				
				socket.onmessage = function(event){  //data에는 서버로부터 전달받은 메세지가 담겨있다.
					var msg = event.data;
					if(msg != null && msg.trim() != ""){
						
						var d = JSON.parse(msg);  //String => Json으로 변환
						if(d.type == "getId"){
							
							var si = d.sessionId != null ? d.sessionId : "";
							if(si != ""){
								$("#sessionId").val(si);
							}//if
							
						}else if(d.type == "message"){
							
							if(d.sessionId == $("#sessionId").val()){
								$("#chat_history").append("<div id='bubble_send'>"+d.msg+"</div>");
							}else {
								$("#chat_history").append("<div id='bubble_receive'>"+d.msg+"</div>");
							}
						}//if
						
					}else {
						console.warn("unknown type!");
					}//if
				}//onmessage
				
			}//connect()
			
			
			//WebSocket 서버로 메세지를 보낼 때 - Json 형태의 데이터로 가공하여 전송한다.
			function send(){
				
				var option = {
					type:"message",
					sessionId:$("#sessionId").val(),
					userName:user,
					msg:$("#message").val()
				}
				socket.send(JSON.stringify(option));  //Json ==> String으로 변환
				$("#message").val("");
				
			}//send()
			
			
			//엔터 클릭시 - 메세지 '전송' 실행
			document.addEventListener("keypress", function(e){
				if(e.keyCode == 13){
					doSend();
				}//if
			});
			
			
		
		</script>

	</head>
	<body>
	<input type="hidden" id="sessionId" name="sessionId">
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				<!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp"%>
				</div>
				<div id="board_outline">
					<div id="title_area">
						<h1>채팅 페이지</h1>
					</div>
					<div id="chatRoom">
						<div id="chat_history">
						
							<!-- 대화 말풍선 들어가는 자리 -->
							
						</div>
						<div id="message_area">
							<input type="text" id="message" placeholder="내용을 입력하세요.">
							<input type="button" id="sendBtn" value="전송">
						</div>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					alert("로그인 후 이용가능합니다.");
					location.href="/login";
				</script>
			</c:otherwise>
		</c:choose>
		
	</body>
</html>