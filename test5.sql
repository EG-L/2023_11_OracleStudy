--오라클 2일차 ==> 연산자 / 내장함수 / ORDER BY

/*
     => 조인
        => 서브쿼리
        => DDL (Table생성)

        1) DQL : 검색(웹사이트 => 핵심(80%))
                   목록, 로그인, 상세보기, 예약, 결제 ... 검색, 페이징
                                SELECT문장은 종류
              => 명령어 : SELECT
                 테이블의 구조 : 데이터를 저장하는 공간(파일)
                            데이터베이스 : 폴더 ==> 자동생성 (XE)
                            테이블 : 파일(파일시스템 ==> DBMS)
                 1. 테이블의 구조
                               => column + row => 2차원 구조
                                CREATE TABLE member(
                       id VARCHAR2(10),
                       name VARCHAR2(51),
                       sex VARCHAR2(10),
                       phone VARCHAR2(20)
                   )
                   
                               -----------------------------
                                  id       name   sex    phone  =>column
                               -----------------------------
                    aaa    aaaa    a      aaa   =>row(인스턴스)
                               -----------------------------
                    bbb    bbbb    b      bbb   =>row(인스턴스)
                               -----------------------------

                   => 데이터별로 구분이 되어 있다. (관리가 쉽다)
                               => 데이터 읽기 / 쓰기가 편리
                               => 전체 데이터 읽기 / 원하는 데이터만 추출 / 지정된 데이터만 추출
                                    SELECT *         SELECT column1..    SELECT * FROM 테이블명 WHERE 조건문

                                검색하는 명령어 SELECT의 형식
                                SELECT * 또는 원하는 데이터 FROM 테이블명 (필수조건)
                                -------------------------------------
                                 [
                      WHERE 조건문 => 연산자
                                    ----------------------------
                                     GROUP BY 그룹 => 그룹별 처리 ===> 단독 사용 가능
                      HAVING ==> 단독사용이 불가능(GROUP BY가 있어야 사용이 가능)
                     ------------------------------
                      ORDER BY => 정렬 (ASC , DESC)
                                                | 컬렴명
                    ](옵션사항)

                    => 연산처리(조건문)
                      1. 산술연산자(+,-,*,/)
                                          + : 순수하게 산술연산만 가능(문자열 결합 => ||)
                                          /: 정수/정수 => 실수
                                          => 조건문보다 SELECT 뒤에서 주로 통계
                                     --------------------------------------------
                                     2. 비교연산자 : =, <>(!=), < , > , <= , >=
                                    3. 논리연산자 : AND , OR
                                    4. 대입연산자 : =
                        => WHERE 뒤에 = (같다)
                                        => 다른 곳에 = ( 대입 )
                           UPDATE 테이블명 SET name = '' WHERE id = '';
                                                                                   ----대입       ----- 같다
                                    5. IN : OR가 여러개 사용
                                                 deptno = 10 OR deptno = 20 OR deptno = 30 OR deptno = 40 OR deptno=50
                             => WHERE deptno in (10,20,30,40,50)
                             => 최대한 SQL문장을 줄여야한다., 검색 속도
                                                   -------------------------- 오라클 / 자바
                      6. NULL : 데이터가 없는 상태
                                                   => 데이터가 NULL일 때는 연산처리가 안된다.
                                                  
                                                  => IS NULL => NULL이라면
                              => IS NOT NULL => NULL이 아니라면
                                                  => 자바에서는 NULL을 제어하면 오류 발생 
                                                        String name = null;
                                  if(name.equals("aaa")) => NullPointerException
                                 
                      7. BETWEEN : >= AND <=
                                   기간 , 범위 => 페이징 기법
                      8. NOT : 부정 반대의 효과
                                                    NOT IN, NOT BETWEEN, NOT LIKE
                      9. LIKE : 유사문자열 검색
                                                     검색
                                                      % => 문자의 갯수 제한이 없다.
                                                      _ => 한글자
                                                      'A%' => A로 시작하는 모든 문자열
                                '%A' => A로 끝나는 모든 문자열
                                '%A%' => A가 포함된 모든 문자열(******) => 검색, 우편번호 찾기
                                                       => 1차(오라클 => SQL) : 우편번호를 만들어서 처리
                                                       => 2차(기술) : DAUM에서 제공
                                '_A%' => 2번째 문자가 A로 시작하는 모든 문자열
                                '__A__' => 5글자 중에 3번째 자리에 A가 있는 모든 문자열
                                     다중검색
                                    ---------
                                          A, B, C, D, E
                         WHERE ename LIKE '%A%'
                         OR ename LIKE '%B%'
                         OR ename LIKE '%C%'
                         OR ename LIKE '%D%'
                         OR ename LIKE '%E%'
                         
                         WHERE REGEXP_LIKE(ename,'A|B|C|D|E')
                      -------------------------------------------- WHERE 문장 뒤에서 사용 (조건문)
                                 =>  내장함수
     2) DDL : 테이블 생성 , 뷰 생성 , 시퀀스 생성 , 인덱스
                        생성 : CREATE
                        삭제 : DROP
                        수정 : ALTER
     3) DML : 추가, 수정, 삭제
                         추가:INSERT
                         수정:UPDATE
                         삭제:DELETE
     4) TCL : 일괄처리 => 한번에 저장, 명령어 취소
                           한번에 저장 : COMMIT
                           명령어 취소 : ROLLBACK
     5) DCL : 사용자 계정 권한부여, 권한해제
                      ---------------------------- 제약이 많다.
                권한부여 : GRANT
                권한해제 : REVOKE
                ----------------------------------
                system / sysdba => 권한 부여
                           conn system/happy
                conn hr/happy
*/
-- 1. 데이터 검색 => table , column, 데이터형  => '12345' ==> DESC table명 ==> book
--DESC book;
-- 웹 => tomcat => web.xml
/*
 BOOKID                                    NOT NULL NUMBER(2)     =>구분자(PK) 중복이 없다.
 BOOKNAME                                           VARCHAR2(40)
 PUBLISHER                                          VARCHAR2(40)
 PRICE                                              NUMBER(8)
*/
--SELECT : 원하는 데이터만 출력 ==> 책이름 과 가격을 출력
SELECT bookname,price FROM book;

-- 가격이 20000원 미만인 도서 출력
SELECT bookname FROM book WHERE price<20000;

-- 가격이 12000이상 20000이하는 책이름과 가격을 출력
SELECT bookname "책이름" , price "가격" FROM book WHERE price BETWEEN 12000 AND 20000;

SELECT bookname "책이름" , price "가격" FROM book WHERE price >= 12000 AND price <= 20000;

-- 출판사가 굿스포츠 혹은 대한미디어인 도서를 검색
SELECT bookname FROM book WHERE publisher IN('굿스포츠','대한미디어');

-- '축구의 역사'를 출간한 출판사를 검색
SELECT publisher FROM book WHERE bookname='축구의 역사';

-- 도서이름에 '축구'가 포함된 출판사를 검색
SELECT publisher FROM book WHERE bookname LIKE '%축구%';

-- 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색
SELECT bookname FROM book WHERE bookname LIKE '_구%';

-- 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색
SELECT bookname FROM book WHERE price>=20000 AND bookname LIKE '%축구%';

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색
SELECT bookname FROM book WHERE publisher IN('굿스포츠','대한미디어');