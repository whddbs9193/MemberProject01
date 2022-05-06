package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

// DAO(Date Access Object), DBBean
public class BoardDAO {
	// singleton pattern
	private BoardDAO(){ }
	
	private static BoardDAO boardDAO = new BoardDAO();
	
	public static BoardDAO getInstance() {
		return boardDAO;
	}
	
	// DB 연결, 질의에 사용할 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 게시판 글등록 메소드(원글)
	public void insertBoard(BoardDTO board) {
		// 작업1 - board에서 가장 큰 글번호를 구함 -> 이 번호로 그룹화 아이디 값을 결정
		String sql1 = "select max(num) from board";
		// 작업2 - 같은 그룹화 아이디(ref)이고, 글순서(re_step)이 크다면 글순서(re_step)을 1증가함. 
		String sql2 = "updata board set re_step = re_step + 1 where ref = ? and re_step > ?";
		// 작업3 - 최종적으로 원글 또는 댓글을 추가함.
		String sql3 = "insert into board(writer, subject, content, ref, re_step, re_level) values(?,?,?,?,?,?)";
		
		int num = board.getNum();
		int ref = board.getRef();
		int re_step = board.getRe_step();
		int re_level = board.getRe_level();
		int number = 0;
		
		try{
			conn = JDBCUtil.getConnection();
			
			// 글번호의 최대값 획득
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			
			if(rs.next()) number = rs.getInt(1) + 1;
			else number = 1;
			
			// 댓글그룹, 댓글순서, 댓글깊이를 수정
			if(num != 0) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			}else {
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			
			// 글등록 처리
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, board.getRef());
			pstmt.setInt(5, board.getRe_step());
			pstmt.setInt(6, board.getRe_level());
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 게시판 글보기(전체) 메소드
	public List<BoardDTO> getBoardList() {
		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
		BoardDTO board = null;
		String sql = "select * from board order by num desc";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 1단계: 글번호, 제목, 작성자, 작성일, 조회수의 5가지 정보를 BoardDTO 에 저장
			// 2단계: board를 boardList에 저장
			while(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setSubject(rs.getString("subject"));
				board.setWriter(rs.getString("writer"));
				board.setRegDate(rs.getTimestamp("regDate"));
				board.setReadcount(rs.getInt("readcount"));
				boardList.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return boardList;
	}
	
	// 게시판 글보기(1건) 메소드
	public BoardDTO getBoard(int num) {
		BoardDTO board = new BoardDTO();
		String sql1 = "update board set readcount = readcount + 1 where num =? ";
		String sql2 = "select * from board where num = ?";
		
		try {
			conn = JDBCUtil.getConnection();
			// 조회수 증가
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			// 글 상세 보기
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board.setNum(rs.getInt("num"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegDate(rs.getTimestamp("regDate"));
				board.setReadcount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setRe_step(rs.getInt("re_step"));
				board.setRe_level(rs.getInt("re_level"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return board;
	}
	
	// 게시판 글수정 폼에서 글보기 메소드
	public BoardDTO getBoardUpdateForm(int num) {
		BoardDTO board = new BoardDTO();
		String sql = "select * from board where num = ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 글 수정 폼에서 수정하는 2가지 정보
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return board;
	}
	
	// 게시판 글수정 메소드
	public void updateBoard(BoardDTO board) {
		String sql = "update board set subject=?, content=? where num =?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNum());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 게시판 글삭제 메소드
	public int deleteBoard(int num, String writer, String pwd){
		String sql1 = "select pwd from member where id = ?";
		String sql2 = "delete from board where num = ?";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			// 1단계: member 테이블에서id(writer) writer에 해당하는 dbpwd를 구함
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, writer);
			pstmt.executeQuery();
			rs = pstmt.executeQuery();
			
			// 2단계: pwd와 dbPwd가 일치할 때 num에 해당하는 글을 삭제
			if(rs.next()) { //아이디(작성자)가 있다면
				String dbPwd = rs.getString("pwd");
				if(pwd.equals(dbPwd)) { //비밀번호가 일치한다면
					pstmt = conn.prepareStatement(sql2);
					pstmt.setInt(1, num);
					cnt = pstmt.executeUpdate();
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
}
