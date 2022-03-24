Use KosaDB
--JOIN
--���� �ǽ����̺�

DROP TABLE X,S,M

CREATE TABLE M
(M1 CHAR(6), M2 VARCHAR(10))

CREATE TABLE S
(S1 CHAR(6), S2 VARCHAR(10))

CREATE TABLE X
(X1 CHAR(6), X2 VARCHAR(10))

 
INSERT INTO M VALUES('A','1')
INSERT INTO M VALUES('B','1')
INSERT INTO M VALUES('C','3')
INSERT INTO M VALUES(NULL, '3')

 
INSERT INTO S VALUES('A','X')
INSERT INTO S VALUES('B','Y')
INSERT INTO S VALUES(NULL, 'Z')


INSERT INTO X VALUES('A','DATA')

select * from m
select * from s
select * from x

/*
���� : �Ѱ� �̻��� ���̺��� �����͸� �������� ���

���� 
inner join
crose join
outer join
self join
nonequi join

ǥ����
�� ���� ( oracle, mysql, mssql ) ������ ����
ǥ�ع��� : ansi ����
*/

--1. INNER JOIN	 -- inner�� �������� default�� inner join �̴�.

--sql ������..;;
select * from m , s where m1 = s1

select m1, m2, s2 from m,s where m1 = s1

--ANSI ����
select * from m inner join s on m1 = s1

select  m.m1, m.m2 , s.s1, s.s2 from m,s inner join s on m.m1 = s.s1

--������̺��� ���, �̸�, �μ���ȣ, �μ��̸��� ����Ͻÿ�
select * from emp
select * from dept

select emp.empno, emp.ename, emp.deptno, dept.dname from emp inner join dept 
on emp.deptno = dept.deptno

-- �ϼ��� ����
select e.empno, e.ename, e.deptno, d.dname from emp e  join dept d
on e.deptno = d.deptno

----------------------------------------------------------------
--cross join(������ ���� ����) ��� ������ ����� ���� ������
select * from m,s

--ANSI 
select * from m cross join s

--------------------------------------------------------------
--outer join
--���ο� �������� �ʴ� �����Ͱ� ����
--���� �����͸� �������� ���(null������ ����� ����)
-- ���� ������ �����ϰ� ���� ������ �������� ~..

--���������� inner join �����ϰ� �������踦 �ľ��ؼ� ���� �����͸� ��� ���� ���
--left / right
select * from m left outer join s -- m�� ������..s�� �뿹..? 
on m.m1 =s.s1 

select *
from m right outer join s --s�� ����.. m�� �뿹...
on m.m1 = s.s1

--���� : left�� right�� ���Ѱ� >> union
select * from m full outer join s
on m.m1 = s.s1




----------------------------------------------------------------
/* UNION ������--

1. ���� �Ǵ� [�÷��� ��]�� [��ġ]�Ͽ��� ��
2. ���� �Ǵ� [�÷��� �ڷ���(Ÿ��)] [��ġ]
3. �ߺ� ����
ù��° ���̺� �ι�° ���̺� ����� ����°�
*/
select empno, ename from emp
union select deptno , dname from dept

select empno, ename,job from emp
union 
select deptno , dname, null from dept


select empno, ename from emp --ename varchar
union 
select deptno , dname, null from dept --deptno int

select * from emp
union --�ߺ�����
select * from emp

select * from emp
union all
select * from emp
----------------------------------------------------------------

--self join (�Ѱ��� ���̺��� 2��ó��)
--�ڽ��� Ư�� �÷��� �ڽ��� Ư�� �÷��� ����

--���, �̸�, �����ڻ��, �������̸��� ����ϼ���
select e.empno, e.ename, m.empno, m.ename from emp e inner join emp m 
on e.mgr = m.empno 

--^^ ���� �߻� ����� �� 14��
--���� �����ʹ� 13�� 
--null�� ������ ����� �ƴϴ�. -> �̷��� left outer join
select e.empno, e.ename, m.empno, m.ename
from emp e left outer join emp m 
on e.mgr = m.empno 
---------------------------------------------------------------
--nonequi join
select * from emp


select e.empno, e.ename, e.sal, s.grade from emp e inner join salgrade s
on e.sal between s.LOSAL and s.HISAL
--1��1�� ���εǴ� �÷��� ������... �ٵ� ���� ����... >> innerjoin ���� �ذ�


--���̺� 2, 3, 4�� ����
select m.m1, m.m2, s.s2, x.X2 
from m join s on m.m1 = s.s1 
	   join x on s.s1 = x.x1
	   join y on x.x1 = y.y1


