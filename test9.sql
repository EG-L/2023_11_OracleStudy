--157 page �����Լ��� GROUP BY
/*
    �����Լ� => ���� COLUMN����
       *** �������Լ��� �÷��� �����Լ��� ���� ��� �� �� ����.
             SELECT ename,COUNT() => ����
             => ������ �Լ� , �÷� ���ÿ� ����� ����(GROUP�� ��쿡�� ����)
      --------
        COUNT(ROW�� ����) => �α��� , ���̵� �ߺ� , ��ٱ���..
         => COUNT(�÷���) => NULL���� ����
               => COUNT(*) => NULL���� ����
        *** MAX => ������ �÷��� �ִ� : �ڵ�������ȣ (MAX+1)
               => MAX(sal), MAX(empno)
        MIN => ������ �÷��� �ּҰ�
        ***AVG : ��� AVG(sal) 
        ***SUM : �� SUM(sal)
             -------------------------------> ������ �� �ݾ�
        ***RANK : ���� RANK() OVER(ORDER BY �÷���) => �ڵ� ������ �ȴ�.
                  1
           2
           2
          ---
           4
        ***DENSE_RANK : ����
                  1
                  2
           2
          ---
           3
        GROUP => ���� �����͸� ��Ƽ� ���� (���� ����)
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
