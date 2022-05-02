<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*, java.sql.*,util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	
	<!-- 액션 태그 사용 -->
	<jsp:useBean id="member" class="member.Member" />
	<jsp:setProperty property="*" name="member"/>
	
	<%
	// 완전한 주소: address(도로명 주소) + address2(상세 주소)
	String address2 = request.getParameter("address2");
	String address = member.getAddress() + " " + address2;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql ="insert into member values(?,?,?,?,?,?,now())";
	int cnt = 0;
	try{
		conn = JDBCUtil.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,member.getId());
		pstmt.setString(2,member.getPwd());
		pstmt.setString(3,member.getName());
		pstmt.setString(4,member.getEmail());
		pstmt.setString(5,member.getTel());
		pstmt.setString(6,address);
		cnt = pstmt.executeUpdate();
		
		out.print("<script>");
		if(cnt > 0){ //추가 성공
			out.print("alert(`회원 가입에 성공하였습니다.`);");
			out.print("location='../logon/memberLoginForm.jsp'");
		}else{ // 추가 실패
			out.print("alert(`회원 가입에 실패하였습니다.\n다시 시도해 주세요.`);");
			out.print("history.back();");
		}
		
		out.print("</script>");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		JDBCUtil.close(conn, pstmt);
	}
	%>
</body>
</html>