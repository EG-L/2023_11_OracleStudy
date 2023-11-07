--����Ŭ 2���� ==> ������ / �����Լ� / ORDER BY

/*
     => ����
        => ��������
        => DDL (Table����)

        1) DQL : �˻�(������Ʈ => �ٽ�(80%))
                   ���, �α���, �󼼺���, ����, ���� ... �˻�, ����¡
                                SELECT������ ����
              => ��ɾ� : SELECT
                 ���̺��� ���� : �����͸� �����ϴ� ����(����)
                            �����ͺ��̽� : ���� ==> �ڵ����� (XE)
                            ���̺� : ����(���Ͻý��� ==> DBMS)
                 1. ���̺��� ����
                               => column + row => 2���� ����
                                CREATE TABLE member(
                       id VARCHAR2(10),
                       name VARCHAR2(51),
                       sex VARCHAR2(10),
                       phone VARCHAR2(20)
                   )
                   
                               -----------------------------
                                  id       name   sex    phone  =>column
                               -----------------------------
                    aaa    aaaa    a      aaa   =>row(�ν��Ͻ�)
                               -----------------------------
                    bbb    bbbb    b      bbb   =>row(�ν��Ͻ�)
                               -----------------------------

                   => �����ͺ��� ������ �Ǿ� �ִ�. (������ ����)
                               => ������ �б� / ���Ⱑ ��
                               => ��ü ������ �б� / ���ϴ� �����͸� ���� / ������ �����͸� ����
                                    SELECT *         SELECT column1..    SELECT * FROM ���̺�� WHERE ���ǹ�

                                �˻��ϴ� ��ɾ� SELECT�� ����
                                SELECT * �Ǵ� ���ϴ� ������ FROM ���̺�� (�ʼ�����)
                                -------------------------------------
                                 [
                      WHERE ���ǹ� => ������
                                    ----------------------------
                                     GROUP BY �׷� => �׷캰 ó�� ===> �ܵ� ��� ����
                      HAVING ==> �ܵ������ �Ұ���(GROUP BY�� �־�� ����� ����)
                     ------------------------------
                      ORDER BY => ���� (ASC , DESC)
                                                | �÷Ÿ�
                    ](�ɼǻ���)

                    => ����ó��(���ǹ�)
                      1. ���������(+,-,*,/)
                                          + : �����ϰ� ������길 ����(���ڿ� ���� => ||)
                                          /: ����/���� => �Ǽ�
                                          => ���ǹ����� SELECT �ڿ��� �ַ� ���
                                     --------------------------------------------
                                     2. �񱳿����� : =, <>(!=), < , > , <= , >=
                                    3. �������� : AND , OR
                                    4. ���Կ����� : =
                        => WHERE �ڿ� = (����)
                                        => �ٸ� ���� = ( ���� )
                           UPDATE ���̺�� SET name = '' WHERE id = '';
                                                                                   ----����       ----- ����
                                    5. IN : OR�� ������ ���
                                                 deptno = 10 OR deptno = 20 OR deptno = 30 OR deptno = 40 OR deptno=50
                             => WHERE deptno in (10,20,30,40,50)
                             => �ִ��� SQL������ �ٿ����Ѵ�., �˻� �ӵ�
                                                   -------------------------- ����Ŭ / �ڹ�
                      6. NULL : �����Ͱ� ���� ����
                                                   => �����Ͱ� NULL�� ���� ����ó���� �ȵȴ�.
                                                  
                                                  => IS NULL => NULL�̶��
                              => IS NOT NULL => NULL�� �ƴ϶��
                                                  => �ڹٿ����� NULL�� �����ϸ� ���� �߻� 
                                                        String name = null;
                                  if(name.equals("aaa")) => NullPointerException
                                 
                      7. BETWEEN : >= AND <=
                                   �Ⱓ , ���� => ����¡ ���
                      8. NOT : ���� �ݴ��� ȿ��
                                                    NOT IN, NOT BETWEEN, NOT LIKE
                      9. LIKE : ���繮�ڿ� �˻�
                                                     �˻�
                                                      % => ������ ���� ������ ����.
                                                      _ => �ѱ���
                                                      'A%' => A�� �����ϴ� ��� ���ڿ�
                                '%A' => A�� ������ ��� ���ڿ�
                                '%A%' => A�� ���Ե� ��� ���ڿ�(******) => �˻�, �����ȣ ã��
                                                       => 1��(����Ŭ => SQL) : �����ȣ�� ���� ó��
                                                       => 2��(���) : DAUM���� ����
                                '_A%' => 2��° ���ڰ� A�� �����ϴ� ��� ���ڿ�
                                '__A__' => 5���� �߿� 3��° �ڸ��� A�� �ִ� ��� ���ڿ�
                                     ���߰˻�
                                    ---------
                                          A, B, C, D, E
                         WHERE ename LIKE '%A%'
                         OR ename LIKE '%B%'
                         OR ename LIKE '%C%'
                         OR ename LIKE '%D%'
                         OR ename LIKE '%E%'
                         
                         WHERE REGEXP_LIKE(ename,'A|B|C|D|E')
                      -------------------------------------------- WHERE ���� �ڿ��� ��� (���ǹ�)
                                 =>  �����Լ�
     2) DDL : ���̺� ���� , �� ���� , ������ ���� , �ε���
                        ���� : CREATE
                        ���� : DROP
                        ���� : ALTER
     3) DML : �߰�, ����, ����
                         �߰�:INSERT
                         ����:UPDATE
                         ����:DELETE
     4) TCL : �ϰ�ó�� => �ѹ��� ����, ��ɾ� ���
                           �ѹ��� ���� : COMMIT
                           ��ɾ� ��� : ROLLBACK
     5) DCL : ����� ���� ���Ѻο�, ��������
                      ---------------------------- ������ ����.
                ���Ѻο� : GRANT
                �������� : REVOKE
                ----------------------------------
                system / sysdba => ���� �ο�
                           conn system/happy
                conn hr/happy
*/
-- 1. ������ �˻� => table , column, ��������  => '12345' ==> DESC table�� ==> book
--DESC book;
-- �� => tomcat => web.xml
/*
 BOOKID                                    NOT NULL NUMBER(2)     =>������(PK) �ߺ��� ����.
 BOOKNAME                                           VARCHAR2(40)
 PUBLISHER                                          VARCHAR2(40)
 PRICE                                              NUMBER(8)
*/
--SELECT : ���ϴ� �����͸� ��� ==> å�̸� �� ������ ���
SELECT bookname,price FROM book;

