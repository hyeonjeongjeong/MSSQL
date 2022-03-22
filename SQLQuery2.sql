/*
CREATE TABLE EMP
(EMPNO int not null,
ENAME VARCHAR(10),
JOB VARCHAR(9),
MGR int,
HIREDATE datetime,
SAL int,
COMM int,
DEPTNO int);

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);


CREATE TABLE DEPT
(DEPTNO int,
DNAME VARCHAR(14),
LOC VARCHAR(13) );


INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE BONUS
(
ENAME VARCHAR(10),
JOB VARCHAR(9),
SAL int,
COMM int
);


CREATE TABLE SALGRADE
( GRADE int,
LOSAL int,
HISAL int );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
*/


select * from emp;

select * from dept;

select * from salgrade;

/*
DDL(Data Definition Language): ������ ���� ���, �����ͺ��̽� ��ü�� ����/����/������ �������� ����ϴ� ���
CREATE ... : ���°� ����
ALTER ... : ����
DROP ... :����

DCL(Data Control Language): ������ ���� ���, ������ ��� �����ϰ� ����ϴ� ���, ���� �����͸� ������ �� �ִ����� �����ϴ� ���.
DB�����ڰ� �ַ� �ϴ� ����
GRANT : �������
REVOKE : grant �ߴٰ� ���� ����� ������
Deny : ���ٱ���

DML(Data Manipulation Language): ������ ���� ���, ������ ��ü�� ó���ϰ� �����ϱ� ���� ���
�����ڰ� �ؾ��ϴ� ~ 

SELECT : 60���� >> �Լ� , ����, ��������, �� ���

INSERT

UPDATE 

DELETE
*/


SELECT * FROM emp;

select * from dept;

select * from salgrade;

--1. ��� ���̺� �ִ� ��� ��� �����͸� ����ϼ���
select * 
from emp;

--2. Ư�� �÷��� (���, �̸� ,�޿� )�� ����ϼ���
select empno , ename, sal 
from emp;

--3. �μ����̺� �ִ� �μ� ��ȣ, �μ��̸� ����ϼ���
select deptno, dname from dept;

--4. �����ȣ, ����̸� �÷����� ��½� �ѱ۷� ..
select empno �����ȣ, ename ����̸� from emp;
select empno as '��� ��ȣ', ename as '��� �̸�' from emp;

--5. ������̺��� ������ ����ϼ���
-- �츮 ȸ�翡 ������ � �ֳ�?
select job from emp;
-- �ߺ��� �� �����ϰ� ��� distinct
select distinct job from emp;


--SQL (���) ���Ǹ� �� �� �ִ� ���
--������ 
--1. ���, ��, ��

--6. ������̺��� ���empno, �̸�ename, �޿�sal, 300�޷� �λ�� �޿��� ����ϼ���
select * from emp;
select empno, ename, sal, sal+300 as '�λ�޿�' from emp;

--7. ������̺��� ���, �̸�, �޿�, ������ ���
select empno, ename, sal, sal*12 as '����' from emp;

--8. Null (�ʿ��)  - �ʱް����ڴ� �̰� �߽���Ѵ�
--ȸ�� ���̺� .. ȸ����ȣ , ȸ����, �ڵ�����ȣ, ��� (�ʼ� �Է�, �ɼ� null ���)
select * from emp;

select empno, sal, comm from emp;
-- comm �����Ͱ� null >> Ŀ�̼��� ���� �ʴ±���..
-- 0�� ���� �ʴ°����� ��������.... 

--9. ������̺��� ���, �̸�, ����, �޿�, ����, �޿�+����
select empno, ename, job,sal, comm , sal+comm  as'�ѱ޿�' from emp;

--POINT ** Null ���� ��� ���� ����� >> Null
--NULL�� ó���ϴ� �Լ�..
--Oracle : nvl() >> select nvl(comm,0)
--Mysql : ifnull() >> select ifnull(comm.,0)
--Mssql : Isnull()

select sal+isnull(comm,0) from emp;
select empno, ename, job,sal, comm , sal+isnull(comm,0) as'�ѱ޿�' from emp;