--����� ���, �̸�, �޿�, �޿����, �μ���ȣ, �μ��̸��� ����Ͻÿ�
select * from emp e join dept d on e.deptno = d.DEPTNO
join salgrade s on e.sal between s.losal and s.hisal

--�μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, �����ȣ, ����̸��� ���

select *
from emp e join dept d on e.deptno = d.deptno
where e.deptno = 10

--�μ���ȣ�� 20�������� ������� �μ���ȣ, �μ��̸�, �����ȣ ,����̸��� ����ϵ�
--���������� �����ض�

select *
from emp e join dept d on e.deptno = d.deptno
where e.deptno <=20 order by d.deptno desc



-- 1. ������� �̸�, �μ���ȣ, �μ��̸��� ����϶�.
select ename, empno, deptno from emp

select * from dept
select * from emp
select * from salgrade

-- 2. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸���
-- ����϶�.
select e.ename, e.job, d.deptno, d.dname
from emp e join dept d on e.deptno = d.deptno where d.dname = 'dallas'

-- 3. �̸��� 'A'�� ���� ������� �̸��� �μ��̸��� ����϶�.
select e.ename, d.dname  from emp e join dept d on e.deptno = d.deptno 
where  e.ename LIKE '%A%'


-- 4. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������ 
--����ϴµ� ������ 3000�̻��� ����� ����϶�.
select d.dname, e.sal,e.ename from emp e join dept d on e.DEPTNO = d.DEPTNO
where sal >= 3000


-- 5. ������ 'SALESMAN'�� ������� ������ �� ����̸�, �׸���
-- �� ����� ���� �μ� �̸��� ����϶�.
select e.job, e.ename, d.dname from emp e join dept d on e.deptno = d.deptno
where job = 'salesman'


select * from dept
select * from emp
select * from salgrade

-- 6. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,
-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',
-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.
select e.empno as '�����ȣ', e.ename as '����̸�', e.sal*12 as '����', e.sal*12+isnull(comm,0) as '�Ǳ޿�', s.grade as '�޿����'
FROM EMP E inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
where COMM IS NOT NULL


-- 7. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,
-- ����, �޿������ ����϶�.
 
 select d.deptno , d.dname, e.ename, e.sal, s.grade 
 from emp e join dept d on  e.deptno = d.deptno
inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.DEPTNO=10


-- 8. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�, 
-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ� 
-- ������� �μ���ȣ�� ���� ������, ������ ���� ������ 
-- �����϶�.

select d.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on  e.deptno = d.deptno 
inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE  E.DEPTNO<=20
order by deptno asc , sal desc 

-- 9. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� �������� 
-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',
-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.

select e.empno as'�����ȣ', e.ename as'����̸�', e.mgr as'�����ڹ�ȣ', e.ename as '�����ڸ�'
from emp e inner join emp m 
on e.mgr = m.empno 


-----------------------------------------------------------------
--Subquery

--johnes �� �޴� �޿�����  �� ���� �޿��� �޴� ����� �̸��� �޿��� ����ؿ�
select sal from emp where ename ='jones'
select ename, sal from emp where sal > 2975


select ename, sal from emp 
where sal>(select sal from emp where ename ='jones')

/*
1. ��ȣ�ȿ� �־����..
2. �ܵ����� ���� ���� �ؾ���
3. ���� �÷����� �����Ǿ��� (select sal , detpno �̰� �ȵǿ�)

����� �ϳ��� �÷�, �ϳ��� �÷��� �����Ͱ� 1��? 2��? ������?

������� 
���������� ������������ �켱

����
single row subquery : ����� 1���� row ( < > >= = )
multi row subquery : ����� �������� row�� ���( in, not in, any, all )
�����ϴ� ������ ����ϴ� �����ڰ� �޶� 
*/

-- ������ salesman�� ������ ���� �޿��� �޴� ������� ���, �̸�, �޿������� ����ϼ���
select sal from emp where job = 'salesman'

select empno , ename, sal from emp
where sal in (select sal from emp where job = 'salesman')

-- �μ���ȣ�� 10���� ������ ���� �޿��� �޴� ������� ����� ����ϼ���
select * from emp where sal in (select sal from emp where deptno = '10')

select sal from emp where deptno = '10'

--���������� �ִ� ����� ����� �̸��� ����ϼ���
-- �ڱ��� ����� mgr�� �ѹ� ������
select mgr from emp

select * from emp where empno in (select mgr from emp)
--empno=7902 or empno=7788 or empno = 1123 ....

