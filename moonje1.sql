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
-- ����1) �����ȣ, �̸� , ������ ����Ͻÿ�.

SELECT empno,ename,sal FROM emp;

-- ����2) �̸� ���� ���� �Ի����� ����Ͻÿ�.

SELECT ename "�̸�",sal,job,hiredate FROM emp;

-- ����3) ����̸��� ������ ����ϴµ� �̸��� �÷����� employee��� �ϰ� ������ �÷�����
-- salary��� �Ͻÿ�.
SELECT ename "employee", sal "Salary" FROM emp;
--����4) ����̸��� �Ի����� ����ϴµ� ����̸��� �÷����� employee name���� ��µǰ� �Ͻÿ�.
SELECT ename "employee name",hiredate FROM emp;
--����5) ������ ����Ͻÿ�.(�ߺ�����)
SELECT DISTINCT job FROM emp;
--����6)�μ���ȣ�� ����ϴµ� �ߺ������ؼ� ����Ͻÿ�.
SELECT DISTINCT deptno FROM emp;
--����7)�����ȣ�� 7788���� ����� �����ȣ�� �̸��� ����Ͻÿ�.
SELECT empno,ename FROM emp WHERE empno=7788;
--����8)������ 3000�� ������� �̸��� ������ ���
SELECT ename,sal FROM emp WHERE sal = 3000;
--����9)�̸��� scott�� ����� �̸��� ������ ����Ͻÿ�.
SELECT ename,job FROM emp WHERE UPPER(ename)='SCOTT';
--����10)������ 3000�̻��� ������� �̸��� ������ ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE sal>=3000;
--����11)������ salesman�� �ƴ� ������� �̸��� ������ ����Ͻÿ�.
--SELECT ename,job FROM emp WHERE NOT job='salesman';
SELECT ename,job FROM emp WHERE LOWER(job)<>'salesman';
--����12)������ 1000���� 3000������ ������� �̸��� ������ ����ϴµ�, �÷�����
-- Employee, Salary�� ����Ͻÿ�.
--SELECT * FROM emp WHERE sal BETWEEN 1000 AND 3000;
SELECT ename "Employee",sal "Salary" FROM emp WHERE sal>=1000 AND sal<=3000;

--����13)����̸��� ������ ����ϴµ� ������ ���� ������� ���� ��������� ����Ͻÿ�.
SELECT ename,sal FROM emp ORDER BY sal;
--����14)�̸��� �Ի����� ����ϴµ� ���� �ֱٿ� �Ի��� ������� ����Ͻÿ�.
SELECT ename,hiredate FROM emp ORDER BY hiredate DESC;
--����15)������ SALESMAN�� ������� �̸��� ���ް� ������ ����ϴµ� ������ ���� ������� ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE UPPER(job)='SALESMAN' ORDER BY sal DESC;
--����16)������ 1000�̻��� ������� �̸��� ������ ����ϴµ� ������ ���� ������� ���� ��������� ���
SELECT ename,sal FROM emp WHERE sal>=1000 ORDER BY sal;
--����17)����(������*12)�� 36000 �̻��� ������� �̸��� ������ ����Ͻð� �÷����� ��Ī�� '����'����
SELECT ename,sal,sal*12 "����" FROM emp WHERE (sal*12)>=36000;
--����18)������ 1000���� 3000���̰� �ƴ� ������� �̸��� ������ ���
SELECT ename,sal FROM emp WHERE NOT sal BETWEEN 1000 AND 3000;
--����19)�̸��� ù ���ڰ� s�� �����ϴ� ������� �̸��� ���
SELECT ename FROM emp WHERE ename LIKE 'S%';
--����20) �̸��� �� ���ڰ� T�� ������ ������� �̸��� ���
SELECT ename FROM emp WHERE ename LIKE '%T';
--����21)�̸��� �ι�° ö�ڰ� M�� ������� �̸��� ���
SELECT ename FROM emp WHERE ename LIKE '_M%';
--����22)�̸��� �ι�° ö�ڰ� C�� ����� �̸��� ���
SELECT ename FROM emp WHERE ename LIKE '_C%';
--����23) �̸��� �ι�° ö�ڿ� ����° ö�ڰ� L�� ������� �̸��� ���
SELECT ename FROM emp WHERE ename LIKE '_LL%';
--����24) �̸��� ù��° ö�ڰ� S�� �ƴ� ������� �̸��� ���
SELECT ename FROM emp WHERE not ename LIKE 'S%';
--����25)��� ��ȣ 7788,7902,7369���� ������� �����ȣ�� �̸��� ���
SELECT empno,ename FROM emp WHERE empno IN(7788,7902,7369);
SELECT empno,ename FROM emp WHERE empno = 7788 OR empno = 7902 OR empno=7369;
-- ����26)������ SALESMAN ANALYST�� �ƴ� ������� �̸��� ������ ����Ͻÿ�.
SELECT ename,job FROM emp WHERE NOT job IN('SALESMAN','ANALYST');
SELECT ename,job FROM emp WHERE NOT(job = 'SALESMAN' OR job = 'ANALYST');
SELECT ename,job FROM emp WHERE (job<>'SALESMAN' AND job<>'ANALYST');
-- ����29)Ŀ�̼��� null�� ������� �̸��� Ŀ�̼��� ����Ͻÿ�.
SELECT ename,comm FROM emp WHERE (comm IS NULL OR comm = 0);
-- ����30) Ŀ�̼��� null�� �ƴ� ������� �̸��� Ŀ�̼��� ����Ͻÿ�.
SELECT ename,comm FROM emp WHERE comm IS NOT NULL;