-- 149page ==> ���ǰ˻�
/*
     ����Ŭ���� �����ϴ� ��������
         = ������
            *** �ѱ��� �ѱ��ڴ� 3byte CHAR(4) = '����'; ==> ���� �߻�
                                                   CHAR(6) = '����';
            CHAR(1~2000����Ʈ) : ��������Ʈ
             data CHAR(100)
             data = 'A' ==> 1byte ==> �޸𸮴� 100����Ʈ�� �����Ѵ�. : �޸� ���� ����
                  => ��� ���� ������ ũ�⸦ ������ �ִ� ���
            ***VARCHAR2(1~4000����Ʈ) : ������
             data VARCHAR(2)
        data = 'A'; ==> 1byte => �޸𸮴� 1����Ʈ�� �����Ѵ�.
            CLOB : �ٰŸ� , �ڼҼ�... 4�Ⱑ ���� ( ������ )
           ------------------------------------------- �ڹٿ��� String���� �޴´�.
         = ������ => ����/�Ǽ� ǥ��
            NUMBER ================> �ڸ����� 8�ڸ�
            NUMBER(4) =============> �ڸ����� 4�ڸ� 0, 100, 10, 1000 => 9999���� ��� ����
            NUMBER(7,2) ===========> 7�ڸ����� ����� ���� (�ʿ��ϸ� 2�ڸ��� �Ҽ������� ���)
               => 800 = double d = 800;
           -------------------------------------------- ����(int), �Ǽ�(double)
         = ��¥�� => DATE
                  --------------- YY/MM/DD => java.util.Date  (java.sql.Date ==> X)
         = ��Ÿ�� (4�Ⱑ => ������ , ����, �̹���)
                   binary ���� => BLOB 
                   file ����  => BFILE
        ------------------------------------ java.io.inputStream

         => �߿�
                    ��¥/���ڿ� = ''
                    ����� �����ʹ� ��ҹ��� ����

        ����Ŭ���� �����ϴ� ������(149page)
         => ��������� ( +, -, *, /) => %�� ����. (�������� => MOD()�� ����)
            *** /�� 0���� ���� �� ����.
                ����/���� => �Ǽ� = 5/2 => 2.5
                    *** ���� SELECT �ڿ��� ��� (WHERE���� ����� �ȵȴ� => ���ǹ� : true/false)
            *** ��������ڴ� ����� �� �� �ִ�.
                                             ------
                ���ڿ� ���� : || 
               => �񱳿����� :
                           = : ����.
                          != , <>, ^=: ���� �ʴ�. (��������� <>�� ����Ѵ�.)
                           < : �۴�.
                          > : ũ��.
                <=: ���ų� �۴�.
                          >= : ũ�ų� ����.
               => ��������
                                    AND , OR
                      => &&(�Է°� ���� ���), ||(���ڿ� ����) 
                        
               => NOT������
                              ���� ������
                               SELECT * FROM emp WHERE NOT ename='KING';  ==> ename <> 'KING'
                   => NOT IN(), NOT BETWEEN, NOT LIKE
               => BETWEEN ~ AND : �Ⱓ, ������ ���� >= AND <=
                  BETWEEN 1 AND 10 => 1~10
                  >=1 AND <=10 => page ������, ������
         => NULL : �ּҰ� ���� ���� (�� ��ü�� �������� �ʴ� ���)
                    *** NULL�� �ִ� ��쿡�� ��� ������ ������� �ʴ´�.
                    ename = null (X)
                    NULL�� ��� => IS NULL
                    NULL�� �ƴ� ��� => IS NOT NULL
          = IN ������
                    WHERE deptno = 10 OR deptno = 20 OR deptno = 30
                             --------------------------------------
                  WHERE deptno IN(10,20,30)
         => LIKE : �˻� ( %, _ )
                               %�� ������ ������ �𸣴� ���
                       = startsWith ==> 'A%' (A�� �����ϴ� ��� ���ڿ�)
                       = endsWith ==> '%A' (A�� ������ ��� ���ڿ�)
                       = contains ==> '%A%' (A�� ���Ե� ��� ���ڿ�)
                       = _ : �ѱ��� '___A_' ==> '__A%'
              ---------> 'A%' 'A__'
              ---------> REGEXP_LIKE() �Լ�
                => ����Ʈ �����
                    ------------
                     => �˻�
                       -----
                 |����� => �˻��� �Է�
                            |���α׷��� => WHERE title LIKE '%�˻���%';
          = ������ ���� 
                    WHERE �÷��� ������ ��
                             --------------- true�� ���� false�� �̼���
                    WHERE�� if���� ����
                    if(���ǹ�) => ��������� => SELECT �ڿ��� ���
                  

        
*/
/*
SELECT ename,sal FROM emp;
SELECT ename||' '||job FROM emp;
SELECT empno,ename FROM emp WHERE empno=&&sabun;
*/

/*
-- ��������� ==> ������ ���̺� => DUAL
SELECT 5+2,5-2,5*2,5/2,MOD(5,2) FROM DUAL;
*/
/*
--null���� ����ó���� �ȵȴ�.
SELECT ename as �̸� ,sal as �޿�, comm as ������, sal+NVL(comm,0) as �����Ѿ� FROM emp;
*/

