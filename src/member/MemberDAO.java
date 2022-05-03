package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;

// DAO(Data Access Object) - DB 연결, 해제, 질의를 담당
public class MemberDAO {
	
	// Singleton Pattern(싱글톤 패턴) - 클래스의 인스턴스 하나만 생성하는 방법
	private MemberDAO(){ }
	
	private static MemberDAO memberDAO = new MemberDAO();
	
	public static MemberDAO getInstance(){
		return memberDAO;
	}
	// DB 연결, 질의 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	// 회원 가입 메소드
	public int insertMember(MemberDTO member) {
		String sql ="insert into member values(?, ?, ?, ?, ?, ?, now())";
		int cnt = 0; // 성공여부 확인
		
		try{
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setNString(3, member.getName());
			pstmt.setNString(4, member.getEmail());
			pstmt.setNString(5, member.getTel());
			pstmt.setNString(6, member.getAddress());
			cnt = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	
	// 회원 ID 중복 체크
	public int checkId(String id) {
		String sql = "select * from member where id = ?";
		int cnt = 0; //성공여부
		
		try{
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			
			if(rs.next())cnt = 0; //아이디가 있을때 -> 중복일때 사용 불가능 아이디
			else  cnt = 1; //아이디가 없을때 중복이 아닐때 -> 사용할 수 있는 아이디
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			JDBCUtil.close(conn, pstmt,rs);
		}
		return cnt;
	}
	// 로그인 메소드
	public int login(String id, String pwd) {
		String sql = "select * from member where id = ?";
		int cnt = -1; // 3가지의 경우 -1: 아이디가 없다, 0 아이디는 있고 비밀번호가 다르다, 1 아이디,비밀번호 모두 일치
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //아이디가 있을 떄
				String dbpwd = rs.getString("pwd");
				if(pwd.equals(dbpwd)) { // 아이디 비밀번호 일치
					cnt = 1;
				}else { // 아이디는 일치하고 비밀번호는 일치하지 않을 때
					cnt = 0;
				}
			}else{ // 아이디가 없을 때
				cnt = -1;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	// 회원 정보 보기(1명, 자신의 정보)
	public MemberDTO getMember(String id) {
		String sql ="select * from member where id = ?";
		MemberDTO member = new MemberDTO();
		
		try{
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 가입일을 제외한 정보를 member 테이블로 부터 가져와서 member 객체에 저장
				member.setId(rs.getString("id"));
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddress(rs.getString("address"));
				
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return member;
		
	}
	// 회원 정보 수정
	public int updateMember(MemberDTO member) {
		String sql = "update member set pwd=?,name=?,email=?,tel=?,address=? where id=?";
		int cnt = 0; //성공 여부
		
		
		try{
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getId());
			cnt = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		
		return cnt;
	}
	
	// 회원 삭제(탈퇴)
	public int deleteMember(String id,String pwd) {
		String sql = "delete from member where id = ? and pwd = ?";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			cnt = pstmt.executeUpdate();
			
			if(cnt > 0) cnt = 1; // 아이디가 있을 때
			else cnt = 0; // 아이디가 없을 때 
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
}