--���������� ���� ����� ����� �̸��� ����ϼ���
--mgr �÷��� ������ ����� ������ ( ������ �� �� �� )
 select * from emp where empno not in (select mgr from emp)
 --empno!=7902 and empno!=7369 and ...null >> null���� ��� ������ null

 select mgr from emp where empno not in (select isnull(mgr,0) from emp)

 --20�� �μ��� ��� �߿��� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ��� ��� ���� ���
select * from emp where sal >(select max(sal) from emp where deptno = 20)

select * from emp where sal > all(select sal from emp where deptno = 20)
--where sal > data and sal > data and sal> data and..

select max(sal) from emp where deptno = 20

--20�� �μ��� ��� �� ���� ���� ������ �޴� ����麸�� �� ���� ������ �޴� ������� �̸��� ������ ����ػ�

select ename, sal from emp where sal > (select min(sal) from emp where deptno =20)

/*
select > subquery
from > subquery
where > subquery

ALL(and) <--�ݴ�--> ANY(or)

*/
select ename, sal from emp 
where sal > any(select sal from emp where deptno =20)

--where sal>800 or sal > 2975 or sal >3000 or sal >1100 or sal >3000

--������ 'salesman'�� ����� ���� �μ����� �ٹ��ϰ�, ���� ������ �޴� ������� �̸�, ����. �μ���ȣ�� ����϶�.
select deptno from emp where job ='salesman'

select sal from emp where job = 'salesman'

select ename, sal, deptno 
from emp where deptno in (select deptno from emp where job ='salesman')
and sal in (select sal from emp where job = 'salesman')


--�ڱ� �μ��� ��� ���޺��� �� ���� ������ �޴� ������� �̸�. ���� �μ���ȣ, �μ��� ��տ����� ���Ͻÿ�

select avg(sal) from emp where deptno = '10'

/*
�μ��� ��տ����� ��� �ִ� ���̺��� ����..  �޸𸮸� ��� ����.. subquery .. from �������̺�
--1. if��տ����� ��� �ִ� ���̺��� �����Ѵٸ�
10������.. ��� 2916
20�� �μ� ���..2175
30�� �μ� ���..1566.

--2. ���������� from���ڿ� ����� �� ����
*/

--�ǹ����� �� ���� �� /���̺��� �ϳ� ������ ���ڴµ� create�� �� �׷��� ���������� �������̺��� �ϳ� ���� �������
-- in live view
select * 
from emp e inner join (select deptno, avg(sal) as avgsal from emp  group by deptno)d
on e.deptno = d.deptno
where e.sal > d.avgsal


--TIP) ���� �����ϴ°� ����? ������ (JOIN)�ϴٰ� �ذ� �ȵǸ� SUB QUERY) >> in line view(�������̺�)
 
 --1. 'SMITH'���� ������ ���� �޴� ������� �̸��� ������ ����϶�.
 select * from emp where sal > 800

 select ename,sal from emp where sal > ( select sal from emp where sal > 800)

--2. 10�� �μ��� ������ ���� ������ �޴� ������� �̸�, ����,
-- �μ���ȣ�� ����϶�.
select sal from emp where deptno = '10'
select ename, sal, deptno from emp where sal in (select sal from emp where deptno = '10')

--3. 'BLAKE'�� ���� �μ��� �ִ� ������� �̸��� ������� �̴µ�
-- 'BLAKE'�� ���� ����϶�.
select deptno from emp where ename = 'blake'
select ename, hiredate from emp where deptno in ( select deptno from emp where ename = 'blake')


--4. ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������
-- ����ϵ�, ������ ���� ��� ������ ����϶�.
select sal from emp where sal>avg(sal)
select empno, ename from emp where sal in (select sal from emp where sal>avg(sal))
order by sal asc


--5. �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϰ�
-- �ִ� ����� �����ȣ�� �̸��� ����϶�.
select deptno from emp where ename LIKE '%T%'
select empno, ename from emp where deptno in (select deptno from emp where ename LIKE '%T%')



--6. 30�� �μ��� �ִ� ����� �߿��� ���� ���� ������ �޴� �������
-- ���� ������ �޴� ������� �̸�, �μ���ȣ, ������ ����϶�.
--(��, ALL �Ǵ� ANY �����ڸ� ����� ��)
select  max(sal) from emp where deptno ='30'

select ename, empno, sal from emp 
where sal >all ( select -- max(Sal)�� ���� ȿ��
  sal from emp where deptno =30)

select * from emp;

select * from dept;

select * from salgrade;

