package com.sist.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class StudentDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@211.238.142.119:1521:XE";
	
	public StudentDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL, "hr", "happy");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 기능
	// 1. 목록 SELECT => 페이징(자바, 오라클(인라인뷰))
	// 오라클만 연동 => 출력은 main이나 브라우저에서 한다
	// 데이터를 모아서 전송(목록) ArrayList
	public ArrayList<StudentVO> stdListData(){
		ArrayList<StudentVO> list=new ArrayList<StudentVO>();
		try {
			getConnection();
			String sql="SELECT hakbun,name,kor,eng,math,"
					+ "kor+eng+math,ROUND((kor+eng+math)/3.0,2),"
					+ "DENSE_RANK() OVER(ORDER BY kor+eng+math DESC),"
					+ "TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') "
					+ "FROM student";
			// 웹은 모든 데이터가 공유 => 데이터는 반드시 오라클에 저장된 상태
			// XML => JSON => Ajax
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			// next(), preivous()
			while(rs.next()) {
				// 데이터를 모아서 전송 => MainCass
				StudentVO vo=new StudentVO();
				vo.setHakbun(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setKor(rs.getInt(3));
				vo.setEng(rs.getInt(4));
				vo.setMath(rs.getInt(5));
				vo.setTotal(rs.getInt(6));
				vo.setAvg(rs.getDouble(7));
				vo.setRank(rs.getInt(8));
				vo.setDbday(rs.getString(9));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
	// 2. 추가 INSERT => COMMIT(AUTOCOMMIT)
	public void stdInsert(StudentVO vo) {
		try {
			getConnection();
			/*
			String sql="INSERT INTO student(hakbun,name,kor,eng,math) "
					+ "VALUES ((SELECT MAX(hakbun)+1 FROM student),"
					+ "'"+vo.getName()+"',"+vo.getKor()+","+vo.getEng()+","+vo.getMath()+")";
			System.out.println(sql);
			*/
			String sql="INSERT INTO student(hakbun,name,kor,eng,math) "
					+ "VALUES ((SELECT MAX(hakbun)+1 FROM student),?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setInt(2, vo.getKor());
			ps.setInt(3, vo.getEng());
			ps.setInt(4, vo.getMath());
			ps.executeUpdate(); // 데이터베이스 변동시
			// executeUpdate() => AUTOCOMMIT
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	public void stdInsert(String mno,int cno,String cate) {
		try {
			getConnection();
			String sql = "";
			System.out.println(mno);
			if(String.valueOf(Integer.parseInt(mno)).length()==7) {
				sql="INSERT INTO middlect(mno,cno,cate) "
						+ "VALUES (TO_CHAR('"+mno+"'),"+cno+",'"+cate+"')";
			}
			else {
				sql="INSERT INTO middlect(mno,cno,cate) "
						+ "VALUES (TO_CHAR('"+mno+"'),"+cno+",'"+cate+"')";
			}
			ps=conn.prepareStatement(sql);
//			ps.setString(1, mno);
//			ps.setInt(2, cno);
//			ps.setString(3, cate);
			ps.executeUpdate(); // 데이터베이스 변동시

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	// 3. 상세보기 SELECT => WHERE
	// 상세보기시, 반드시 PRIMARY KEY값을 전송
	public StudentVO stdDetailData(int hakbun) {
		StudentVO vo=new StudentVO();
		try {
			getConnection();
			String sql="SELECT hakbun,name,kor,eng,math,"
					+ "kor+eng+math,ROUND((kor+eng+math)/3.0,2),"
					+ "RANK() OVER(ORDER BY kor+eng+math DESC),"
					+ "TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') "
					+ "FROM student "
					+ "WHERE hakbun="+hakbun;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setHakbun(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setKor(rs.getInt(3));
			vo.setEng(rs.getInt(4));
			vo.setMath(rs.getInt(5));
			vo.setTotal(rs.getInt(6));
			vo.setAvg(rs.getDouble(7));
			vo.setRank(rs.getInt(8));
			vo.setDbday(rs.getString(9));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		return vo;
	}
	// 4. 수정 UPDATE => COMMIT(AUTOCOMMIT)
	public StudentVO stdUpdateData(int hakbun) {
		StudentVO vo=new StudentVO();
		try {
			getConnection();
			String sql="SELECT hakbun,name,kor,eng,math "
					+ "FROM student "
					+ "WHERE hakbun="+hakbun;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setHakbun(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setKor(rs.getInt(3));
			vo.setEng(rs.getInt(4));
			vo.setMath(rs.getInt(5));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		return vo;
	}
	public void stdUpdate(StudentVO vo) {
		try {
			getConnection();
			String sql="UPDATE student "
					+ "SET name=?,kor=?,eng=?.math=? "
					+ "WHERE hakbun=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setInt(2, vo.getKor());
			ps.setInt(3, vo.getEng());
			ps.setInt(4, vo.getMath());
			ps.setInt(5, vo.getHakbun());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	// 5. 삭제 DELETE => COMMIT(AUTOCOMMIT)
	public void stdDelete(int hakbun) {
		try {
			getConnection();
			String sql="DELETE FROM student "
					+ "WHERE hakbun="+hakbun;
			ps=conn.prepareStatement(sql);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	/*
	public static void main(String[] args) {
		StudentDAO dao=new StudentDAO();
		StudentVO vo=new StudentVO();
		vo.setHakbun(8);
		vo.setName("이산");
		vo.setKor(80);
		vo.setEng(70);
		vo.setMath(100);
		dao.stdInsert(vo);
	}
	*/
}