/*
������� 
selct 3
from  1
where 2
*/
--������̺��� ����� 7788�� ����� ���, �̸�, �޿��� ����ϼ���
select empno, ename, sal
from emp
where empno =7788;

--������̺��� ����̸��� smith �� ����� ��������� ����Ͻÿ� 
select * from emp where ename = 'SMITH';

--Oracle�� ���ڿ� ��ҹ��ڸ� �� �� �� �� ������
--where ename = 'smith'; �ȳ���
--��𿡼����� ���ڿ� �����ʹ� �ִ� �״�� ���� ~~~ (�ҹ����̴� �빮���̴� �׷��� ��� ��� �ᵵ �������ܽ�)

--������̺��� �Ի��� 1980�� 12�� 17���� ����� ��� ���� ���
--��¥�����͵� �̸�ó�� '' ����ؼ� ������ ó��
select * from emp where hiredate ='1980-12-17';
select * from emp where hiredate ='80/12/17';

--������ saleman�� ����� ���, �̸�, �޿�, ���� ���
select empno, ename, sal, job
from emp
where job = 'SALESMAN';


--�μ���ȣ�� 10���� ����� �μ���ȣ, �̸�, �޿����� ���
select deptno, ename, sal from emp where deptno ='10';

--�񱳿���
--��� ���̺��� �޿��� 3000�޷� �̻��� ����� �̸��� ������ ����ϼ���
select ename, sal from emp where sal>=3000

--������̺��� ������ salesman�� �ƴ� ����� ����� �̸�, ������ ����ϼ���
select empno, ename, job from emp where job != 'SALESMEN';

--������̺��� ������ 3000�޷� �̻��� ����� ���, �̸�, �޿�, ������ ����ϼ���
select empno, ename, sal, sal*12 as'����' from emp where (sal *12) >3000;

--������ salesman�̰� �޿��� 2000�̻��� ����� ���, �޿�, ������ ����ϼ���
--and
select * from emp
where job = 'SALESMAN' and sal >= 1500;

--������ salesman�̰ų� �޿��� 2000�̻��� ����� ���, �޿�, ������ ����ϼ���
select * from emp
where job = 'SALESMAN' or sal >= 1500;

-- ������̺��� �޿��� 1000�޷� �̻� 3000�޷� ������ ����� ���,�̸�,�޿� ����ϼ���
select empno, ename, sal from emp where 1000>=sal and sal<=3000

--between A and B ( =�� ����)
select empno, ename ,sal from emp where sal between 1000 and 3000;

--������̺��� �޿��� 1000�ʰ� 3000�̸��� ����� ���, �̸�, �޿��� ����ϼ��� // �̰Ǿ�¿������ �̷��� ��ߴ�
select empno, ename, sal from emp where 1000>sal and sal<3000 

--������̺��� ����� 7788, 7902, 7369�� ����� ����� �̸��� ����ϼ���
select empno, ename from emp where empno = 7788 or empno = 7902 or empno = 7369

-- in ������ ( �̷��� �ݺ������� ���� �ʾƵ� �Ǽ� ����)
select empno,ename from emp where empno in(7788,7902,7359);

----������̺��� ����� 7788, 7902, 7369�� �ƴ� ����� ����� �̸��� ����ϼ���
select empno, ename from emp where empno not in (7788,7902,7359);

--Like ������ (���� : ���ڿ�)
--������̺��� �̸��� S�� �����ϴ� ^���^(s�� ������ �ڿ� ���� �͵� �������) ����� ����� �̸��� ����ϼ���
select * from emp where ename like 'S%'; 

--Like �����ڸ� �����ִ� wild card
--% ��� ��, (�ƹ��͵� ���� ��쵵 ����)
-- _ �ѹ���
--[] �ȿ� �ִ� ����
--[^] ������ �ִ� ���� ������

--�̸��� �ι�° ��¥�� A�� ����� ����� �̸��� ����ϼ���
select * from emp where ename like '_A%' ; --a�� �ι�°

/*
WARD
MARTIN
JAMES
*/

