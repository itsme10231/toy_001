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
		
		$("input[type='date']").on("change",function(){
			var dinputs = $("input[type='date']");
			
			if(eval("${pageScope.schflag}")){
				if($(this).is("[name='sdate']")){ //sdate의 값이 변했을때
					
					dinputs.eq(1).attr("min",$(this).val());
					if(compareDate(dinputs.eq(1).val(),dinputs.eq(0).val())){
						dinputs.eq(1).val($(this).val());
					}
					
				}else{ //edate의 값이 변했을때
					
					dinputs.eq(0).attr("max",$(this).val());
					if(compareDate(dinputs.eq(1).val(),dinputs.eq(0).val())){
						dinputs.eq(0).val($(this).val());
					}
				}
			}else{
				if($(this).is("[name='sdate']")){ //sdate의 값이 변했을때
					dinputs.eq(1).attr("min",$(this).val());
					if(compareDate(dinputs.eq(1).val(),dinputs.eq(0).val())){
						dinputs.eq(1).val($(this).val());
					}
				}else{ //edate의 값이 변했을때
					dinputs.eq(0).attr("max",$(this).val());
					if(compareDate(dinputs.eq(1).val(),dinputs.eq(0).val())){
						dinputs.eq(0).val($(this).val());
					}
				}
			}
		});
	});
	
	function compareDate(date1, date2){
		return eval(replaceAll(date1,"-","")) <= eval(replaceAll(date2,"-","")) ? true: false;
	}
	
	function replaceAll(str, searchStr, replaceStr) {
		return str.split(searchStr).join(replaceStr);
	}
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
		pageContext.setAttribute("caldate", util.formDate(yyyyMMdd));
		pageContext.setAttribute("schflag", (schflag.equals("Y")?"true":"false"));
		
		mntn_code = request.getParameter("mntn_code");
		mntn_name = request.getParameter("mntn_name");
		mntn_loc = request.getParameter("mntn_loc");
		
	}else{
		pageContext.setAttribute("caldate", util.formDate(yyyyMMdd));
	}
	
	//schflag는 산 디테일 페이지에서 온 것인지를 판단
	//=>schflag가 존재할 경우 산 선택기능은 표시되지 않음
	//=>갈 예정이에요로 왔을시 N, 코멘트 작성후 왔을시 Y
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
			
			<input type="date" name="sdate" value="${pageScope.caldate}" ${pageScope.schflag eq null?'':'max='+pageScope.caldate}>
		</td>
	</tr>
	
	<tr>
		<th>오는 날짜</th>
		<td>
			<input type="date" name="edate" value="${pageScope.caldate}" ${pageScope.schflag eq null?'':'max='+pageScope.caldate}>
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
			<select name="searchresult" size="1">
			<%
			if(schflag!=null){
				%>
				<option value="<%=mntn_code%>" selected="selected"><%=mntn_loc+" "+mntn_name%></option>
				<%
			}
			%>
			</select>
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