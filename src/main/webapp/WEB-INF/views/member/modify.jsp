<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보수정</title>
  		<link rel="stylesheet" href="../css/member/join.css">
  		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<script type="text/javascript">
	  		$(document).ready(function(){
	  			
	  			$("#modify_check").on("click", function(){
	  				if(!$("#user_pw").val() || !$("#user_pw1").val()){
	  					alert("비밀번호를 입력해 주시기 바랍니다.");
	  					$("#user_pw").focus();
	  					$("#user_pw").val("");
	  					$("#user_pw1").val("");
	  					return false;
	  				}
	  				
	  				if($("#user_pw").val() != $("#user_pw1").val()){
	  					alert("비밀번호가 일치하지 않습니다.");
	  					$("#user_pw").focus();
	  					$("#user_pw").val("");
	  					$("#user_pw1").val("");
	  					return false;
	  				}
	  				
	  				var pwPtn = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~`!@#$%^&*()_\-+={}\[\]\\\|:;"\'<>,.?\/]).{5,10}$/;
	  				if(pwPtn.test($("#user_pw").val()) != true){
	  					alert("비밀번호는 5~10자리의 영어+숫자+특수문자 조합으로 가능합니다.");
	  					$("#user_pw").focus();
	  					$("#user_pw").val("");
	  					$("#user_pw1").val("");
	  					return false;
	  				}
	  				
	  				document.modifyForm.submit();
	  			})
	  			
	  		})//jQuery
	  		
	  		
	  		function doModifyChk(){
	  			
	  			if(!$("#user_pw").val() || !$("#user_pw1").val()){
  					alert("비밀번호를 입력해 주시기 바랍니다.");
  					$("#user_pw").focus();
  					$("#user_pw").val("");
  					$("#user_pw1").val("");
  					return false;
  				}
  				
  				if($("#user_pw").val() != $("#user_pw1").val()){
  					alert("비밀번호가 일치하지 않습니다.");
  					$("#user_pw").focus();
  					$("#user_pw").val("");
  					$("#user_pw1").val("");
  					return false;
  				}
  				
  				var pwPtn = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~`!@#$%^&*()_\-+={}\[\]\\\|:;"\'<>,.?\/]).{5,10}$/;
  				if(pwPtn.test($("#user_pw").val()) != true){
  					alert("비밀번호는 5~10자리의 영어+숫자+특수문자 조합으로 가능합니다.");
  					$("#user_pw").focus();
  					$("#user_pw").val("");
  					$("#user_pw1").val("");
  					return false;
  				}
  				
  				document.modifyForm.submit();
	  			
	  		}//doModifyChk()
	  		
	  		
	  		
	  		//엔터 클릭시 - 회원정보수정
	  		document.addEventListener("keypress", function(e){
				if(e.keyCode == 13){
					doModifyChk();
				}//if
			});
	  		
	  		
  		</script>
	</head>
	<c:choose>
		<c:when test="${map.chk_num eq 1}">
			<body>
				<!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp"%>
				</div>
				
				<div id="board_outline">
					<div id="title_area">
						<h1>회원정보수정</h1>
					</div>
					<div id="contents_area">
						<form action="/modifyCheck" method="post" name="modifyForm">
							<table>
								<colgroup>
									<col width="40%">
									<col width="60%">
								</colgroup>
								<tr>
									<th>아이디 <font>*</font>
									</th>
									<td>
										<h3>${map.memberDto.user_id}</h3>
										<input type="hidden" name="user_id" id="user_id" value="${map.memberDto.user_id}">
									</td>
								</tr>
								<tr>
									<th>비밀번호 <font>*</font>
									</th>
									<td><input type="password" name="user_pw" id="user_pw" placeholder="비밀번호는 영어+숫자+특수문자 조합 5~10자리"></td>
								</tr>
								<tr>
									<th>비밀번호 확인 <font>*</font>
									</th>
									<td><input type="password" name="user_pw1" id="user_pw1">
									</td>
								</tr>
								<tr>
									<th>이름 <font>*</font>
									</th>
									<td>
										<h3>${map.memberDto.user_name}</h3>
										<input type="hidden" name="user_name" id="user_name" value="${map.memberDto.user_name}">
									</td>
								</tr>
								<tr>
									<th>연락처 <font>*</font>
									</th>
									<td><input type="text" name="user_mobile" id="user_mobile" value="${map.memberDto.user_mobile}"></td>
								</tr>
								<tr>
									<th>이메일 <font>*</font>
									</th>
									<td><input type="text" name="user_email" id="user_email" value="${map.memberDto.user_email}">
									</td>
								</tr>
							</table>
							<div id="btn_area">
								<a href="../main"><input type="button" value="취소" class="cancel_btn"></a>&nbsp;
								<input type="button" value="수정" class="confirm_btn"	id="modify_check">
							</div>
						</form>
					</div>
				</div>
			</body>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				alert("비밀번호가 일치하지 않습니다.");
				location.href="./modifyPwCheck";
			</script>
		</c:otherwise>
	</c:choose>
	
</html>