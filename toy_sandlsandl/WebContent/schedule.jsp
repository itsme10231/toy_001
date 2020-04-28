<%@page import="java.util.Map"%>
<%@include file="header.jsp" %>
<%@page import="com.sandl.dtos.LoginDto"%>
<%@page import="com.sandl.dtos.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@page import="com.sandl.daos.MntDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.sandl.utils.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.dayTd{width: 100px; height: 100px;}

	.sdate{background-color: NavajoWhite;}
	.mdate{background-color: BlanchedAlmond;}
	.edate{background-color: NavajoWhite;}

</style>
<script type="text/javascript">

	$(function(){
		$(".dayTd").on("click",function(){
			var thisVal = $(this).find("input[type='hidden']").val();

			if($(this).find("p").hasClass("addsch")){
				location.href="addsch.jsp?yyyyMMdd="+thisVal;
			}else{
				location.href="PostController.do?command=getschdetail&seq="+thisVal;
			}
		});
	});

</script>
</head>
<body>
<%
	Util util = new Util();
	
	String pYear = request.getParameter("year");
	String pMonth = request.getParameter("month");
	String id = ((LoginDto)session.getAttribute("ldto")).getId();

	//Calendar 객체는 getInstance 메서드를 통해서만 사용 가능하다(new 사용 불가)
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR); //현재 연도 구하기
	int month = cal.get(Calendar.MONTH) +1; //month는 0부터 시작하기 때문에 +1을 해야함
	
	if(pYear != null) {
		util.setCookie("pYear", pYear, response);
		year = Integer.parseInt(pYear);
	}
	
	if(pMonth != null) {
		util.setCookie("pMonth", pMonth, response);
		month = Integer.parseInt(pMonth);
	}
	
	//month가 1보다 작거나 12보다 클 경우의 값 처리
	if(month > 12) {
		year++;
		month = 1;
	}else if (month < 1){
		year--;
		month = 12;
	}
	
	//현재 달의 1일에 대한 요일 구하기
	//해당달의 1일로 Calendar 객체 설정하기
	cal.set(year, month-1, 1); //month에 1을 더했기 때문에 api에 대입할 때는 다시 1을 빼야함
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); //현재 날짜의 요일을 표시 | 일요일 1 ~ 토요일 7
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH); //해당 월의 날짜 중 최댓값을 구함
	
	MntDao dao = new MntDao();
	String yyyyMM = year +Util.isTwo(month+"");
	List<ScheduleDto> list = dao.getScheduleList(yyyyMM, id);
	
	//EL에서 꺼내쓰기 위해 자바 변수를 pageScope객체에 담아놓을 수 있다
%>

<div id="container">
<h1>일정보기(달력)</h1>
<table border="1">
	<caption>
		<a href="schedule.jsp?year=<%=year-1%>&month=<%=month%>">&Lt;</a>
		<a href="schedule.jsp?year=<%=year%>&month=<%=month-1%>">&lt;</a>
		<span class="yearNum"><%=year %></span>년 <span class="monthNum"><%=month %></span>월
		<a href="schedule.jsp?year=<%=year%>&month=<%=month+1%>">&gt;</a>
		<a href="schedule.jsp?year=<%=year+1%>&month=<%=month%>">&Gt;</a>
	</caption>
	<tr>
		<th>일</th>
		<th>월</th>
		<th>화</th>
		<th>수</th>
		<th>목</th>
		<th>금</th>
		<th>토</th>
	</tr>
	<tr>
	<%
		for(int i = 0; i < dayOfWeek-1; i++){
			//테이블에 공백수 출력하기
			out.print("<td>&nbsp;</td>");
		}
		
		for(int i = 1; i <= lastDay; i++) {
			//날짜 출력하기
			Map<String, String> map = Util.getCalView(list, year, month, i);
			String titleList = map.get("titleList");
			%>
			<td class="dayTd">
				<%=i %>
				<%=titleList.equals("")?
						"<input type='hidden' name='thisval' value='"+year+Util.isTwo(month+"")+Util.isTwo(i+"")+"'>"
						+"<p class='addsch'>일정 추가하기</p>":
						"<input type='hidden' name='thisval' value='"+map.get("seq")+"'>"	
						+titleList %>
			</td>
			<%
			if((i+(dayOfWeek-1))%7 == 0){
				out.print("</tr><tr>");
			}
		}
		
		int nbsp = (7 -(dayOfWeek-1 +lastDay)%7)%7;
		for(int i = 1; i <= nbsp; i++) {
			out.print("<td>&nbsp;</td>");
		}
	%>
	</tr>
</table>
</div>
<%@include file="footer.jsp" %>
</body>
</html>