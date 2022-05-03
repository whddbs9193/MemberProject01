<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판전체보기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
#container{width: 1000px; margin: 0 auto;}
a{text-decoration: none; color: black;}
input[type="text"], input[type="password"]{ height: 20px;}
/* 상단 - 메인, 서브 타이틀 */
.m_title{font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title{font-family: 'Do Hyeon', sans-serif; font-size: 2em; text-align: center; margin-bottom:30px;}
.top_info{text-align: right;}
.s_id{font-weight: bold;}
</style>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>location='../logon/memberLoginForm.jsp'</script>");
}
// 세션이 있는경우
%>
<div id="container">
	<div class="m_title"><a href="#">EZEN MALL</a></div>
	<div class="s_title">전체 게시판</div><br>
	<div class="top_info" ><span class="s_id"><a href="../member/memberInfoForm.jsp"><%=memberId %>님</span></a>&emsp;
	|&emsp;<a href="../logon/memberLogout.jsp">로그아웃</a> </div>
</div>
</body>
</html>