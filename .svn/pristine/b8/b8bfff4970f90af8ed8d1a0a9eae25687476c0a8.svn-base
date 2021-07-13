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
					'/ajax/DoView',
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
			});
			
			
			
			
			//목록 버튼 클릭 시
			function goListBtn(){
				
				//정규식이용, url 파라미터 값 읽기
				var postNum_ajax = getParameterByName('postNum_ajax');
				var page = getParameterByName('page');
				
				//수정된 후 목록 버튼 클릭 시 리스트 새로고침
				$.post(
					'/ajax/DoList',
					{
						"page":page
					},
					function(data){
						console.log(data);
						
						$(opener.document).find("input[id='page']").val(data.page);
						$(opener.document).find("input[id='maxPage']").val(data.maxPage);
						$(opener.document).find("span[id='dataCnt']").text(data.listCount);
						
						/* //list 데이터
						html = "";
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
					<div id="comment_write">댓글 쓰기 영역</div>
					<div id="comment_history">댓글 히스토리</div>
					<div id="comment_pageNum">
						<ul class="page_num">
							<li class="first"></li>
							<li class="prev"></li>
							<li class="num"><div>1</div></li>
							<li class="next"></li>
							<li class="last"></li>
						</ul>
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