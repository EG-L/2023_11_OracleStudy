--����Ŭ 3���� => �����Լ�
/*
     SELECT ���� => DQL (������ �˻�)
     => ���õ� �����͸� ��Ƶδ� ��� : ���̺�
              �������, ȸ������,��������,��������..
        ������ �����ϱ� ���� => �÷� (�������)
              �÷� => �������� ( ����(int,long) , ����(char,String), ��¥(Date))
              => �÷� �ؿ� �����͸� ÷�� => ROW
              => Ȯ��
                DESC ���̺�� => �÷���� ���������� Ȯ��
                  => users_tables => ����Ŭ�� ����
                      ------------ user_views...
                  => ��� ���̺��� �빮�ڷ� ���� 
                  => ���̺� ���� (���� �����ͺ��̽�(XE) => ���̺��� �ߺ� ����)
                       SELECT * FROM tab
        1) ����
             SELECT * �Ǵ� �÷��� -------------------5 => �����Լ�
             FROM ���̺�� -------------------------1
             [
           WHERE ���ǹ� ----------------------2 => ������
                  ---------------------
                  GROUP BY -------------------------3
           HAVING ---------------------------4
           ---------------------
           ORDER BY -------------------------6
        ]

        => �׷캰 ó�� GROUP BY
             => ���̺��� �����ؼ� �ʿ��� ������ ���� ==> JOIN
                  ���� ====> ȸ������ 
                  --- id,mno => ȸ���� ��� ���� / ��ȭ�� ��� ����
                    |
               ��ȭ����
                         
                          customer / book / orders
               ���������   å����    ��������
                     => SQL������ �������� => �Ѱ��� ��� SQL���� 1�� ����
                         SUBQUERY

                     => SQL => ���� => �ӵ��� �������� , �޸� ���� => ���� ����
                          => ���� (VIEW)
                     => ������ �˻� => ���� => �ӵ��� ��������.
                        => INDEX
                     => ��ȣ (�ߺ�(X)) => �ڵ����� : SEQUENCE
             => abcdefghijklmnopqrstuvwzyz => alpha => ���̺� ��Ī  synonym
            ------------------- SQL������ ��� �ݺ��� ���� : �޼ҵ�
                                                      PL/SQL => ���ν���
                      => �����ͺ��̽� �𵨸� (����ȭ) => Part 3��

             => ������
                ��������� : ����� ó�� (+:���ڿ� ������ �� �� ����)
                                   / => ����/���� = �Ǽ�
                                   '10'+'20'=30
                                   ----  ---- �ڵ� ����ȯ
                             TO_NUMBER('10') => 10 
                �񱳿����� : =, <> : ��¥�� ���ڿ�
                                ����,�����ʴ�
                �������� : AND(���� ����) , OR(������ ��� ��� ���)
                     &&             || => �ڹٿ����� ���
                                  �Է�                   ���ڿ� ���� =>����Ŭ ��
                ---------
                NOT : !�� ����� �� ����.
                NULL : ����ó���� �ȵǱ� ������ IS NULL , IS NOT NULL
                BETWEEN : �Ⱓ, ���� ���� => ����(�̻� , ����)
                IN : OR�� ���� �� ���ÿ� 
                LIKE : ���Ե� ���ڿ� => �˻�
                            % : ���������� ����.
                 _ : �ѱ���
             => �����Լ�
                 ������ �Լ� : ROW ���� ó��, Ʃ�� ���� ó��
                    ������
                        =>UPPER => �빮�� ��ȯ => UPPER('abc') => 'ABC'
              =>LENGTH=> ���� ���� => LENGTH('ȫ�浿') => 3
                       => REPLACE=> ���� ���� => REPLACE('ABCD','A','K') => KBCD
                           REPLACE(���ڿ�,ã�¹���,���湮��) => ���߹��ں��� ����
                           => ũ�Ѹ� (�̹��� => http => &(^),||�� ����)
                       => SUBSTR => ���ڸ� �ڸ��� ���
                                           SUBSTR(���ڿ�,ù��°��ġ,�ڸ�����)
                                           SUBSTR('abcdef',1,3) => abc
                          *** �ڹٴ� ���ڿ��� �ε�����ȣ�� 0������ ���������� ����Ŭ�� 1������ �����Ѵ�.
                      => INSTR => ���ڿ��� �ε��� ��ȣ ����
                                           INSTR(���ڿ�,ã�¹���,�����ε���,���° ��ġ)
                                           INSTR('ABCDABC','A',1,2) => 5
                                                      --   --
                      => RPAD : ��� ���� ���� => ���ڸ� �� ������ ���ڸ� ���
                                           => ID,PWD
                                         RPAD(���ڿ�,��°���,ä�� ����) => Right => �����ʿ� ä��
                                         RPAD('ABC',10,'*') => ABC*******
                         RPAD('ABCDEFG',5,'*') => ABCDE
                                         
                    ������
                                     => MOD : ������ ������
                                          MOD(5/2) => 1
                                     ***=> ROUND : �ݿø� �Լ�
                                          ROUND(�Ǽ�,�ڸ���)
                                          ROUND(1234.5678,2) => 1234.57
                      => TRUNC : ���� �Լ�
                                          TRUNC(78.678,2) => 78.67
                      ***=> CEIL : �ø��Լ�  , ������Ʈ �⺻ ����¡
                                                                              => ����� �� ���� �� �� �ִ� ũ�� 15~20
                                          CEIL(�Ǽ�) => ������ȯ
                         CEIL(1234.678) => 1235
                         => PPT (7���� �̻� ������ ����ϸ� ==)
                                          => ��������
                    ��¥��
                                      ***=> SYSDATE : �ý����� �ð�, ��¥ 
                                               -------- �����̱� ������ ������� ����
                                               SYSDATE+1...
                                               => �ַ� ���ó(����� �ڵ�)
                                                    �Խ���, ���, ȸ�� ����, ���� ...
                                      => MONTH_BETWEEN : �Ⱓ�� ���� ��
                                          MONTH_BETWEEN(����,����) 
                                            => 'YY/MM/DD' => 23/11/09 => ����
                                      => ADD_MONTHS : �߰��� ���� ��¥
                                           => ������ ���� ��¥
                                           => 1���� ����
                                           ADD_MONTHS(SYSDATE,6) => 6���� ���� ��¥ ���
                    ��ȯ��
                                      ***=> TO_CHAR
                       1) ���� => ���ڿ�
                                           L999,999
                                           $999,999
                                      2) ��¥ => ���ڿ� ����
                                                                     d : �� => 1~31
                                        dd : �� => 01,02,...10...31
                                                                   yy : �⵵ 23
                                                                 yyyy : �⵵ 2023
                                                                    rr : �⵵ 23
                                                                 rrrr : �⵵ 2023
                                       m/mm : ��
                                                                 hh(1~12)/hh24(1~24) : �ð�
                                                                 mi / MI => ��
                                                                  s  / ss  => ��
                                                                  dy  => ����
                                      ------------- ���������� ��¥ ��� �ÿ� �ַ� ���
                                                               ***TO_CHAR ==> �ڹٿ����� String���� �޴´�.
                    ��Ÿ��
                    ***=> NVL : NULL���� ���ϴ� �����ͷ� �����ؼ� ���
                          NVL(�÷���, ��ü��)
                                           NVL(comm, 0) => NULL���� 0���� ��ü
                                           �����ȣ => bunji => null�� ��ſ� ����(' ')���� ���
                                            ** �������� null�� ��쿡 null�� ���
                       => DECODE : ���� ���ǹ� => Switch 
                                            DECODE(deptno,10,'������',20,'���ߺ�',30,'�ѹ���')
                                           DECODE(start,1,'�ڡ١١١�',2,'�ڡڡ١١�',3,'�ڡڡڡ١�')
                       => CASE : ���� ���ǹ� => if~else
                          CASE
                                               WHEN deptno = 10 THEN '���ߺ�'
                            WHEN deptno = 20 THEN '������'
                            WHEN deptno = 30 THEN '�ѹ���'
                          END "DNAME"
                 ������ �Լ� : ������ ���� ó��(column)
*/
/*
SELECT * FROM orders;
SELECT * FROM emp WHERE empno=&sabun;
*/
/*
SELECT RPAD('ABC',7,'*'),RPAD('ABCDEFG',5,'#') FROM dual;

SELECT ename , TO_CHAR(sal,'L999,999')||'��' FROM emp;
*/
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM dual;

SELECT TO_CHAR(SYSDATE,'RRRR-MM-DD') FROM dual;

SELECT TO_CHAR(SYSDATE,'HH:MI:SS') FROM dual;

SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') FROM dual;

SELECT TO_CHAR(SYSDATE,'DY') FROM dual;

SELECT TO_CHAR(SYSDATE,'YYYY"�⵵" MM"��" DD"��" HH24"��" MI"��" SS"��" DY"����"') FROM dual;

-- emp ����� ���� ���Ͽ� �Ի��ߴ��� Ȯ��
SELECT ename,TO_CHAR(hiredate,'DY"����"') "�Ի����" FROM emp;

SELECT ename,TO_CHAR(hiredate,'DY"����"') "�Ի����" FROM emp WHERE TO_CHAR(hiredate,'DY')='��';

SELECT ename,job,hiredate,DECODE(deptno,10,'������',20,'���ߺ�',30,'�ѹ���',40,'����') "dname" FROM emp;

SELECT ename,job,hiredate,CASE
                                               WHEN deptno = 10 THEN '���ߺ�'
                            WHEN deptno = 20 THEN '������'
                            WHEN deptno = 30 THEN '�ѹ���'
                          END "DNAME" FROM emp;