--7. 'DALLAS'���� �ٹ��ϰ� �ִ� ����� ���� �μ����� ���ϴ� �����
-- �̸�, �μ���ȣ, ������ ����϶�.
select * from dept where loc ='dallas'

select e.ename, d.deptno, e.job from emp e join dept d 
on d.deptno in ( select d.deptno from dept where loc ='dallas')

--8. SALES �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ����϶�.
select * from dept where dname = 'sales'

select e.empno, e.ename, e.job from emp e join dept d
on d.dname in (select * from dept where dname = 'sales')


--9. 'KING'���� �����ϴ� ��� ��� mrg�� 7398�γ��  �� �̸��� �޿��� ����϶�.
select * from emp where mgr ='7839' 

SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO
		FROM EMP
		WHERE ENAME='KING')

--10. �ڽ��� �޿��� ��� �޿����� ����, �̸��� 'S'�� ����
-- ����� ������ �μ����� �ٹ��ϴ� ��� ����� �����ȣ, �̸�,
-- �޿��� ����϶�.
select avg(sal) from emp where ename Like '%s%'

select empno, ename, sal from emp
--where deptno in (select DEPTNO from emp where ename Like '%s%')
WHERE SAL > (SELECT AVG(SAL)
		FROM EMP)
AND DEPTNO IN(SELECT DEPTNO
		FROM EMP
		WHERE ENAME LIKE '%S%')


--11. Ŀ�̼��� �޴� ����� �μ���ȣ, ������ ���� �����
-- �̸�, ����, �μ���ȣ�� ����϶�.
select comm from emp where comm is not null

select ename, sal, empno from emp 
where deptno in (select deptno from emp where comm is not null)
and SAL IN(SELECT SAL
FROM EMP WHERE COMM IS NOT NULL)


--12. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ����
-- ������� �̸�, ����, Ŀ�̼��� ����϶�.
select sal, comm from emp where deptno = '30'

select ename, sal, comm from emp 
where comm not in (select isnull(comm,0) from emp where deptno = '30')


--13. �����ȣ, �̸�, ����, �׸��� ���޴����� ����϶�.
SELECT E.EMPNO, E.ENAME, E.SAL, SUM(D.SAL)
FROM EMP E, (SELECT EMPNO, SAL
		FROM EMP) D
WHERE E.EMPNO>=D.EMPNO
GROUP BY E.EMPNO, E.ENAME, E.SAL

---------------------------------------------------------------
--DML (insert , update, delete) �� �� �� �� �� ---
/* ������ �� �� ��
insert ... �ǹݿ� 
insert , update, delete .. begin tran�̶�� �۾��� ���� �ɾ commit���� �׳� ó��

*/
create table Test(
userid int
)
insert into Test(userid) values(100) --�ǹݿ�
select * from Test
begin tran
insert into Test(userid) values(200)

rollback
--�Ϸ� / ���( commit & rollback ) ��ɾ ..
select * from Test

begin tran
delete from Test
select * from Test
commit
/*
mssql DML �۾��� ���� autocommit ��
begin tran 
DML �ۼ��Ͻø� 
commit , rollback ������ ����

oracle dml �۾��� ���� default begin tran 
begin tran ����..
insert..
�ݵ�� commit & rollback ����..

*****TRANSACTION***** : �ϳ��� ������ �۾� ���� ( �� �� OR �� �� ) LOCK �� �⺻
�ִ� �� �ܼ��ϰ� �ϴ°� ������ ����
���� ���� 
A ���� -> B ���·� ��ü 
������ Ư���� commit & rollback 

���⼭�� �� ...
A = A - 1000
B = B + 1000
������� �ϳ��� ������....

*/

-- insert
--1. ��ü �÷��� ������ �����ϱ�

insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(9999, 'ȫ�浿', 'IT', 7902,getdate(), 3000, 100, 10)

select * from emp

insert into emp
values(9991, 'ȫ��', 'IT', 7902,getdate(), 3000, 100, 10)

-- Ư�� �÷��� ������ ���� ( �ݵ�� �÷��� ��� )
insert into emp
values(5555, '�ƹ���', 800) --(x)

insert into emp(empno, ename, sal) -- �Ⱦ� �����ʹ� null ���� ��
values( 9992, '�ƹ���',800)

insert into emp(empno, ename, hiredate, deptno)
values(9998, '����','2022-01-01', 10)

select * from emp order by empno desc


--------------------------------------------------------------
/*
update 
update table_name
set column_name = value
WHere search_condition
*/
begin tran
update emp set sal = 0

select * from emp
rollback

