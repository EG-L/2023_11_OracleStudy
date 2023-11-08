-- ����Ŭ GROUP BY / JOIN / SUBQUERY
/*
      orders
      ORDERID                                   NOT NULL NUMBER(2) => ���Ź�ȣ ( �ߺ� ���� ������ )
      CUSTID                                             NUMBER(2) => ����ȣ
      BOOKID                                             NUMBER(2) => å��ȣ
      SALEPRICE                                          NUMBER(8) => ����
      ORDERDATE                                          DATE      => ������
*/
-- SUM => ���� => ������ å�� �� ���� 
SELECT SUM(saleprice) FROM orders;
-- COUNT => ���� => ������ ����� ��
SELECT COUNT(*) FROM orders;
SELECT custid FROM orders;

SELECT DISTINCT custid FROM orders;

SELECT COUNT(DISTINCT custid) FROM orders;

-- ���ŵ� å �߿� ���� ��� å�� ���ΰ�? => MAX
SELECT MAX(saleprice),MIN(saleprice),AVG(saleprice) FROM orders;

/*
    GROUP BY : ������ �׷캰��  ���� ���
                        ------------- ���� ���� ������ �ִ� ���
       emp : �μ���ȣ , �Ի�⵵, ����
            ---> �μ����� �ο���, �޿��� ����, �޿� ���, �ִ밪, �ּҰ�
                    --------
*/
--10
SELECT COUNT(*) "�ο���", SUM(sal) "�޿�����", AVG(sal) "���", MAX(sal) "�ִ밪", MIN(sal) "�ּҰ�" FROM emp WHERE deptno=10;

SELECT deptno,COUNT(*) "�ο���", SUM(sal) "�޿�����", AVG(sal) "���", MAX(sal) "�ִ밪", MIN(sal) "�ּҰ�" FROM emp GROUP BY deptno ORDER BY deptno;

-- ������

SELECT job,COUNT(*) "�ο���", SUM(sal) "�޿�����", AVG(sal) "���", MAX(sal) "�ִ밪", MIN(sal) "�ּҰ�" FROM emp GROUP BY job ORDER BY job;

-- �Ի�⵵����

SELECT SUBSTR(hiredate,1,2),COUNT(*) "�ο���", SUM(sal) "�޿�����", AVG(sal) "���", MAX(sal) "�ִ밪", MIN(sal) "�ּҰ�" FROM emp GROUP BY SUBSTR(hiredate,1,2) ORDER BY SUBSTR(hiredate,1,2);

SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*) "�ο���", SUM(sal) "�޿�����", AVG(sal) "���", MAX(sal) "�ִ밪", MIN(sal) "�ּҰ�" FROM emp GROUP BY TO_CHAR(hiredate,'YYYY') ORDER BY TO_CHAR(hiredate,'YYYY');

-- ���Ϻ��� ���

SELECT TO_CHAR(hiredate,'DY'),COUNT(*) "�ο���", SUM(sal) "�޿�����", AVG(sal) "���", MAX(sal) "�ִ밪", MIN(sal) "�ּҰ�" FROM emp GROUP BY TO_CHAR(hiredate,'DY') ORDER BY TO_CHAR(hiredate,'DY');

-- �μ��� ���-> ��ü �޿��� ��պ��� ���� �μ��� ����Ͻÿ�.
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
SELECT deptno ,COUNT(*) "�ο���", SUM(sal) "�޿�����", AVG(sal) "���", MAX(sal) "�ִ밪", MIN(sal) "�ּҰ�"
FROM emp GROUP BY deptno HAVING AVG(sal)<2073;
-- �� �μ��� => �������� �޴� �ο���  ���

SELECT deptno ,COUNT(*) FROM emp WHERE comm IS NOT NULL AND comm<>0 GROUP BY deptno;
-- WHERE ������ GROUP BY���� ����� �� ����.(GROUP BY�� HAVING�� �̿�)
/*
   GROUP BY ���ÿ��� ����÷���� GROUP BY �÷����� ����

     SELECT job,COUNT(*) FROM emp GROUP BY deptno <== ����
                 ------------                                 -----
                              ��-------------------------| ���� ��ġ�ؾ� ��
      SELECT ������ ����
      
      FROM
      WHERE
      GROUP BY
    HAVING
    SELECT
    ORDER BY
*/
SELECT deptno,job,COUNT(*),AVG(sal),SUM(sal) FROM emp GROUP BY deptno,job ORDER BY deptno,job DESC; 