-- �̸��� T�� �ι� ����ִ� ��� 
-- TT, ATAT
select * from emp where ename like '%T%T%';
--SCOTT

--�̸��� ù���ڰ� A , B , S �� �����ϴ� �����
select * from emp where ename like'[ABS]%';
/*
SMITH
ALLEN
BLAKE
SCOTT
ADAMS
*/
--�̸��� ù���ڰ� A or S �����ϰ� �ι�° ��¥�� C�� ���������ʴ� �ݏD
select * from emp where ename like '[AS][^C]%'


--QUESTION
--1. ������̺��� ��� �����͸� ����϶�
select * from emp 

--2. ������̺��� �����ȣ, ����̸�, ������ ����϶�
select empno, ename, sal from emp

--3. ������̺��� ������ �̴µ� �ߺ��� �����Ͱ� ���� ����϶�
select distinct sal from emp 

--4. ������̺��� ����̸��� ������ ����ϴµ� ������ �÷�����
-- '�� ��','�� ��'���� �ٲ㼭 ����϶�. ��, ALIAS�� �����߰�
select ename as '�� ��', sal as '�� ��' from emp 

--5. ������̺��� ����̸�, ������ �̰�, ���ް� Ŀ�̼���  ���� ����
-- ����ϴµ� �÷����� '�Ǳ޿�'�̶�� �ؼ� ����϶�.
-- ��, NULL���� ��Ÿ���� �ʰ� �϶�.
select ename, sal, sal+isnull(comm,0)as '�Ǳ޿�' from emp 

--6. ������̺��� 'SCOTT'�̶�� ����� �����ȣ, �̸�, ������ ����϶�
select empno, ename, sal from emp where ename = 'SCOTT'


--7. ������̺��� ������ 'SALESMAN'�� ����� �����ȣ, �̸�, ������
-- ����϶�
select empno, ename, job from emp where job = 'SALESMAN'

--8. ������̺��� �����ȣ�� 7499, 7521, 7654�� ����� �����ȣ, �̸�
-- ������ ����϶�
select empno, ename, sal from emp where empno in (7788,7521,7654)

--9. ������̺��� ������ 1500���� 3000������ ����� �����ȣ, �̸�,
-- ������ ����϶�.
select empno, ename, sal from emp where sal between 1500 and 3000

--10. ������̺��� �̸��� ù���ڰ� A�̰� ������ ���ڰ� N�� �ƴ� �����
-- �̸��� ����϶�
select ename from emp where ename LIKE'A%[^N]'


create table TLike(
col1 int,
col2 varchar(10) -->10����Ʈ (�ѱ� 5��, ����,Ư��,���� 10��)
)

go --���� ����� ������������ �ؿ��� �����ϼ���
insert into TLike(col1, col2) values(10, '10')
insert into TLike(col1, col2) values(20, '10%')
insert into TLike(col1, col2) values(30, '20')

select * from TLike

select * from TLike where col2 like '%10%'
--10%�� �˻��ϰ������ ..;; Ư�����ڷ� �ν���..;; %�� ���� �״�� �νĽ��ѾߵǴµ�
select * from TLike where col2 like '%10E%%' escape 'E' 
--ESCAPE E����ϴ� ���ڸ� �����ͷ� �ν��Ұ�� >> 10E%

--TODAY POINT 
--������̺��� Ŀ�̼��� å���Ǿ����� ���� (�����ʴ�)
--����� �̸��� Ŀ�̼��� ����ض� (��, comm = 0 �ΰ��� �޴°����� ����)
-- select * from emp where comm = null; �̷���������..;;
--null ������
--1. isnull
--2. is not null
select * from emp where comm is null
--������ �޴� �������
select * from emp where comm is not null

--�Լ�
--�����Լ�, �����Լ� ,��¥�Լ� ,����Լ�, �ý��� �Լ�..

--1. �����Լ�
select lower('ABC')
select upper('abc')

select upper(ename)as 'ename' from emp 

select 100+100+100
select ename + ' is a ' + job from emp -- + ���� or ����(���ڿ�)

