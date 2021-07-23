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
		
		
		<script type="text/javascript">
		
			//변수선언
			var socket = null;   //WebSocket
			var user = "${hSession}";   //http 세션 값, 즉 로그인 한 아이디
			
			$(document).ready(function(){
				
				//채팅창 하단 메시지 '전송'버튼 클릭 시
				$("#sendBtn").on("click", function(evt){
					
					if(socket.readyState !== 1){
						return false;
					}
					
					//전송 메세지에 입력된 내용을 Socket으로 보낸다.
					var msg = user +" : "+$("#message").val();
					
					socket.send(msg);
				});
				
				//WebSocket 연결
				connect();
			});//jQuery
		
		
			function connect(){
				
				var ws = new WebSocket("ws://localhost:8000/chat");  //Socket 1개를 연다.
				
				socket = ws;
				
				//이벤트 리스너
				//커넥션이 연결됐을 때 작동한다.
				ws.onopen = function(){
					
					var str = user+"님이 입장하셨습니다.";
					socket.send(str);
					console.log('Info : connection opened.');
				};
				
				//Socket이 메세지를 수신했을 때
				//handler에서 sendMessage()메소드를 통해 Websocket이 전체 세션에게 뿌린 message가 event 변수에 담긴다.
				ws.onmessage = function(event){
					$("#chat_history").append("<p>"+event.data+"</p>");
					console.log("Received Message : "+event.data+'\n');
				};
				
				ws.onclose = function(event){
					
					
					var str = user+"님이 퇴장하셨습니다.";
					socket.send(str);
					console.log('Info : connection closed');
					socket.close();
					/* setTimeout(function(){
						connect();
					}, 1000); */
				};
				
				ws.onerror = function(error){
					console.log('Error :', error);
				};
			}//connect()
			
		
		</script>

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
					<div id="chatRoom">
						<div id="chat_history">
						<!-- 채팅방 대화내용이 표시된다. -->
						
							<!-- 대화 말풍선 -->
							<div id="bubble_send"></div>
							<div id="bubble_receive"></div>
						</div>
						<div id="message_area">
							<!-- <span id="conNickName"></span> -->
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