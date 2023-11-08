--오라클 3일차 => 내장함수
/*
     SELECT 문장 => DQL (데이터 검색)
     => 관련된 데이터를 모아두는 장소 : 테이블
              사원정보, 회원정보,맛집정보,여행정보..
        정보를 저장하기 위해 => 컬럼 (멤버변수)
              컬럼 => 데이터형 ( 숫자(int,long) , 문자(char,String), 날짜(Date))
              => 컬럼 밑에 데이터를 첨부 => ROW
              => 확인
                DESC 테이블명 => 컬럼명과 데이터형만 확인
                  => users_tables => 오라클에 저장
                      ------------ user_views...
                  => 모든 테이블은 대문자로 저장 
                  => 테이블 생성 (같은 데이터베이스(XE) => 테이블이 중복 없이)
                       SELECT * FROM tab
        1) 형식
             SELECT * 또는 컬럼명 -------------------5 => 내장함수
             FROM 테이블명 -------------------------1
             [
           WHERE 조건문 ----------------------2 => 연산자
                  ---------------------
                  GROUP BY -------------------------3
           HAVING ---------------------------4
           ---------------------
           ORDER BY -------------------------6
        ]

        => 그룹별 처리 GROUP BY
             => 테이블을 연결해서 필요한 데이터 추출 ==> JOIN
                  예약 ====> 회원정보 
                  --- id,mno => 회원의 모든 정보 / 영화의 모든 정보
                    |
               영화정보
                         
                          customer / book / orders
               사용자정보   책정보    구매정보
                     => SQL문장이 여러개면 => 한개로 묶어서 SQL문장 1번 수행
                         SUBQUERY

                     => SQL => 조인 => 속도가 느려진다 , 메모리 저장 => 보안 노출
                          => 보완 (VIEW)
                     => 데이터 검색 => 정렬 => 속도가 느려진다.
                        => INDEX
                     => 번호 (중복(X)) => 자동증가 : SEQUENCE
             => abcdefghijklmnopqrstuvwzyz => alpha => 테이블 별칭  synonym
            ------------------- SQL문장이 계속 반복적 수행 : 메소드
                                                      PL/SQL => 프로시저
                      => 데이터베이스 모델링 (정규화) => Part 3장

             => 연산자
                산술연산자 : 산술만 처리 (+:문자열 결합은 할 수 없다)
                                   / => 정수/정수 = 실수
                                   '10'+'20'=30
                                   ----  ---- 자동 형변환
                             TO_NUMBER('10') => 10 
                비교연산자 : =, <> : 날짜와 문자열
                                같다,같지않다
                논리연산자 : AND(범위 포함) , OR(범위를 벗어난 경우 사용)
                     &&             || => 자바에서만 사용
                                  입력                   문자열 결합 =>오라클 내
                ---------
                NOT : !를 사용할 수 없다.
                NULL : 연산처리가 안되기 때문에 IS NULL , IS NOT NULL
                BETWEEN : 기간, 범위 설정 => 포함(이상 , 이하)
                IN : OR를 여러 개 사용시에 
                LIKE : 포함된 문자열 => 검색
                            % : 문자제한이 없다.
                 _ : 한글자
             => 내장함수
                 단일행 함수 : ROW 단위 처리, 튜플 단위 처리
                    문자형
                        =>UPPER => 대문자 변환 => UPPER('abc') => 'ABC'
              =>LENGTH=> 문자 갯수 => LENGTH('홍길동') => 3
                       => REPLACE=> 문자 변경 => REPLACE('ABCD','A','K') => KBCD
                           REPLACE(문자열,찾는문자,변경문자) => 다중문자변경 가능
                           => 크롤링 (이미지 => http => &(^),||가 포함)
                       => SUBSTR => 문자를 자르는 경우
                                           SUBSTR(문자열,첫번째위치,자를갯수)
                                           SUBSTR('abcdef',1,3) => abc
                          *** 자바는 문자열의 인덱스번호가 0번부터 시작하지만 오라클은 1번부터 시작한다.
                      => INSTR => 문자열의 인덱스 번호 추출
                                           INSTR(문자열,찾는문자,시작인덱스,몇번째 위치)
                                           INSTR('ABCDABC','A',1,2) => 5
                                                      --   --
                      => RPAD : 출력 개수 지정 => 모자를 시 지정된 문자를 출력
                                           => ID,PWD
                                         RPAD(문자열,출력갯수,채울 문자) => Right => 오른쪽에 채움
                                         RPAD('ABC',10,'*') => ABC*******
                         RPAD('ABCDEFG',5,'*') => ABCDE
                                         
                    숫자형
                                     => MOD : 나누고 나머지
                                          MOD(5/2) => 1
                                     ***=> ROUND : 반올림 함수
                                          ROUND(실수,자릿수)
                                          ROUND(1234.5678,2) => 1234.57
                      => TRUNC : 버림 함수
                                          TRUNC(78.678,2) => 78.67
                      ***=> CEIL : 올림함수  , 웹사이트 기본 페이징
                                                                              => 사람이 한 눈에 볼 수 있는 크기 15~20
                                          CEIL(실수) => 정수반환
                         CEIL(1234.678) => 1235
                         => PPT (7가지 이상 색상을 사용하면 ==)
                                          => 총페이지
                    날짜형
                                      ***=> SYSDATE : 시스템의 시간, 날짜 
                                               -------- 숫자이기 떄문에 산술연산 가능
                                               SYSDATE+1...
                                               => 주로 사용처(등록일 자동)
                                                    게시판, 댓글, 회원 가입, 예약 ...
                                      => MONTH_BETWEEN : 기간의 개월 수
                                          MONTH_BETWEEN(현재,과거) 
                                            => 'YY/MM/DD' => 23/11/09 => 예약
                                      => ADD_MONTHS : 추가된 달의 날짜
                                           => 지정된 뒤의 날짜
                                           => 1개월 단위
                                           ADD_MONTHS(SYSDATE,6) => 6개월 후의 날짜 계산
                    변환형
                                      ***=> TO_CHAR
                       1) 숫자 => 문자열
                                           L999,999
                                           $999,999
                                      2) 날짜 => 문자열 변경
                                                                     d : 일 => 1~31
                                        dd : 일 => 01,02,...10...31
                                                                   yy : 년도 23
                                                                 yyyy : 년도 2023
                                                                    rr : 년도 23
                                                                 rrrr : 년도 2023
                                       m/mm : 월
                                                                 hh(1~12)/hh24(1~24) : 시간
                                                                 mi / MI => 분
                                                                  s  / ss  => 초
                                                                  dy  => 요일
                                      ------------- 브라우저에서 날짜 출력 시에 주로 사용
                                                               ***TO_CHAR ==> 자바에서는 String으로 받는다.
                    기타형
                    ***=> NVL : NULL값을 원하는 데이터로 변경해서 사용
                          NVL(컬럼명, 대체값)
                                           NVL(comm, 0) => NULL값이 0으로 대체
                                           우편번호 => bunji => null값 대신에 공백(' ')으로 출력
                                            ** 브라우저는 null일 경우에 null로 출력
                       => DECODE : 다중 조건문 => Switch 
                                            DECODE(deptno,10,'영업부',20,'개발부',30,'총무부')
                                           DECODE(start,1,'★☆☆☆☆',2,'★★☆☆☆',3,'★★★☆☆')
                       => CASE : 다중 조건문 => if~else
                          CASE
                                               WHEN deptno = 10 THEN '개발부'
                            WHEN deptno = 20 THEN '영업부'
                            WHEN deptno = 30 THEN '총무부'
                          END "DNAME"
                 집합행 함수 : 도메인 단위 처리(column)
*/
/*
SELECT * FROM orders;
SELECT * FROM emp WHERE empno=&sabun;
*/
/*
SELECT RPAD('ABC',7,'*'),RPAD('ABCDEFG',5,'#') FROM dual;

SELECT ename , TO_CHAR(sal,'L999,999')||'원' FROM emp;
*/
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM dual;

SELECT TO_CHAR(SYSDATE,'RRRR-MM-DD') FROM dual;

SELECT TO_CHAR(SYSDATE,'HH:MI:SS') FROM dual;

SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') FROM dual;

SELECT TO_CHAR(SYSDATE,'DY') FROM dual;

SELECT TO_CHAR(SYSDATE,'YYYY"년도" MM"월" DD"일" HH24"시" MI"분" SS"초" DY"요일"') FROM dual;

-- emp 사원의 무슨 요일에 입사했는지 확인
SELECT ename,TO_CHAR(hiredate,'DY"요일"') "입사요일" FROM emp;

SELECT ename,TO_CHAR(hiredate,'DY"요일"') "입사요일" FROM emp WHERE TO_CHAR(hiredate,'DY')='목';

SELECT ename,job,hiredate,DECODE(deptno,10,'영업부',20,'개발부',30,'총무부',40,'신입') "dname" FROM emp;

SELECT ename,job,hiredate,CASE
                                               WHEN deptno = 10 THEN '개발부'
                            WHEN deptno = 20 THEN '영업부'
                            WHEN deptno = 30 THEN '총무부'
                          END "DNAME" FROM emp;