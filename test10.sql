-- 오라클 GROUP BY / JOIN / SUBQUERY
/*
      orders
      ORDERID                                   NOT NULL NUMBER(2) => 구매번호 ( 중복 없는 데이터 )
      CUSTID                                             NUMBER(2) => 고객번호
      BOOKID                                             NUMBER(2) => 책번호
      SALEPRICE                                          NUMBER(8) => 가격
      ORDERDATE                                          DATE      => 구매일
*/
-- SUM => 총합 => 구매한 책의 총 가격 
SELECT SUM(saleprice) FROM orders;
-- COUNT => 갯수 => 구매한 사람의 수
SELECT COUNT(*) FROM orders;
SELECT custid FROM orders;

SELECT DISTINCT custid FROM orders;

SELECT COUNT(DISTINCT custid) FROM orders;

-- 구매된 책 중에 가장 비싼 책은 얼마인가? => MAX
SELECT MAX(saleprice),MIN(saleprice),AVG(saleprice) FROM orders;

/*
    GROUP BY : 지정된 그룹별로  따로 통계
                        ------------- 같은 값을 가지고 있는 경우
       emp : 부서번호 , 입사년도, 직위
            ---> 부서별로 인원수, 급여의 총합, 급여 평균, 최대값, 최소값
                    --------
*/
--10
SELECT COUNT(*) "인원수", SUM(sal) "급여총합", AVG(sal) "평균", MAX(sal) "최대값", MIN(sal) "최소값" FROM emp WHERE deptno=10;

SELECT deptno,COUNT(*) "인원수", SUM(sal) "급여총합", AVG(sal) "평균", MAX(sal) "최대값", MIN(sal) "최소값" FROM emp GROUP BY deptno ORDER BY deptno;

-- 직위별

SELECT job,COUNT(*) "인원수", SUM(sal) "급여총합", AVG(sal) "평균", MAX(sal) "최대값", MIN(sal) "최소값" FROM emp GROUP BY job ORDER BY job;

-- 입사년도별로

SELECT SUBSTR(hiredate,1,2),COUNT(*) "인원수", SUM(sal) "급여총합", AVG(sal) "평균", MAX(sal) "최대값", MIN(sal) "최소값" FROM emp GROUP BY SUBSTR(hiredate,1,2) ORDER BY SUBSTR(hiredate,1,2);

SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*) "인원수", SUM(sal) "급여총합", AVG(sal) "평균", MAX(sal) "최대값", MIN(sal) "최소값" FROM emp GROUP BY TO_CHAR(hiredate,'YYYY') ORDER BY TO_CHAR(hiredate,'YYYY');

-- 요일별로 통계

SELECT TO_CHAR(hiredate,'DY'),COUNT(*) "인원수", SUM(sal) "급여총합", AVG(sal) "평균", MAX(sal) "최대값", MIN(sal) "최소값" FROM emp GROUP BY TO_CHAR(hiredate,'DY') ORDER BY TO_CHAR(hiredate,'DY');

-- 부서별 통계-> 전체 급여의 평균보다 작은 부서만 출력하시오.
/*
 EMPNO                                     NOT NULL NUMBER(4)
 ENAME                                              VARCHAR2(10)
 JOB                                                VARCHAR2(9)
 MGR                                                NUMBER(4)
 HIREDATE                                           DATE
 SAL                                                NUMBER(7,2)
 COMM                                               NUMBER(7,2)
 DEPTNO                                             NUMBER(2)
*/
SELECT deptno ,COUNT(*) "인원수", SUM(sal) "급여총합", AVG(sal) "평균", MAX(sal) "최대값", MIN(sal) "최소값"
FROM emp GROUP BY deptno HAVING AVG(sal)<2073;
-- 각 부서별 => 성과금을 받는 인원수  출력

SELECT deptno ,COUNT(*) FROM emp WHERE comm IS NOT NULL AND comm<>0 GROUP BY deptno;
-- WHERE 문장은 GROUP BY에서 사용할 수 없다.(GROUP BY는 HAVING을 이용)
/*
   GROUP BY 사용시에는 출력컬럼명과 GROUP BY 컬럼명이 동일

     SELECT job,COUNT(*) FROM emp GROUP BY deptno <== 오류
                 ------------                                 -----
                              ㄴ-------------------------| 둘이 일치해야 함
      SELECT 문장의 순서
      
      FROM
      WHERE
      GROUP BY
    HAVING
    SELECT
    ORDER BY
*/
SELECT deptno,job,COUNT(*),AVG(sal),SUM(sal) FROM emp GROUP BY deptno,job ORDER BY deptno,job DESC; 