<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>글 내용 확인페이지</title>
		<link rel="stylesheet" href="../css/board/view.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				
				//댓글 쓰기
				$("#replyBtn").on("click", function(){
					if(!$("#reContents").val()){
						alert("내용을 입력해 주세요!");
						$("#reContents").focus();
						return false;
					}
					
					document.replyForm.submit();
				});
				
			});//jQuery
	
	
			//글 삭제
			function deleteBtn(postNum, page){
				
				if(confirm("정말 삭제하시겠습니까?")){
					location.href="/deleteChk?postNum="+postNum+"&page="+page;
				}else{
					return false;
				}//if
			}
	
	
			//댓글 수정 View
			function modiBtn(postNum, reNum, page){
				location.href="/commentModifyView?postNum="+postNum+"&reNum="+reNum+"&page="+page;
			}//modiBtn()
	
	
	
			//댓글 삭제
			function commentDeleteBtn(postNum, reNum, page){
				if(confirm("정말 삭제하시겠습니까?")){
					location.href="/commentDeleteChk?postNum="+postNum+"&page="+page+"&reNum="+reNum;
				}else{
					return false;
				}//if
			}//deleteBtn()
			
			
			//첨부파일 다운로드 테스트 중
			function fileDown(postNum){
				
			}//fileDown()
			
		</script>
	</head>
	<body>
		<!-- header 추가 -->
		<div>
			<%@ include file="../header.jsp" %>
		</div> 
		<div id="board_outline">
			<div id="title_area">
				<h1>일반 게시판</h1>
			</div>
			<div id="contents_area">
				<table>
					<colgroup>
						<col width="80%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<tbody>
						<tr>
							<th colspan="3">제목</th>
						</tr>
						<tr>
							<td colspan="3"><strong>${map.boardDto.title}</strong></td>
						</tr>
						<tr>
							<td>${map.boardDto.user_id}</td>
							<td>조회수</td>
							<td>${map.boardDto.hitNum}</td>
						</tr>
						<tr>
							<td colspan="3" class="article">
								${map.boardDto.contents}<br>
								<c:choose>
									<c:when test="${map.boardDto.fileName ne null}">
										<br>
										<img alt="" src="/upload/${map.boardDto.fileName}" width="300"><br>
										<a href="/fileDown?postNum=${map.boardDto.postNum}">
											<font color="red"><strong>[첨부파일]</strong></font> ${map.boardDto.originFileName}
										</a> (${map.boardDto.fileSize}KB)
									</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<strong>다음글</strong>
								<span class="seperator">|</span>
								<a href="/board/view?postNum=${map.nextDto.postNum}&page=${map.page}">${map.nextDto.title}</a>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<strong>이전글</strong>
								<span class="seperator">|</span>
								<a href="/board/view?postNum=${map.preDto.postNum}&page=${map.page}">${map.preDto.title}</a>
							</td>
						</tr>
					</tbody>
				</table>
				<br>
				<br>
				<!-- 댓글 영역 -->
				<div id="reply_area">
					<div id="reply_history">
						<c:choose>
							<c:when test="${map.result eq false}">
								<!-- 댓글이 있는 경우 -->
								<c:forEach var="dto" items="${map.list}">
									<!-- 비밀글 설정여부 확인 -->
									<c:choose>
										<c:when test="${dto.reSecret eq 'n'}">
											<div id="replyBlock">
												<form action="/replyModify" name="reModifyForm" method="post">
													<strong>${dto.user_id}</strong>&nbsp;&nbsp;
														<c:choose>
															<c:when test="${dto.user_id eq session_user_id}">
																	<input type="button" value="수정" id="reModifyBtn_no" onclick="modiBtn(${map.boardDto.postNum}, ${dto.reNum}, ${map.page})">
																	<input type="button" value="삭제" id="reDeleteBtn_no" onclick="commentDeleteBtn(${map.boardDto.postNum}, ${dto.reNum}, ${map.page})">&nbsp;
																	<span class="replySaveDate_no">${dto.reDate}</span>
															</c:when>
														</c:choose>
													<div class="replyDetail">
														${dto.reContents}
													</div>
													<br>
													<hr>
													<br>
												</form>
											</div>
										</c:when>
										<c:when test="${dto.reSecret eq 'y'}">
											<c:choose>
												<c:when test="${dto.user_id eq session_user_id || map.boardDto.user_id eq session_user_id}">
													<div id="replyBlock">
														<strong>${dto.user_id}</strong>&nbsp;&nbsp;
														<c:choose>
															<c:when test="${dto.user_id eq session_user_id}">
																<input type="button" value="수정" id="reModifyBtn_yes" onclick="modiBtn(${map.boardDto.postNum}, ${dto.reNum}, ${map.page})">
																<input type="button" value="삭제" id="reDeleteBtn_yes" onclick="commentDeleteBtn(${map.boardDto.postNum}, ${dto.reNum}, ${map.page})">&nbsp;
																<span class="replySaveDate">${dto.reDate}</span>
															</c:when>
														</c:choose>
														<div class="replyDetail">
															<font color="red">[비밀글]</font>&nbsp;${dto.reContents}
														</div>
														<br>
														<hr>
														<br>
													</div>
												</c:when>
												<c:otherwise>
													<div id="replyBlock">
														<strong>${dto.user_id}</strong>&nbsp;&nbsp;${dto.reDate}<br>
														<font color="red">비밀댓글 입니다.</font><br>
														<br>
														<hr>
														<br>
													</div>
												</c:otherwise>
											</c:choose>
										</c:when>
									</c:choose>
								</c:forEach>
							</c:when>
							<c:when test="${map.result eq true}">
							<!-- 댓글이 없는 경우 -->
							<div id="replyBlock"><br><h4>&nbsp;&nbsp;댓글이 없습니다.</h4><br></div>
							</c:when>
						</c:choose>
					</div>
					
					<!-- 댓글 페이지 넘버링 -->
					<div id="reply_pageNum_area">
						<ul class="page_num">
							<li class="first"></li>
							<li class="prev"></li>
							<li class="num"><div>1</div></li>
							<li class="next"></li>
							<li class="last"></li>
						</ul>
					</div>
					
					<!-- 댓글 쓰기 -->
					<div id="reply_write">
						<form action="/reWrite?page=${map.page}" method="post" name="replyForm" id="replyForm">
							<strong>${session_user_name}(${session_user_id})</strong>&nbsp;&nbsp;
							<input type="hidden" name="user_id" id="user_id" value="${session_user_id}">
							<input type="hidden" name="postNum" id="postNum" value="${map.boardDto.postNum}">
							<input type="checkbox" name="reSecret" id="reSecret" value="y"> &nbsp;<span>비밀글 설정</span>
							<br>
							<input type="text" name="reContents" id="reContents">
							<input type="button" id="replyBtn" value="등록">
						</form>
					</div>
					
					<!-- 버튼 모음 -->
					<c:choose>
						<c:when test="${session_user_id eq map.boardDto.user_id}">
							<a href="/board/modify?postNum=${map.boardDto.postNum}&page=${map.page}"><div class="list_btn">수정</div></a>
							<div class="list_btn" id="deleteBtn" onclick="deleteBtn(${map.boardDto.postNum}, ${map.page})"><strong>삭제</strong></div>
							<a href="/replyView?postNum=${map.boardDto.postNum}&page=${map.page}"><div class="list_btn">답변달기</div></a>
							<a href="/board/list?page=${map.page}&search=${map.search}&category=${map.category}"><div class="list_btn">목록</div></a>
						</c:when>
						<c:otherwise>
							<a href="/replyView?postNum=${map.boardDto.postNum}&page=${map.page}"><div class="list_btn">답변달기</div></a>
							<a href="/board/list?page=${map.page}&search=${map.search}&category=${map.category}"><div class="list_btn">목록</div></a>
						</c:otherwise>
					</c:choose>
					
				</div>
			</div>
		</div>
	</body>
</html>