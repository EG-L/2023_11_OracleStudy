--157 page 집계함수와 GROUP BY
/*
    집합함수 => 단위 COLUMN단위
       *** 단일행함수나 컬럼은 집합함수와 같이 사용 할 수 없다.
             SELECT ename,COUNT() => 오류
             => 단일행 함수 , 컬럼 동시에 사용이 가능(GROUP인 경우에는 가능)
      --------
        COUNT(ROW의 갯수) => 로그인 , 아이디 중복 , 장바구니..
         => COUNT(컬럼명) => NULL값을 제외
               => COUNT(*) => NULL값을 포함
        *** MAX => 지정된 컬럼의 최댓값 : 자동증가번호 (MAX+1)
               => MAX(sal), MAX(empno)
        MIN => 지정된 컬럼의 최소값
        ***AVG : 평균 AVG(sal) 
        ***SUM : 합 SUM(sal)
             -------------------------------> 구매한 총 금액
        ***RANK : 순위 RANK() OVER(ORDER BY 컬럼명) => 자동 정렬이 된다.
                  1
           2
           2
          ---
           4
        ***DENSE_RANK : 순위
                  1
                  2
           2
          ---
           3
        GROUP => 같은 데이터를 모아서 관리 (따로 관리)
        ***CUBE
        ***ROLLUP
        ---------- GROUP
*/
/*
SELECT deptno,COUNT(*) FROM emp GROUP BY deptno;
*/

SELECT COUNT(mgr),COUNT(comm),COUNT(*) FROM emp;

SELECT MAX(sal) FROM emp;

SELECT AVG(sal),SUM(sal) FROM emp;

SELECT ename,sal,DENSE_RANK() OVER(ORDER BY sal DESC) "RANK" FROM emp;
