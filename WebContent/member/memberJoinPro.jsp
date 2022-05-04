<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	
	<!-- 액션 태그 사용 -->
	<jsp:useBean id="member" class="member.MemberDTO" />
	<jsp:setProperty property="*" name="member"/>
	
	<%
	// 완전한 주소: address(도로명 주소) + address2(상세 주소)
	String address2 = request.getParameter("address2");
	String address = member.getAddress() + " " + address2;
			
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.insertMember(member);	
	%>
	
	<script>
	<%if(cnt > 0) {%> <%-- cnt가 1, 데이터 추가에 성공한 --%>
		alert('회원 가입에 성공하였습니다.');
		location = '../logon/memberLoginForm.jsp';
	<%} else { %> <%-- cnt가0, 데이터 추가에 실패 --%>
		alert('회원가입에 실패하였습니다.');
		history.back();
	<%} %>
	</script>
</body>
</html>