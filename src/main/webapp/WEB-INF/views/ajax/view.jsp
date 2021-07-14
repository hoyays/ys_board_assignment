<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
	<html>
		<head>
		<meta charset="UTF-8">
		<title>Ajax 게시판 - 상세페이지</title>
		<link rel="stylesheet" href="/css/ajax/view.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		
		
			$(document).ready(function(){
				//상세 페이지 View 최초 로딩 시
				detailView();
				
			});
			
			//url 파라미터 값을 읽어주는 정규식 함수
			function getParameterByName(name) {
			  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
			  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
			  results = regex.exec(location.search);
			  return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
			}
			
			
			//상세 페이지 내용 불러오기
			function detailView(){
				
				//정규식이용, url 파라미터 값 읽기
				var postNum_ajax = getParameterByName('postNum_ajax');
				var page = getParameterByName('page');
				
				$.post(
					'/ajax/doView',
					{
						"postNum_ajax":postNum_ajax
					},
					function(data){
						
						$("#page").val(data.page);
						$("#title_ajax").val(data.ajaxDto.title_ajax);
						$("#contents_ajax").val(data.ajaxDto.contents_ajax);
						$("#postNum_ajax").val(data.ajaxDto.postNum_ajax);
						$("#groupNum_ajax").val(data.ajaxDto.groupNum_ajax);
						$("#indentNum_ajax").val(data.ajaxDto.indentNum_ajax);
						$("#stepNum_ajax").val(data.ajaxDto.stepNum_ajax);
						$("#hitNum_ajax").val(data.ajaxDto.hitNum_ajax);
						
						
						//상세 페이지 - 제목, 내용, 조회수 등
						html = "";
						html += "<tr><th colspan='3'>제목</th></tr><tr>";
						html += "<td colspan='3'><strong>"+data.ajaxDto.title_ajax+"</strong></td></tr>";
						html += "<tr><td>"+data.ajaxDto.user_id+"</td><td>조회수</td>";
						html += "<td>"+data.ajaxDto.hitNum_ajax+"</td></tr><tr>";
						html += "<td colspan='3' class='article'>"+data.ajaxDto.contents_ajax+"</td></tr>";
						$("#tbody").html(html);
						

						
						//댓글 히스토리
						comHtml = "";
						
						//댓글이 있는 경우
						if(data.result == false){
							
							for(var i=0; i<data.comList.length; i++){
								
								//비밀글 설정 N
								if(data.comList[i].comSecret_ajax == 'n'){
									comHtml += "<div id='comNum_"+data.comList[i].comNum_ajax+"'><div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>&nbsp;&nbsp;";
									if(data.comList[i].user_id == data.session_user_id){
										comHtml += "<input type='button' value='수정' id='goComModify' onclick='goComModifyBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
										comHtml += "<input type='button' value='삭제' id='goComDelete' onclick='goComDeleteBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
									}
									comHtml += "<span>"+data.comList[i].comDate_ajax+"</span>";
									comHtml += "<div class='commentDetail'>"+data.comList[i].comContents_ajax+"</div><br><hr><br></div></div>";
									
								//비밀글 설정 Y	
								}else {
									
									//원글작성자 or 댓글 작성자인 경우 ==> 비밀글 내용 보여주기
									if(data.comList[i].user_id == data.session_user_id || data.ajaxDto.user_id == data.session_user_id){
										comHtml += "<div id='comNum_"+data.comList[i].comNum_ajax+"'><div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>&nbsp;&nbsp;";
										
										//단, 댓글 작성자인 경우 ==> 수정, 삭제 버튼 노출
										if(data.comList[i].user_id == data.session_user_id){
											comHtml += "<input type='button' value='수정' id='goComModify' onclick='goComModifyBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
											comHtml += "<input type='button' value='삭제' id='goComDelete' onclick='goComDeleteBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
											comHtml += "<span>"+data.comList[i].comDate_ajax+"</span>";
										}//if
										
										comHtml += "<div class='commentDetail'><font color='red'>[비밀글]</font>&nbsp;"+data.comList[i].comContents_ajax+"</div><br><hr><br></div></div>";
										
										
									//그 이외의 사람 ==> 비밀글 내용 볼 수 없음	
									}else{
										comHtml += "<div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>";
										comHtml += "&nbsp;&nbsp;"+data.comList[i].comDate_ajax+"<br>";
										comHtml += "<font color='red'>비밀댓글 입니다.</font><br><br><hr><br></div>";
									}//if - 접속자 누구? 확인용
								}//if - 비밀글 설정? 확인용
							}//for
							
						//댓글이 없는 경우
						} else {
							comHtml += "<div id='commentBlock'><br><h4>&nbsp;&nbsp;댓글이 없습니다.</h4><br></div>";
						}//if - 댓글 유무 확인용
						$("#comment_history").html(comHtml);
						
						

						
						var session_user_id = data.session_user_id;  //세션 user_id
						var user_id = data.ajaxDto.user_id;          //글 작성 user_id
						
						//버튼 모음 - 수정, 삭제, 목록 등
						if(session_user_id == user_id){
							
							btn_html = "";
							btn_html += "<div class='list_btn' id='goModify' onclick='goModifyBtn("+data.ajaxDto.postNum_ajax+", "+data.page+")'>수정</div>";
							btn_html += "<div class='list_btn' id='goDelete' onclick='goDeleteBtn("+data.ajaxDto.postNum_ajax+", "+data.page+")'>삭제</div>";
							btn_html += "<div class='list_btn' id='goReply' onclick='goReplyBtn("+data.ajaxDto.postNum_ajax+", "+data.page+")'>답변달기</div>";
							btn_html += "<div class='list_btn' onclick='goListBtn()'>목록</div>";
							$("#btn_area").html(btn_html);
						}else {
							
							btn_html = "";
							btn_html += "<div class='list_btn' id='goReply' onclick='goReplyBtn("+data.ajaxDto.postNum_ajax+", "+data.page+")'>답변달기</div>";
							btn_html += "<div class='list_btn' onclick='goListBtn()'>목록</div>";
							$("#btn_area").html(btn_html);
						}//if
					},
					'json'
				);//ajax
			}//detailView()
			
			
			
			//동적 태그 이벤트 바인딩
			$(document).ready(function(){
				$(document).on('click', '#goDelete');   //삭제하기
				$(document).on('click', '#goModify');   //수정하기
				$(document).on('click', '#goReply');   	//답변하기
				
				$(document).on('click', '#goComModify');    //댓글 수정하기
				$(document).on('click', '#goComDelete');    //댓글 삭제하기
			});
			
			
			
			
			//댓글 수정 View
			function goComModifyBtn(comNum_ajax){
				
				$.post(
					'/ajax/comModify',
					{
						"comNum_ajax":comNum_ajax,
						"postNum_ajax":$("#postNum_ajax").val()
					},
					function(data){
						
						console.log(data);
						var add_div = "#comNum_"+comNum_ajax;
						
						html = "";
						html += "<strong>"+data.ajaxCommentDto.user_id+"</strong>&nbsp;&nbsp;";
						html += "<input type='button' value='취소' id='cancelComModify' onclick=''>&nbsp;";
						html += "<span>"+data.ajaxCommentDto.comDate_ajax+"</span>";
						html += "<div class='commentDetail'><input type='text' value='"+data.ajaxCommentDto.comContents_ajax+"'>&nbsp;";
						html += "<input type='button' value='저장' id='doComModifySave' onclick=''></div>";
						/* html += "<input type='checkbox' name='comSecret_ajax' value='y' ";
						if(data.ajaxCommentDto.reSecret_ajax == 'y'){
							html += "checked>>&nbsp;";
						}
						html += "<label>비밀글 설정</label><br><hr><br>"; */
						
						$(add_div).html(html);
						
					},
					'json'
				);//ajax
				
			}//goComModifyBtn()
			
			
			
			
			
			
			
			
			//댓글 삭제하기
			function goComDeleteBtn(comNum_ajax){
				
				if(confirm("정말 삭제하시겠습니까?")){
					
					$.post(
						'/ajax/doComDelete',
						{
							"comNum_ajax":comNum_ajax,
							"postNum_ajax":$("#postNum_ajax").val()
						},
						function(data){
							
							var msg = data.msg;
							alert(msg);
							
							//댓글 히스토리
							comHtml = "";
							
							//댓글이 있는 경우
							if(data.result == false){
								
								for(var i=0; i<data.comList.length; i++){
									
									//비밀글 설정 N
									if(data.comList[i].comSecret_ajax == 'n'){
										comHtml += "<div id='comNum_"+data.comList[i].comNum_ajax+"'><div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>&nbsp;&nbsp;";
										if(data.comList[i].user_id == data.session_user_id){
											comHtml += "<input type='button' value='수정' id='goComModify' onclick='goComModifyBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
											comHtml += "<input type='button' value='삭제' id='goComDelete' onclick='goComDeleteBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
										}
										comHtml += "<span>"+data.comList[i].comDate_ajax+"</span>";
										comHtml += "<div class='commentDetail'>"+data.comList[i].comContents_ajax+"</div><br><hr><br></div></div>";
										
									//비밀글 설정 Y	
									}else {
										
										//원글작성자 or 댓글 작성자인 경우 ==> 비밀글 내용 보여주기
										if(data.comList[i].user_id == data.session_user_id || data.ajaxDto.user_id == data.session_user_id){
											comHtml += "<div id='comNum_"+data.comList[i].comNum_ajax+"'><div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>&nbsp;&nbsp;";
											
											//단, 댓글 작성자인 경우 ==> 수정, 삭제 버튼 노출
											if(data.comList[i].user_id == data.session_user_id){
												comHtml += "<input type='button' value='수정' id='goComModify' onclick='goComModifyBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
												comHtml += "<input type='button' value='삭제' id='goComDelete' onclick='goComDeleteBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
												comHtml += "<span>"+data.comList[i].comDate_ajax+"</span>";
											}//if
											
											comHtml += "<div class='commentDetail'><font color='red'>[비밀글]</font>&nbsp;"+data.comList[i].comContents_ajax+"</div><br><hr><br></div></div>";
											
											
										//그 이외의 사람 ==> 비밀글 내용 볼 수 없음	
										}else{
											comHtml += "<div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>";
											comHtml += "&nbsp;&nbsp;"+data.comList[i].comDate_ajax+"<br>";
											comHtml += "<font color='red'>비밀댓글 입니다.</font><br><br><hr><br></div>";
										}//if - 접속자 누구? 확인용
									}//if - 비밀글 설정? 확인용
								}//for
								
							//댓글이 없는 경우
							} else {
								comHtml += "<div id='commentBlock'><br><h4>&nbsp;&nbsp;댓글이 없습니다.</h4><br></div>";
							}//if - 댓글 유무 확인용
							$("#comment_history").html(comHtml);
							
							
						},
						'json'
					);//ajax
						
				}else {
					return false;
				}
				
				
				
				
				
				
			}//goComDeleteBtn()
			
			
			
			
			
			
			//댓글 쓰기 - DB 저장하기
			function doComWrite(){
				
								
				//내용 공백 확인
				if(!$("#comContents_ajax").val()){
					alert("내용을 입력해 주세요!");
					$("#comContents_ajax").focus();
					return false;
				}
				
				$.post(
					'/ajax/doComWrite',
					{
						"user_id":$("#user_id").val(),
						"postNum_ajax":$("#postNum_ajax").val(),
						"comSecret_ajax":$("input:checkbox[name='comSecret_ajax']:checked").val(),
						"comContents_ajax":$("#comContents_ajax").val(),
						"page":$("#page").val()
					},
					function(data){
						
						
						//댓글 히스토리
						comHtml = "";
						
						//댓글이 있는 경우
						if(data.result == false){
							
							for(var i=0; i<data.comList.length; i++){
								
								//비밀글 설정 N
								if(data.comList[i].comSecret_ajax == 'n'){
									comHtml += "<div id='comNum_"+data.comList[i].comNum_ajax+"'><div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>&nbsp;&nbsp;";
									if(data.comList[i].user_id == data.session_user_id){
										comHtml += "<input type='button' value='수정' id='goComModify' onclick='goComModifyBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
										comHtml += "<input type='button' value='삭제' id='goComDelete' onclick='goComDeleteBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
									}
									comHtml += "<span>"+data.comList[i].comDate_ajax+"</span>";
									comHtml += "<div class='commentDetail'>"+data.comList[i].comContents_ajax+"</div><br><hr><br></div></div>";
									
								//비밀글 설정 Y	
								}else {
									
									//원글작성자 or 댓글 작성자인 경우 ==> 비밀글 내용 보여주기
									if(data.comList[i].user_id == data.session_user_id || data.ajaxDto.user_id == data.session_user_id){
										comHtml += "<div id='comNum_"+data.comList[i].comNum_ajax+"'><div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>&nbsp;&nbsp;";
										
										//단, 댓글 작성자인 경우 ==> 수정, 삭제 버튼 노출
										if(data.comList[i].user_id == data.session_user_id){
											comHtml += "<input type='button' value='수정' id='goComModify' onclick='goComModifyBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
											comHtml += "<input type='button' value='삭제' id='goComDelete' onclick='goComDeleteBtn("+data.comList[i].comNum_ajax+")'>&nbsp;";
											comHtml += "<span>"+data.comList[i].comDate_ajax+"</span>";
										}//if
										
										comHtml += "<div class='commentDetail'><font color='red'>[비밀글]</font>&nbsp;"+data.comList[i].comContents_ajax+"</div><br><hr><br></div></div>";
										
										
									//그 이외의 사람 ==> 비밀글 내용 볼 수 없음	
									}else{
										comHtml += "<div id='commentBlock'><strong>"+data.comList[i].user_id+"</strong>";
										comHtml += "&nbsp;&nbsp;"+data.comList[i].comDate_ajax+"<br>";
										comHtml += "<font color='red'>비밀댓글 입니다.</font><br><br><hr><br></div>";
									}//if - 접속자 누구? 확인용
								}//if - 비밀글 설정? 확인용
							}//for
							
						//댓글이 없는 경우
						} else {
							comHtml += "<div id='commentBlock'><br><h4>&nbsp;&nbsp;댓글이 없습니다.</h4><br></div>";
						}//if - 댓글 유무 확인용
						$("#comContents_ajax").val("");
						$("#comment_history").html(comHtml);
						
						
					},
					'json'
				);//ajax
				
			}//doComWrite()
			
			
			
			
			
			//목록 버튼 클릭 시
			function goListBtn(){
				
				//정규식이용, url 파라미터 값 읽기
				var postNum_ajax = getParameterByName('postNum_ajax');
				var page = getParameterByName('page');
				
				//수정된 후 목록 버튼 클릭 시 리스트 새로고침
				$.post(
					'/ajax/doList',
					{
						"page":page
					},
					function(data){
						console.log(data);
						
						$(opener.document).find("input[id='page']").val(data.page);
						$(opener.document).find("input[id='maxPage']").val(data.maxPage);
						$(opener.document).find("span[id='dataCnt']").text(data.listCount);
						
						
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
							html += " onclick='showView("+data.list[i].postNum_ajax+", "+data.page+")' id='showView'>"+data.list[i].title_ajax+"</a>";
							
							
							if(data.list[i].comCnt != 0){
								html += "&nbsp;<font color='red'><strong>["+data.list[i].comCnt+"]</strong></font>";	
							}
							
							html += "</td><td>"+data.list[i].user_id+"</td>";
							html += "<td>"+data.list[i].date_ajax+"</td><td>"+data.list[i].hitNum_ajax+"</td></tr>";
							
							$(opener.document).find("tbody[id='tbody']").html(html);
						}//for
						
						
						//페이지 넘버링
						htmlPg = "";
						for(i=data.startPage; i<=data.endPage; i++){
							htmlPg += "<li class='num' onclick='movePgBtn("+i+")'><div>"+i+"</div></li>";
						}
						$(opener.document).find("span[id='pageNum']").html(htmlPg);
						
						
						self.close();
					},
					'json'
				);//ajax
				
				
			}//goListBtn()
			
			
			
			
			//삭제 버튼 클릭 시
			function goDeleteBtn(postNum_ajax, page){
				if(confirm("정말 삭제하시겠습니까?")){
					
					$.post(
						"/ajax/doDelete",
						{
							"postNum_ajax":postNum_ajax,
							"page":page
						},
						function(data){

							var msg = data.msg;
							alert(msg);
							
							$("#page").val(data.page);
							$(opener.document).find("#dataCnt").text(data.listCount);
							
							
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
								html += " onclick='showView("+data.list[i].postNum_ajax+", "+data.page+")' id='showView'>"+data.list[i].title_ajax+"</a>";
								
								
								if(data.list[i].comCnt != 0){
									html += "&nbsp;<font color='red'><strong>["+data.list[i].comCnt+"]</strong></font>";	
								}
								
								html += "</td><td>"+data.list[i].user_id+"</td>";
								html += "<td>"+data.list[i].date_ajax+"</td><td>"+data.list[i].hitNum_ajax+"</td></tr>";
								
								$(opener.document).find("tbody[id='tbody']").html(html);
							}//for
							
							self.close();
						},
						'json'
					);//ajax
					
				}else{
					return false;
				}//if
			}
			
			
			//수정 버튼 클릭 시
			function goModifyBtn(postNum_ajax, page){
				
				var postNum_ajax = $("#postNum_ajax").val();
				var page = $("#page").val();
				
				// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupX = (window.screen.width / 2) - (600 / 2);
	  			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupY= (window.screen.height /2) - (400 / 2);
	  			
	  			window.open("./write?postNum_ajax="+postNum_ajax+"&page="+page+"&msg=modify", "_blank", "status=no, width=800, height=550, left="+popupX+", top="+popupY+", screenX="+popupX+", screenY="+popupY);
				
			}//goModifyBtn()
			
			
			
			//답변하기 클릭 시
			function goReplyBtn(postNum_ajax, page){
				
				var postNum_ajax = $("#postNum_ajax").val();
				var page = $("#page").val();
				
				// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupX = (window.screen.width / 2) - (600 / 2);
	  			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupY= (window.screen.height /2) - (400 / 2);
	  			
	  			window.open("./write?postNum_ajax="+postNum_ajax+"&page="+page+"&msg=reply", "_blank", "status=no, width=800, height=550, left="+popupX+", top="+popupY+", screenX="+popupX+", screenY="+popupY);
				
				
			}//goReplyBtn()
			
			
		</script>
	</head>
	<body>
	<!-- 필요한 변수값 저장하기 -->
	<input type="hidden" name="page" id="page" value="">
	<input type="hidden" name="title_ajax" id="title_ajax" value="">
	<input type="hidden" name="contents_ajax" id="contents_ajax" value="">
	<input type="hidden" name="postNum_ajax" id="postNum_ajax" value="">
	<input type="hidden" name="groupNum_ajax" id="groupNum_ajax" value="">
	<input type="hidden" name="indentNum_ajax" id="indentNum_ajax" value="">
	<input type="hidden" name="stepNum_ajax" id="stepNum_ajax" value="">
	<input type="hidden" name="hitNum_ajax" id="hitNum_ajax" value="">
	<input type="hidden" name="msg" id="msg" value="">
		<div id="board_outline">
			<div id="title_area">
				<h1>상세 페이지</h1>
			</div>
			<div id="contents_area">
				<table>
					<colgroup>
						<col width="80%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<tbody id="tbody">
						<!-- 상세 페이지 내용이 들어가는 자리 -->
					</tbody>
					<tbody id="test">
						<!-- 리스트 페이지로 데이터 넘기기 위한 임시저장소 -->
					</tbody>
				</table>
				
				
				<!-- 댓글 영역 -->
				<div id="comment_area">
					<div id="comment_history">

						<!-- 댓글 리스트가 들어가는 자리 -->
						
						
						
					</div>
					
					
					<!-- <div id="comment_history">
							<strong>아이디</strong>&nbsp;&nbsp;
								
								<input type="button" value="취소" id="cancelComModify" onclick="">&nbsp;
								<span class="replySaveDate_no">댓글작성일</span>
							<div class="replyDetail">
								<input type="text" value="댓글 내용">
								<input type="button" value="저장" id="goComModifySave" onclick="">
							</div>
							<br>
							<hr>
							<br>
					</div> -->
					
					
					<div id="comment_pageNum">
						<ul class="page_num">
							<li class="first"></li>
							<li class="prev"></li>
							<li class="num"><div>1</div></li>
							<li class="next"></li>
							<li class="last"></li>
						</ul>
					</div>
					<div id="comment_write">
						
							<strong>${session_user_name}(${session_user_id})</strong>&nbsp;&nbsp;
							<input type="hidden" name="user_id" id="user_id" value="${session_user_id}">
							<input type="checkbox" name="comSecret_ajax" id="comSecret_ajax" value="y"> &nbsp;<span>비밀글 설정</span>
							<br>
							<input type="text" name="comContents_ajax" id="comContents_ajax">
							<input type="button" id="comAjaxBtn" value="등록" onclick="doComWrite()">
						
						
						
						
					</div>
					
				</div>
				
				<!-- 버튼 모음 -->
				<div id="btn_area">
					<!-- 수정, 삭제, 답변하기, 목록 버튼이 들어가는 자리 -->
				</div>
				
			</div>
		</div>
	</body>
</html>