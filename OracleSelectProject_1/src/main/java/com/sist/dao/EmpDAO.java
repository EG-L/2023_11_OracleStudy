package com.sist.dao;
/*
 * 연동 => 마지막 (은퇴) => 웹 프로그램의 핵심
 * => 90%
 * 브라우저  =========  자바  ========= 오라클
 *            요청           SQL 전송    | SQL 문장 실행
 *            전송    ======= 결과값 받기
 *    | 결과값을 받아서 화면 출력 (HTML)
 *  ** 오라클 SQL문장과 자바에서 전송하는 SQL 문장이 다른것이 있다.
 *                                        ----- 95% 동일 => 5%가 다르다.
 *                                        => LIKE가 약간 다르다.
 *                                        => 오라클 / MySQL
 *  1) 연결(송수신) => 드라이버 설정
 *                 --------클래스로 만들어져있다.
 *     Class.forName("oracle.jdbc.driver.OracleDriver")
 *                   => ojdbc8.jar
 *  2) 오라클 연결
 *     Connection conn = DriverManager.getConnection(URL,유저명,비밀번호);
 *                                                        hr   happy
 *     URL : jdbc:업체명:드라이버타입:@IP:PORT:데이터베이스명
 *           jdbc:oracle:thin:@localhost:1521:XE
 *           => SQLPlus 동일
 *  3) SQL문장을 전송
 *     PreparedStatement ps = conn.prepareStatement(SQL문장);
 *     SQL문장 => SELECT...
 *  4) 오라클에서 실행된 데이터를 받는다.
 *     ResultSet rs = ps.exectueQuery();
 *                   ---- 실행된 결과를 메모리에 저장
 *     SELECT ename,job
 *     
 *     ResultSet
 *     
 *     -----------------------------------------------------
 *     KING                 PRESIDENT | 커서이동 => next()
		BLAKE                MANAGER
		CLARK                MANAGER
		JONES                MANAGER
		MARTIN               SALESMAN
		ALLEN                SALESMAN
		TURNER               SALESMAN
		JAMES                CLERK
		WARD                 SALESMAN
		FORD                 ANALYST
		SMITH                CLERK
		
		ENAME                JOB
		-------------------- ------------------
		SCOTT                ANALYST
		ADAMS                CLERK
		MILLER               CLERK | 커서이동 => previous()
		 | 커서가 여기 존재
		
		==> Order by를 이용해서 데이터를 읽어 온다. => next()
		while(rs.next())
		{
		   => VO의 값을 채운다.
		}
		=> 읽을 데이터가 없는 상태
		rs.close();
		ps.close();
		conn.close();
		---------- 코딩하는 패턴 1개
		---------- SQL문장을 정상수행하게 제작
		           ------ 오라클
		---------- DML,DQL => CRUD
		
    => 반복 구간 => 연결 / 닫기 => 메소드
    
    SELECT : 데이터 읽기 ( 검색 )
    => 형식 
       SELECT * | 컬럼명
       FROM 테이블명
       [
         WHERE 조건절
         GROUP BY 컬럼|함수 => 그룹
         HAVING 그룹에 대한 조건 절
              => 반드시 GROUP BY가 있는 경우에만 사용
         ORDER BY 컬럼명 , 번호 => ASC|DESC 
                               ----- Default 값(생략가능)
       ]
    
		
 *     
 * */