select substring ('abcd',1,3)
select substring ('abcd',3,1) --1 �ڱ��ڽ���

select left('abcd',3)
select right('abcd',3)

--������̺��� ����� �̸����� ù���ڴ� �빮�ڷ� �������� �ҹ��ڷ� ����ϼ���
--a() b() c() �Ұ���
select left (ename,1) + left(ename,2) from emp
select upper(left(ename,1)) + lower(substring(ename,2,len(ename))) from emp 

select len('abcd') 
select len(ename) from emp
select len('a      b')
select len('       a')
select len('a       ') -- len �Լ��� ��������� �������� ���Ѵ�.

select datalength('abc') --3byte
select datalength('ȫ�浿') --6byte

--��������
select '>' + '      a' + '<'
-->a<
select '>' + ltrim('      a') + '<'
-->a<
select '>' +rtrim('a          ') + '<'
select '>' +rtrim(ltrim('a          ')) + '<'

--replace
select replace ('abcd','a','NEWNEW') --1������ a��� ���ڸ� ã�� newnew�� ��ü�ض�

--'ȫ      ��      ��'
select '>' + 'ȫ      ��      ��' '<'

--������ ���ʿ� ������ ����..;; �� ������ ���ּ� ���
select replace('ȫ      ��      ��',' ','')

--�����Լ�
--round �ݿø��Լ�
select round(123.45,1) --123.50 �Ҽ����� ù��° �ڸ����� ���ܶ��� 
select round(123.45,2) --123.45
select round(123.45,0) --123
select round(123.55,0) --124.00

--�� �Լ� ..? 
select power(2,4) --2��4��


--CEILING : ������ ���ں��� ū �ּ� ������ ��ȯ�Ͽ� ���
select CEILING(1234.5678), CEILING(123.45), CEILING(-1234.56)

--FLOOR : ������ ���ں��� ���� �ִ� ������ ��ȯ�Ͽ� ���
select FLOOR (1234.5678), FLOOR(123.45), FLOOR(-1234.56)--1234 123 1235

--��¥�Լ�
select getdate()

--Oracle : select sysdate
select dateadd(yy,10,getdate()) --�������ٰ� 10�� ������
select dateadd(dd,100,getdate())
select dateadd(mm,5,getdate())

select dateadd(yy,10,'2022-01-01')

select datediff(yy,'2010-12-12','2022-1-13'); 
select datediff(mm,'2010-12-12','2022-1-13');
select datediff(dd,'2010-12-12','2022-1-13');-- ������ ���̸� ���ض�

--��, ������ ���� 30�ϱ���
select ename,
datediff(dd,hiredate,getdate()) / 365 as '��',
(datediff(dd,hiredate,getdate())% 365)/30 as '����',
(datediff(dd,hiredate,getdate())% 365) % 30 as '��'
from emp

--���ú��� ���� 12��31�ϱ��� ��ĥ ���ҳ�?
select datediff(dd,'2022-03-22','2022-12-31')

select year(getdate())
select month(getdate())
select day(getdate())

--���� , ����, ��¥�Լ� �⺻���ΰ� ����ؾ��Ѵ� ( Ư�� ���� ��¥ ***)

--����ȯ �Լ� �ſ�ſ� �߿佺 ( today point)
select convert(int,'100') + 100
select convert(int,'100A') + 100 --varchar �� '100A'��(��) ������ ���� int(��)�� ��ȯ���� ���߽��ϴ�.

--����Ŭ select * from dual;
select convert(varchar(20),sal) + '�޿��Դϴ�' 
from emp

select ename +' �� �����' + convert(varchar(20),empno) + '�Դϴ�' as 'fullname'
from emp

--�����Լ�
--sum() avg() max() min() count()

select sum(sal) from emp
select avg(sal) from emp
select max(sal) from emp
select min(sal) from emp
select count(empno) from emp

/*
1. ���� �Լ��� null ���� �����Ѵ� (��, count(*) ����)
2. select ���� �����Լ� �̿ܿ� �ٸ� �÷��� ���� �ݵ�� �� �÷��� group by ���� ��õǾ���Ѵ�.
*/