-- ������ 20000�� �̸��� ���� ���
SELECT bookname FROM book WHERE price<20000;

-- ������ 12000�̻� 20000���ϴ� å�̸��� ������ ���
SELECT bookname "å�̸�" , price "����" FROM book WHERE price BETWEEN 12000 AND 20000;

SELECT bookname "å�̸�" , price "����" FROM book WHERE price >= 12000 AND price <= 20000;

-- ���ǻ簡 �½����� Ȥ�� ���ѹ̵���� ������ �˻�
SELECT bookname FROM book WHERE publisher IN('�½�����','���ѹ̵��');

-- '�౸�� ����'�� �Ⱓ�� ���ǻ縦 �˻�
SELECT publisher FROM book WHERE bookname='�౸�� ����';

-- �����̸��� '�౸'�� ���Ե� ���ǻ縦 �˻�
SELECT publisher FROM book WHERE bookname LIKE '%�౸%';

-- �����̸��� ���� �� ��° ��ġ�� '��'��� ���ڿ��� ���� ������ �˻�
SELECT bookname FROM book WHERE bookname LIKE '_��%';

-- �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻�
SELECT bookname FROM book WHERE price>=20000 AND bookname LIKE '%�౸%';

-- ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻�
SELECT bookname FROM book WHERE publisher IN('�½�����','���ѹ̵��');