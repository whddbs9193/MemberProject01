<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*, util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql ="select * from member where id = ?";
	try{
		conn = JDBCUtil.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		out.print("들어왔음");
		out.print("<script>");
		if(rs.next()){ // 아이디가 존재할 때
			String dbpwd = rs.getString("pwd");
			if(pwd.equals(dbpwd)){ // 아이디, 비밀번호가 모두 일치할 때 
				// 해당 아이디를 세션으로 저장
				
				session.setAttribute("memberId",id);
				out.print("location='../borad/boradList.jsp'");
			}else{ // 아이디는 있지만, 그 아이디의 비밀번호가 일치하지 않을 때
				out.print("alert(`비밀번호가 다릅니다.`); history.back();");
			}
		}else{ // 아이디가 존재하지 않을 때
			out.print("alert(`아이디가 존재하지 않습니다.`); history.back();");
		}
		out.print("</script>");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		JDBCUtil.close(conn, pstmt, rs);
	}
	%>
</body>
</html>