select comm from emp --14��
select count(comm) from emp -- 6�� �ֳ� null�� �����ؾ���
select comm from emp where comm is not null

--comm�� ���
select avg(comm) from emp --721 �츮 ȸ��� �޴� ������� ����..�����Լ��� null ����
select (300 + 200 + 30 + 300 + 3500 + 0) /6 --721 ȸ��� ������� ����
select (300 + 200 + 30 + 300 + 3500 + 0) /14 --309 ȸ��� �޴»������ ����

--�츮�� ������� �������� �Ұž�..
select avg(isnull(comm,0)) from emp --309 -- ****TODAY POINT****

--�����Լ��� ����� 1�� 
select avg(sal), sum(sal), max(sal), min(sal), count(sal) from emp

select deptno, avg(sal), sum(sal), max(sal), min(sal), count(sal) from emp 
group by deptno --select ���� �����Լ� �̿ܿ� �ٸ� �÷��� ���� �ݵ�� �� �÷��� group by ���� ���

select deptno, job, avg(sal)
from emp group by deptno, job
order by deptno asc --���� deptno�� asc / desc

--from ���� ������ where
-- groupt by �������� having 

-- << ���� ���̺� ��� ����) >>
/*
select   5
from     1
where    2  
group by 3
having   4
order by 6 ���ɻ� �� ������ 
*/

--������ ��� ������ ���ϵ� �÷��� ����Ī�� ���, ��տ����� ���� ������ �����Ͻ�
select job ,avg(sal) as '���' from emp group by job order by ��� desc 
--������ orderby �� ���� �����̴ϱ� �����ִ� �̸���~

--mssql top n ����
--������̺��� ������ ���� ���Ϲ޴� ��� 5���� �̸��� �޿��� ����ض�
select top 5 ename , sal from emp order by sal desc 


select top 2 with ties ename , sal from emp order by sal desc -- ����ó���ϱ�

select top 50 percent ename, sal from emp order by sal desc

--������ �� ������ ���ϰ� �� ������ 5000�޷� �̻��� ��� ��� �����͸� ����ض�

select job, sum(sal) from emp where sum(sal)>5000 group by job  

select sum(sal) as'sumsal' from emp where deptno != 10 group by job having sum(sal)>5000 order by sumsal desc

--�μ��� ������ ���� ���ϰ� �� ������ 10000 �޷� �̻��� ��� �����͸� ����ϼ���
select deptno, sum(sal) as 'subsal' from emp group by deptno having sum(sal) >= 10000 

--�μ��� �ѿ����� ��ȣ�� 30�� �μ��� �����ϰ� 
-- �� �� ������ 8000�޷� �̻��� �μ��� �������ϰ�
--�ѿ����� ���� ������ ����Ͻÿ�

select deptno, sum(sal) as '�ѿ���' 
from emp
where deptno != 30 
group by deptno 
having sum(sal) >= 8000 order by �ѿ��� desc 


--�μ��� ��� ������ ���ϵ� Ŀ�̼��� å���� ����� ��������
-- ��տ����� 2000�޷� �̻��� �μ��� ������ �ϰ�
--��� ������ ���� ������ ����Ͻÿ�

select deptno, avg(sal) as '��տ���' from emp where comm is not null 
group by deptno having avg(sal) >= 2000 order by ��տ��� desc

--QUESTION
--1. ��� ���̺��� ����̸��� ù���ڴ� �빮�ڷ�, �������� �ҹ��ڷ� ����϶�
select upper(left(ename,1)) + lower(substring(ename,2,8)) from emp 

--2. ������̺��� ����̸��� �̰� �� �̸��� �ι�° ���ں��� �׹�° ���ڱ���
-- ����϶�.
select substring(ename, 2,len(ename)) from emp

--3. ������̺��� ��� �̸��� ö�� ������ ����϶�.
select len(ename) from emp 

