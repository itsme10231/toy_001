<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="header.jsp" %>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript">
	$(function(){
		var infoForm = document.getElementsByName("infoform")[0];
		var pwInputs = $(infoForm).find("input[type='password']");
		
		var address = "${ldto.address}";
		var addrArr = address.split(":");
		
		$("input[name='address1']").val(addArr[0]);
		$("input[name='address2']").val(addArr[1]);
		$("input[name='address3']").val(addArr[2]);
		
		pwInputs[2].onblur = function() {
			var pwMsg = document.getElementsByClassName("alertpw")[1];
			
			if(pwInputs[1].value != pwInputs[2].value){
				pwInputs[1].value = "";
				pwInputs[2].value = "";
				pwInputs[1].focus();

				pwMsg.innerHTML = "패스워드를 확인하세요."
			}else{

				pwMsg.innerHTML = "패스워드가 일치합니다."
			}
		}
		
		form.onsubmit = function() {
			if(pwInputs[1].value != pwInputs[2].value){
				alert("패스워드를 확인하세요!");
				pwInputs[1].value = "";
				pwInputs[2].value = "";
				pwInputs[1].focus();
				return false; //유효하지 않은 값이 존재하면 submit 전송기능 취소
			}else if(pwInputs[0].value != "${ldto.password}"){
				alert("예전 비밀번호가 일치하지 않습니다.");
				idInput.focus();
				return false;
			}else {
				
			}
		}
	});

</script>
</head>
<body>
<form action="LoginController.do" method="post" name="infoform">
<input type="hidden" name="command" value="modifyinfo">
<input type="hidden" name="command" value="${ldto.id}">
	<table>
		<tr>
			<th>ID</th>
			<td>${ldto.id}</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="oldpassword" required="required"><span class="alertoldpw"></span></td>
		</tr>
		<tr>
			<th>새 비밀번호</th>
			<td><input type="password" name="password" ><span class="alertpw"></span></td>
		</tr>
		<tr>
			<th>새 비밀번호 확인</th>
			<td><input type="password" name="password2" ></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" value="${ldto.name}" required="required"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="email" name="email" value="${ldto.email}" required="required"></td>
		</tr>
		<tr>
			<th>기존주소</th>
			<td>${ldto.address}</td>
		</tr>
		<tr><th colspan="2">새 주소</th></tr>
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
			<td colspan="2">
				<input type="submit" value="회원정보 수정완료"><input type="button" value="돌아가기" onclick="location.href='myinfo.jsp'">
			</td>
		</tr>
	
	
	</table>
</form>

<%@include file="footer.jsp" %>
</body>
</html>