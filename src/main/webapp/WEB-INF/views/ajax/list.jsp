<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>Ajax 게시판</title>
		<link rel="stylesheet" href="../css/ajax/ajaxList.css">
		<!-- <link rel="stylesheet" href="../css/board/style.css">
  		<link rel="stylesheet" href="../css/board/listStyle.css"> -->
  		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<script type="text/javascript">
  			
  			//리시트 페이지 최초 로딩
  			$(document).ready(function(){
  				listView();
  			});
  			
  			
  			//리스트 불러오기
  			function listView(){
  				
  				$.post(
  					"/ajax/doList",		
  					{
  						"page":$("#page").val(),
  						"category":$("#category").val(),
  						"search":$("#search").val()
  						
  					},
  					function(data){
  						$("#page").val(data.page);
						$("#maxPage").val(data.maxPage);
						$("#dataCnt").text(data.listCount);
						
						//list + 페이지 출력
						list(data);
  					},
  					"json"
  				);//ajax
  			}//listView
  			
  			
  			//동적 태그 이벤트 바인딩
  			$(document).ready(function(){
  				$(document).on('click', '.num');  		//하단 페이지 넘버링
  				$(document).on('click', '#showView');   //상세 페이지
  				
  			});
  			
  		
		  	//페이지 이동 - 숫자 or << or >>
		  	function movePgBtn(page){
		  		
				$.post(
					"/ajax/doList",
					{
						"page":page,
						"category":$("#category").val(),
  						"search":$("#search").val()
					},
					function(data){
						$("#page").val(data.page);
						$("#maxPage").val(data.maxPage);
						
						//list + 페이지 출력
						list(data);
					},
					"json"
				);//ajax
		  	}//movePgBtn()
		  	
		  	
		  	
		  	//페이지 이동 - 이전페이지
		  	function prePgBtn(page){
		  		
		  		var prePage = page-1;
		  		if(prePage <= 0){
		  			prePage = 1;
		  		}
		  		
		  		
		  		$.post(
		  			"/ajax/doList",
		  			{
		  				"page":prePage,
		  				"category":$("#category").val(),
  						"search":$("#search").val()
		  			},
		  			function(data){
						$("#page").val(data.page);
						$("#maxPage").val(data.maxPage);
						
						//list + 페이지 출력
						list(data);
		  			},
		  			"json"
		  		);//ajax
		  	}//prePgBtn
		  	
		  	
		  	
		  	//페이지 이동 - 다음페이지
		  	function nextPgBtn(page){
		  		
		  		if(page == null || page == ''){
		  			page = '1';
		  		}
		  		
		  		var nextPage = parseInt(page)+1;
		  		
		  		$.post(
		  			"/ajax/doList",
		  			{
		  				"page":nextPage,
		  				"category":$("#category").val(),
  						"search":$("#search").val()
		  			},
		  			function(data){
						$("#page").val(data.page);
						$("#maxPage").val(data.maxPage);
						
						//list + 페이지 출력
						list(data);
		  			},
		  			"json"
		  		);//ajax
		  	}//nextPgBtn
		  	
		  	
		  	
		  	//글쓰기 View
  			function ajaxWrite(page){
		  		
		  		if(page == null || page == ''){
		  			page = "1";
		  		}
  				
  				// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupX = (window.screen.width / 2) - (600 / 2);
	  			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupY= (window.screen.height /2) - (400 / 2);
	  			
	  			window.open("./write?page="+page, "_blank", "status=no, width=1000, height=550, left="+popupX+", top="+popupY+", screenX="+popupX+", screenY="+popupY);
  			}//ajaxWrite()
  			
  			
  			
  			
  			//상세 페이지 View
  			function showView(postNum_ajax, page){
  				
  				// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupX = (window.screen.width / 2) - (600 / 2);
	  			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	  			var popupY= (window.screen.height /2) - (400 / 2);
	  			
	  			window.open("./view?postNum_ajax="+postNum_ajax+"&page="+page, "_blank", "status=no, width=1000, height=550, left="+popupX+", top="+popupY+", screenX="+popupX+", screenY="+popupY);
  			}//showDetails()
  			
  			
  			
  			
  			//검색기능
  			function doSearch(page){
  				var category = $("#category").val();
  				var search = $("#search").val();
  				
  				$.post(
  					'/ajax/doList',
  					{
  						"category":category,
  						"search":search,
  						"page":page
  					},
  					function(data){
  						
  						$("#page").val(data.page);
						$("#maxPage").val(data.maxPage);
						$("#dataCnt").text(data.listCount);

						//list + 페이지 출력
						list(data);
  					},
  					'json'
  				);//ajax
  			}//doSearch()
  			
  			
  			
  			
  			//list + 페이지 - 출력 함수
  			function list(data){
  				
  				console.log(data);
  				
  				//검색결과 있을 떄
				if(data.result == false){
					/* //list 데이터 - 오라클 계층 쿼리 사용안한 경우(대댓글 표현 가능)
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
						$("#tbody").html(html);
					}//for */
					
					
					
					
					//list 데이터 - 오라클 계층쿼리 사용한 경우(대댓글 표현 불가능)
					html = "";
					for(var i=0; i<data.list.length; i++){
						html += "<tr><td><span class='table-notice'>"+data.list[i].postNum_ajax;
						html += "</span></td><td class='table-title'>";
						
						/* if(data.list[i].indentNum_ajax != 0){
							for(var j=0; j<data.list[i].indentNum_ajax; j++){
								html += "└─&nbsp;Re:&nbsp;";
							}
						} */
						
						html += "<a href='javascript:void(0)'";
						html += " onclick='showView("+data.list[i].postNum_ajax+", "+data.page+")' id='showView'>"+data.list[i].title_ajax+"</a>";
						
						
						if(data.list[i].comCnt != 0){
							html += "&nbsp;<font color='red'><strong>["+data.list[i].comCnt+"]</strong></font>";	
						}
						
						html += "</td><td>"+data.list[i].user_id+"</td>";
						html += "<td>"+data.list[i].date_ajax+"</td><td>"+data.list[i].hitNum_ajax+"</td></tr>";
						$("#tbody").html(html);
					}//for
					
					
					
					
					
					//페이지 넘버링
					htmlPg = "";
					for(var i=data.startPage; i<=data.endPage; i++){
						htmlPg += "<li class='num' onclick='movePgBtn("+i+")'><div>"+i+"</div></li>";
					}//for
					$("#pageNum_area").show();
					$("#pageNum").html(htmlPg);
				}else if(data.result == true){
					html = "";
					html += "<tr><td colspan='5' id='noSearchResult'>'"+data.search+"'에 대한 검색결과가 없습니다.</td></tr>";
					$("#tbody").html(html);
					$("#pageNum_area").hide();
				}//if
  			}//list();
  			
  			
  			
  			
  		</script>
  		
	</head>
	<body>
	<!-- 필요한 변수값 저장하기 -->
	<input type="hidden" name="page" id="page" value="">
	<input type="hidden" name="maxPage" id="maxPage" value="">
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				 <!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp"%>
				</div> 
				<div id="board_outline">
					<div id="title_area">
						<h1>AJAX 게시판</h1>
					</div>
					<div id="search_area">
						<form action="" name="search" method="post">
							<select name="category" id="category">
								<option value="total">전체</option>
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
							<input type="text" size="16" name="search" id="search">
							<button type="button" onclick="doSearch(page.value)"><font color="white" size="3">찾기</font></button>
						</form>
					</div>
					<div id="dataResultCnt">
						전체&nbsp;<span id="dataCnt"></span>건
					</div>
					<div id="contents_area">
							<table id="table">
								<colgroup>
									<col width="10%">
									<col width="35%">
									<col width="10%">
									<col width="18%">
									<col width="10%">
								</colgroup>
								<!-- 제목부분 -->
								<tr>
									<th>No.</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
								<tbody id="tbody">
									<!-- 테이블 내용이 들어가는 자리 -->								
								</tbody>
							</table>
							
							
							<div id="pageNum_area">
								<!-- 페이지 넘버링 시작 -->
								<ul class="page-num">
									<!-- 제일 첫 페이지로 -->
									<li class="first" onclick="movePgBtn(1)"></li>
									
									<!-- 이전 페이지로 이동 -->
									<li class="prev" onclick="prePgBtn(page.value)"></li>
									
									<span id="pageNum">
										<!-- 페이지 번호 들어가는 자리 -->
									</span>
									
									<!-- 다음 페이지로 이동 -->
									<li class="next" onclick="nextPgBtn(page.value)"></li>
									
									<!-- 제일 마지막 페이지로 -->
									<li class="last" onclick="movePgBtn(maxPage.value)"></li>
								</ul>
							
							</div>
							
							
							<!-- 버튼 영역 -->
							<div id="btn_menu">
								<div class="write" onclick="ajaxWrite(page.value)" id="ajaxWriteBtn">쓰기</div>
							</div>
	
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