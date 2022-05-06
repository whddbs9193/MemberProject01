<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
#container{width: 500px; margin: 0 auto;}
a{text-decoration: none; color: black;}
input[type="text"], input[type="password"]{ height: 20px;}
/* 상단 - 메인, 서브 타이틀 */
.m_title{font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title{font-family: 'Do Hyeon', sans-serif; font-size: 2em; text-align: center; margin-bottom:30px;}
/* 본문 - 테이블*/
table{width: 100%; border: 1px solid black; border-collapse: collapse;}
tr{height: 50px;}
th,td{border: 1px solid black;}
th{background: #ced4da;}
td{padding-left:5px;}
#subject{height: 20px}
.c_text{padding: 5px;}
/* 하단 - 버튼 */
.btns{text-align: center; margin-top: 20px}
.btns input{width: 110px; height: 35px; border: none; background: black; color:white;
font-weight: bold; cursor: pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded",function(){
		let form = document.updateForm;
		
		// 글 수정 버튼을 클릭할 때
		let btn_update = document.getElementById("btn_update")
		btn_update.addEventListener("click",function(){
			if(!form.subject.value){
				alert("제목을 입력하시오.");
				form.subject.focus();
				return;
			}
			if(!form.content.value){
				alert("내용을 입력하시오.");
				form.content.focus();
				return;
			}
			form.submit();
		})
		
		// 전체 게시글 버튼을 클릭할 때
		let btn_boardList = document.getElementById("btn_boardList");
		btn_boardList.addEventListener("click",function(){
			location = 'boardList.jsp';
		})
	})
</script>

</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>location = '../logon/memberLoginForm.jsp'</script>");
}

int num = Integer.parseInt(request.getParameter("num"));

//
BoardDAO boardDAO = BoardDAO.getInstance();
BoardDTO board = boardDAO.getBoardUpdateForm(num);

%>
<div id="container">
	<div class="m_title"><a href="#">EZEN MALL</a></div>
	<div class="s_title">글 수정</div><br>
	
	<form action="boardUpdatePro.jsp" method="post" name="updateForm">
		<input type="hidden" name="num" value="<%=num %>">
		<table>
			<tr>
				<th width="15%">작성자</th>
				<td width="85%"><%=memberId %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="subject" id="subject" size="54" value="<%=board.getSubject() %>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="c_text"><textarea rows="22" cols="56" name="content" id="content"><%=board.getContent() %></textarea></td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="글 수정" id="btn_update">&emsp;&emsp;
			<input type="button" value="게시글 보기" id="btn_boardList">
		</div>
	</form>
</div>
</body>
</html>