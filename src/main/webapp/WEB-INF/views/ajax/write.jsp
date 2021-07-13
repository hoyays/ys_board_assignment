<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
	<html>
		<head>
		<meta charset="UTF-8">
		<title>Ajax 게시판</title>
		<link rel="stylesheet" href="/css/ajax/write.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript" src="/js/ckeditor/ckeditor.js"></script>
		<script type="text/javascript">
		
			//글쓰기 페이지 최초 로딩
			$(document).ready(function(){
				writeView();
			});
			
			
			//url 파라미터 값을 읽어주는 정규식 함수
			function getParameterByName(name) {
			  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
			  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
			  results = regex.exec(location.search);
			  return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
			}
			
			
			//쓰기, 수정, 답변 페이지 로딩
			function writeView(){
				
				//정규식이용, url 파라미터 값 읽기
				var postNum_ajax = getParameterByName('postNum_ajax');
				var page = getParameterByName('page');
				var msg = getParameterByName('msg');
				
				//ajaxDto가 null이면 쓰기
				//msg가 modify이면 수정
				if(msg == 'modify'){
					
					//alert("수정버튼 클릭하여 들어옴");
					
					$.post(
						'/ajax/modifyView',
						{
							"postNum_ajax":postNum_ajax,
							"page":page
						},
						function(data){
							
							$("#title_area").html("<h1>수정하기</h1>");
							$("#title_ajax").val(data.ajaxDto.title_ajax);
							CKEDITOR.instances.contents_ajax.setData(data.ajaxDto.contents_ajax);
						},
						'json'
					);//ajax
					
					
				//msg가 reply이면 답변	
				}else if(msg == 'reply'){
					
					$("#title_area").html("<h1>답변하기</h1>");
					
					//답변하기의 경우 
					//원글의 postNum_ajax, groupNum_ajax, indentNum_ajax, stepNum_ajax 필요함
					var postNum_ajax = $(opener.document).find("input[id='postNum_ajax']").val();
					var groupNum_ajax = $(opener.document).find("input[id='groupNum_ajax']").val();
					var indentNum_ajax = $(opener.document).find("input[id='indentNum_ajax']").val();
					var stepNum_ajax = $(opener.document).find("input[id='stepNum_ajax']").val();
					$("#postNum_ajax").val(postNum_ajax);
					$("#groupNum_ajax").val(groupNum_ajax);
					$("#indentNum_ajax").val(indentNum_ajax);
					$("#stepNum_ajax").val(stepNum_ajax);
					$("#msg").val("reply");
					
				}//if
				
			}//writeView()
		
		
			
		
			//확인 버튼 클릭 시
			function doWrite(page){
				
				//제목 공백 확인
				if(!$("#title_ajax").val()){
					alert("제목을 입력해 주세요!");
					$("#title_ajax").focus();
					return false;
				}
				
				//내용 공백 확인
				if(CKEDITOR.instances.contents_ajax.getData() == '' || CKEDITOR.instances.contents_ajax.getData().length == 0){
					alert("내용을 입력해 주세요!");
					$("#contents_ajax").focus();
					return false;
				}
				
				//ajax 실행에 필요한 변수정리
				var contents_ajax = CKEDITOR.instances.contents_ajax.getData();
				
				
				//정규식이용, url 파라미터 값 읽기
				var postNum_ajax = getParameterByName('postNum_ajax');
				var page = getParameterByName('page');
				var msg = getParameterByName('msg');
				
				
				//쓰기 내용 저장
				if(msg == null || msg == ''){
					
					$.post(
						"/ajax/doWrite",
						{
							"user_id":$("#user_id").val(),
							"title_ajax":$("#title_ajax").val(),
							"contents_ajax":contents_ajax,
							"page":page
						},
						function(data){
							var msg = data.msg;
							alert(msg);
							
							$("#page").val(data.page);
							$(opener.document).find("#dataCnt").text(data.listCount);
							/* html = "";
							for(i=0; i<data.list.length; i++){
								html += "<tr><td><span class='table-notice'>"+data.list[i].postNum_ajax;
								html += "</span></td><td class='table-title'><a href='javascript:void(0)'";
								html += " onclick='showView("+data.list[i].postNum_ajax+", "+data.page+")' id='showView'>"+data.list[i].title_ajax;
								html += "</a></td><td>"+data.list[i].user_id+"</td>";
								html += "<td>"+data.list[i].date_ajax+"</td><td>"+data.list[i].hitNum_ajax+"</td></tr>";
								$(opener.document).find("tbody[id='tbody']").html(html);
							}//for */
							
							//list 데이터
							html = "";
							for(var i=0; i<data.list.length; i++){
								html += "<tr><td><span class='table-notice'>"+data.list[i].postNum_ajax;
								html += "</span></td><td class='table-title'>";
								
								if(data.list[i].indentNum_ajax != 0){
									for(var j=0; j<data.list[i].indentNum_ajax; j++){
										html += "└─&nbsp;Re:&nbsp;";
									}
								}
								
								html += "<a href='javascript:void(0)'";
								html += " onclick='showView("+data.list[i].postNum_ajax+", "+data.page+")' id='showView'>"+data.list[i].title_ajax;
								html += "</a></td><td>"+data.list[i].user_id+"</td>";
								html += "<td>"+data.list[i].date_ajax+"</td><td>"+data.list[i].hitNum_ajax+"</td></tr>";
								$(opener.document).find("tbody[id='tbody']").html(html);
							}//for
							
							self.close();
							
						},
						'json'
					);//ajax
					
					
				//수정 내용 저장
				}else if(msg == 'modify'){
					
					$.post(
						'/ajax/doModify',
						{
							"postNum_ajax":postNum_ajax,
							"title_ajax":$("#title_ajax").val(),
							"contents_ajax":contents_ajax,
							"page":page
						},
						function(data){
							var msg = data.msg;
							alert(msg);
							
							html = "";
							html += "<tr><th colspan='3'>제목</th></tr><tr>";
							html += "<td colspan='3'><strong>"+data.ajaxDto.title_ajax+"</strong></td></tr>";
							html += "<tr><td>"+data.ajaxDto.user_id+"</td><td>조회수</td>";
							html += "<td>"+data.ajaxDto.hitNum_ajax+"</td></tr><tr>";
							html += "<td colspan='3' class='article'>"+data.ajaxDto.contents_ajax+"</td></tr>";
							$(opener.document).find("tbody[id='tbody']").html(html);
							
							self.close();
							
						},
						'json'
					);//ajax
					
					
				//답변 내용 저장
				}else if(msg == 'reply'){
					
					$.post(
							'/ajax/doReply',
							{
								"user_id":$("#user_id").val(),
								"title_ajax":$("#title_ajax").val(),
								"contents_ajax":contents_ajax,
								"postNum_ajax":$("#postNum_ajax").val(),
								"groupNum_ajax":$("#groupNum_ajax").val(),
								"indentNum_ajax":$("#indentNum_ajax").val(),
								"stepNum_ajax":$("#stepNum_ajax").val(),
								"page":page
							},
							function(data){
								
								var msg = data.msg;
								alert(msg);
								
								html = "";
								html += "<tr><th colspan='3'>제목</th></tr><tr>";
								html += "<td colspan='3'><strong>"+data.ajaxDto.title_ajax+"</strong></td></tr>";
								html += "<tr><td>"+data.ajaxDto.user_id+"</td><td>조회수</td>";
								html += "<td>"+data.ajaxDto.hitNum_ajax+"</td></tr><tr>";
								html += "<td colspan='3' class='article'>"+data.ajaxDto.contents_ajax+"</td></tr>";
								$(opener.document).find("tbody[id='tbody']").html(html);
								
								self.close();
								
							},
							'json'
						);//ajax
					
					
				}//if
				
			}//doWrite()
		
			
		
		
			//취소버튼 클릭 시
			function doCancel(){
				self.close();
			}//doCancel()
			
			
		</script>
		
	</head>
	<body>
	<!-- 각종 hidden 값 모음 -->
	<input type="hidden" name="page" id="page" value="">
	<input type="hidden" name="postNum_ajax" id="postNum_ajax" value="">
	<input type="hidden" name="groupNum_ajax" id="groupNum_ajax" value="">
	<input type="hidden" name="indentNum_ajax" id="indentNum_ajax" value="">
	<input type="hidden" name="stepNum_ajax" id="stepNum_ajax" value="">
	<input type="hidden" name="msg" id="msg" value="">
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				<div id="ajax_outline">
					<div id="title_area">
						<h1>글쓰기</h1>	
					</div>
					<hr>
					<div id="contents_area">
						<form action="" name="ajaxWriteForm" id="ajaxWriteForm">
							<table>
								<colgroup>
									<col width="15%">
									<col width="85%">
								</colgroup>
								<tbody id="tbody">
									<tr>
										<th>작성자</th>
										<td>
											${session_user_name}
											<input type="hidden" name="user_id" id="user_id" value="${session_user_id}">
										</td>
									</tr>
									<tr>
										<th>제목</th>
										<td>
											<input type="text" name="title_ajax" id="title_ajax" value="">
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td>
											<textarea rows="10" cols="50" id="contents_ajax"></textarea>
											<script type="text/javascript">
												/* 내용부분 - CKeditor 연동 */
												CKEDITOR.replace('contents_ajax', {height: 280});
											</script>
										</td>
									</tr>
								</tbody>
							</table>
							<hr>
							<div id="btn_area">
								<input type="button" value="취소" class="cancelBtn" onclick="doCancel()">
								<input type="button" value="확인" class="confirmBtn" onclick="doWrite(page.value)">
							</div>				
						</form>
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