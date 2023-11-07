-- ����Ŭ 2���� => ���� => 155page
/*
   SELECT * �Ǵ� �÷��� FROM ���̺�� �Ǵ� ���̸�(�ʼ�����)
     [
      WHERE => ������
          GROUP BY => �׷캰 ó��
          HAVING => �׷쿡 ���� ����
          ORDER BY => ����
   ](���ǻ���)

   => ����Ŭ�� �ڵ� ������ �ȵȴ�.
                       -------- => ORDER BY ~ , INDEX_ASC , INDEX_DESC
   => ORDER BY�� ����
         => SELECT ������ �� �������� �߰�
        ---------------------------------- DEFAULT���� ASC
        => ORDER BY �÷���
        => ORDER BY �÷��� ASC
     ----------------------------------
        => ORDER BY �÷��� DESC
*/
-- �޿��� ���� ������ ���
/* 
SELECT ename,sal FROM emp;

SELECT ename,sal FROM emp ORDER BY sal DESC;

SELECT ename,sal FROM emp ORDER BY 2 DESC;

SELECT ename,sal FROM emp ORDER BY 1 DESC;
*/
-- ���� ���� ==> �亯�� �Խ���, ����
SELECT ename,sal FROM emp ORDER BY sal DESC,ename ASC;

SELECT ename,sal FROM emp ORDER BY 2 DESC, 1 ASC;

-- book => �������� ������������ ���
SELECT bookname "å �̸�" FROM book ORDER BY bookname DESC;

-- ������ , ���� ==> ������ ���� ������� ���
SELECT bookname "å �̸�",price "����" FROM book ORDER BY 2;

-- emp 
/*
 EMPNO   :���                                                                                                                NOT NULL NUMBER(4)
 ENAME   :�̸�
            VARCHAR2(10)
 JOB     :����
            VARCHAR2(9)
 MGR     :�����ȣ
            NUMBER(4)
 HIREDATE:�Ի���
            DATE
 SAL     :����
            NUMBER(7,2)
 COMM    :������
            NUMBER(7,2)
 DEPTNO  :�μ���ȣ
            NUMBER(2)

*/
-- ����� �̸��� �μ���ȣ�� ����Ͻÿ�.
SELECT ename,deptno FROM emp;

SELECT ename,deptno FROM emp ORDER BY deptno DESC;

-- emp���� �������� ���� ����� �̸�, �޿�, ������ ��� => �޿��� ���� ������ ���
SELECT ename "�̸�",sal "�޿�",comm "������" FROM emp WHERE (comm IS NULL OR comm = 0) ORDER BY 2 DESC;

-- emp���� 81�⿡ �Ի��� ����� �̸�,�Ի��� ��� => �Ի����� �ֱ��� ������� ���
SELECT  ename "�̸�",hiredate "�Ի���" FROM emp WHERE hiredate LIKE '81%' ORDER BY 2 DESC;

-- emp���� ����� �̸� �߿� A�ڰ� ���� �̸��� �޿� ��� �޿��� ���� �������
SELECT ename "�̸�", sal "�޿�" FROM emp WHERE ename NOT LIKE '%A%' ORDER BY sal DESC;

-- emp���� �Ŵ����� �ִ� ����� �̸��� �޿�, �Ի����� ���
-- �޿��� ���� ������ ��� ���� ��쿡�� �̸��� ���� ������ ���

SELECT ename "�̸�", sal "�޿�", hiredate "�Ի���",mgr "��� ���" FROM emp WHERE mgr IS NOT NULL ORDER BY sal DESC, ename;

-- ����� ���ϰ� �ִ� ��� ��ȣ�� �ߺ����� ���
SELECT DISTINCT mgr "��� ��ȣ" FROM emp WHERE mgr IS NOT NULL;

-- emp���� �Ի����� 82�� �����̰ų� ������ MANAGER�� ����� �̸�, ����, �Ի����� ���
SELECT ename "�̸�",job "����",hiredate "�Ի���" FROM emp WHERE hiredate > '82/12/31' OR job='MANAGER'; 

-- emp���� �̸� �߿� A�� 3��° �ִ� ����� ��� ������ ���
SELECT * FROM emp WHERE ename LIKE '__A%';