<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<style type="text/css">
	#wrap { position: absolute; /* */
			left: 50%;
			transform: translate(-50%, 0);
			width:70%; 
			min-width: 600px; 
			max-width: 2000px; 
			min-height: 90%;
			}
	#memberfield{clear: left; text-align: right;}
	#loginfield{clear: left; text-align: right;}
	div{border: 1px solid red; margin: 0px; padding: 0px; box-sizing: border-box;}
	header{background-color: white; text-align: center; height: 150px; margin: 0px;}
	header>h1{display: inline-block; color:white;}
	footer{text-align:center;}

	table{display: inline-block; border: 1px solid gray; margin: auto; border-collapse: collapse;}
	form{display: inline-block;}
	a{text-decoration: none; color:black;}
	a:visited{color:black;}
	a:hover{color:darkgray;}
	
	#container{min-height: 500px;}
	#rankmnt{float:left; width: 100%; min-height: 500px;}
	#sidemain{width: 30%; float: right; min-height: 500px;}
	#sidemain:afer{clear: both; display: block; content: ''}
	#todaysmnt{min-height: 250px;}
	#mycal{min-height: 250px;}
	#searchfield{text-align: center;}
	
	.mntntr{cursor:pointer;}
	.mincal{margin:0px; box-sizing: border-box;}
	.dayTd{cursor: pointer;}
</style>
<script type="text/javascript">

	
	
</script>
</head>
<body>
<c:if test="${msg != null}">
	<script type="text/javascript">
		alert("${msg}");
	</script>
</c:if>
<header>
	<h1><a href="index.jsp">SANDLE</a></h1>
	
</header>
<div id="wrap">
	<c:choose>
		<c:when test="${sessionScope.ldto eq null}">
			<div id="loginfield">
			<form action="LoginController.do" method="post" name="loginform">
				<input type="hidden" name="command" value="login">
				아이디<input type="text" name="lid" required="required">
				비밀번호<input type="password" name="lpassword" required="required">
				<input type="submit" value="로그인">
				| <a href="regist.jsp">회원가입</a>
			</form> 
			</div>
		</c:when>
		<c:otherwise>
			<div id="memberfield">
				<span class="welcome">안녕하세요 ${ldto.name} 님!</span>
				<c:choose>
					<c:when test="${ldto.role eq 'ADMIN'}">
					회원정보 관리 | 웹페이지 설정 | <a href="LoginController.do?command=logout">로그아웃</a>						
					</c:when>
					<c:otherwise>
					<a href='schedule.jsp'>
					내 일정 보기
					</a>
					 | 
					<a href="PostController.do?command=mydiary"> 
					 나의 등산기록 보기
					</a>
					 | 
					<a href="myinfo.jsp"> 
					 회원정보 관리
					</a>
					 | <a href="LoginController.do?command=logout">로그아웃</a>
					</c:otherwise>
				</c:choose>
			</div>	
		</c:otherwise>
	</c:choose>
