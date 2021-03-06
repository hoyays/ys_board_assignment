<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>정보수정 - 비밀번호 확인</title>
		<link rel="stylesheet" href="../css/member/modifyPwCheck.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<script type="text/javascript">
  		
	  		$(document).ready(function(){
	  			$("#pwChk_btn").on("click", function(){
	  				if(!$("#user_pw").val()){
	  					alert("비밀번호를 입력해 주시기 바랍니다.");
	  					$("#user_pw").focus();
	  					return false;
	  				}
	  				document.pw_check.submit();
	  			})
	  			
	  		})//jQuery
  		
  		
	  		
	  		
	  		function doModify(){
	  			
	  			if(!$("#user_pw").val()){
  					alert("비밀번호를 입력해 주시기 바랍니다.");
  					$("#user_pw").focus();
  					return false;
  				}
  				document.pw_check.submit();
	  		}//doModify()

	  		
	  		
	  		//엔터 클릭시 - 회원정보수정 실행
			document.addEventListener("keypress", function(e){
				if(e.keyCode == 13){
					doModify();
				}//if
			});
	  		
	  		
	  		
  		</script>
	</head>
	<body>
		<!-- header 추가 -->
		<div>
			<%@ include file="../header.jsp" %>
		</div>
		
		<!-- 상단 이미지 시작 -->
		<div id="top_img" class="test_img">
			<div id="header_title">
				<p>HUATION</p>
				<h3>신입사원 과제</h3>
			</div>
		</div>
		<!-- 상단 이미지 끝 -->
		
		<div id="board_outline">
			<div id="title_area">
				<h1>비밀번호 확인</h1>
				<p>개인정보 보호를 위해 비밀번호를 한번 더 입력해 주시기 바랍니다!</p>
			</div>
			<div id="contents_area">
				<form action="/pwCheck" name="pw_check" method="post" id="pwCheck_form">
					<h1>아이디 : ${session_user_id} </h1>
					<input type="hidden" name="user_id" id="user_id" value="${session_user_id}">
					<br>
					<input type="password" name="user_pw" id="user_pw" placeholder="비밀번호확인"><br>
					<input type="button" value="회원정보수정" id="pwChk_btn">
				</form>
			</div>
		</div>
	</body>
</html>