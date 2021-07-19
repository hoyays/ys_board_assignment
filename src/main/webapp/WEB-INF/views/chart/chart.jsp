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
  				var ctx = document.getElementById("myChart").getContext('2d');
				/*
				- Chart를 생성하면서, 
				- ctx를 첫번째 argument로 넘겨주고, 
				- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
				*/
				var myChart = new Chart(ctx, {
				    type: 'bar',
				    data: {
				        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
				        datasets: [{
				            label: '# of Votes',
				            data: [12, 19, 3, 5, 2, 3],
				            backgroundColor: [
				                'rgba(255, 99, 132, 0.2)',
				                'rgba(54, 162, 235, 0.2)',
				                'rgba(255, 206, 86, 0.2)',
				                'rgba(75, 192, 192, 0.2)',
				                'rgba(153, 102, 255, 0.2)',
				                'rgba(255, 159, 64, 0.2)'
				            ],
				            borderColor: [
				                'rgba(255,99,132,1)',
				                'rgba(54, 162, 235, 1)',
				                'rgba(255, 206, 86, 1)',
				                'rgba(75, 192, 192, 1)',
				                'rgba(153, 102, 255, 1)',
				                'rgba(255, 159, 64, 1)'
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
  				
  			});
  		
  		
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
						<h1>Chart 페이지</h1>
					</div>
					<div id="contents_area">
						<h1>Chart 통계 출력 Area</h1>
						<canvas id="myChart"></canvas>
							
							
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