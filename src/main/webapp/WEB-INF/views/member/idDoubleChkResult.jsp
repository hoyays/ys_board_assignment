<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>id Double Check Result</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<c:choose>
			<c:when test="${chk_num eq 0}">
				<script type="text/javascript">
					alert("사용가능한 아이디입니다.");
					location.href="./idDoubleChk?idChkResult=yes&user_id=${user_id}";
				</script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					alert("이미 사용중인 아이디입니다.");
					location.href="./idDoubleChk?idChkResult=no";
				</script>
			</c:otherwise>
		</c:choose>
	</head>
	<body>
	
	</body>
</html>