begin tran update emp set sal = 0, comm = 0, deptno = 100
where deptno =10;
rollback

select * from emp where deptno = 100

begin tran update emp set sal = 0 where ename = 'scott'
rollback

begin tran 
update emp set sal =0 where ename = 'scott'
update emp set sal = 1111 where deptno = 10
update emp set sal = (select max(sal) from emp) where deptno = 20;
select * from emp order by deptno
rollback -- ���Ʈ���� �� �������� �� ���~

--------------------------------------------------------
----DELETE ---
-- �����ȣ 7902 �����͸� �����Ͻÿ�
begin tran
delete from emp where empno = 7902
select * from emp where empno = 7902
rollback

begin tran
delete from emp
select * from emp
rollback

/*
�ΰ����� �ɼ�

1. select into ( ���̺� ���� �� ������ insert ����)
2. insert ~ select ( �뷮 ������ �� �� )
*/
select *
into emp01
from emp -- emp01 ���̺� ����� ������ insert �ѹ濡 �ذ� 

select * from emp01

select empno , ename, job, sal 
into emp02
from emp
where 'A' ='B' 

select * from emp02

----------------------------------------------------------------

insert into emp (empno, ename)
values (1111,'AAA')
--values ��ſ� select �� ����� �� ����

insert into emp02(empno, ename, job, sal)
select empno, ename, job, sal from emp where deptno = 10

select * from emp02

--�ǽ� --------------------------------------------------------
select * 
into empclone
from emp

select * from empclone

delete from empclone

insert into empclone
select * from emp

select * from emp

delete from emp where empno in (9999,9991,9992,9998)
-------------------------------------------------------------------
-- ��� �ǽ������� EMP ���̺��� ������ ������ ���� BEGIN TRAN...
-- ROLLBACK TRAN ������ ����� ��

select * into emptest from emp
select * from emptest

-- 1. EMP ���̺��� �����ȣ�� 7499���� ����� ������ 5000�޷��� �ٲ��.

update emptest set sal = 5000 where empno = 7499

-- 2. EMP���̺��� �μ���ȣ�� 20���� ������� ������ 4000�޷��� �ٲ��.
update emptest set sal = 4000 where deptno = 20


-- 3. DEPT ���̺� �Ʒ��� �������� �����͸� �Է��϶�.
-- �μ���ȣ: 50, �μ���ġ: BOSTON,  �μ���: RESERCH

insert into dept(deptno, loc, dname) 
values(50, 'BOSTON', 'RESEACH')


-- 4. �����ȣ�� 7698���� ����� �μ���ȣ�� 7499�� ����� 
--�μ���ȣ�� �ٲ��.
 
 update emptest set deptno = (select deptno from emptest where empno=7499)
where empno = 7698

-- 5. EMP ���̺� �Ʒ��� ���� �����͸� �����϶�.
-- �����ȣ: 9900, ����̸�: JACKSON, ����: SALESMAN, �μ���ȣ: 10

insert into emptest(empno, ename, job, deptno)
values (9900, 'JACKSON', 'SALESMAN', 10)

-- 6. INSERT...SELECT ���� �̿��Ͽ� ������ 'SALESMAN'��
-- ����� �����ȣ, �̸�, ������ EMP ���̺� �Է��϶�.

insert into emptest(empno, ename, job) 
select empno, ename, job from emptest where job = 'SALESMAN'


-- 7. �����ȣ�� 7369���� ����� ���� ������ ���� �������
-- ������ 7698�� ����� �������� �����϶�.
update emptest set sal=(select sal from emptest where empno = 7698)
where job = (select job from emptest where empno = 7369)


-- 8. SCOTT�� ���� ������ ���� ����� ��� �����϶�.
delete from emptest where job =(select job from emptest where ename='scott')


-- 9. 'SCOTT'�� ������ 'SMITH'�� ���ް� ���� �����϶�.
update emptest set sal =(select sal from emptest where ename = 'smith')
where ename ='scott'
select * from emp

-- 10. 'ALLEN'�� ������ 'SCOTT'�� ������ ���� �����϶�.
update emptest set job =(select job from emptest where ename='scott')

-- 11. �����ȣ�� 7499���� ����� ���� ������ ���� �������
-- �Ի����� ���ó�¥�� �����϶�.
update emptest set hiredate =getdate() where job =( select job from emptest where empno = 7499)


-- 12. SCOTT�� ���� ������ ���� ������� ������ 0���� �����϶�.
update emptest set sal =0 where job =( select job from emptest where ename = 'scott')
begin tran 

select * from emptest
