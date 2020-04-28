<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="header.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	$(function(){
		var address = "${ldto.address}".replace(":"," ");
		$(".addr").text(address);
	});
	
	function deluser(){
		location.href="LoginController.do?command=deluser";
	}
</script>
</head>
<body>

	<table>
		<tr>
			<th>ID</th>
			<td>${ldto.id}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${ldto.name}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${ldto.email}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td class="addr"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" onclick="location.href='infoupdate.jsp'" value="회원정보 수정하기"><input type="button" value="탈퇴하기" onclick="deluser()">
			</td>
		</tr>
	
	
	</table>

<%@include file="footer.jsp" %>
</body>
</html>