--�񱳿�����
-- =����.
/*
SELECT ename,hiredate,job,sal FROM emp WHERE ename='KING';
SELECT ename,hiredate,job,sal FROM emp WHERE ename='SCOTT';

SELECT ename,hiredate,job,sal FROM emp WHERE hiredate='81/11/17';
SELECT ename,hiredate,job,sal FROM emp WHERE hiredate='81/12/11';

SELECT ename,hiredate,job,sal FROM emp WHERE empno=7788;
SELECT ename,hiredate,job,sal FROM emp WHERE empno=7904;
SELECT ename,hiredate,job,sal FROM emp WHERE empno=7900;

SELECT ename,hiredate,job,sal FROM emp WHERE job='MANAGER';
SELECT ename,hiredate,job,sal FROM emp WHERE job='CLERK';
*/
-- ���� �ʴ�. !=, <> ,^=
-- ����Ŭ�� ������ ���� ������ ����� �� ����� ���� ����. (�м��� ��ƴ�)
SELECT ename,hiredate,job,sal FROM emp WHERE job<>'CLERK';
SELECT ename,hiredate,job,sal FROM emp WHERE NOT job='CLERK';
SELECT ename,hiredate,job,sal FROM emp WHERE job!='CLERK';
SELECT ename,hiredate,job,sal FROM emp WHERE job^='CLERK';

-- < �۴�(���� ����) => ���� , ���� , ��¥
/*
SELECT ename, sal FROM emp WHERE sal<2500;
-- ��ձ޿����� �۰� �޴� ���
SELECT ename, sal FROM emp WHERE sal<(SELECT AVG(sal) FROM emp);
*/

-- 81�� ������ �Ի��� ���
SELECT ename,sal,hiredate FROM emp WHERE hiredate<'81/01/01';

--KING���� ���� ��� ��� => ���ĺ��� (=,!=) => ��ҹ��� ����
SELECT ename,sal,hiredate FROM emp WHERE ename<'KING';
-- ��¥, ���ڿ� �˻� ����
-- > ũ��
-- �޿��� 2500���� ���� �޴� ����� �̸�, �޿� ���
SELECT ename,sal FROM emp WHERE sal>2500;

-- 81�� ���Ŀ� �Ի��� ==>�̸�,�Ի���,����
SELECT ename,hiredate,job FROM emp WHERE hiredate>'81/12/31';

-- <=
-- �޿��� 3000������ ����� �̸�, �޿� ���
SELECT ename,sal FROM emp WHERE sal<=3000;
/*
     ��������
         AND => ���Ŀ�����(����, �Ⱓ�� ����) ==> ~ AND ~ => BETWEEN
     (����) AND (����)
         TRUE          TRUE    = TRUE
         TRUE          FALSE  = FALSE
     FALSE     TRUE   = FALSE
     FALSE     FALSE  = FALSE
         OR => ���Ŀ�����(����, �Ⱓ�� ��� ���) => IN
     (����)  OR  (����)
      TRUE      TRUE  = TRUE
      TRUE      FALSE = TRUE
      FALSE     TRUE  = TRUE
      FALSE     FALSE = FALSE
*/
--AND
--�޿��� 1500�̻� 3000������ ����� �̸�, �޿�

SELECT ename,sal FROM emp WHERE sal>=1500 AND sal<=3000;
SELECT ename,sal FROM emp WHERE sal BETWEEN 1500 AND 3000;

-- 81�⿡ �Ի��� ��� (�̸�, �Ի���)
SELECT ename,hiredate FROM emp WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';

SELECT ename,hiredate FROM emp WHERE hiredate LIKE '81%';

SELECT ename,hiredate FROM emp WHERE substr(hiredate,1,2)=81;

-- OR
-- �μ���ȣ (deptno) 10 �̰ų� 20 �̰ų� 30�� �μ����� �ٹ��ϴ� ����� �̸��� �μ���ȣ ���
SELECT ename,deptno FROM emp WHERE deptno=10 OR deptno = 20 OR deptno = 30;
SELECT ename,deptno FROM emp WHERE deptno in(10,20,30);

-- ������ (job) => MAnager or CLERK�� ����� ��� ������ ���

SELECT * FROM emp WHERE job in('MANAGER','CLERK');

-- NULL ������
-- NULL�� ����ó���� �ȵǴ� ������ => IS NULL(NULL���̸�) , IS NOT NULL(NULL���� �ƴϸ�)
-- 1. IS NULL => ����� ���� ��� ����� �̸�, �Ի��� ���
SELECT ename,hiredate FROM emp WHERE mgr IS NULL;

-- 2. ��� �߿� �������� ���� ����� �̸� �޿�, ������ ���
SELECT ename as �̸�, sal as �޿�, comm as ������ FROM emp WHERE comm IS NULL:

-- 3. ��� �߿� �������� �޴� ��� ��� , �� 0�� �������� �ʴ´�.
SELECT ename as �̸�, sal as �޿�, comm as ������ FROM emp WHERE comm IS NOT NULL AND comm <> 0;

-- BETWEEN AND �޿��� 1500�̻��̰� 3000���ϰ� �ƴ� ����� �̸� �޿� ���
SELECT ename,sal FROM emp WHERE sal NOT BETWEEN 1500 AND 3000;

-- job�� MANAGER , CLERK�� �ƴ� ����� �̸��ϰ� ���� ���
SELECT ename,job FROM emp WHERE job not in('MANAGER','CLERK');

-- LIKE : �˻�
-- 'A%'
-- ����߿� A�� �����ϴ� �̸��� ��� ���� ���
SELECT * FROM emp WHERE ename LIKE 'A%';

-- ����߿� T�� ������ �̸��� ��� ��� ���� ���
SELECT * FROM emp WHERE ename LIKE '%T';

-- ����߿� ������ �̸��� IN, EN�� ����� ��� ������ ���
SELECT * FROM emp WHERE NOT(ename LIKE '%IN' OR ename LIKE '%EN');