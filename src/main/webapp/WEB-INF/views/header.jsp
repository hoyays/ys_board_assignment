<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar time = Calendar.getInstance();
	String format_time = sdf.format(time.getTime());
%>
<link href="../css/header.css" rel="stylesheet">
<!-- 상단 메뉴 시작 -->
<div id="top">
	<div id="logo_img">
		<a href="/main"><img alt="ci_huation" src="../img/huation_CI_4.png"></a>
	</div>
	<div id="top_menu">
		<ul class="ul_style_menu">
			<li><a href="/board/list">일반 게시판</a></li>
			<li><a href="/ajax/list">AJAX 게시판</a></li>
			<li><a href="/chartMain">Chart 페이지</a></li>
			<li><a href="/chatting">채팅 페이지</a></li>
		</ul>
	</div>
	<div id="member_menu">
		<ul class="ul_member_menu">
			<c:choose>
				<c:when test="${session_flag eq 'fail' || session_flag eq null}">
					<li><a href="/login">로그인</a></li>
					<li><a href="/join">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<div id="connect_info_box">
						<li><strong>${session_user_name}(${session_user_id})</strong>님 접속중</li>
					</div>
					<li><a href="/logout">로그아웃</a></li>
					<li><a href="/modifyPwCheck">회원정보수정</a></li>	
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>
<!-- 상단메뉴 끝 -->

<%-- <div id="time_info">
	<h2>현재 시간 <%= format_time %></h2>
</div> --%>

<!-- <script>
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


</script> -->
