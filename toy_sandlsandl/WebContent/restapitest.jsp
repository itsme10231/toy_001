<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="header.jsp" %>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$("button[name='searchM']").on("click", function(){
			var searchVal = $("input[name='testIn']").val();
			
			$.ajax({
				url: "FindController.do",
				data: {"command":"findmntn", "searchWrd":searchVal},
				datatype: "xml",
				method: "post",
				success: function(result) {
					$(".testout").text(result);
				}
			});
		});
	});
	

</script>
</head>
<body>
<form action="FindController.do">
지역:
<select name="testSel">
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
<input type="text" name="testIn"><button type="button" name="searchM">찾기</button>
</form>
<div class="testout"></div>
</body>
</html>
<%@include file="footer.jsp"%>