/*

 EMPNO                                                                                                             NOT NULL NUMBER(4)
 ENAME
            VARCHAR2(10)
 JOB
            VARCHAR2(9)
 MGR
            NUMBER(4)
 HIREDATE
            DATE
 SAL
            NUMBER(7,2)
 COMM
            NUMBER(7,2)
 DEPTNO
            NUMBER(2)
*/
-- 문제1) 사원번호, 이름 , 월급을 출력하시오.

SELECT empno,ename,sal FROM emp;

-- 문제2) 이름 월급 직업 입사일을 출력하시오.

SELECT ename "이름",sal,job,hiredate FROM emp;

-- 문제3) 사원이름과 월급을 출력하는데 이름의 컬럼명을 employee라고 하고 월급의 컬럼명을
-- salary라고 하시오.
SELECT ename "employee", sal "Salary" FROM emp;
--문제4) 사원이름과 입사일을 출력하는데 사원이름의 컬러명이 employee name으로 출력되게 하시오.
SELECT ename "employee name",hiredate FROM emp;
--문제5) 직위를 출력하시오.(중복없이)
SELECT DISTINCT job FROM emp;
--문제6)부서번호를 출력하는데 중복제거해서 출력하시오.
SELECT DISTINCT deptno FROM emp;
--문제7)사원번호가 7788번인 사원의 사원번호와 이름을 출력하시오.
SELECT empno,ename FROM emp WHERE empno=7788;
--문제8)월급이 3000인 사원들의 이름과 월급을 출력
SELECT ename,sal FROM emp WHERE sal = 3000;
--문제9)이름이 scott인 사원의 이름과 직업을 출력하시오.
SELECT ename,job FROM emp WHERE UPPER(ename)='SCOTT';
--문제10)월급이 3000이상인 사원들의 이름과 월급을 출력하시오.
SELECT ename,sal FROM emp WHERE sal>=3000;
--문제11)직업이 salesman이 아닌 사원들의 이름과 직업을 출력하시오.
--SELECT ename,job FROM emp WHERE NOT job='salesman';
SELECT ename,job FROM emp WHERE LOWER(job)<>'salesman';
--문제12)월급이 1000에서 3000사이인 사원들의 이름과 월급을 출력하는데, 컬럼명을
-- Employee, Salary로 출력하시오.
--SELECT * FROM emp WHERE sal BETWEEN 1000 AND 3000;
SELECT ename "Employee",sal "Salary" FROM emp WHERE sal>=1000 AND sal<=3000;

--문제13)사원이름과 월급을 출력하는데 월급이 낮은 사원부터 높은 사원순으로 출력하시오.
SELECT ename,sal FROM emp ORDER BY sal;
--문제14)이름과 입사일을 출력하는데 가장 최근에 입사한 사원부터 출력하시오.
SELECT ename,hiredate FROM emp ORDER BY hiredate DESC;
--문제15)직업이 SALESMAN인 사원들의 이름과 월급과 직업을 출력하는데 월급이 높은 사원부터 출력하시오.
SELECT ename,sal FROM emp WHERE UPPER(job)='SALESMAN' ORDER BY sal DESC;
--문제16)월급이 1000이상인 사원들의 이름과 월급을 출력하는데 월급이 낮은 사원부터 높은 사원순으로 출력
SELECT ename,sal FROM emp WHERE sal>=1000 ORDER BY sal;
--문제17)연봉(샐러리*12)이 36000 이상인 사원들의 이름과 연봉을 출력하시고 컬럼명의 별칭은 '연봉'으로
SELECT ename,sal,sal*12 "연봉" FROM emp WHERE (sal*12)>=36000;
--문제18)월급이 1000에서 3000사이가 아닌 사원들의 이름과 월급을 출력
SELECT ename,sal FROM emp WHERE NOT sal BETWEEN 1000 AND 3000;
--문제19)이름의 첫 글자가 s로 시작하는 사원들의 이름을 출력
SELECT ename FROM emp WHERE ename LIKE 'S%';
--문제20) 이름의 끝 글자가 T로 끝나는 사원들의 이름을 출력
SELECT ename FROM emp WHERE ename LIKE '%T';
--문제21)이름의 두번째 철자가 M인 사원들의 이름을 출력
SELECT ename FROM emp WHERE ename LIKE '_M%';
--문제22)이름의 두번째 철자가 C인 사원의 이름을 출력
SELECT ename FROM emp WHERE ename LIKE '_C%';
--문제23) 이름의 두번째 철자와 세번째 철자가 L인 사원들의 이름을 출력
SELECT ename FROM emp WHERE ename LIKE '_LL%';
--문제24) 이름의 첫번째 철자가 S가 아닌 사원들의 이름을 출력
SELECT ename FROM emp WHERE not ename LIKE 'S%';
--문제25)사원 번호 7788,7902,7369번인 사원들의 사원번호와 이름을 출력
SELECT empno,ename FROM emp WHERE empno IN(7788,7902,7369);
SELECT empno,ename FROM emp WHERE empno = 7788 OR empno = 7902 OR empno=7369;
-- 문제26)직업이 SALESMAN ANALYST가 아닌 사원들의 이름과 직업을 출력하시오.
SELECT ename,job FROM emp WHERE NOT job IN('SALESMAN','ANALYST');
SELECT ename,job FROM emp WHERE NOT(job = 'SALESMAN' OR job = 'ANALYST');
SELECT ename,job FROM emp WHERE (job<>'SALESMAN' AND job<>'ANALYST');
-- 문제29)커미션이 null인 사원들의 이름과 커미션을 출력하시오.
SELECT ename,comm FROM emp WHERE (comm IS NULL OR comm = 0);
-- 문제30) 커미션이 null이 아닌 사원들의 이름과 커미션을 출력하시오.
SELECT ename,comm FROM emp WHERE comm IS NOT NULL;