<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴(삭제)</title>
</head>
<body>
	<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.deleteMember(id, pwd);
	%>
	<script>
	<%if (cnt > 0) {%> <%-- 삭제 완료 --%>
		alert('회원 탈퇴 완료!');
		location = '../logon/memberLoginForm.jsp';
	<%} else {%>
		alert('회원 탈퇴 실패');
		history.back();
	<%}%>
	</script>
</body>
</html>