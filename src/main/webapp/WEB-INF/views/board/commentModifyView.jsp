<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>댓글 수정하기 View</title>
		<link rel="stylesheet" href="../css/board/commentModifyView.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			//글 삭제
			function deleteBtn(postNum, page){
				if(confirm("정말로 삭제하시겠습니까?")){
					location.href="/deleteChk?postNum="+postNum+"&page="+page;
				}else{
					return false;
				}//if
			}
	
	
	
			/*================> 댓글 부분 <================>*/
			//댓글 수정(비밀글 X) - DB 저장하기
			function commentModifyBtn(){
				if(!$(".reContents").val()){
					alert("내용을 입력해 주세요!");
					$(".reContents").focus();
					return false;
				}
				
				document.commentModify.submit();
				
			}//commentModifyBtn()
	
	
			//댓글 수정(비밀글 O) - DB 저장하기
			function commentModifyBtn1(){
				if(!$(".reContents1").val()){
					alert("내용을 입력해 주세요!");
					$(".reContents1").focus();
					return false;
				}
				
				document.commentModify1.submit();
				
			}//commentModifyBtn()


		</script>
	</head>
	<body>
	 <!-- header 추가 -->
	<div>
		<%@ include file="../header.jsp"%>
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
						<td colspan="3" class="article">${map.boardDto.contents}<br>
							<c:choose>
								<c:when test="${map.boardDto.fileName ne null}">
									<br>
									<img alt="" src="/upload/${map.boardDto.fileName}" width="300">
								</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td colspan="3"><strong>다음글</strong> <span class="seperator">|</span>
							<a
							href="/board/view?postNum=${map.nextDto.postNum}&page=${map.page}">${map.nextDto.title}</a>
						</td>
					</tr>
					<tr>
						<td colspan="3"><strong>이전글</strong> <span class="seperator">|</span>
							<a
							href="/board/view?postNum=${map.preDto.postNum}&page=${map.page}">${map.preDto.title}</a>
						</td>
					</tr>
				</tbody>
			</table>
			<br> <br>
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
											<c:choose>
												<c:when test="${dto.user_id eq session_user_id && dto.reNum eq map.reNum}">
													<form action="/commentModifyChk" method="post" name="commentModify" onsubmit="return false">
														<input type="hidden" name="postNum" value="${map.boardDto.postNum}">
														<input type="hidden" name="reNum" value="${dto.reNum}">
														<input type="hidden" name="page" value="${map.page}">
														<strong>${dto.user_id}</strong>&nbsp;&nbsp;
														<input type="button" value="취소" onclick="history.go(-1)">&nbsp;
														<span class="replySaveDate_no">${dto.reDate}</span><br><br>
														<input type="text" class="reContents" name="reContents" value="${dto.reContents}" autofocus="autofocus">
														<input type="button" class="commentBtn" value="수정" onclick="commentModifyBtn()">
														<input type="checkbox" name="reSecret" value="y" <c:if test="${dto.reSecret eq 'y'}">checked</c:if>>&nbsp;
														<label>비밀글 설정</label>
													</form>
												</c:when>
												<c:otherwise>
													<strong>${dto.user_id}</strong>&nbsp;&nbsp;
													<input type="button" value="답글">&nbsp;${dto.reDate}<br><br>
													<div class="replyDetail">${dto.reContents}</div>
												</c:otherwise>
											</c:choose>
											
											<br>
											<hr>
											<br>
										</div>
									</c:when>
									<c:when test="${dto.reSecret eq 'y'}">
										<c:choose>
											<c:when test="${dto.user_id eq session_user_id || map.boardDto.user_id eq session_user_id}">
												<div id="replyBlock">
													<c:choose>
														<c:when test="${dto.user_id eq session_user_id && dto.reNum eq map.reNum}">
															<form action="/commentModifyChk" method="post" name="commentModify1" onsubmit="return false">
																<input type="hidden" name="postNum" value="${map.boardDto.postNum}">
																<input type="hidden" name="reNum" value="${dto.reNum}">
																<input type="hidden" name="page" value="${map.page}">
																<strong>${dto.user_id}</strong>&nbsp;&nbsp;
																<input type="button" value="취소" onclick="history.go(-1)">&nbsp;
																<span class="replySaveDate_no">${dto.reDate}</span><br><br>
																<input type="text" class="reContents1" name="reContents" value="${dto.reContents}" autofocus="autofocus">
																<input type="button" class="commentBtn" value="수정" onclick="commentModifyBtn1()">
																<input type="checkbox" name="reSecret" value="y" <c:if test="${dto.reSecret eq 'y'}">checked</c:if>>&nbsp;
																<label>비밀글 설정</label>
															</form>
														</c:when>
														<c:otherwise>
															<input type="button" value="답글">&nbsp;${dto.reDate}
														</c:otherwise>
													</c:choose>
													<br>
													<hr>
													<br>
												</div>
											</c:when>
											<c:otherwise>
												<div id="replyBlock">
													<strong>${dto.user_id}</strong>&nbsp;&nbsp;${dto.reDate}<br>
													<font color="red">비밀댓글 입니다.</font><br> <br>
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
							<div id="replyBlock">
								<br>
								<h4>&nbsp;&nbsp;댓글이 없습니다.</h4>
								<br>
							</div>
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
				<%-- <div id="reply_write">
					<form action="/reWrite?page=${map.page}" method="post"
						name="replyForm" id="replyForm">
						<strong>${session_user_name}(${session_user_id})</strong>&nbsp;&nbsp;
						<input type="hidden" name="user_id" id="user_id"
							value="${session_user_id}"> <input type="hidden"
							name="postNum" id="postNum" value="${map.boardDto.postNum}">
						<input type="checkbox" name="reSecret" id="reSecret" value="y">
						&nbsp;<span>비밀글 설정</span> <br> <input type="text"
							name="reContents" id="reContents"> <input type="button"
							id="replyBtn" value="등록">
					</form>
				</div> --%>

				<!-- 버튼 모음 -->
				<c:choose>
					<c:when test="${session_user_id eq map.boardDto.user_id}">
						<a
							href="/board/modify?postNum=${map.boardDto.postNum}&page=${map.page}"><div
								class="list_btn">수정</div></a>
						<div class="list_btn" id="deleteBtn"
							onclick="deleteBtn(${map.boardDto.postNum}, ${map.page})">
							<strong>삭제</strong>
						</div>
						<a
							href="/replyView?postNum=${map.boardDto.postNum}&page=${map.page}"><div
								class="list_btn">답변달기</div></a>
						<a href="/board/list?"><div class="list_btn">목록</div></a>
					</c:when>
					<c:otherwise>
						<a
							href="/replyView?postNum=${map.boardDto.postNum}&page=${map.page}"><div
								class="list_btn">답변달기</div></a>
						<a href="/board/list?page=${map.page}"><div class="list_btn">목록</div></a>
					</c:otherwise>
				</c:choose>

			</div>
		</div>
	</div>
</body>
</html>