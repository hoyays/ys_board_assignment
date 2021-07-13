<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	session.invalidate();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그아웃</title>
	</head>
	<body>
		<c:choose>
			<c:when test="${session_flag == null || session_flag eq 'fail'}">
				<script type="text/javascript">
					alert("정상적으로 로그아웃 되었습니다.");
					location.href="../main";
				</script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					alert('로그아웃이 정상적으로 되지 않았습니다.');
					location.href="../main";
				</script>
			</c:otherwise>
		</c:choose>
	</body>
</html>