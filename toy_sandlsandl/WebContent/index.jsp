<%@page import="java.io.PrintWriter"%>
<%@page import="com.sandl.utils.Util"%>
<%@page import="java.util.Calendar"%>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

</style>
<script type="text/javascript">
	$(function(){
		$("form[name='searchForm']").on("submit",function(){
			if($(this).find("[name='mName']").val().length<1){
				alert("산명은 1글자 이상 입력해주세요");
				return false;
			}
		});
		$(".mincal").css({"width":$("#mycal").css("width"),"height":$("#mycal").css("height")});
		
		
		$.ajax({
			url:"FindController.do",
			data:{"command":"indexAjax"},
			dataType:"json",
			method:"post",
			success:function(json){
				
			},
			error:function(){
				
			}
		});
	});
</script>
</head>
<body>
<%
	Util util = new Util();	

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR); //현재 연도 구하기
	int month = cal.get(Calendar.MONTH) +1; //month는 0부터 시작하기 때문에 +1을 해야함
	int date = cal.get(Calendar.DATE);
	
	//오늘의 날짜가 속한 주의 월~오늘까지의 날짜
	
	
	String today = year +Util.isTwo(month+"") +Util.isTwo(date+"");
	//오늘의 날짜 쿠키에 담기
	util.setCookie("today", today, response);
	util.setParamCookie("pYear", year+"", request, response);
	util.setParamCookie("pMonth", month+"", request, response);
%>
	<div id="container">
		<div id="rankmnt">
			이 산이...
			
			좋아요
			가고 싶어요
			많이 갔어요
			(일주일 단위로 초기화)
			<br>
			슬라이딩 사용 예정
		</div>
	</div>
	<div id="searchField">
		<form action="FindController.do" method="get" name="searchForm">
			<input type="hidden" name="command" value="findmntn">
			<table>
				<tr>
					<td>
						지역:
						<select name="mLoc">
							<option value="all">모든 시도</option>
							<option value="11">서울</option>
							<option value="26">부산</option>
							<option value="27">대구</option>
							<option value="28">인천</option>
							<option value="29">광주</option>
							<option value="30">대전</option>
							<option value="31">울산</option>
							<option value="41">경기</option>
							<option value="42">강원도</option>
							<option value="43">충청북도</option>
							<option value="44">충청남도</option>
							<option value="45">전라북도</option>
							<option value="46">전라남도</option>
							<option value="47">경상북도</option>
							<option value="48">경상남도</option>
							<option value="49">제주</option>
						</select>
						산명: 
						<input type="text" name="mName">
						<input type="submit" value="찾기"><br>
						
					</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" name="is100" id="ish" value="Y"><label for="is100">100대 명산만 찾기</label> 
						<input type="checkbox" name="isclimb" id="isc" value="Y"><label for="isc">가본 산은 제외하고 찾기</label>
					</td>
				</tr>
			</table>
		</form>
	</div>

<%@include file="footer.jsp" %>
</body>
</html>