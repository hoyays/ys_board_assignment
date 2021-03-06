<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>일반게시판</title>
		<link rel="stylesheet" href="../css/board/boardList.css">
		<!-- <link rel="stylesheet" href="../css/board/style.css">
  		<link rel="stylesheet" href="../css/board/listStyle.css"> -->
  		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<script type="text/javascript">
	  		$(document).ready(function(){
	  			
	  			$("#searchBtn").on("click", function(){
	  				if(!$("#search").val()){
	  					alert("검색어를 입력해 주세요!");
	  					$("#search").focus();
	  					return false;
	  				}
	  				
	  				document.searchForm.submit();
	  			});
	  			
	  			
	  			$("#excelUpBtn").on("click", function(){
	  				if(!$("#file").val()){
	  					alert("엑셀 파일을 첨부해 주시기 바랍니다.");
	  					return false;
	  				}
	  				
	  				document.excelUpForm.submit();
	  			});
	  			
	  		})//jQuery
  		</script>
	</head>
	<body>
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				<!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp"%>
				</div>
				<div id="board_outline">
					<div id="title_area">
						<h1>일반 게시판</h1>
					</div>
					<div id="search_area">
						<form action="/board/list" name="searchForm" method="post">
							<select name="category" id="category">
								<option value="total" <c:if test="${map.category eq 'total'}">selected</c:if>>전체</option>
								<option value="title" <c:if test="${map.category eq 'title'}">selected</c:if>>제목</option>
								<option value="content" <c:if test="${map.category eq 'content'}">selected</c:if>>내용</option>
							</select>
							<input type="text" size="16" name="search" id="search" value="${map.search}">
							<button type="button" id="searchBtn"><font color="white" size="3">찾기</font></button>
						</form>
					</div>
					<div id="excelUpDown">
						<a href="/excelDown?page=${map.page}&search=${map.search}&category=${map.category}"><div class="write">엑셀다운</div></a><br>
						<form action="/excelUp" name="excelUpForm" id="excelUpForm" method="post" enctype="multipart/form-data">
							<!-- 
							<span id="exceUpGuide">
								<font color="red"><strong>※ 참고 : 엑셀 업로드 파일 양식 <a href="/fileDown">다운로드</a></strong></font>
							</span>
							 -->
							<input type="file" name="file" id="file" accept=".xlsx, .xls">
							<input type="button" value="엑셀업" id="excelUpBtn">
						</form>
					</div>
					<div id="dataResultCnt">
						전체&nbsp;<span id="dataCnt">${map.listCount}</span>건
					</div>
					<div id="contents_area">
						<table>
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
							<!-- 내용부분 - 반복 시작 -->
							<c:choose>
								<c:when test="${map.searchResult eq false}">
									<!-- 검색 결과가 있을 경우 -->
									<c:forEach var="dto" items="${map.list}">
										<tr>
											<td>
												${dto.postNum}
											</td>
											<td class="table-title">
												<c:forEach begin="1" end="${dto.indentNum}">
													└─&nbsp;Re:&nbsp;
												</c:forEach>
												<a href="/board/view?postNum=${dto.postNum}&page=${map.page}&search=${map.search}&category=${map.category}">
													${dto.title}&nbsp;
													<c:choose>
														<c:when test="${dto.reCnt ne 0 }">
															<font color="red"><strong>[${dto.reCnt}]</strong></font>	
														</c:when>
													</c:choose>
												</a>
											</td>
											<td>
												${dto.user_id}
											</td>
											<td>
												${dto.boardDate}
											</td>
											<td>
												${dto.hitNum}
											</td>
										</tr>
									<!-- 내용부분 - 반복 끝 -->
									</c:forEach>
								</c:when>
								<c:otherwise>
									<!-- 검색결과가 없는 경우 -->
									<tr>
										<td colspan="5">'${map.search}'에 대한 검색결과가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
							
						</table>
						
						
						<div id="pageNum">
							<!-- 페이지 넘버링 시작 -->
							<ul class="page-num">
								<!-- 제일 첫 페이지로 -->
								<a href="/board/list?page=1&search=${map.search}&category=${map.category}">
									<li class="first"></li>
								</a> 
								
								<!-- 이전 페이지 이동 -->
								<c:choose>
									<c:when test="${map.page <= 1}">
										<!-- 현재 페이지가 1 이하인 경우 링크 없음 -->
										<li class="prev"></li>
									</c:when>
									<c:otherwise>
										<a href="/board/list?page=${map.page-1}&search=${map.search}&category=${map.category}">
											<li class="prev"></li>
										</a>
									</c:otherwise>
								</c:choose>
								
								<!-- 페이지 반복 시작 -->
								<c:forEach var="nowPage" begin="${map.startPage}" end="${map.endPage}">
									<c:choose>
										<c:when test="${nowPage eq map.page}">
											<li class="num"><div>${nowPage}</div></li>  <!-- 현재 페이지가 같으면 링크없음 -->
										</c:when>
										<c:when test="${nowPage > 0 && nowPage != map.page}">
											<a href="/board/list?page=${nowPage}&search=${map.search}&category=${map.category}">
												<li class="num"><div>${nowPage}</div></li>			
											</a>
										</c:when>
											
									</c:choose>
								</c:forEach>
								
								<!-- 다음 페이지 이동 -->
								<c:choose>
									<c:when test="${map.page ge map.maxPage}">
										<!-- 현재 페이지가 최대페이지 이상일 경우 링크 없음 -->
										<li class="next"></li>
									</c:when>
									<c:otherwise>
										<a href="/board/list?page=${map.page+1}&search=${map.search}&category=${map.category}">
											<li class="next"></li>
										</a>
									</c:otherwise>
								</c:choose>
								<!-- 제일 마지막 페이지 -->							
								<a href="/board/list?page=${map.maxPage}&search=${map.search}&category=${map.category}">
									<li class="last"></li>
								</a>
							</ul>
						</div>
						
						<!-- 쓰기 버튼 -->
						<div id="btn_menu">
							<a href="/board/write"><div class="write">쓰기</div></a>
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