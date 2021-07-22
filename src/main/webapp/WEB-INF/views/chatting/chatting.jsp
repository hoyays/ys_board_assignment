<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>일반게시판</title>
  		<link rel="stylesheet" href="../css/chatting/chatting.css">
  		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		<!-- <script type="text/javascript">
			$(document).ready(function(){
				
				var webSocket;
		        var nickName;
				
		        $("#nickNameBtn").click(function(){

		        	nickName = $("#nickName").val();
		        	if(!nickName){
		        		alert("닉네임을 입력해 주세요!");
		        		return false;
		        	}
		        	$("#nickName_area").hide();
		        	connect();
		        });
				
		        
		        
		        $("#sendBtn").click(function(){
		        	send();
		        });
		        
		        
		        
		        
		        function connect(){
		        	
		        	webSocket = new WebSocket("ws://localhost:8000/chatting")
		        	webSocket.onopen = onOpen;
		        	webSocket.onclose = onClose;
		        	webSocket.onmessage = onMessage;
		        }//connect()
		        
		        
		        
		        function disconnect(){
		        	
		        	webSocket.send(nickName+"님이 퇴장하셨습니다.");
		        	webSocket.close();
		        }//disconnect()
		        
		        
		        
		        function send(){
		        	
		        	msg = $("#message").val();
		        	webSocket.send(nickName+" : "+msg);
		        	$("#message").val("");
		        }//send()
		        
		        
		        function onOpen(){
		        	
		        	webSocket.send(nickName+"님이 입장하셨습니다.");
		        }//onOpen()
		        
		        
		        function onMessage(e){
		        	data = e.date;
		        	chat_history = $("#chat_history");
		        	chat_history.innerHTML = chat_history.innerHTML + "<br>" + data;
		        }//onMessage()
		        
		        
		        
		        function onClose(){
		        	
		        }//onClose()
		        
		        
				
			});//jQuery
		</script> -->

	</head>
	<body>
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
					<div id="nickName_area">
						<label><strong>◆ 닉네임 : </strong></label>
						<input type="text" id="nickName" placeholder="닉네임을 입력해 주세요.">
						<input type="button" id="nickNameBtn" value="확인">
					</div>
					<div id="chatRoom">
						<div id="chat_history">

						<!-- 채팅방 대화내용이 표시된다. -->

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