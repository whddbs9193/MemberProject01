<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정처리</title>
</head>
<body>
	<%request.setCharacterEncoding("utf-8"); %>
	<%-- 1단계: 수정정보를 액션태그로 받음 --%>
	<jsp:useBean id="member" class="member.MemberDTO" />
	<jsp:setProperty property="*" name="member"/>
	
	<%
	// 주소 처리: 도로명 주소 + 상세 주소
	String address2 = request.getParameter("address2");
	String address = member.getAddress() + " " + address2;
	member.setAddress(address);
	
	// 2단계: DB 테이블에 처리
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.updateMember(member);
	%>
	<script>
	<%if(cnt > 0){ %> <%-- 수정 성공 --%>
		alert('회원 정보 수정에 성공하였습니다.');
	<%}else{ %> <%-- 수정 실패 --%>
		alert('회원 정보 수정에 실패하였습니다.');
	<%} %>
	history.back();
	</script>
</body>
</html>