--4. ������̺��� ��� �̸��� �� ���� �ϳ��� ������ ���� �ϳ��� ����ϵ� 
-- ��� �ҹ��ڷ� ���� ����϶�. -- �𸣰���
select LOWER(LEFT(ENAME,1)), LOWER(RIGHT(ENAME,1)) from emp


--5. 3456.78�� �Ҽ��� ù��° �ڸ����� �ݿø��϶�.
select round(3456.78, 1)

--6. 3�� 4������ ���ϰ�, 64�� �������� ���϶�.
SELECT POWER(3,4), SQRT(64)
-->: �������� �Ҽ��� ���Ϸ� ��Ÿ�� �� �ֱ� ������ float������ ��µȴ�.


--7. ���ó�¥�� ���ó�¥���� 10���� ���� ��¥�� ����϶�.
select dateadd(dd,10,2022-03-22)

--8. ���� ǥ������ ���� ��¥�� ����϶�.
SELECT CONVERT(VARCHAR(20), GETDATE(), 112)

--9. ������̺��� ����̸��� ������� ���� ��¥������ �ٹ��ϼ��� ���϶�.
select ename, (datediff(dd,hiredate,getdate())% 365) % 30 as '�ٹ��ϼ�' from emp


--10. �� �������� �ٹ��ϼ��� 00�� 00���� 00�� �ٹ��Ͽ�����
--Ȯ���� �� �ֵ��� ��ȯ�϶�.(��, �� ���� 30�Ϸ� ����϶�)
-- ��)
--  | ENAME	| �ٹ��ϼ�		|
--  | KING		| 00�� 00���� 00��	| -- �𸣰���

select ename, 
convert (varchar(20), datediff(dd,hiredate, getdate())/365) +'��'+
convert(varchar(20), datediff(dd,hiredate,getdate())%365/30)+'��'+
convert(varchar(20), datediff(dd,hiredate, getdate())%365%30) +'��' from emp


--1. ������̺��� �μ��� �ִ� ������ ����϶�.
select max(sal) as'�ִ����', deptno from emp group by deptno

--2. ������̺��� ������ �ּ� ������ ���ϵ� ������ 
-- CLERK�� �͸� ����϶�.
select min(sal) from emp group by job having job = 'CLERK'

--3. Ŀ�̼��� å���� ����� ��� �� ���ΰ�?
select count(comm) from emp where comm is not null

--4. ������ 'SALESMAN'�̰� ������ 1000�̻��� �����
-- �̸��� ������ ����϶�.
select ename, sal from emp where job = 'SALESMAN' AND sal>=1000

--5. �μ��� ��տ����� ����ϵ�, ��տ����� 2000����
-- ū �μ��� �μ���ȣ�� ��տ����� ����϶�.
select avg(sal), deptno from emp group by deptno 
having avg(sal) > 2000 

--6. ������̺��� Ŀ�̼��� ���� ���� �޴� ��� 2����
-- ����ϵ� ��ŷ�� �ߺ��� ��� ����ó���� �Ͽ� ����϶�.
select top 2 with ties comm from emp 

--7. ������ MANAGER�� ����� �̴µ� ������ ���� ���
-- ������ �̸�, ����, ������ ����϶�.
select ename, job, sal from emp where job = 'MANAGER' order by sal desc

--8. �� �������� �ѿ����� ����ϵ� ������ ���� ������
-- ����϶�.
select sum(sal),job from emp group by job order by sum(sal) asc

--9. ������ �ѿ����� ����ϵ�, ������ 'MANAGER'��
-- ������� �����϶�. �׸��� �� �ѿ����� 5000���� 
-- ū ������ �ѿ��޸� ����϶�.
select job, sum(sal) from emp where job != 'MANAGER' 
group by job having sum(sal)>5000

--10. ������ �ִ������ ����ϵ�, ������ 'CLERK'�� 
-- ������� �����϶�. �׸��� �� �ִ������ 2000 �̻���
-- ������ �ִ������ �ִ� ������ ���� ������ �����Ͽ� 
-- ����϶�.

select max(sal),deptno from emp where job !='CLERK' 
group by deptno having max(sal) > 2000
order by max(sal) desc
