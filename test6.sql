-- 오라클 2일차 => 정렬 => 155page
/*
   SELECT * 또는 컬럼명 FROM 테이블명 또는 뷰이름(필수사항)
     [
      WHERE => 연산자
          GROUP BY => 그룹별 처리
          HAVING => 그룹에 대한 조건
          ORDER BY => 정렬
   ](조건사항)

   => 오라클은 자동 정렬이 안된다.
                       -------- => ORDER BY ~ , INDEX_ASC , INDEX_DESC
   => ORDER BY의 사용법
         => SELECT 문장의 맨 마지막에 추가
        ---------------------------------- DEFAULT값은 ASC
        => ORDER BY 컬럼명
        => ORDER BY 컬럼명 ASC
     ----------------------------------
        => ORDER BY 컬럼명 DESC
*/
-- 급여가 높은 순으로 출력
/* 
SELECT ename,sal FROM emp;

SELECT ename,sal FROM emp ORDER BY sal DESC;

SELECT ename,sal FROM emp ORDER BY 2 DESC;

SELECT ename,sal FROM emp ORDER BY 1 DESC;
*/
-- 이중 정렬 ==> 답변형 게시판, 대댓글
SELECT ename,sal FROM emp ORDER BY sal DESC,ename ASC;

SELECT ename,sal FROM emp ORDER BY 2 DESC, 1 ASC;

-- book => 도서명을 내림차순으로 출력
SELECT bookname "책 이름" FROM book ORDER BY bookname DESC;

-- 도서명 , 가격 ==> 가격이 낮은 순서대로 출력
SELECT bookname "책 이름",price "가격" FROM book ORDER BY 2;

-- emp 
/*
 EMPNO   :사번                                                                                                                NOT NULL NUMBER(4)
 ENAME   :이름
            VARCHAR2(10)
 JOB     :직위
            VARCHAR2(9)
 MGR     :사수번호
            NUMBER(4)
 HIREDATE:입사일
            DATE
 SAL     :연봉
            NUMBER(7,2)
 COMM    :성과금
            NUMBER(7,2)
 DEPTNO  :부서번호
            NUMBER(2)

*/
-- 사원의 이름과 부서번호를 출력하시오.
SELECT ename,deptno FROM emp;

SELECT ename,deptno FROM emp ORDER BY deptno DESC;

-- emp에서 성과금이 없는 사원의 이름, 급여, 성과금 출력 => 급여가 높은 순으로 출력
SELECT ename "이름",sal "급여",comm "성과금" FROM emp WHERE (comm IS NULL OR comm = 0) ORDER BY 2 DESC;

-- emp에서 81년에 입사한 사원의 이름,입사일 출력 => 입사일이 최근인 사원부터 출력
SELECT  ename "이름",hiredate "입사일" FROM emp WHERE hiredate LIKE '81%' ORDER BY 2 DESC;

-- emp에서 사원의 이름 중에 A자가 없는 이름과 급여 출력 급여가 높은 순서대로
SELECT ename "이름", sal "급여" FROM emp WHERE ename NOT LIKE '%A%' ORDER BY sal DESC;

-- emp에서 매니저가 있는 사원의 이름과 급여, 입사일을 출력
-- 급여가 높은 순으로 출력 같은 경우에는 이름을 낮은 순으로 출력

SELECT ename "이름", sal "급여", hiredate "입사일",mgr "사수 사번" FROM emp WHERE mgr IS NOT NULL ORDER BY sal DESC, ename;

-- 사수로 일하고 있는 사수 번호를 중복없이 출력
SELECT DISTINCT mgr "사수 번호" FROM emp WHERE mgr IS NOT NULL;

-- emp에서 입사일이 82년 이후이거나 직위가 MANAGER인 사원의 이름, 직위, 입사일을 출력
SELECT ename "이름",job "직위",hiredate "입사일" FROM emp WHERE hiredate > '82/12/31' OR job='MANAGER'; 

-- emp에서 이름 중에 A가 3번째 있는 사원의 모든 정보를 출력
SELECT * FROM emp WHERE ename LIKE '__A%';