<%@page import="java.util.Map"%>
<%@page import="com.sandl.dtos.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@page import="com.sandl.daos.MntDao"%>
<%@page import="com.sandl.dtos.LoginDto"%>
<%@page import="com.sandl.utils.Util"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.imposs{color:"lightgray";}
</style>

<script type="text/javascript">
	$(function(){
		
		var dest = $("select[name=searchresult]");
		
		$("input[name='search']").on("click",function(){
			
			var mLoc = $("select[name='mLoc']").val();
			var mName = $("input[name='mName']").val();

			if(mName.length < 1){
				alert("산명은 한글자 이상 입력해주세요!");
			}else {
				$.ajax({
					url:"FindController.do",
					data:{"command":"findmntnAjax","mLoc":mLoc,"mName":mName},
					dataType:"json",
					method: "post",
					success: function(jArr){
						console.log("통신성공");
						dest.children().remove();

						if(jArr.length == 0){
							dest.attr("size",2);
							var opt = "<option value='0'>검색결과 없음</option>"
							dest.append(opt);
						}else{
							dest.attr("size",5);
							for(var i = 0; i < jArr.length; i++){
								var opt = "<option value='"+jArr[i].mntn_code+"'>"+jArr[i].mntn_loc +" " +jArr[i].mntn_name+"</option>"
								dest.append(opt);
							}
						}
					},
					error: function(){
						console.log("통신 실패");
					}
				});
			}
			
		});
		
		$("input[name='wishlist']").on("click",function(){
			var id = $("input[name='id']").val();
			
			//ajax처리로 나의 위시리스트 가져오기
			$.ajax({
				url:"PostController.do",
				data:{"command":"getwishAjax","id":id},
				dataType:"json",
				method:"post",
				success: function(jArr){
					console.log("통신성공");
					dest.children().remove();

					if(jArr.length == 0){
						dest.attr("size",2);
						var opt = "<option value='0'>등록된 가고 싶은 산이 없습니다.</option>"
						dest.append(opt);
					}else{
						dest.attr("size",5);
						for(var i = 0; i < jArr.length; i++){
							var opt = "<option value='"+jArr[i].mntdto.mntn_code+"'>"+jArr[i].mntdto.mntn_loc +" " +jArr[i].mntdto.mntn_name+"</option>"
							dest.append(opt);
						}
					}
				},
				error: function(){
					console.log("통신 실패");
				}
				
			});
		});
		
		$("input[name='searchlist']").on("click",function(){
			$(".searchfield").toggle();
		});
		
		
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
					console.log(result);
					$(this).closest("table").children(".datesT").replaceWith("<h1>dd</h1>");
				},
				error: function(){
					console.log("ajaxError");
				}
			});
		});
		
		$(".poss").on("click",function(){
			$(this).toggleClass("selday");
			
			
			var year = $(this).closest(".mincal").find("input[name='year']").val();
			var month = $(this).closest(".mincal").find("input[name='month']").val();
			var day = $(this).text();
			
			var daytds = $(this).parent("table").find(".days");
			
			if(year +month +daytds.text()){
				
			}
		});
	}); //onload 종료
	
	
</script>
</head>
<body>
<%
	Util util = new Util();
	String yyyyMMdd = request.getParameter("yyyyMMdd");
	String schflag = request.getParameter("schflag");
	
	String mntn_code = "";
	String mntn_name = "";
	String mntn_loc = "";
	
	if(schflag!=null){
		pageContext.setAttribute("schflag", (schflag.equals("Y")?"true":"false"));
		
		mntn_code = request.getParameter("mntn_code");
		mntn_name = request.getParameter("mntn_name");
		mntn_loc = request.getParameter("mntn_loc");
		
	}
	
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	String id = ldto.getId();
	
	Calendar cal = Calendar.getInstance();
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	String day = yyyyMMdd.substring(6);
	
	pageContext.setAttribute("year", year);
	pageContext.setAttribute("month", month);
	
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	//스케쥴 화면에 달력 두개 출력, 일정이 있는 일자에는 체크 못함, 시작일보다 전의 날짜나 종료일보다 후의 날짜에는 체크 못함
	//ajax를 통해 서버단에서 달력을 만들어서 가져온다?
	
	MntDao dao = new MntDao();
	String yyyyMM = yyyyMMdd.substring(0,6);
	List<ScheduleDto> list = dao.getScheduleList(yyyyMM, id);
	
	String today = util.getCookie("today", request).getValue();
	pageContext.setAttribute("today", today);
	
	//schflag는 산 디테일 페이지에서 온 것인지를 판단
	//=>schflag가 존재할 경우 산 선택기능은 표시되지 않음
	//=>갈 예정이에요로 왔을시 N, 코멘트 작성후 왔을시 Y
	//=>Y일 경우 시작일과 종료일은 오늘의 날짜보다 뒤로 갈수 없음
