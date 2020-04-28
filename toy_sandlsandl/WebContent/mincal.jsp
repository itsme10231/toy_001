<%@page import="java.util.Map"%>
<%@page import="com.sandl.dtos.LoginDto"%>
<%@page import="com.sandl.daos.MntDao"%>
<%@page import="com.sandl.dtos.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@page import="com.sandl.utils.Util"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.mincal tr td:first-child{color:red;}
	.mincal tr td:last-child{color:red;}
</style>
<script type="text/javascript">
	$(function(){
		$("select[name=sel]").on("change",function(){
			var selects = $(this).parent().children();
			var selyear = selects.eq(0).val();
			var selmonth = selects.eq(1).val();
			
			$.ajax({
				url:"PostController.do",
				data:{"command":"ajaxCalendar","selyear":selyear,"selmonth":selmonth},
				method:"post",
				dataType:"html",
				success:function(result){
					$(this).parent("table").find(".datesT").replaceWith(result);
				},
				error: function(){
					console.log("ajaxError");
				}
			});
		});
		
		$(".days").on("click",function(){
			
		});
	});

</script>
</head>
<body>
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	String id = ldto.getId();
	
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) +1;
	
	cal.set(year, month-1, 1);
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	//스케쥴 화면에 달력 두개 출력, 일정이 있는 일자에는 체크 못함, 시작일보다 전의 날짜나 종료일보다 후의 날짜에는 체크 못함
	//ajax를 통해 서버단에서 달력을 가져온다?
	
	MntDao dao = new MntDao();
	String yyyyMM = year +Util.isTwo(month+"");
	List<ScheduleDto> list = dao.getScheduleList(yyyyMM, id);
	
%>	
<table class="mincal" border="1">
	<tr>
		<td>
			<select name="selyear">
				<c:forEach begin="${year-5}" end="${year+5}" var="i">
					<option 
						<c:if test="${year eq i}">selected="selected"</c:if>
					value="${i}">${i}년</option>
				</c:forEach>
			</select>
			<select name="selmonth">
				<c:forEach begin="1" end="12" var="i">
					<option 
						<c:if test="${month eq i}">selected="selected"</c:if>
					value="${i}">${i}월</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<th colspan="7" class="mincalMonth"><%=year %>. <%=month %></th>
	</tr>
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
		<td colspan='7'>
			<table class="datesT">
				<tr>
				<%
					for(int i = 0; i < dayOfWeek-1; i++){
						out.print("<td>&nbsp;</td>");
					}
					
					for(int i = 1; i <= lastDay; i++){
						Map<String, String> map = Util.getCalView(list, year, month, i);
						String titleList = map.get("titleList");
						%>
						<td class="days <%=map.get("titleList").equals("")? "poss" : "imposs" %>"><%=i %></td>
						<%
						if((i+(dayOfWeek-1))%7 == 0){
							out.print("<tr></tr>");
						}
					}
					
					int nbsp = (7 -(dayOfWeek-1 +lastDay)%7)%7;
					for(int i = 1; i <= nbsp; i++) {
						out.print("<td>&nbsp;</td>");
					}
				%>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>