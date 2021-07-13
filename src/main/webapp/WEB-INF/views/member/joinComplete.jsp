<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>join Complete</title>
		<c:choose>
			<c:when test="${check eq 1}">
				<script type="text/javascript">
					alert("회원가입이 정상적으로 완료되었습니다.\n\n로그인 후 이용가능합니다.");
					location.href="/login";
				</script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					alert("회원가입에 실패하였습니다. \n\n 다시 시도해 주시기 바랍니다.");
					location.href="./join";
				</script>
			</c:otherwise>
		</c:choose>
	</head>
	<body>
	
	</body>
</html>