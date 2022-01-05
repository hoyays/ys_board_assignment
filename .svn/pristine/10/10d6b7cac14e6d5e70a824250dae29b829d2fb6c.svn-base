<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Chart Main</title>
		<link rel="stylesheet" href="../css/chart/chartMain.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	</head>
	<body>
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				<!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp"%>
				</div>
				<div id="contents_outline">
					<!-- 일반게시판 영역 -->
					<div id="generalBoard_area">
						<div class="title_area">
							<h1><font color="red">일반</font><br>게시판</h1>
						</div>
						<div class="category"><a href="/chart">게시물 등록건수</a></div>
						<div class="category"><a href="/chart2">댓글수ㆍ조회수</a></div>
					</div>
					
					<!-- ajax게시판 영역 -->
					<div id="ajaxBoard_area">
						<div class="title_area">
							<h1><font color="blue">AJAX</font><br>게시판</h1>
						</div>
						<div class="category"><a href="/chartAjax">게시물 등록건수</a></div>
						<div class="category"><a href="/chartAjax2">댓글수ㆍ조회수</a></div>
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