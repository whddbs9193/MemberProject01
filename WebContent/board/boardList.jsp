<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*, java.util.*, java.text.*" %>
<%@ page import="board.*" %>
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
.s_id, .s_logout, .s_write{font-weight: bold;}
.s_logout a{color: #C84557}
.s_write a{color:#1E94BE}
/* 중단 - 게시판 전체 테이블*/
table{width: 100%; border: 1px solid black; border-collapse: collapse;}
tr{height: 30px;}
th, td{border: 1px solid black;}
th{background-color: #ced4da;}
td{ }
.center{text-align: center;}
.left{padding-left: 5px;}

</style>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>location='../logon/memberLoginForm.jsp'</script>");
}
// 날짜 형식 클래스
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

// 게시판 정보를 획득
BoardDAO boardDAO = BoardDAO.getInstance();
List<BoardDTO> boardList =  boardDAO.getBoardList();
int number = boardList.size();
%>

<div id="container">
	<div class="m_title"><a href="#">EZEN MALL</a></div>
	<div class="s_title">전체 게시판</div><br>
	<div class="top_info" >
		<span class="s_id"><a href="../member/memberInfoForm.jsp"><%=memberId %>님</a></span>
		&emsp;|&emsp;<span class="s_logout"><a href="../logon/memberLogout.jsp">로그아웃</a></span>
		&emsp;|&emsp;<span class="s_write"><a href="boardWriteForm.jsp">글등록</a></span>
	</div><br>
	<table>
		<tr>
			<th width="8%">번호</th>
			<th width="50%">제목</th>
			<th width="14%">작성자</th>
			<th width="20%">작성일</th>
			<th width="8%">조회수</th>
		</tr>
		<%if(number == 0){%>
			<tr><td>등록된 글이 없습니다.</td></tr>
		<%}else{ 
			for(BoardDTO board : boardList){
				int num = board.getNum();
			%>
				<tr>
					<td class="center"><%=number-- %></td>
					<td class="left"><a href="boardContent.jsp?num=<%=num%>"><%=board.getSubject() %></a></td>
					<td class=center><%=board.getWriter() %></td>
					<td class="center"><%=sdf.format(board.getRegDate()) %></td>
					<td class="center"><%=board.getReadcount() %></td>
				</tr>
		<%} }%>
	</table>
</div>
</body>
</html>