%>
<div id="container">
<h1>일정 추가하기</h1>
<form action="PostController.do" method="post">
<input type="hidden" name="command" value="writesch" />
<input type="hidden" name="id" value="${ldto.id}" />
<table>
	<tr>
		<th>가는 날짜</th>
		<td>
			<table class="mincal" border="1">
				<tr>
					<td>
						<select name="sel">
							<c:forEach begin="${year-5}" end="${year+5}" var="i">
								<option 
									<c:if test="${year eq i}">selected="selected"</c:if>
								value="${i}">${i}년</option>
							</c:forEach>
						</select>
						<select name="sel">
							<c:forEach begin="1" end="12" var="i">
								<option 
									<c:if test="${month eq i}">selected="selected"</c:if>
								value="${i}">${i}월</option>
							</c:forEach>
						</select>
						<input type="hidden" name="year" value="<%=year%>">
						<input type="hidden" name="month" value="<%=month%>">
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
									<td class="days <%=map.get("titleList").equals("")? "poss" : "imposs" %> <%=String.valueOf(i).equals(day)?"selday":""%>"><%=i %></td>
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
			<input type="hidden" name="sdate" value="">
		</td>
	</tr>
	
	<tr>
		<th>오는 날짜</th>
		<td>
			<table class="mincal" border="1">
				<tr>
					<td>
						<select name="sel">
							<c:forEach begin="${year-5}" end="${year+5}" var="i">
								<option 
									<c:if test="${year eq i}">selected="selected"</c:if>
								value="${i}">${i}년</option>
							</c:forEach>
						</select>
						<select name="sel">
							<c:forEach begin="1" end="12" var="i">
								<option 
									<c:if test="${month eq i}">selected="selected"</c:if>
								value="${i}">${i}월</option>
							</c:forEach>
						</select>
						<input type="hidden" name="year" value="<%=year%>">
						<input type="hidden" name="month" value="<%=month%>">
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
									<td class="days <%=map.get("titleList").equals("")? "poss" : "imposs" %> <%=String.valueOf(i).equals(day)?"selday":""%>"><%=i %></td>
									<%
									if((i+(dayOfWeek-1))%7 == 0){
										out.print("<tr></tr>");
									}
								}
								
								nbsp = (7 -(dayOfWeek-1 +lastDay)%7)%7;
								for(int i = 1; i <= nbsp; i++) {
									out.print("<td>&nbsp;</td>");
								}
							%>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="edate" value="">
		</td>
	</tr>
	
	<tr>
		<th>목적지</th>
		<td>
			<%
			if(schflag==null){
				%>
				<input type="button" value="산 목록에서 검색해서 찾기" name="searchlist">
				<input type="button" value="내가 가고 싶은 산에서 찾기" name="wishlist">
				<%
			}
			%>
		</td>
	</tr>
	<tr>
		<td colspan="2" class="searchfield" style="display:none">
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
						<input type="button" name="search" value="찾기"><br>
						
					</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" name="is100" id="ish" value=""><label for="ish">100대 명산만 찾기</label> 
						<input type="checkbox" name="isclimb" id="isc" value=""><label for="isc">가본 산은 제외하고 찾기</label>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			
			<%
			if(schflag!=null){
				%>
				<input type="hidden" name="searchresult" value="<%=mntn_loc+" "+mntn_name%>">
				<%=mntn_loc+" "+mntn_name%>
				<%
			}else {
				%>
				<select name="searchresult" size="2"></select>
				<%
			}
			%>
			
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="mcontent"></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			이 일정을 다른 사람도 볼 수 있게 할까요? <input type="radio" name="pubflag" value="Y">예 <input type="radio" name="pubflag" value="N" checked="checked">아니오
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="일정추가">
			<input type="button" value="돌아가기" onclick="location.href='PostController.do?command=getschlist${refererQuery}'">
		</td>
	</tr>
</table>
</form>
</div>
<%@include file="footer.jsp" %>
</body>
</html>