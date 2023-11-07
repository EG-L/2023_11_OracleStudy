-- ����Ŭ : ���� �Լ� => GROUP / JOIN / SUBQUERY
-- DDL(Table ���� => DML(INSERT,UPDATE,DELETE)) => ���� 1�� ����(INSERT (ũ�Ѹ��ؼ� ����Ŭ�ȿ� ����))
-- VIEW / SEQUENCE / INDEX
-- PL/SQL (FUNCTION,PROCEDURE,TRIGGER)
-- �����ͺ��̽� �𵨸�
/*
    ���� �Լ�
          => ����Ŭ���� �����ϴ� ���̺귯�� , ����� ���� �Լ� (Function) => ��ü���� ���� ERP
          => �Լ� : ����
             -------------> ��� ������ ����� �����ϰ� ... 
         => ����Ŭ���� �����ϴ� ���� �Լ�
              1. ������ �Լ�(row����) => Ʃ��,�ο�
                  ROW ������ ó�� => �� �پ� ó���Ѵ�.
           ���� �Լ� : String
             => ��ȯ �Լ� 
                          ***1) UPPER : �빮�ڷ� ��ȯ => UPPER('')
                          2) LOWER : �ҹ��ڷ� ��ȯ => LOWER('')
                3) INITCAP : �̴ϼ� ��ȯ => INITCAP('')
                    => ABC => Abc ( ù�ڸ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ )
                   => �����Լ�
                       1) CONCAT : ���ڿ� ����
                                           CONCAT('A','B') => 'AB' ===> 'A'||'B'
                       ***2) REPLACE : ���� 
                                           REPLACE('Hello Oracle','l','k')  ==> Hekko Oracke
                                  --------------
                                   ���� => column , ������, ������ ����
                       ***3) SUBSTR : ���ڸ� �ڸ��� ��� (����) => substring
                                                 SUBSTR('Hello Oracle',1,3) ==> Hel
                                                     -- ����
                              �ڹ�: ���ڿ� => index��ȣ => 0������ ����
                                               ����Ŭ: ���ڿ� => index��ȣ => 1������ ����
                       ***4) INSTR : ������ ��ġ Ȯ�� => ���° �ִ��� Ȯ��
                                                  INSTR('ABCDEFG','D',1,1) => 4 ����
                                                        --------- -- -- --
                                                         ã�� ���ڿ�,ã�� ����,������ġ,�����
                                                INSTR('ABCDABCD','A',1,2) => 5 ����
                                   ------------------ 2��° �ִ� A ��ġ
                       5) LPAD : ������ ������ �ʰ��Ǹ� ���� ������ ���ڸ� ���
                                            abcdefg => 12���� ��û => *****abcdefg
                                            LPAD('ABC',10,'#') ==> #######ABC                                            
                       ***6) RPAD
                           RPAD('ABC',10,'#') ==> ABC#######
                       7) LTRIM : ���ʿ� �ִ� ���� ����
                                             LTRIM('ABCDA') => ���� �������� ���� �� ���� ���� ���� => ABCDA
                                             LTRIM('ABCDA','A') => BCDA
                                         --- ������ ����
                       8) RTRIM
                           RTRIM('ABCDA','A') => �����ʿ� �ִ� ���� ����
                                                                => 'ABCD'
                           TRIM('A' FROM 'ABCDA') => BCD => ��������
                       9) ASCII
                           => ���ڸ� ��ȣ�� ���� 
                             ASCII('A') => 65
                      10) CHR
                           => ��ȣ�� ���ڷ� ����
                                                CHR(65) => 'A'
                      ***11) LENGTH : ���� ����
                           LENGTH(�����Է�)
                                     ===> �Լ� ���ó
                                              1) SELECT �ڿ� ���
                                                    SELECT ename,LENGTH(ename) FROM emp;
                                                                         ------------- ���ڼ� Ȯ��
                                                    =>�÷� ��ſ� ���
                                              2) WHERE ���� ���
                                                    SELECT ename FROM emp WHERE LENGTH(ename) = 5;
                                              3) GROUP BY �ڿ� ���
                                              4) ORDER BY �ڿ� ���

                  ���� �Լ� : Math
                          1) MOD => ������ �Լ�
                                                MOD(5,2) => 1
                             SELECT empno,ename FROM emp WHERE MOD(empno,2) = 0; // ¦�� ��� ���
                          ***2) ROUND => �ݿø� �Լ�
                                                ROUND(123.5678,2) => 123.57 => ���� ���ڸ��� ����
                          3) TRUNC => �ڸ��� ���� �Լ�
                                                            TRUNC(1234.5678,2) => 1234.56 => ���� ���ڸ��� ����� ����
                          ***4) CEIL => �ø� �Լ�
                                                     => �������� ���ϱ�
                                                     CEIL(1234.123) => 1235 ���� ��ȯ
                  ��¥ �Լ� : Date
                     SYSDATE : �ý����� ��¥�� �ð� ���
                                      => ������ ����.
                                      ���� SYSDATE-1
                                      ���� SYSDATE+1
                     ***MONTHS_BETWEEN : ������� ���ű��� ���� �� 
                                      23/11/07 ~ 22/12/07 => ������ ��� / ���� ��� / ȣ��
                     ***ADD_MONTHS ==> ���� �߰�
                                       ADD_MONTHS(SYSDATE,1) => 1�� �߰�
                                       ADD_MONTHS('23/09/11',7) => 7�� ���� ��¥ ���
                     NEXT_DAY
                      NEXT_DAY(SYSDATE,'��') ==> ���� ��¥ ���
                     LAST_DAY => ������ ���� ��������
                                   LAST_DAY(SYSDATE) ==> 11�� ���� => 30
                     
                  ��ȯ �Լ� : Format
                     ***1) TO_CHAR : ���� ��ȯ => ����, ��¥.. String.valueOf()
                          ���� ��ȯ ==> 1,000
                     2) TO_NUMBER : ���� => ���� ��ȯ => Integer.ParseInt() 
                     3) TO_DATE : ��¥��ȯ
                  ��Ÿ �Լ� : if , switch~case
              2. ������ �Լ�(column����) => ������
                  ������ ������ ó�� ==> �м�, ���(���, ����, �ִ밪, �ּҰ�, ROW)
              3.  
*/ 
/*
SELECT UPPER(ename) "�빮��", LOWER(ename) "�ҹ���", INITCAP(ename) "�̴ϼ�" FROM emp;

SELECT empno,ename,hiredate FROM emp WHERE ename=UPPER('king');
*/

