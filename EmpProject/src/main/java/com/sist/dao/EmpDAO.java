package com.sist.dao;
import java.util.*;
import java.sql.*;
public class EmpDAO {
	//오라클 연결 => 객체
	private Connection conn;// Socket
	//SQL을 전송하는 객체
	private PreparedStatement ps;
	// BufferedReader / OutputStream
	// 오라클 주소
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
	//연결 => driver 등록
	public EmpDAO(){
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// new 대신 사용 => 클래스 명으로 메모리 할당 => 리플렉션
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	//오라클 연동
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL,"hr","happy");
			// conn => hr/happy;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	// 필수 조건
	//전체 데이터 출력
	public ArrayList<EmpVO> empListData(){
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try {
			//연결
			getConnection();
			//SQL 문장 전송
			String sql = "SELECT empno,ename,job,hiredate,sal"+"FROM emp"+"ORDER BY 1";
			ps = conn.prepareStatement(sql);//값 삽입
			ResultSet rs = ps.executeQuery();//Enter
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();//오라클 닫기
		}
		return list;
	}
}