import java.util.*;
import java.sql.*;
public class EmpDAO {
	// 네트워크 => 자바응용프로그램(클라이언트)  <====> 오라클 (서버)
	// 요청(SQL) <======> 응답(실제 출력 결과값)
	// 연결 객체 선언 => Connection
	private Connection conn;
	// SQL문장 송수신
	private PreparedStatement ps;//read/write
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	// 드라이버 등록
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// 메모리 할당 => 클래스명으로 메모리 할당이 가능 => 리플렉션
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	// 연결 => SQLPlus를 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL,"hr","happy");
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	// 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	// 기능수행 => 메소드 => 테이블 1개당 = > VO,DAO
	// emp에서 데이터를 출력 => 사번,이름,입사일,직위,급여 출력
	public void empListData() {
		try {
			//1. 오라클 연결
			getConnection();
			//2. SQL 문장 제작
			String sql = "SELECT empno,ename,job,hiredate,sal "+"FROM emp";
			ps = conn.prepareStatement(sql);
			//3. SQL 문장을 송신
			ResultSet rs = ps.executeQuery();
			//4. 결과값 출력
			/*
			 *    no    name    sex    regdate
			 *    -----------------------------
			 *    1     홍길동    남자    23/11/13
			 *    -     ----    ---   ----------
			 *                        |rs.getDate(4);
			 *                  |rs.getString(3);
			 *          |rs.getString(2);
			 *    | rs.getInt(1);
			 * */
			while(rs.next()) {
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				System.out.println(rs.getString(2)+" "+rs.getString(3)+" "+rs.getDate(4)+" "+rs.getInt(5));
			}
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			// 오류 위치 확인
			e.printStackTrace();
		}
		finally {
			//닫기
			disConnection();
		}
	}
	// 사원의 이름, 직위, 급여, 입사일, 성과금 => 성과금이 없는 사원의 목록을 출력
	public void empNotCommListData() {
		try {
			getConnection();
			String sql = "SELECT ename,job,sal,hiredate,comm "+"FROM emp "+"WHERE comm IS NULL OR comm = 0";//;이 자동 생성
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getString(3)+" "+rs.getDate(4)+" "+rs.getInt(5));
			}
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
	}
	
	public void empCommListData() {
		try {
			getConnection();
			String sql = "SELECT ename,job,sal,hiredate,comm "+"FROM emp "+"WHERE comm IS NOT NULL AND comm<>0";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getInt(3)+" "+rs.getDate(4)+" "+rs.getInt(5));
			}
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
	}
	// 사용자로부터 입력값을 받아 검색
	public void empFindData(String ename) {
		try {
			getConnection();
			//'%'||?||'%'
			String sql = "SELECT ename,job,sal,hiredate "+"FROM emp "+"WHERE REGEXP_LIKE(ename,?) ORDER BY 1";
			ps = conn.prepareStatement(sql);
			ps.setString(1, ename);
			//?에 값을 채운 후에 실행 요청
//			String sql = "SELECT ename,job,sal,hiredate "+"FROM emp "+"WHERE ename LIKE '%'||?||'%' ORDER BY 1";
//			ps.setString(1,ename);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getInt(3)+" "+rs.getDate(4));
			}
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
	}
	
	public void empRpadData() {
		try {
			getConnection();
			String sql = "SELECT ename,RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') "+"FROM emp";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1)+" "+rs.getString(2));
			}
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
	}
	
	public void empSalInfoData() {
		try {
			getConnection();
			String sql = "SELECT ename,ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)),"
					+ "TO_CHAR(sal,'$999,999'),TO_CHAR(sal*12,'$999,999,999'),"
					+ "TO_CHAR(sal+NVL(comm,0),'$999,999'),"
					+ "TO_CHAR(hiredate,'YYYY-MM-DD HH24:MI:SS') "
					+ "FROM emp";
			// ,다음에는 공백을 사용할 필요가 없다.
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				//TO_CHAR 문자열 변환 => getString으로 출력
				System.out.println(rs.getString(1)+" "+rs.getInt(2)+" "+rs.getString(3)+rs.getString(4)+" "+rs.getString(5)+" "+rs.getString(6));
			}
			rs.close();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
	}
	
	public void empGroupByData() {
		try {
			getConnection();
			String sql = "SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*),SUM(sal),"
					+ "AVG(sal),MAX(sal),MIN(sal) "
					+ "FROM emp GROUP BY TO_CHAR(hiredate,'YYYY') "
					+ "ORDER BY TO_CHAR(hiredate,'YYYY')";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1)+" "+rs.getInt(2)+" "+rs.getInt(3)+" "+rs.getDouble(4)+" "+rs.getInt(5)+" "+rs.getInt(6));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
	}
	
	public void subqueryNotDAta() {
		try {
			getConnection();
			
			String sql = "SELECT ename,job,hiredate,sal "+"FROM emp "+"WHERE sal<(SELECT ROUND(AVG(sal)) "+"FROM emp)";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getDate(3)+" "+rs.getInt(4));
			}
			rs.close();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
	}
}
