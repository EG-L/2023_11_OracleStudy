-- 이름은 대문자로 직업은 소문자로 이름의 첫글자를 대문자 나머지는 소문자로 출력하시오.

SELECT UPPER(ename),LOWER(job),INITCAP(ename) FROM emp;

-- 이름이 scott인 사원의 이름과 월급을 출력하는데 where절에 scott의 소문자로 검색해서 출력하시오.
SELECT ename,sal FROM emp WHERE LOWER(ename)='scott';

-- 아래의 쿼리 결과를 출력하시오.
SELECT ename,SUBSTR(ename,1,3) "SUBSTR" FROM emp;

-- 이름의 첫번째 철자만 출력하는데 소문자로 출력되게 하시오.
SELECT LOWER(SUBSTR(ename,1,1)) "SUBSTR" FROM emp;

-- UPPER LOWER SUBSTR을 사용하여 아래와 같은 글자로 출력하시오.
SELECT UPPER(SUBSTR(ename,1,1))||LOWER(SUBSTR(ename,2,LENGTH(ename)-1)) FROM emp;

-- 이름에 M자를 포함하고 있는 사원들의 이름과 월급을 출력
SELECT ename,sal FROM emp WHERE ename LIKE '%M%';

-- 이름에 EN 또는 IN을 포함하고 있는 사원들의 이름과 입사일을 출력하는데 최근에 입사한 순서로 출력
SELECT ename,hiredate FROM emp WHERE ename LIKE '%EN%' OR ename LIKE '%IN%' ORDER BY hiredate DESC;

-- 직업이 SALESMAN인 사원들의 사원 이름과 직업과 월급을 출력하는데 월급이 높은 사원부터 출력하시오.
SELECT ename,job,sal FROM emp WHERE LOWER(job)='salesman' ORDER BY sal DESC;

-- 이름의 첫글자가 A로 시작하는 사원들의 이름과 월급과 직업을 출력하시오.
SELECT ename,sal,job FROM emp WHERE ename LIKE 'A%';

-- 월급이 1000에서 3000 사이인 사원들의 이름과 월급과 입사일을 출력하는데 입사일을 먼저 입사한 사원부터 출력
SELECT ename,sal,hiredate FROM emp WHERE sal BETWEEN 1000 AND 3000 ORDER BY hiredate DESC;

-- 1981년도에 입사한 사원들의 이름과 입사일을 출력하시오.
SELECT ename,hiredate FROM emp WHERE TO_CHAR(hiredate,'YYYY') = '1981';

-- instr 함수를 이용해서 이름에 A자를 포함하고 있는 사원들의 이름을 출력하시오.
SELECT ename FROM emp WHERE INSTR(ename,'A',1,1) <> 0;

-- 이름과 월급을 출력하는데 월급을 전체 10자리로 출력하고 나머지 자리는 *로 출력하시오.
SELECT ename,RPAD(sal,10,'*') FROM emp;

-- LENGTH 함수를 이용해서 이름과 이름의 철자의 갯수를 출력하시오.
SELECT ename,LENGTH(ename) FROM emp;

-- 이름,입사한 날짜부터 오늘까지 총 몇일 근무했는지 소수점 뒤에는 잘라서 출력하시오.
SELECT ename,TRUNC(MONTHS_BETWEEN(sysdate,hiredate)) FROM emp;

-- 오늘부터 100달뒤의 날짜 출력
SELECT ADD_MONTHS(sysdate,100) FROM dual;

--오늘부터 앞으로 돌아올 월요일 날짜를 출력 하시오.
SELECT NEXT_DAY(sysdate,'월') FROM dual;

-- 이번달 말일의 날짜를 출력하시오.
SELECT LAST_DAY(sysdate) FROM dual;

-- 오늘이 무슨 요일인지 출력하시오.

SELECT TO_CHAR(sysdate,'DY') FROM dual;

-- 이름과 입사한 요일을 출력하시오.

SELECT ename, TO_CHAR(hiredate,'DY')||'요일' FROM emp;

-- 목요일에 입사한 사원들의 이름과 입사일, 입사한 요일을 출력하시오.

SELECT ename, hiredate, TO_CHAR(hiredate,'DY')||'요일' FROM emp WHERE TO_CHAR(hiredate,'DY') ='목';

-- 이름과 커미션을 출력하는데 커미션이 null인 사원들은 no comm으로 출력하시오.
SELECT ename,NVL(TO_CHAR(DECODE(comm,0,'no comm',comm,comm)),'no comm') FROM emp;