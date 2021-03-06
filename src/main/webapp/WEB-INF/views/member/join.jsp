<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
  		<link rel="stylesheet" href="../css/member/join.css">
  		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<script type="text/javascript">
	  		//==========> 아이디 중복검사 <==========
	  		function idDoubleChk(){
	  			
	  			// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupX = (window.screen.width / 2) - (600 / 2);
	  			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupY= (window.screen.height /2) - (400 / 2);
	  			
	  			window.open("/idDoubleChk", "_blank", "status=no, width=600, height=400, left="+popupX+", top="+popupY+", screenX="+popupX+", screenY="+popupY);
	
	  			
	  		}//idDoubleChk()
	
	
	
	  		//==========> 회원가입 유효성 검사 <==========
	  		function join_check(){
	  			
	  			//유효성 검사 시작
	  			//아이디 확인
	  			var idPtn = /^[a-zA-Z0-9]{3,7}$/;
	  			if(idPtn.test($("#user_id").val()) != true){
	  				alert("아이디는 3~7자리의 영어+숫자 조합으로 가능합니다. ");
	  				$("#user_id").focus();
	  				$("#user_id").val("");
	  				return false;
	  			}
	  			
	  			//아이디 중복 검사
	  			if($("#idChkResult").val() == 'no' || $("#idChkResult").val() == 'default'){
	  				alert("아이디 중복검사를 진행해 주시기 바랍니다.");
	  				$("#user_id").focus();
	  				$("#user_id").val("");
	  				return false;
	  			}
	  			
	  			//비밀번호 확인
	  			var pwPtn = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~`!@#$%^&*()_\-+={}\[\]\\\|:;"\'<>,.?\/]).{5,10}$/;
	  			if(pwPtn.test($("#user_pw").val()) != true){
	  				alert("비밀번호는 5~10자리의 영어+숫자+특수문자 조합으로 가능합니다.");
	  				$("#user_pw").focus();
	  				$("#user_pw").val("");
	  				$("#user_pw1").val("");
	  				return false;
	  			}
	  			
	  			//비밀번호 확인 - 공백체크
	  			if(!$("#user_pw1").val()){
	  				alert("비밀번호 확인을 입력해 주시기 바랍니다.");
	  				$("#user_pw1").focus();
	  				return false;
	  			}
	  			
	  			//비밀번호 일치 확인
	  			if($("#user_pw").val() != $("#user_pw1").val()){
	  				alert("비밀번호가 일치하지 않습니다.");
	  				$("#user_pw").focus();
	  				$("#user_pw").val("");
	  				$("#user_pw1").val("");
	  				return false;
	  			}
	
	  			//이름 확인
	  			var namePtn = /^[가-힣]{2,}$/;
	  			if(namePtn.test($("#user_name").val()) != true){
	  				alert("이름은 한글만 입력가능합니다.");
	  				$("#user_name").focus();
	  				$("#user_name").val("");
	  				return false;
	  			}
	  			
	  			//연락처 확인하기
	  			var telPtn = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
	  			if(telPtn.test($("#user_mobile").val()) != true){
	  				alert("전화번호를 형식에 맞게 입력해 주시기 바랍니다.");
	  				$("#user_mobile").focus();
	  				$("#user_mobile").val("");
	  				return false;
	  			}
	  			
	  			
	  			//이메일 확인하기
	  			var emailPtn = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	  			if(emailPtn.test($("#user_email").val()) != true){
	  				alert("이메일 형식에 맞게 입력해 주시기 바랍니다.");
	  				$("#user_email").focus();
	  				$("#user_email").val("");
	  				return false;
	  			}
	  			
	
	  			
	  			document.joinForm.submit();
	  			
	  		}//js-join_check()
	
	
	
	
	
	  		$(document).ready(function(){
	  			
	  			//비밀번호 일치 - keyup
	  			$("#user_pw").keyup(function(){
	  				$("span[name=pwEqualChk]").text("");
	  			})
	  			
	  			$('#user_pw1').keyup(function() {
	  				if ($('#user_pw').val() != $('#user_pw1').val()) {
	  					$('span[name=pwEqualChk]').text('');
	  					$('span[name=pwEqualChk]').html("<span id='pwEqualChk' name='pwEqualChk'>* 비밀번호가 일치하지 않습니다.</span>");
	  				} else {
	  					$('span[name=pwEqualChk]').text('');
	  					$('span[name=pwEqualChk]').html("<span id='pwEqualChk' name='pwEqualChk'>* 비밀번호가 일치입니다.</span>");
	  				}
	  			}); //#user_pw1.keyup
	  			
	  		})//jQuery 
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
				<h1>회원가입</h1>
			</div>
			<div id="contents_area">
				<form action="/joinCheck" method="post" name="joinForm">
					<table>
						<colgroup>
							<col width="40%">
							<col width="60%">
						</colgroup>
						<tr>
							<th>
								아이디
								<font>*</font>
							</th>
							<td>
								<input type="text" name="user_id" id="user_id" placeholder="아이디는 영어+숫자 조합 3~7자리">
								<input type="button" name="idDouble" id="idDouble" value="아이디 중복" onclick="idDoubleChk()"><br>
								<input type="hidden" id="idChkResult" name="idChkResult" value="default"><!-- 아이디 중복 검사 실시여부 체크 -->
							</td>
						</tr>
						<tr>
							<th>
								비밀번호
								<font>*</font>
							</th>
							<td>
								<input type="password" name="user_pw" id="user_pw" placeholder="비밀번호는 영어+숫자+특수문자 조합 5~10자리">
							</td>
						</tr>
						<tr>
							<th>
								비밀번호 확인
								<font>*</font>
							</th>
							<td>
								<input type="password" name="user_pw1" id="user_pw1">
								<span id="pwEqualChk" name="pwEqualChk"></span>
							</td>
						</tr>
						<tr>
							<th>
								이름
								<font>*</font>
							</th>
							<td>
								<input type="text" name="user_name" id="user_name" placeholder="이름은 한글만 입력가능">
							</td>
						</tr>					
						<tr>
							<th>
								연락처
								<font>*</font>
							</th>
							<td>
								<input type="text" name="user_mobile" id="user_mobile" placeholder="예) 000-0000-0000">
							</td>
						</tr>
						<tr>
							<th>
								이메일
								<font>*</font>
							</th>
							<td>
								<input type="text" name="user_email" id="user_email">
							</td>
						</tr>
					</table>
					<div id="btn_area">
						<a href="../main"><input type="button" value="취소" class="cancel_btn"></a>&nbsp;
						<input type="button" value="확인" class="confirm_btn" onclick="join_check()">
					</div>
				</form>
			</div>
		</div>
		<!-- footer 추가 -->
		<%-- <div>
			<%@ include file="../footer.jsp" %>
		</div> --%>
	</body>
</html>