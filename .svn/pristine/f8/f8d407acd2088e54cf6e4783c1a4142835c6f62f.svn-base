<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>AJAX게시판 - 댓글수ㆍ조회수</title>
		<link rel="stylesheet" href="../css/chart/chartAjax2.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		<script type="text/javascript">
		
			$(document).ready(function(){
				
				//오늘날짜 저장
				let today = new Date();
				$("#today").val(dateToString(today));
				
				
				//Default - 오늘날짜 기준 차트페이지 로딩
				monthChk();                            //차트 상단 날짜 출력
				chartMultiAxis($("#selected").val());  //차트그리기
				
				
				
			});//jQuery
			
			
			
			
			//월간 이동(좌,우 버튼)
			function monthChk(choice){
				
				var savaSelectedMonth;  //20220104 형태의 변수, 임시저장용
				var SelectedMonth;      //2022.01. 형태의 변수, 화면 출력용
				
				
				if(choice == null || choice == ""){
					savaSelectedMonth = dateToString();
					SelectedMonth= dateToPrint(savaSelectedMonth);
					
				}else if(choice == 'pre'){
					
					var str = $("#selected").val();
					var y = str.substr(0,4);
					var m = str.substr(4,2);
					var d = str.substr(6,2);
					
					var pre = new Date(y, m-1, d-30);  //날짜 Date()로 변경하여 1개월 전 날짜 구하기
					savaSelectedMonth = dateToString(pre);
					SelectedMonth = dateToPrint(savaSelectedMonth);
					
					chartMultiAxis(savaSelectedMonth);
					
					
				}else if(choice == 'next' && $("#today").val() != $("#selected").val()){
					
					var str = $("#selected").val();
					var y = str.substr(0,4);
 					var m = str.substr(4,2);
 					var d = str.substr(6,2);
 					str = str.slice(0,4)+"-"+str.slice(4,6)+"-"+str.slice(6,);
					
 					var next = new Date(str);  //날짜 Date()로 변경하여 1개월 후 날짜 구하기
 					next.setDate(next.getDate()+30);
 					savaSelectedMonth = dateToString(next);
 					SelectedMonth = dateToPrint(savaSelectedMonth).substr(0,8);
 					
 					chartMultiAxis(savaSelectedMonth);
					
				}else if(choice == 'next' && $("#today").val() == $("#selected").val()){
					
					alert("오늘 이후의 날짜로는 이동이 불가합니다.");
					savaSelectedMonth = dateToString(new Date());
					SelectedMonth = dateToPrint(savaSelectedMonth).substr(0,8);
					
				}//if
				
				
				$("#selected").val(savaSelectedMonth);
				$("#selectedMonth").text(SelectedMonth);
				
				
			}//monthChk()
			
			
			
			
			
			//날짜 - Date()타입을 String(20220104)형태로 변경
			function dateToString(reqData){
				
				let changeResult;
				
				if(reqData == null || reqData ==""){
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
			
			
			
			
			//String(20220104) 형태 → 출력용 String(2022.01.04)형태로 변경
			//단, 매개변수는 반드시 20220104(String) 형태로 들어와야 함
			function dateToPrint(reqData){
  				
  				var y = reqData.substr(0,4);
				var m = reqData.substr(4,2);
				var d = reqData.substr(6,2);
				
				var result = y+"."+m+".";
  				return result;
  				
  			}//dateToPrint()
  			
  			
  			
  			
  			//차트 데이터 확인
  			function chartMultiAxis(reqDate){
  				
  				$("#chart_area").html("<canvas id='myChartMultiAxis'></canvas>");
  				
  				//차트 그리기 ajax
  				$.post(
  					'/chart2/doChartMultiAxis',  						
  					{
  						selectedDate:reqDate,
  						kind: "ajax"
  					},
  					function(data){
  						console.log(data);
  						
  						 
  						//ctx
  						var ctx = $("#myChartMultiAxis");
  						
  						//type
  						var type1 = 'bar';
  						var type2 = 'line';
  						
  						//data - labels
  						var labels = [];
  						for(var i=6; i>=0; i--){
  							labels.push(data.listComment[i].resultDate.substr(2,2)+"년 "+data.listComment[i].resultDate.substr(4,2)+"월");
  						}
  						console.log(labels);
  						
  						
  						//data - datasets - title
  						var title_left  = '댓글수';
  						var title_right = '조회수';
  						
  						
  						//data - datasets - data
  						var data_left = [];
  						var data_right = [];
  						for(var i=6; i>=0; i--){
  							data_left.push(data.listComment[i].boardCnt);
  							data_right.push(data.listHitNum[i].boardCnt);
  						}
  						console.log(data_left);
  						console.log(data_right);
  						
  						mkChart(ctx, type1, type2, labels, title_left, title_right, data_left, data_right);
  						
  					},
  					'json'
  				);//ajax
  			}//chartMultiAxis()
  			
  			
  			
  			
  			
  			
  			
  			//차트 그리기 함수
  			function mkChart(ctx, type1, type2, labels, title_left, title_right, data_left, data_right){
  				
  				var myChart = new Chart(ctx, {
					type: type1,
					data: {
						labels: labels,            //x축 라벨링
						datasets: [{
							label: title_left,
							yAxisID: 'y-left',
							type: type1,            //bar
							data: data_left,
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
						},{
							label: title_right,
							yAxisID: 'y-right',
							type: type2,
							data: data_right,
							fill : false,         // 채우기 없음
  		                    lineTension : 0,      // 0이면 꺾은선 그래프, 숫자가 높을수록 둥글해짐
  		                    pointRadius : 5,      // 0이면 각 지점에 포인트 주지 않음, 숫자가 높을수록 포인트가 커짐
  		                    backgroundColor: 'rgb(255, 153, 0)',
  		                    borderColor: 'rgb(255, 153, 0)'
						}]//datasets
					},//data
  					options: {
  						//responsive: false,
  						maintainAspectRatio: false, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
  						scales: {
							'y-left': {
								type: 'linear',
								position: 'left',
								title: {
									display: true,
									text: title_left
								},
								ticks: {
									stepSize: 1         //y축 Left 숫자 간격
								},
								grid: {
									display: true
								}
							},
							'y-right': {
								type: 'linear',
								position: 'right',
								title: {
									display: true,
									text: title_right
								},
								ticks: {
									stepSize: 20        //y축 Right 숫자 간격
								},
								grid: {
									display: false
								}
							}
  						}//scales
  					}//options
  				});//new Chart()
  			}//mkChart()
  			
		
		
		</script>
	</head>
	<body>
	<input type="hidden" id="today" name="today">
	<input type="hidden" id="selected" name="selected">
	
		<c:choose>
			<c:when test="${session_flag eq 'success'}">
				<!-- header 추가 -->
				<div>
					<%@ include file="../header.jsp"%>
				</div>
				
				<div id="board_outline">
					<div id="title_area">
						<h2><font color="blue">AJAX</font> 게시판 - 댓글수ㆍ조회수</h2> 
					</div>
					<div id="contents_area">
						<div id="search_area">

							<!-- 월간 날짜 -->
							<span id="monthChk">
								<span id="monthBefore">
									<a onclick="monthChk('pre')">◀</a>
								</span>&nbsp;&nbsp;&nbsp;
								<span id="selectedMonth"></span>
								<span id="monthAfter">
									<a onclick="monthChk('next')">▶</a>
								</span>&nbsp;&nbsp;&nbsp;
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