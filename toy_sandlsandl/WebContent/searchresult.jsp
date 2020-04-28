<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$(".mntntr").on("click",function(){
			var thismCode = $(this).children().eq(0).text();
			var thismName = $(this).children().eq(1).text();
			
			location.href="FindController.do?command=findreview&mntn_name=" +thismName +"&mntn_code=" +thismCode;
		
		});
		
		
		$("form[name='searchForm']").on("submit",function(){
			if($(this).find("[name='mName']").val().length<1){
				alert("산명은 1글자 이상 입력해주세요");
				return false;
			}
		});
	});

</script>
</head>
<body>
	<div class="searchIn">
	<form action="FindController.do" method="get" name="searchForm">
	<input type="hidden" name="command" value="findmntn">
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
	<input type="text" name="mName">
	<input type="submit" value="찾기">
	<br>
	<input type="checkbox" name="is100" id="ish" value="Y"><label for="is100">100대 명산만 찾기</label> 
	<input type="checkbox" name="isclimb" id="isc" value="Y"><label for="isc">가본 산은 제외하고 찾기</label>

	</form>
	</div>
	<div class="searchList">
		<table border="1">
			<tr>
				<td colspan="3">
					총 <span class='important'>${scount}</span> 개의 검색결과가 있습니다. 
					<br>상세설명을 보시려면 산 정보를 클릭해주세요.
				</td>
			</tr>
			<tr>
				<th>산코드</th>
				<th>산이름</th>
				<th>위치</th>
				
			</tr>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="3">검색결과가 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="mDto">
						<tr class="mntntr">
							<td>${mDto.mntn_code}</td>
							<td>${mDto.mntn_name}</td>
							<td>${mDto.mntn_loc}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="3">
					<c:if test="${pmap.startPage != 1}">
						<a href="FindController.do?command=findmntn&mName=${mName}&mLoc=${mLoc}&pnum=1">&Lt;</a>
						<a href="FindController.do?command=findmntn&mName=${mName}&mLoc=${mLoc}&pnum=${pmap.prePageNum}">&lt;</a>
					</c:if>
					<c:forEach var="i" begin="${pmap.startPage}" end="${pmap.endPage}" step="1">
						<a href="FindController.do?command=findmntn&mName=${mName}&mLoc=${mLoc}&pnum=${i}"
							${i eq pnum ? 'style="font-weight:bold;"' : ''}
						>[${i}]</a>
					</c:forEach>
					<c:if test="${pnum != pcount}">
						<a href="FindController.do?command=findmntn&mName=${mName}&mLoc=${mLoc}&pnum=${pmap.nextPageNum}">&gt;</a>
						<a href="FindController.do?command=findmntn&mName=${mName}&mLoc=${mLoc}&pnum=${pcount}">&Gt;</a>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
<%@include file="footer.jsp" %>
</body>
</html>