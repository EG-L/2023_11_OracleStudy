-- 오라클 : 내장 함수 => GROUP / JOIN / SUBQUERY
-- DDL(Table 제작 => DML(INSERT,UPDATE,DELETE)) => 조별 1차 과제(INSERT (크롤링해서 오라클안에 수집))
-- VIEW / SEQUENCE / INDEX
-- PL/SQL (FUNCTION,PROCEDURE,TRIGGER)
-- 데이터베이스 모델링
/*
    내장 함수
          => 오라클에서 지원하는 라이브러리 , 사용자 정의 함수 (Function) => 업체마다 따로 ERP
          => 함수 : 재사용
             -------------> 모든 영역에 댓글이 가능하게 ... 
         => 오라클에서 지원하는 내장 함수
              1. 단일행 함수(row단위) => 튜플,로우
                  ROW 단위로 처리 => 한 줄씩 처리한다.
           문자 함수 : String
             => 변환 함수 
                          ***1) UPPER : 대문자로 변환 => UPPER('')
                          2) LOWER : 소문자로 변환 => LOWER('')
                3) INITCAP : 이니셜 변환 => INITCAP('')
                    => ABC => Abc ( 첫자만 대문자로 나머지는 소문자로 변환 )
                   => 제어함수
                       1) CONCAT : 문자열 결합
                                           CONCAT('A','B') => 'AB' ===> 'A'||'B'
                       ***2) REPLACE : 변경 
                                           REPLACE('Hello Oracle','l','k')  ==> Hekko Oracke
                                  --------------
                                   원본 => column , 변경대상, 변경할 문자
                       ***3) SUBSTR : 문자를 자르는 경우 (추출) => substring
                                                 SUBSTR('Hello Oracle',1,3) ==> Hel
                                                     -- 갯수
                              자바: 문자열 => index번호 => 0번부터 시작
                                               오라클: 문자열 => index번호 => 1번부터 시작
                       ***4) INSTR : 문자의 위치 확인 => 몇번째 있는지 확인
                                                  INSTR('ABCDEFG','D',1,1) => 4 리턴
                                                        --------- -- -- --
                                                         찾을 문자열,찾는 문자,시작위치,몇번쨰
                                                INSTR('ABCDABCD','A',1,2) => 5 리턴
                                   ------------------ 2번째 있는 A 위치
                       5) LPAD : 문자의 갯수가 초과되면 앞의 지정된 문자를 출력
                                            abcdefg => 12글자 요청 => *****abcdefg
                                            LPAD('ABC',10,'#') ==> #######ABC                                            
                       ***6) RPAD
                           RPAD('ABC',10,'#') ==> ABC#######
                       7) LTRIM : 왼쪽에 있는 문자 제거
                                             LTRIM('ABCDA') => 문자 지정하지 않을 시 왼쪽 공백 제거 => ABCDA
                                             LTRIM('ABCDA','A') => BCDA
                                         --- 제거할 문자
                       8) RTRIM
                           RTRIM('ABCDA','A') => 오른쪽에 있는 문자 제거
                                                                => 'ABCD'
                           TRIM('A' FROM 'ABCDA') => BCD => 동시제거
                       9) ASCII
                           => 문자를 번호로 변경 
                             ASCII('A') => 65
                      10) CHR
                           => 번호를 문자로 변경
                                                CHR(65) => 'A'
                      ***11) LENGTH : 문자 갯수
                           LENGTH(문자입력)
                                     ===> 함수 사용처
                                              1) SELECT 뒤에 사용
                                                    SELECT ename,LENGTH(ename) FROM emp;
                                                                         ------------- 글자수 확인
                                                    =>컬럼 대신에 사용
                                              2) WHERE 절에 사용
                                                    SELECT ename FROM emp WHERE LENGTH(ename) = 5;
                                              3) GROUP BY 뒤에 사용
                                              4) ORDER BY 뒤에 사용

                  숫자 함수 : Math
                          1) MOD => 나머지 함수
                                                MOD(5,2) => 1
                             SELECT empno,ename FROM emp WHERE MOD(empno,2) = 0; // 짝수 사번 출력
                          ***2) ROUND => 반올림 함수
                                                ROUND(123.5678,2) => 123.57 => 뒤의 두자리만 남김
                          3) TRUNC => 자릿수 버림 함수
                                                            TRUNC(1234.5678,2) => 1234.56 => 뒤의 두자리만 남기고 버림
                          ***4) CEIL => 올림 함수
                                                     => 총페이지 구하기
                                                     CEIL(1234.123) => 1235 정수 반환
                  날짜 함수 : Date
                     SYSDATE : 시스템의 날짜와 시간 출력
                                      => 정수와 같다.
                                      어제 SYSDATE-1
                                      내일 SYSDATE+1
                     ***MONTHS_BETWEEN : 현재부터 과거까지 개월 수 
                                      23/11/07 ~ 22/12/07 => 퇴직금 계산 / 연차 계산 / 호봉
                     ***ADD_MONTHS ==> 달을 추가
                                       ADD_MONTHS(SYSDATE,1) => 1달 추가
                                       ADD_MONTHS('23/09/11',7) => 7달 후의 날짜 계산
                     NEXT_DAY
                      NEXT_DAY(SYSDATE,'수') ==> 다음 날짜 계산
                     LAST_DAY => 지정한 달의 마지막일
                                   LAST_DAY(SYSDATE) ==> 11월 기준 => 30
                     
                  변환 함수 : Format
                     ***1) TO_CHAR : 문자 변환 => 숫자, 날짜.. String.valueOf()
                          숫자 변환 ==> 1,000
                     2) TO_NUMBER : 문자 => 숫자 변환 => Integer.ParseInt() 
                     3) TO_DATE : 날짜변환
                  기타 함수 : if , switch~case
              2. 집합행 함수(column단위) => 도메인
                  도메인 단위로 처리 ==> 분석, 통계(평균, 총합, 최대값, 최소값, ROW)
              3.  
*/ 
/*
SELECT UPPER(ename) "대문자", LOWER(ename) "소문자", INITCAP(ename) "이니셜" FROM emp;

SELECT empno,ename,hiredate FROM emp WHERE ename=UPPER('king');
*/

