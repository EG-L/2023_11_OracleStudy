-- 오라클 SQL => DML (129page)
/*
     => DQL : SELECT (3장)
                      = 형식
                      = 조건 => 셀렉션
                        => 연산자
                        => 내장함수
                      = 테이블 병합 => 데이터 추출 ( JOIN )
             = SQL문장을 합친다. => 서브쿼리
     => DDL : 테이블 생성 => 키의 종류
     => DML(TCL) => 추가, 수정, 삭제
        => 문제 => 책 중심
        ------------------------------------------------ 기초
     => View : 가상 테이블
        => INDEX : 최적화
        => SEQUENCE,SYNONYM
     => PL/SQL
     => 데이터베이스 모델링

       BIT ==> BYTE ==> WORD ==> RECORD ==> TABLE
       용어
       -------------------------------------------------
     데이터베이스          실무               같은 의미
    -------------------------------------------------
     릴레이션               테이블                파일
    -------------------------------------------------
     속성                     컬럼                   필드(멤버변수)
    -------------------------------------------------
     튜플                     로우/레코드        객체(인스턴스) ==> 한줄 (클래스 객체)
    -------------------------------------------------

         테이블 => emp(사원정보)  => 오라클에서 지원(연습용 테이블)
               => 컬럼 (8개), ROW (14개) => 14개에 대한 정보 
                   ---------
                         DESC table명 => 컬럼명과 데이터형 확인이 가능
                         *** 데이터형 (CHAR, VARCHAR2, CLOB => 문자열) => ''
                               (DATE) = 날짜형 => 저장은 문자열로 한다.
                               (NUMBER) = 숫자형 => int , double (정수, 실수)

 emp 테이블의 구조
  컬럼명                                                                           데이터형
 EMPNO                                     NOT NULL NUMBER(4)     =>정수       => 사원번호
 ENAME                                              VARCHAR2(10)  =>문자         =>  이름
 JOB                                                VARCHAR2(9)   =>문자         => 직위
 MGR                                                NUMBER(4)     =>정수          => 사수번호
 HIREDATE                                           DATE          =>날짜          => 입사일
 SAL                                                NUMBER(7,2)   =>정수,실수  => 급여
 COMM                                               NUMBER(7,2)   =>정수,실수  => 성과금
 DEPTNO                                             NUMBER(2)     =>정수          => 부서번호     ====> 조인 연습용
 -------------------------------- 8개의 정보 (한 사람 당) => 총 사원수는 14명
  => 프로그램에 필요한 데이터 추출 => SELECT

  1) SELECT : 데이터 추출 (필요한 데이터 검색)
      ------- 데이터 검색
     = SQL문장은 문자열로 되어 있다 => 형식을 익히는데 주력
        1. 형식(순서) => 대소문자 구분 (X) => 가급적이면 키워드는 대문자 사용한다.
           ------------------------------
       SELECT * 또는 원하는 데이터 추출(column1,column2)
            FROM table명 ---------------------------------- 필수
            [
          WHERE 조건문 
                          ------- 연산자 
                GROUP BY group컬럼 => 입사년도별 , 부서별 , 직위별 ...
                HAVING 그룹조건 => GROUP BY가 있는 경우에만 사용이 가능..
                ORDER BY 정렬 (ASC, DESC)
           => INDEX 
       ]
           -----------------------------------
*/

-- emp에 있는 모든 데이터 출력
SELECT * FROM emp;
-- 원하는 데이터만 출력 (이름, 직위, 입사일, 급여)
SELECT  ename,job,hiredate,sal FROM emp;
/*
   -- 별칭
     SELECT ename "이름" , hiredate "입사일", sal "급여" FROM emp;

   SELECT ename as 이름, hiredate as 입사일, sal as 급여 FROM emp;
*/
/*
SELECT ename as 이름, hiredate as 입사일, sal as 급여 FROM emp;
-- 부서번호
SELECT deptno FROM emp;
-- 중복제거 부서번호 ==> 가수명, 장르.. => DISTINCT 뒤에는 컬럼 1개만 적용 가능
SELECT DISTINCT deptno FROM emp;
-- 직위출력
SELECT job FROM emp;
-- 중복제거 직위
SELECT DISTINCT job FROM emp;
*/

-- 1. book 테이블 확인
DESC book;
/*
 BOOKID                   => 구분자                                                                                                                NOT NULL NUMBER(2)
 BOOKNAME                 => 책 이름
            VARCHAR2(40)
 PUBLISHER                => 출판사
            VARCHAR2(40)
 PRICE                    => 가격
            NUMBER(8)
*/
-- 2. 모든 도서의 도서명과 가격 출력

SELECT bookname,price FROM book;

-- 출판사 출력
SELECT DISTINCT publisher FROM book;
-- 148page