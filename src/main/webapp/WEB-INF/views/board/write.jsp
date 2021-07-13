<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>글쓰기 페이지</title>
		<link rel="stylesheet" href="../css/board/write.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript" src="/js/ckeditor/ckeditor.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				
				//확인 버튼 클릭 시
				$("#confirm_btn").on("click", function(){
					
					//제목 확인
					if(!$("#title").val()){
						alert("제목을 입력해 주세요!");
						$("#title").focus();
						return false;
					}
					
					//내용 확인
					if(CKEDITOR.instances.contents.getData() == '' || CKEDITOR.instances.contents.getData().length == 0){
						alert("내용을 입력해 주세요!");
						$("#contents").focus();
						return false;
					}
					
					document.writeForm.submit();
				});
				
			})//jQuery
		</script>
		
	</head>
	<body>
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				<!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp" %>
				</div>
				<div id="board_outline">
					<div id="title_area">
						<c:choose>
							<c:when test="${map.boardDto eq null}">
								<h1>글쓰기</h1>	
							</c:when>
							<c:when test="${map.replyView eq '1'}">
								<h1>답변하기</h1>
							</c:when>
							<c:otherwise>
								<h1>수정하기</h1>
							</c:otherwise>
						</c:choose>
					</div>
					<hr>
					<div id="contents_area">
						<form action="${map.formAction}" name="writeForm" method="post" enctype="multipart/form-data">
							<table>
								<colgroup>
									<col width="15%">
									<col width="85%">
								</colgroup>
								<tbody>
									<tr>
										<th>작성자</th>
										<td>
											${session_user_name}
											<input type="hidden" name="user_id" id="user_id" value="${session_user_id}">
											<input type="hidden" name="originFileName" id="originFileName" value="${map.boardDto.originFileName}">
											<input type="hidden" name="fileSize" id="fileSize" value="${map.boardDto.fileSize}">
										</td>
									</tr>
									<tr>
										<th>제목</th>
										<td>
											<c:choose>
												<c:when test="${map.replyView ne '1'}">
													<input type="text" name="title" id="title" value="${map.boardDto.title}">
												</c:when>
												<c:otherwise>
													<input type="text" name="title" id="title">
												</c:otherwise>
											</c:choose>
											
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td>
											<textarea rows="10" cols="50" name="contents" id="contents">
												<c:choose>
													<c:when test="${map.replyView ne '1'}">
														${map.boardDto.contents}
													</c:when>
												</c:choose>
											</textarea>
											<!-- CKeditor 적용 -->
											<script type="text/javascript">
												//textarea와 CKeditor 연결
												CKEDITOR.replace('contents', {height: 500});  
											</script>
										</td>
									</tr>
									<tr>
										<th>이미지표시</th>
										<td>
											<c:choose>
												<c:when test="${map.boardDto.fileName ne null && map.replyView ne '1'}">
													<br>
													<img alt="" src="/upload/${map.boardDto.fileName}" width="300">
												</c:when>
											</c:choose> 
										</td>
									</tr>
									<tr>
										<th>이미지 첨부</th>
										<td>
											<input type="file" name="file" id="file" accept=".jpg, .png, .xlsx, .xls">
											<font color="red">※ .png, .jpg, .xlsx, .xls만 첨부가능</font>
										</td>
									</tr>
								</tbody>
							</table>
							<input type="hidden" name="fileName" id="fileName" value="${map.boardDto.fileName}">
							<input type="hidden" name="postNum" id="postNum" value="${map.boardDto.postNum}">
							<input type="hidden" name="groupNum" id="groupNum" value="${map.boardDto.groupNum}">
							<input type="hidden" name="indentNum" id="indentNum" value="${map.boardDto.indentNum}">
							<input type="hidden" name="stepNum" id="stepNum" value="${map.boardDto.stepNum}">
							<input type="hidden" name="page" id="page" value="${map.page}">
							<hr>
							<div id="btn_area">
								<a href="/board/list?page=${map.page}"><input type="button" value="취소" class="cancel_btn"></a>&nbsp;
								<input type="button" value="확인" class="confirm_btn" id="confirm_btn">
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