SELECT ename, SUBSTR(hiredate,1,2) FROM emp;

SELECT ename, SUBSTR(hiredate,7,2) FROM emp;

SELECT INSTR('ABCDEFG','D') FROM dual;

SELECT INSTR('ABCDABCD','A',1,2) FROM dual;

SELECT ename "이름", RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') "RPAD처리" FROM emp;

SELECT ASCII('A'),CHR(65) FROM dual;

SELECT LTRIM('ABCDA','A') , RTRIM('ABCDA','A'), TRIM('A' FROM 'ABCDA') FROM dual;

SELECT ename,LENGTH(ename) "글자수" FROM emp;

SELECT ename FROM emp WHERE LENGTH(ename)=5;

SELECT ROUND(123.45678,2) FROM dual;

SELECT CEIL(14/10),14/10 FROM dual;

SELECT SYSDATE-1, SYSDATE+1 FROM dual;

SELECT NEXT_DAY(SYSDATE,'화'),NEXT_DAY(SYSDATE,'수') FROM dual;

SELECT LAST_DAY(SYSDATE),LAST_DAY('23/10/01') FROM dual;

SELECT ADD_MONTHS('23/09/11',7) FROM dual;

SELECT ename,hiredate,TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE,hiredate))/12) FROM emp;

SELECT ename,hiredate,empno FROM emp WHERE empno='7788';
--                                               자동형변환
SELECT ename,hiredate,empno FROM emp WHERE empno=TO_NUMBER('7788');

SELECT ename,sal,TO_CHAR(sal,'L999,999')||'원' FROM emp;
-- ORACLE 999로 표현 ###이랑 같음
