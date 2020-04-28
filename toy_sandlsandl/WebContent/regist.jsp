<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript">

	window.onload = function() {
		//form 태그에서 submit 전송 이벤트가 발생하는지 감지 => 패스워드 일치 확인
		var form = document.getElementsByName("regist")[0];
		var pwInputs = document.querySelectorAll(".regist input[type='password']");
		var idInput = document.querySelectorAll("input[name='id']")[0];
		

		
		pwInputs[1].onblur = function() {
			var pwMsg = document.getElementsByClassName("alertpw")[0];
			
			if(pwInputs[0].value != pwInputs[1].value){
				pwInputs[0].value = "";
				pwInputs[1].value = "";
				pwInputs[0].focus();

				pwMsg.innerHTML = "패스워드를 확인하세요."
			}else{

				pwMsg.innerHTML = "패스워드가 일치합니다."
			}
		}
		
		idInput.onkeyup = function() {
			var id = document.getElementsByName("id")[0];
			var regType = /^[a-z0-9+]{5,12}$/; 
			console.log("dd");
			if(!regType.test(id.value)){
				$("#idcheck").text("아이디는 5~14자 사이의 특수문자를 제외한 영소문자+숫자로 입력해 주세요.");
				$("#idcheck").attr("style","color:red;");
				$(id).attr("class", "n");
			}else {
				$.ajax({
					url: "LoginController.do",
					data: {"command":"idchk", "id":id.value},
					dataType: "json",
					method: "post",
					success: function(obj) {
						if(!obj){
							$("#idcheck").text("사용할 수 있는 아이디입니다.");
							$("#idcheck").attr("style","color:blue;");
							$(id).attr("class", "y");
							
						}else {
							$("#idcheck").text("사용할 수 없는 아이디입니다.");
							$("#idcheck").attr("style","color:red;");
							$(id).attr("class", "n");
						}
					},
					error: function() {
						$("#idcheck").text("다시 시도해주세요.");
					}
				});
			}
		}
		
		form.onsubmit = function() {
			if(pwInputs[0].value != pwInputs[1].value){
				alert("패스워드를 확인하세요!");
				pwInputs[0].value = "";
				pwInputs[1].value = "";
				pwInputs[0].focus();
				return false; //유효하지 않은 값이 존재하면 submit 전송기능 취소
			}else if(idInput.className == 'n'){
				alert("아이디 중복체크를 해주세요!");
				idInput.focus();
				return false;
			}else {
				
			}
		}
		
		$("#postcodify_search_button").postcodifyPopUp();
			
	}
	


</script>

<style type="text/css">
	.alertpw {
		color: red;
		font-size: 11px;
	}
	#idcheck{padding: 0; margin: 4px 0; font-size: 12px; color: blue;}
</style>
</head>
<body>
<div id="container">
<form action="LoginController.do" method="post" name="regist">
<input type="hidden" name="command" value="insertuser" />
<table class="regist">
	<tr>
		<th>아이디</th>
		<td>
			<input type="text" name="id" required="required" class="n">
			<p id="idcheck">&nbsp;</p>
		</td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text" name="name" required="required"></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" name="password" required="required"><span class="alertpw"></span></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" name="password2" required="required"></td>
	</tr>
	<tr>
		<th>우편번호</th>
		<td>
		    <input type="text" name="address1" class="postcodify_postcode5" value="" required="required"/>
			<button id="postcodify_search_button">검색</button>
		</td>
	</tr>
	<tr>
		<th>도로명주소</th>
		<td><input type="text" name="address2" class="postcodify_address" value="" required="required"/></td>
	</tr>
	<tr>
		<th>상세주소</th>
		<td>
			<input type="text" name="address3" class="postcodify_details" value="" />
		</td>
	</tr>

	<tr>
		<th>이메일</th>
		<td><input type="email" name="email" required="required"></td>
	</tr>
	<tr>
		<td colspan = "2">
			<input type="submit" value="회원가입" />
			<input type="button" value="돌아가기" onclick="location.href='index.jsp'" />
		</td>	
	</tr>
</table>
</form>
</div>
<%@include file="footer.jsp" %>
</body>
</html>