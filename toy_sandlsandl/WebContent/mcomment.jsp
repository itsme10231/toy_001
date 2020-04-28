<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var jsonTest = {test:"testval"};
	
	function test() {
		console.log(jsonTest.test);
	}

</script>

</head>
<body>
<button onclick="test()">test</button>
</body>
</html>