<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>일반게시판</title>
  		<link rel="stylesheet" href="../css/chart/chart.css">
  		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  		<script type="text/javascript">
  			
  			$(document).ready(function(){
  				//default
  				dateChk();   //오늘 날짜
  				perDay();    //일자별 챠트 출력
  			});//jQuery
  		
  			
  			 			
  			
  			//선택 날짜 확인
  			function dateChk(choice){
  				
  				var now;  //화면 출력용
  				var saveNow;  //저장용
  				
  				if(choice == null || choice== ""){
  					saveNow = dateToString();   //20210701형태(String)로 변경
  					now = dateToPrint(saveNow);
  	  				
  				}else if(choice == 'pre'){

  					var str = $("#saveNow").val();
  					var y = str.substr(0,4);
  					var m = str.substr(4,2);
  					var d = str.substr(6,2);
  					
  					var pre = new Date(y, m-1, d-1);  //날짜 Date()로 변경하여 이전날짜 구하기
  					saveNow = dateToString(pre);      //20210701형태(String)로 변경
  					now = dateToPrint(saveNow);
  					
  				}else if(choice == 'next'){
  					
  					var str = $("#saveNow").val();
  					var y = str.substr(0,4);
  					var m = str.substr(4,2);
  					var d = str.substr(6,2);
  					str = str.slice(0,4)+"-"+str.slice(4,6)+"-"+str.slice(6,);
  					
  					var next = new Date(str);  //날짜 Date()로 변경하여 다음날짜 구하기
  					next.setDate(next.getDate()+1);
  					saveNow = dateToString(next);      //20210701형태(String)로 변경
  					now = dateToPrint(saveNow);
  				}
  				$("#saveNow").val(saveNow);
  				$("#selectedDate").text(now);
  			}//todayChk()
  			
  			
  			
  			
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
  				
  				var result = year+month+date;
  				
  				return result;
  			}//dateToString()
  			
  			
  			
  			
  			
  			//20210701 ==> 2021.07.01. 형태로 변경(출력용)  단, reqData  ==> 20210701 형태로 들어와야 함
  			function dateToPrint(reqData){
  				
  				var y = reqData.substr(0,4);
				var m = reqData.substr(4,2);
				var d = reqData.substr(6,2);
				
				var result = y+"."+m+"."+d+".";
  				return result;
  				
  			}//dateToPrint()
  			
  			
  			
  			
  			
  			//일별 확인
  			function perDay(){
  				//버튼 클릭 시 배경색 변경
  				$(".perDay").addClass("checked");
  				$(".perMonth").removeClass("checked");
  				
  				//일별, 월별 div - show/hide
  				$("#myChartPerDay").show();
  				$("#myChartPerMonth").hide();
  				
  				
  				
  				//일별 차트 그리기 ajax
  				$.post(
  					'/chart/doChartPerDay',
  					{
  						selectedDate:$("#saveNow").val()
  					},
  					function(data){
  						console.log(data);
  						
  						//DB에서 데이터를 가져와서
  						//데이터를 가공한 다음
  						//챠트를 그린다. ajax 안에서, 함수 호출 이용해서
  						
  						
  						
  					},
  					'json'
  				
  				
  				);//ajax
  				
  				
  				
  				
  				var ctx = $("#myChartPerDay");
				var myChart = new Chart(ctx, {
				    type: 'bar',
				    data: {
				        labels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
				        datasets: [{
				            label: '날짜별 게시물 등록 수',
				            data: [12, 19, 3, 5, 2, 3, 11],
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
				        }]
				    },
				    options: {
				        maintainAspectRatio: false, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
				        scales: {
				            yAxes: [{
				                ticks: {
				                    beginAtZero:true
				                }
				            }]
				        }
				    }
				});
  				
				
  			}//perDay()
  			
  			
  			//월별 확인
  			function perMonth(){
  				
  				//버튼 클릭 시 배경색 변경
  				$(".perMonth").addClass("checked");
  				$(".perDay").removeClass("checked");
  				
  				//일별, 월별 div - show/hide
  				$("#myChartPerDay").hide();
  				$("#myChartPerMonth").show();
  				
  				
  				//월별 - 챠트 그리기
  				/* var ctx = document.getElementById("myChartPerMonth").getContext('2d'); */
  				var ctx = $("#myChartPerMonth");
				var myChart = new Chart(ctx, {
				    type: 'bar',
				    data: {
				        labels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
				        datasets: [{
				            label: '월별 게시물 등록 수',
				            data: [5, 9, 8, 15, 12, 20, 11],
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
				        }]
				    },
				    options: {
				        maintainAspectRatio: false, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
				        scales: {
				            yAxes: [{
				                ticks: {
				                    beginAtZero:true
				                }
				            }]
				        }
				    }
				});
  				
  			}//perMonth()
  			
  			
  			
  			
  			//차트 그리기
  			function mkChart(ctx, type, labels, data, title){
  					
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
  			
  			
  		
  		</script>
	</head>
	<body>
	<input type="hidden" id="saveNow" name="saveNow">
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				<!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp"%>
				</div>
				<div id="board_outline">
					<div id="title_area">
						<h2>일반 게시판 - 게시물 등록 현황</h2> 
					</div>
					<div id="contents_area">
						<div id="search_area">
							<span id="dayBefore">
								<a href="javascript:void(0)" onclick="dateChk('pre')">◀</a>
							</span>&nbsp;&nbsp;&nbsp;
							<span id="selectedDate"></span>
							<span id="dayAfter">
								<a href="javascript:void(0)" onclick="dateChk('next')">▶</a>
							</span>&nbsp;&nbsp;&nbsp;
							<span id="searchBtn">
								<button class="perDay" onclick="perDay()">일별</button>
								<button class="perMonth" onclick="perMonth()">월별</button>
							</span>
						</div>
						<div id="chart_area">
							<canvas id="myChartPerDay"></canvas>
							<canvas id="myChartPerMonth"></canvas>
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