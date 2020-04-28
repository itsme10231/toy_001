<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.mypagediv{float: left; width:33.3%; min-width:300px;}
</style>

</head>
<body>
	<div id="container">
		<div id="wishfield" class="mypagediv">
			<h3>가고 싶어요!(즐겨찾기)</h3>
			<table>
				<tr>
					<th>산이름</th>
					<th>산코드</th>
				</tr>
				<c:forEach items="${wlist}" var="wdto">
				<tr>
					<td>
						${wdto.mntdto.mntn_loc} ${wdto.mntdto.mntn_name}
					</td>
					<td>${wdto.mntn_code}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		
		<div id="climbfield" class="mypagediv">
			<h3>이런 산을 가보셨네요!</h3>
			<table>
				<tr>
					<th>산이름</th>
					<th>산코드</th>
					<th>등반횟수</th>
				</tr>
				<c:forEach items="${clist}" var="cdto">
				<tr>
					<td>
						${cdto.mntdto.mntn_loc} ${cdto.mntdto.mntn_name}
					</td>
					<td>${cdto.mntdto.mntn_code}</td>
					<td>${cdto.climbc}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		
		<div id="schfield" class="mypagediv">
			<h3>후기를 작성하지 않은 일정이 있습니다.</h3>
			<table>
				<tr>
					<th>산이름</th>
					<th>등반일</th>
				</tr>
				<c:forEach items="${slist}" var="sdto">
				<tr>
					<td>
						${sdto.mntdto.mntn_loc} ${sdto.mntdto.mntn_name}
					</td>
					<td>
						<c:choose>
							<c:when test="${sdto.sdate eq sdto.edate}">
								${sdto.sdate}
							</c:when>
							<c:otherwise>
								${sdto.sdate} ~ ${sdto.edate}
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>

<%@include file="footer.jsp" %>
</body>
</html>