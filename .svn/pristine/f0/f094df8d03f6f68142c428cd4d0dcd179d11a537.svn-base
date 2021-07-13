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
			<li><a href="/chart">Chart 페이지</a></li>
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
