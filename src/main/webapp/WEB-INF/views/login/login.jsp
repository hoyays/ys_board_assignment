<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
  		<link rel="stylesheet" href="css/login/login.css">
  		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<script type="text/javascript">
  		
	  		$(document).ready(function(){
	  			
	  			$("#login_btn").on("click", function(){
	  				/*로그인 - ID/PW 유효성 검사*/
	  			if(!$("#user_id").val()){
	  				alert("아이디를 입력해 주세요!");
	  				$("#user_id").focus();
	  				return false;
	  			}
	  			if(!$("#user_pw").val()){
	  				alert("비밀번호를 입력해 주세요!");
	  				$("#user_pw").focus();
	  				return false;
	  			}
	  			
	  			document.form_login.submit();
	  			})
	  			
	  		})//jQuery
	  			
	  		
	  		
	  		
	  		function doLogin(){
	  			if(!$("#user_id").val()){
	  				alert("아이디를 입력해 주세요!");
	  				$("#user_id").focus();
	  				return false;
	  			}
	  			if(!$("#user_pw").val()){
	  				alert("비밀번호를 입력해 주세요!");
	  				$("#user_pw").focus();
	  				return false;
	  			}
	  			document.form_login.submit();
	  			
	  		}//doLogin()


	  		
	  		//엔터 클릭시 - 로그인 실행
			document.addEventListener("keypress", function(e){
				if(e.keyCode == 13){
					doLogin();
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
				<h1>로그인</h1>
			</div>
			<div id="contents_area">
				<form action="loginCheck" name="form_login" method="post" id="login_form">
					<input type="text" name="user_id" id="user_id" placeholder="아이디"><br>
					<input type="password" name="user_pw" id="user_pw" placeholder="비밀번호"><br>
					<input type="button" value="로그인" id="login_btn">
				</form>
			</div>
			<div id="join_info">
				<p>아직 회원이 아니신가요?&nbsp&nbsp<a href="/join">회원가입</a> 하러가기</p>
			</div>
		</div>
		<!-- footer 추가 -->
		<%-- <div>
			<%@ include file="../footer.jsp" %>
		</div> --%>
	</body>
</html>