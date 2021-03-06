<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>일반게시판 - 게시물 등록현황</title>
  		<link rel="stylesheet" href="../css/chart/chart.css">
  		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  		<script type="text/javascript">
  			
  			$(document).ready(function(){
  				
  				//오늘날짜 저장
  				let today = new Date();
  				$("#today").val(dateToString(today));
  				
  				//default - 일별 데이터
  				dateChk();   //날짜
  				perDay($("#today").val());    //일자별 챠트
  			});//jQuery
  		
  			
  			
  			//날짜 선택 이동
  			function dateChk(choice){
  				
  				var now;  //화면 출력용
  				var saveNow;  //저장용
  				
  				
				if(choice == null || choice== ""){
					saveNow = dateToString();   //20210701형태(String)로 변경(저장용)
					now = dateToPrint(saveNow); //2021.07.01 형태로 변경(출력용)
					
	  				
				}else if(choice == 'pre'){

					var str = $("#saveNow").val();
					var y = str.substr(0,4);
					var m = str.substr(4,2);
					var d = str.substr(6,2);
					
					var pre = new Date(y, m-1, d-1);  //날짜 Date()로 변경하여 이전날짜 구하기
					saveNow = dateToString(pre);      //20210701형태(String)로 변경
					now = dateToPrint(saveNow);
					
					perDay(saveNow);
					
				}else if(choice == 'next' && $("#today").val() != $("#saveNow").val()){
					var str = $("#saveNow").val();
 					var y = str.substr(0,4);
 					var m = str.substr(4,2);
 					var d = str.substr(6,2);
 					str = str.slice(0,4)+"-"+str.slice(4,6)+"-"+str.slice(6,);
 					
 					var next = new Date(str);  //날짜 Date()로 변경하여 다음날짜 구하기
 					next.setDate(next.getDate()+1);
 					saveNow = dateToString(next);      //20210701형태(String)로 변경
 					now = dateToPrint(saveNow);
 					
					perDay(saveNow);
 					
				}else if(choice == 'next' && $("#today").val() == $("#saveNow").val()){
					alert("오늘 이후의 날짜로는 이동이 불가합니다.");
					saveNow = dateToString(new Date());
					now = dateToPrint(saveNow);
					
				}
				$("#saveNow").val(saveNow);
				$("#selectedDate").text(now);
  			}//dateChk()
  			
  			
  			
  			
  			//월 선택 이동
  			function monthChk(choice){
  				
  				var nowMonth;  //화면 출력용
  				var saveNowMonth;  //저장용
  				
				if(choice == null || choice== ""){
					saveNowMonth = dateToString();   //202107형태(String)로 변경(저장용)
					nowMonth = dateToPrint(saveNowMonth).substr(0,8); //2021.07. 형태로 변경(출력용)
					
				}else if(choice == 'pre'){
					
					var str = $("#saveNowMonth").val();
					var y = str.substr(0,4);
					var m = str.substr(4,2);
					var d = str.substr(6,2);
					
					var pre = new Date(y, m-1, d-30);  //날짜 Date()로 변경하여 1개월 전 날짜 구하기
					saveNowMonth = dateToString(pre);      //20210701형태(String)로 변경
					nowMonth = dateToPrint(saveNowMonth).substr(0,7);
					
					perMonth(saveNowMonth);
					
				}else if(choice == 'next' && $("#today").val() != $("#saveNowMonth").val()){
					var str = $("#saveNowMonth").val();
 					var y = str.substr(0,4);
 					var m = str.substr(4,2);
 					var d = str.substr(6,2);
 					str = str.slice(0,4)+"-"+str.slice(4,6)+"-"+str.slice(6,);
 					
 					var next = new Date(str);  //날짜 Date()로 변경하여 1개월 후 구하기
 					next.setDate(next.getDate()+30);
 					saveNowMonth = dateToString(next);      //20210701형태(String)로 변경
 					nowMonth = dateToPrint(saveNowMonth).substr(0,7);
 					
					perMonth(saveNowMonth);
 					
				}else if(choice == 'next' && $("#today").val() == $("#saveNowMonth").val()){
					alert("오늘 이후의 날짜로는 이동이 불가합니다.");
					saveNowMonth = dateToString(new Date());
					nowMonth = dateToPrint(saveNowMonth).substr(0,7);
					
				}
				$("#saveNowMonth").val(saveNowMonth);
				$("#selectedMonth").text(nowMonth);
  				
  				
  			}//monthChk()
  			
  			
  			
 			
  			//날짜 Date() ==> 20210701형태(String)로 변경
  			function dateToString(reqData){
  				
  				let changeResult;
  				
  				if(reqData == null || reqData == ""){
  					changeResult = new Date();
  				}else {
  					changeResult = new Date(reqData);
  				}//if
  				
  				
  				let year = changeResult.getFullYear(); // 년도
 				let month = changeResult.getMonth() + 1;  // 월
 				if(month < 10){
 					month = "0"+month;
 				}
 				let date = changeResult.getDate();  // 날짜
 				if(date < 10){
 					date = "0"+date;
 				}
  				
  				var result = year+""+month+""+date;
  				
  				return result;
  			}//dateToString()
  			
  			
  			
  			//20210701 ==> 2021.07.01. 형태로 변경(출력용)  
  			//단, reqData  ==> 20210701 형태로 들어와야 함
  			function dateToPrint(reqData){
  				
  				var y = reqData.substr(0,4);
				var m = reqData.substr(4,2);
				var d = reqData.substr(6,2);
				
				var result = y+"."+m+"."+d+".";
  				return result;
  				
  			}//dateToPrint()
  			
  			
  			
  			
  			//차트 그리기 함수
  			function mkChart(ctx, type, labels, title, data){
  					
				var myChart = new Chart(ctx, {
				    type: type,
				    data: {
				        labels: labels,
				        datasets: [{
				            label: title,
				            data: data,
				            backgroundColor: [
				                'rgba(255, 99, 132, 0.2)',
				                'rgba(255, 159, 64, 0.2)',
				                'rgba(255, 205, 86, 0.2)',
				                'rgba(75, 192, 192, 0.2)',
				                'rgba(54, 162, 235, 0.2)',
				                'rgba(153, 102, 255, 0.2)',
				                'rgba(201, 203, 207, 0.2)'
				            ],
				            borderColor: [
				                'rgb(255, 99, 132)',
				                'rgb(255, 159, 64)',
				                'rgb(255, 205, 86)',
				                'rgb(75, 192, 192)',
				                'rgb(54, 162, 235)',
				                'rgb(153, 102, 255)',
				                'rgb(201, 203, 207)'
				            ],
				            borderWidth: 1
				        }]//datasets
				    },//data
				    options: {
				        maintainAspectRatio: false, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
				        scales: {
				            yAxes: [{
				                ticks: {
				                    beginAtZero:true
				                }
				            }]
				        }
				    }//options
				});//new Chart()
  			}//mkChart()
  			
  			
  			
  			
  			
  			//일별 확인
  			function perDay(reqDate){
  				
				$("#chart_area").html("<canvas id='myChartPerDay'></canvas>");
  				
  				
  				//버튼 클릭 시 배경색 변경
  				$(".perDay").addClass("checked");
  				$(".perMonth").removeClass("checked");
  				
  				//일별, 월별 날짜 부분
  				$("#dayChk").show();
  				$("#monthChk").hide();
  				
  				
  				//일별, 월별 canvas - show/hide
  				$("#myChartPerDay").show();
  				$("#myChartPerMonth").hide();
  				
  				
  				//일별 차트 그리기 ajax
  				$.post(
  					'/chart/doChartPerDay',
  					{
  						selectedDate:reqDate,
  						kind:"general"
  					},
  					function(data){
  						console.log(data);
  						
  						//ctx
  						var ctx = $("#myChartPerDay");
  						
  						//type
  						var type = 'bar';
  						
  						//data - labels
  						var labels = [];
  						for(var i=6; i>=0; i--){
  							labels.push(data.list[i].resultDate.substr(4,2)+"월 "+data.list[i].resultDate.substr(6,2)+"일");
  						}
  						//console.log(labels);
  						
  						//data - datasets - title
  						var title = '일별 게시물 등록 현황';
  						
  						//data - datasets - data
  						var dataAll = [];
  						for(var i=6; i>=0; i--){
  							dataAll.push(data.list[i].boardCnt);
  						}
  						//console.log(dataAll);
  						
  						mkChart(ctx, type, labels, title, dataAll);
  						
  					},
  					'json'
  				);//ajax
  				
  			}//perDay()
  			
  			
  			
  			//월별 확인
  			function perMonth(reqDate){
  				
  				if(reqDate == null || reqDate == ""){
  					reqDate = $("#today").val();
  				}
  				monthChk();
  				
				$("#chart_area").html("<canvas id='myChartPerMonth'></canvas>");
  				
  				//버튼 클릭 시 배경색 변경
  				$(".perDay").removeClass("checked");
  				$(".perMonth").addClass("checked");
  				
  				//일별, 월별 날짜 부분
  				$("#monthChk").show();
  				$("#dayChk").hide();
  				
  				//일별, 월별 canvas - show/hide
  				$("#myChartPerDay").hide();
  				$("#myChartPerMonth").show();
  				
  				//월별 차트 그리기 ajax
  				$.post(
  					'/chart/doChartPerMonth',
  					{
  						selectedDate:reqDate,
  						kind:"general"
  					},
  					function(dataMonth){
  						
  						console.log(dataMonth);
  						
  						//ctx
  						var ctx = $("#myChartPerMonth");
  						
  						//type
  						var type = 'bar';
  						
  						//data - labels
  						var labels = [];
  						for(var i=6; i>=0; i--){
  							//labels.push(dataMonth.list[i].resultDate.substr(2,4));
  							labels.push(dataMonth.list[i].resultDate.substr(2,2)+"년 "+dataMonth.list[i].resultDate.substr(4,2)+"월");
  						}
  						console.log(labels);
  						
  						//data - datasets - title
  						var title = '월별 게시물 등록 현황';
  						
  						//data - datasets - data
  						var dataAll = [];
  						for(var i=6; i>=0; i--){
  							dataAll.push(dataMonth.list[i].boardCnt);
  						}
  						console.log(dataAll);
  						
  						mkChart(ctx, type, labels, title, dataAll);
  						
  					},
  					'json'
  				);//ajax
  			}//perMonth()
  		</script>
	</head>
	<body>
	<input type="hidden" id="saveNow" name="saveNow"> <!-- 일별 확인용 : 1일 단위로 변경 -->
	<input type="hidden" id="saveNowMonth" name="saveNowMonth">  <!-- 월별 확인용 : 30일 단위로 변경 -->
	<input type="hidden" id="today" name="today">
	
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				<!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp"%>
				</div>
				<div id="board_outline">
					<div id="title_area">
						<h2><font color="red">일반</font> 게시판 - 게시물 등록 현황</h2> 
					</div>
					<div id="contents_area">
						<div id="search_area">
							<span id="dayChk">
								<span id="dayBefore">
									<a href="javascript:void(0)" onclick="dateChk('pre')">◀</a>
								</span>&nbsp;&nbsp;&nbsp;
								<span id="selectedDate"></span>
								<span id="dayAfter">
									<a href="javascript:void(0)" onclick="dateChk('next')">▶</a>
								</span>&nbsp;&nbsp;&nbsp;
							</span>
							<span id="monthChk">
								<span id="monthBefore">
									<a href="javascript:void(0)" onclick="monthChk('pre')"><<</a>
								</span>&nbsp;&nbsp;&nbsp;
								<span id="selectedMonth"></span>
								<span id="monthAfter">
									<a href="javascript:void(0)" onclick="monthChk('next')">>></a>
								</span>&nbsp;&nbsp;&nbsp;
							</span>
							
							<span id="searchBtn">
								<button class="perDay" onclick="perDay(saveNow.value)">일별</button>
								<button class="perMonth" onclick="perMonth(saveNowMonth.value)">월별</button>
							</span>
						</div>
						<div id="chart_area">
						
							<!-- Chart가 그려지는 영역 -->
							
						</div>
					</div>
					
					<!-- 목록버튼 -->
					<div id="btn_menu">
						<a href="/chartMain"><div class="list">Chart 목록</div></a>
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