SELECT ename, SUBSTR(hiredate,1,2) FROM emp;

SELECT ename, SUBSTR(hiredate,7,2) FROM emp;

SELECT INSTR('ABCDEFG','D') FROM dual;

SELECT INSTR('ABCDABCD','A',1,2) FROM dual;

SELECT ename "�̸�", RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') "RPADó��" FROM emp;

SELECT ASCII('A'),CHR(65) FROM dual;

SELECT LTRIM('ABCDA','A') , RTRIM('ABCDA','A'), TRIM('A' FROM 'ABCDA') FROM dual;

SELECT ename,LENGTH(ename) "���ڼ�" FROM emp;

SELECT ename FROM emp WHERE LENGTH(ename)=5;

SELECT ROUND(123.45678,2) FROM dual;

SELECT CEIL(14/10),14/10 FROM dual;

SELECT SYSDATE-1, SYSDATE+1 FROM dual;

SELECT NEXT_DAY(SYSDATE,'ȭ'),NEXT_DAY(SYSDATE,'��') FROM dual;

SELECT LAST_DAY(SYSDATE),LAST_DAY('23/10/01') FROM dual;

SELECT ADD_MONTHS('23/09/11',7) FROM dual;

SELECT ename,hiredate,TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE,hiredate))/12) FROM emp;

SELECT ename,hiredate,empno FROM emp WHERE empno='7788';
--                                               �ڵ�����ȯ
SELECT ename,hiredate,empno FROM emp WHERE empno=TO_NUMBER('7788');

SELECT ename,sal,TO_CHAR(sal,'L999,999')||'��' FROM emp;
-- ORACLE 999�� ǥ�� ###�̶� ����
