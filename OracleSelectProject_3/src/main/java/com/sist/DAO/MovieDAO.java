package com.sist.DAO;
import java.util.*;
import java.sql.*;
public class MovieDAO {
	private Connection conn;//오라클 연결
	private PreparedStatement ps;
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
	//드라이버 등록 = 생성자
	public MovieDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// 클래스 메모리 할당 (new, class.forname)
			// 클래스명을 등록 => 패키지부터 등록 => Spring
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	// 오라클 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL,"hr","happy");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	// 오라클 닫기
	public void DisConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
 		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	// 기능 설정
	//검색 => 여러 개 ArrayList, 한 개 => VO
	public ArrayList<MovieVO> movieFindData(String column,String fd){
		ArrayList<MovieVO> list = new ArrayList<MovieVO>();
		try {
			getConnection();
			//'%'||?||'%'
			String sql = "SELECT title,genre,actor "+"FROM movie "+"WHERE "+"REGEXP_LIKE("+column+",?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, fd);
			// 결과값 받기
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getString(3));
				MovieVO vo = new MovieVO();
				vo.setTitle(rs.getString(1));
				vo.setGenre(rs.getString(2));
				vo.setActor(rs.getString(3));
				
				list.add(vo);
			}
			rs.close();
			//테이블명/컬럼명은 문자열 결합
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			DisConnection();
		}
		return list;
	}
	
	public int movieFindCount(String column,String fd) {
		int count = 0;
		try {
			getConnection();
//			String sql = "SELECT COUNT(*) "+"FROM movie "+"WHERE REGEXP_LIKE("+column+",'?')";
			String sql = "SELECT COUNT(*) "+"FROM movie "+"WHERE "+column+" LIKE '%'||?||'%'";
			ps = conn.prepareStatement(sql);
//			ps.setString(1, column);
			ps.setString(1, fd);
			ResultSet rs = ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
			// 0 => 검색 결과가 없는 상탠
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			DisConnection();
		}
		return count;
	}

}
