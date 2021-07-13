<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>아이디 중복체크</title>
		<link rel="stylesheet" href="../css/member/idDoubleChk.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<!-- <script type="text/javascript" src="../js/member/idDoubleChk.js"></script> -->
  		<script type="text/javascript">
	  		//확인버튼 클릭시
	  		function idDoubleChk(){
	  			
	  			//아이디 유효성 검사
	  			var idPtn = /^[a-zA-Z0-9]{3,7}$/;
	  			if(idPtn.test($("#user_id").val()) != true){
	  				alert("아이디는 3~7자리의 영어+숫자 조합으로 가능합니다. ");
	  				$("#user_id").focus();
	  				$("#user_id").val("");
	  				return false;
	  			}
	  			document.idDoubleChkForm.submit();
	  		}
	
	
	  		//아이디 사용 클릭시
	  		function finalBtn(){
	  			
	  			//자식창 => 부모창 값 전달하기
	  			$("#user_id", opener.document).val($("#user_id").val());
	  			$("#idChkResult", opener.document).val($("#idChkResult").val());
	  			self.close();
	  		}
  		</script>
	</head>
	<body>
		<div id="outline">
			<div id="title_area">
				<h1>아이디 중복확인</h1>
				<br>
				<hr>
			</div>
			<div id="contents_area">
				<form action="/ConfirmIdDoubleChk" method="post" name="idDoubleChkForm">
					<label><strong>아이디</strong></label>&nbsp;&nbsp;&nbsp;
					<input type="text" id="user_id" name="user_id" value="${user_id}" placeholder="아이디는 영어+숫자 조합 3~7자리"><br>
					<input type="hidden" id="idChkResult" name="idChkResult" value="${idChkResult}"><!-- 아이디 중복검사 결과 -->
					<c:choose>
						<c:when test="${idChkResult eq 'yes'}">
							<input type="button" value="아이디사용" onclick="finalBtn()" class="btn1">
						</c:when>
						<c:otherwise>
							<input type="button" value="중복검사" onclick="idDoubleChk()" class="btn2">
						</c:otherwise>
					</c:choose>
				</form>
			
			</div>
		
		</div>
	</body>
</html>