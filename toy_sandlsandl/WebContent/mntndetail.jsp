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
	

	//페이지가 로딩되었을때 ajax를 통해 해당 산의 데이터를 받아와 가공하기
	$(function(){
		
		$.ajax({
			url:"FindController.do",
			data: {"command":"findmntndetail","mName":"${param.mntn_name}"},
			dataType: "xml",
			method: "post",
			success: function(xml){
				console.log("통신 성공");
				console.log("${param.mntn_code}");
				
				var mntnInfo = null;
				$(xml).find("mntilistno").each(function(){
					console.log("${param.mntn_code}");
					
					if($(this).text() == "${param.mntn_code}"){
						console.log("matching success");
						mntnInfo = $(this).parent();
						putInfo(mntnInfo);
						return;
					}
				});
				

				
				$.ajax({
					url:"FindController.do",
					data: {"command":"findmntnimg","mCode":"${param.mntn_code}"},
					dataType: "xml",
					method: "post",
					success: function(xml){
						var mntnImg = $(xml).find("imgfilename");
						putImg(mntnImg);
						
					},
					error: function(){
						console.log("통신 실패");
					}
				});
				
			},
			error: function(){
				console.log("통신 실패");
			}
		});
		
		$("form[name='commentform']").on("submit", function(){
			if($("input[name='loginflag']").val()=="N"){
				alert("로그인이 필요한 기능입니다.");
				return false;
			}else{
				if(confirm("다녀오신 날짜와 상세일정을 추가로 기록하시겠어요?")){
					$(this).find("input[name='schflag']").val("Y");
					return true;
				}else{
					return true;
				}
			}
		});
		
		$("input[name='togglewish']").on("click", function(){
			if($("input[name='loginflag']").val()=="N"){
				alert("로그인이 필요한 기능입니다.");
			}else {
				if($(this).hasClass("pushed")){//이미 위시리스트에 체크되어 있을 경우
					toggleWish("delwishlist",$(this));
				}else{
					toggleWish("addwishlist",$(this));
				}
				
			}
		});
		
		
		
	});//onload종료
	
	function putInfo(xml){
		console.log("디테일 프린트");

		$("td").each(function(){
			var targetTd = $(this);
			if(targetTd.is("[class]")){
				targetTd.text(
					$(xml).find(targetTd.attr("class")).text()		
				);
			}
		});
		
	}
	
	function putImg(xml){
		console.log("이미지 프린트");
		for(var i = 0; i < xml.length; i++){
			var imgsrc = "<img src='http://www.forest.go.kr/images/data/down/mountain/" +xml.eq(i).text() +"'>";
			$("#mntiimg").append(imgsrc);
		}
	}
	
	function toggleWish(command, input){
		$.ajax({
			url:"PostController.do",
			data:{"command":command, "id":"${ldto.id}", "mntn_code":"${param.mntn_code}"},
			method:"post",
			success: function(){
				console.log("ajaxSuccess");
				input.toggleClass("pushed");
			},
			error: function(){
				console.log("ajaxError");
			}
			
		});
	}
	
</script>
<style type="text/css">
	.pushed{background-color: red;}
</style>
</head>
<body>
	
<table border="1">
	<tr>
		<th colspan="1">산명</th>
		<td colspan="3" class="mntiname">
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<p>가봤어요: ${list[0].climbc}</p>
			<p>좋아요: ${list[0].sumlike}</p>
			<p>가고싶어요: ${list[0].wishc}</p>
		</td>
	</tr>
	<tr>
		<th colspan="1">전경</th>
		<td id="mntiimg" colspan="3"></td>
	</tr>
	<tr>
		<th>소재지</th>
		<td class="mntiadd"></td>
		<th>고도</th>
		<td class="mntihigh"></td>
	</tr>
	<tr>
		<th>관리주체</th>
		<td class="mntiadmin"></td>
		<th>연락처</th>
		<td class="mntiadminnum"></td>
	</tr>
	<tr>
		<th colspan="1">상세설명</th>
		<td colspan="3" class="mntidetails"></td>
	</tr>
	<tr>
		<td colspan="4">
			<table>
				<c:forEach items="${list}" var="cdto">
					<tr>
						<td>
							${cdto.mcomment}
						</td>
					</tr>
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<input type="button" name="putsch" value="갈 예정이에요!(일정 등록)">
			<input type="button" name="togglewish" value="가고 싶어요!" ${wdto eq null ? '': 'class="pushed"'}>
		</td>
	</tr>
	
		<tr>
			<td colspan="4">
				<form action="PostController.do" method="post" name="commentform">
				<input type="hidden" name="command" value="addcomment">
				<input type="hidden" name="mntn_code" value="${param.mntn_code}">
				<input type="hidden" name="mntn_name" value="${param.mntn_name}">
				<input type="hidden" name="schflag" value="N">
				<input type="hidden" name="loginflag" value="${ldto==null?'N':'Y'}">
				
				<textarea rows="5" cols="100" name="mcomment" placeholder="이미 이 산에 다녀오셨나요? 평가를 남겨주세요!"></textarea><br>
				<label for="good">좋았어요!</label><input name="mlike" id="good" value="1" type="radio">
				<label for="soso">보통이에요</label><input name="mlike" id="soso" value="0" type="radio" checked="checked">
				<label for="bad">별로였어요</label><input name="mlike" id="bad" value="-1" type="radio"><br>
				<input type="submit" name="smcomment" value="등록">
				
				</form>
			</td>
		</tr>

	<tr>
		<td colspan="4"><button type="button" onclick="history.back()">산 목록으로 돌아가기</button></td>
	</tr>
	
</table>


<%@include file="footer.jsp" %>
</body>
</html>