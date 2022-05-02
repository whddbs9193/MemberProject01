<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdCheck</title>
</head>
<body>
	<%
	// ID 중복 체크 처리 페이지
	String id = request.getParameter("id");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from member where id = ?";
	
	try{
		conn = JDBCUtil.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		out.print("<script>");
		if(rs.next()){ // 아이디가  있음 -> 사용할 수 없는 이아디
			out.print("alert(`이미 사용중인 아이디가 있습니다.\n다른 아이디를 입력해 주세요.`);");
		}else{ // 아이디가 없음 -> 사용할 수 있는 아이디
			out.print("alert(`사용가능한 아이디입니다.`);");
		}
		out.print("history.back();");
		out.print("</script>");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		JDBCUtil.close(conn, pstmt, rs);
	}
	%>
</body>
</html>