-- �̸��� �빮�ڷ� ������ �ҹ��ڷ� �̸��� ù���ڸ� �빮�� �������� �ҹ��ڷ� ����Ͻÿ�.

SELECT UPPER(ename),LOWER(job),INITCAP(ename) FROM emp;

-- �̸��� scott�� ����� �̸��� ������ ����ϴµ� where���� scott�� �ҹ��ڷ� �˻��ؼ� ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE LOWER(ename)='scott';

-- �Ʒ��� ���� ����� ����Ͻÿ�.
SELECT ename,SUBSTR(ename,1,3) "SUBSTR" FROM emp;

-- �̸��� ù��° ö�ڸ� ����ϴµ� �ҹ��ڷ� ��µǰ� �Ͻÿ�.
SELECT LOWER(SUBSTR(ename,1,1)) "SUBSTR" FROM emp;

-- UPPER LOWER SUBSTR�� ����Ͽ� �Ʒ��� ���� ���ڷ� ����Ͻÿ�.
SELECT UPPER(SUBSTR(ename,1,1))||LOWER(SUBSTR(ename,2,LENGTH(ename)-1)) FROM emp;

-- �̸��� M�ڸ� �����ϰ� �ִ� ������� �̸��� ������ ���
SELECT ename,sal FROM emp WHERE ename LIKE '%M%';

-- �̸��� EN �Ǵ� IN�� �����ϰ� �ִ� ������� �̸��� �Ի����� ����ϴµ� �ֱٿ� �Ի��� ������ ���
SELECT ename,hiredate FROM emp WHERE ename LIKE '%EN%' OR ename LIKE '%IN%' ORDER BY hiredate DESC;

-- ������ SALESMAN�� ������� ��� �̸��� ������ ������ ����ϴµ� ������ ���� ������� ����Ͻÿ�.
SELECT ename,job,sal FROM emp WHERE LOWER(job)='salesman' ORDER BY sal DESC;

-- �̸��� ù���ڰ� A�� �����ϴ� ������� �̸��� ���ް� ������ ����Ͻÿ�.
SELECT ename,sal,job FROM emp WHERE ename LIKE 'A%';

-- ������ 1000���� 3000 ������ ������� �̸��� ���ް� �Ի����� ����ϴµ� �Ի����� ���� �Ի��� ������� ���
SELECT ename,sal,hiredate FROM emp WHERE sal BETWEEN 1000 AND 3000 ORDER BY hiredate DESC;

-- 1981�⵵�� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename,hiredate FROM emp WHERE TO_CHAR(hiredate,'YYYY') = '1981';

-- instr �Լ��� �̿��ؼ� �̸��� A�ڸ� �����ϰ� �ִ� ������� �̸��� ����Ͻÿ�.
SELECT ename FROM emp WHERE INSTR(ename,'A',1,1) <> 0;

-- �̸��� ������ ����ϴµ� ������ ��ü 10�ڸ��� ����ϰ� ������ �ڸ��� *�� ����Ͻÿ�.
SELECT ename,RPAD(sal,10,'*') FROM emp;

-- LENGTH �Լ��� �̿��ؼ� �̸��� �̸��� ö���� ������ ����Ͻÿ�.
SELECT ename,LENGTH(ename) FROM emp;

-- �̸�,�Ի��� ��¥���� ���ñ��� �� ���� �ٹ��ߴ��� �Ҽ��� �ڿ��� �߶� ����Ͻÿ�.
SELECT ename,TRUNC(MONTHS_BETWEEN(sysdate,hiredate)) FROM emp;

-- ���ú��� 100�޵��� ��¥ ���
SELECT ADD_MONTHS(sysdate,100) FROM dual;

--���ú��� ������ ���ƿ� ������ ��¥�� ��� �Ͻÿ�.
SELECT NEXT_DAY(sysdate,'��') FROM dual;

-- �̹��� ������ ��¥�� ����Ͻÿ�.
SELECT LAST_DAY(sysdate) FROM dual;

-- ������ ���� �������� ����Ͻÿ�.

SELECT TO_CHAR(sysdate,'DY') FROM dual;

-- �̸��� �Ի��� ������ ����Ͻÿ�.

SELECT ename, TO_CHAR(hiredate,'DY')||'����' FROM emp;

-- ����Ͽ� �Ի��� ������� �̸��� �Ի���, �Ի��� ������ ����Ͻÿ�.

SELECT ename, hiredate, TO_CHAR(hiredate,'DY')||'����' FROM emp WHERE TO_CHAR(hiredate,'DY') ='��';

-- �̸��� Ŀ�̼��� ����ϴµ� Ŀ�̼��� null�� ������� no comm���� ����Ͻÿ�.
SELECT ename,NVL(TO_CHAR(DECODE(comm,0,'no comm',comm,comm)),'no comm') FROM emp;