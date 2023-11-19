package com.sist.dao;
//VO=table(column) , DAO는 한개만 만들 수 있다.
/*
 *     조인
 *      => 2개 이상의 테이블을 연결해서 하나의 테이블처럼 필요한 데이터를 추출
 *      => 데이터 추출에 목적
 *      => 종류
 *         INNER JOIN (INTERSECT)
 *           => EQUI JOIN (=)
 *           => NON-EQUI-JOIN (BETWEEN , > , < , >= , <=)
 *              포함 시에도 조인이 가능
 *           => NULL값을 처리 못한다.
 *         OUTER JOIN => NULL값을 처리할 수 있게 만드는 과정 (INTERSECT + MINUS)
 *           => LEFT OUTER JOIN
 *           => RIGHT OUTER JOIN
 * */
import java.util.*;
import java.sql.*;

public class EmpDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	//1. 드라이버 등록 => 각 데이터베이스 업체에서 제공
	//=> 한번만 사용 ===> 생성자에서 주로 사용
	public EmpDAO() {
		// TODO Auto-generated constructor stub
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// thin / oci
			// thin => 연결만 하는 역할(무료)
			// oci => 드라이버에 오라클 기능(유료)
			// => 클래스명으로 메모리 할당 => 스프링, 마이바티스 => 라이브러리에 주로 사용
			// 리플렉션 => 메모리 할당 => 클래스 등록 (XML)
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}
	// 오라클 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL,"hr","happy");
			// 오라클로 전송하는 명령어 => conn hr/happy;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}
	// 오라클 닫기
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			//OutputStream / BufferedReader
			if(conn!=null) conn.close();
			//Socket
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}
	// => DAO의 필수 과정
	/*
	 *    DAO => 원래 한개의 테이블만 제어 할 수 있게 만든다.
	 *        => 통합해서 사용
	 *           게시판 + 댓글
	 *           찜하기 + 좋아요 => Service
	 *    ****** 100% DAO vs Service
	 *    회원 / 게시판 / 영화 / 음악 / 맛집 / 레시피
	 *    => 재사용
	 * */
	// DAO(JDBC) => DBCP => ORM (MyBatis => JPA)
	//       200줄                   100줄    10줄
	// 기능 => 사원의 정보 => 급여등급 , 부서명 , 근무지
	// 조인 => emp=dept , emp=salgrade
	public ArrayList<EmpVO> empAllData(){
		//emp,dept,salgrade정보를 한번에 모아서 전송
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try {
			// 1. 연결
			getConnection();
			String sql = "SELECT empno,ename,job,hiredate,"+"sal,emp.deptno,dname,loc,grade "
			             +"FROM emp JOIN dept ON emp.deptno=dept.deptno "+"JOIN salgrade ON sal BETWEEN losal AND hisal";
//			String sql = "SELECT empno,ename,job,hiredate,"+"sal,emp.deptno,dname,loc,grade "+"FROM emp,dept,salgrade "+"WHERE emp.deptno=dept.deptno "+"AND sal BETWEEN losal AND hisal";
			ps = conn.prepareStatement(sql);
			//오라클 전송
			ResultSet rs = ps.executeQuery();
			//실행 후에 결과값을 받아 온다.
			while(rs.next()) {
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setSal(rs.getInt(5));
				vo.setDeptno(rs.getInt(6));
				vo.getDvo().setDname(rs.getString(7));
				vo.getDvo().setLoc(rs.getString(8));
				vo.getSvo().setGrade(rs.getInt(9));
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
		return list;
	}
	//SubQuery
	/*
	 *   subquery : SQL문장 여러 개를 한 개로 모아서 한번에 처리
	 *   MainQuery : (subQuery)
	 *   종류
	 *    = WHERE 뒤에 조건
	 *      => 단일행 서브쿼리
	 *         비교연산자 ( = , !=, < , > , <= , >= ) 
	 *      => 다중행 서브쿼리
	 *         IN , ANY, ALL
	 *    = 컬럼 대신 사용 SELECT 뒤에 => 스칼라 서브쿼리 4장
	 *    = 테이블 대신 사용 FROM 뒤에 처리 => 인라인뷰 4장
	 *    =
	 * */
	//KING이 있는 부서에서 근무하는 사원의 사번,이름,부서명,근무지,입사일,급여
	public ArrayList<EmpVO> subqueryEmpData(){
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try {
			// 서브쿼리가 먼저 실행 => ()
			// 서브쿼리에서는 ORDER BY는 사용 할 수 없다.
			getConnection();
			String sql = "SELECT empno,ename,dname,loc,hiredate,sal "
			+"FROM emp e JOIN dept d "
			+"ON e.deptno=d.deptno "
			+"WHERE e.deptno=(SELECT deptno FROM emp WHERE ename='KING')";
			
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.getDvo().setDname(rs.getString(3));
				vo.getDvo().setLoc(rs.getString(4));
				vo.setHiredate(rs.getDate(5));
				vo.setSal(rs.getInt(6));
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		finally {
			disConnection();
		}
		return list;
	}
	// => 다중행 서브쿼리 => IN => 이름 중에 A를 포함하고 있는 사원의 부서에서 근무하는 사원의 사번,이름,부서명,근무지,입사일,급여
	public ArrayList<EmpVO> subqueryInEmpListData(){
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try {
			getConnection();
			String sql = "SELECT empno,ename,dname,loc,hiredate,sal "+"FROM emp e JOIN dept d "+"ON e.deptno=d.deptno WHERE e.deptno IN(SELECT DISTINCT deptno FROM emp WHERE REGEXP_LIKE(ename,'A'))";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.getDvo().setDname(rs.getString(3));
				vo.getDvo().setLoc(rs.getString(4));
				vo.setHiredate(rs.getDate(5));
				vo.setSal(rs.getInt(6));
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		finally {
			disConnection();
		}
		return list;
	}

}
