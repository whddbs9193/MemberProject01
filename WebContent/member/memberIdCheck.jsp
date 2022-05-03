<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdCheck</title>
</head>
<body>
	<%-- --%>
	<%
	// ID 중복 체크 처리 페이지 
	String id = request.getParameter("id");
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.checkId(id);
	%>
	<script>
	<%if(cnt > 0) { %> <%-- 가입 가능한 아이디 --%>
		alert('사용가능한 아이디입니다.');
	<%}else{%> <%-- 가입 불가능한 아이디 --%>
		alert(`이미 존재하는 아이디입니다.\n다른 아이디를 입력해 주세요`);
	<%} %>
	history.back();
	</script>
</body>
</html>