<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="board" class="board.BoardDTO" />
<jsp:setProperty property="*" name="board"/>
<%
String pageNum = request.getParameter("pageNum");
if(pageNum == null) pageNum = "1";
BoardDAO boardDAO = BoardDAO.getInstance();
boardDAO.insertBoard(board);

response.sendRedirect("boardList.jsp?pageNum=" + pageNum);
%>
<script>

</script>
</body>
</html>