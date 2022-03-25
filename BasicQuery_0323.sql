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



----------------------------------------------------------------------------------------------
--0324
-- DDL ���Ǿ� >> Create , alter , drop
-- 1. DB ���������
-- 2. �� ����Ҿȿ� .. TABLE �����ϰ� ����


sp_helpDB kosadb --DB �⺻ ���� ��ȸ�ϱ� 

-- DDL table ����
create table emp10  -- class emp10 { public int empno {get;set;} }
(
	empno int,
	ename nvarchar(20),
	hiredate datetime

)

/*
char(10) >> ������ ,Ư������, ���� 10�� or �ѱ� 5�� �����ϴ� Ÿ��    >> �������� ���ڿ�
varchar(10) >> ������ ,Ư������, ���� 10�� or �ѱ� 5�� �����ϴ� Ÿ�� >> �������� ���ڿ�

�����Ͱ� '��' �Ǵ� '��' / �ֹι�ȣ ���� ������ �����ʹ� char�� ��ߴ��.
create table T ( gender char(2))   (0)  >> ���������� ������ ���� 
create table T ( gender varchar(2))

�����Ͱ� ����� �̸� : ... �̼��ѹ�, ������ ...
create table T (name char(50))  >> 6����Ʈ ���� >> 50����Ʈ �״�� �������
create table T (name varchar(50)) >> 6����Ʈ�� ���� >> 6����Ʈ ����

�����ڿ� �ѱ��� ����� ?
unicode 
create table T ( gender nchar(4))   >>  ���� 4���� (������ Ư������ ���� ������� 4���� )
create table T ( gender nvarchar(4))
*/

-- ���̺� ����

sp_help emp10 -- �� �� 

insert into emp10(empno, ename, hiredate)
values (100,'������',getdate())

select * from emp10

create table member2(
id int,
name varchar(20),
adress varchar(50),
birth datetime,
hobby varchar(100),
)

sp_help member2

insert into member2(id,name,adress,birth,hobby)
values(1,'������','�����','1996-12-12','��')

select * from member2
-- hobby >> null

insert into member2(id)
values(3)

select * from member2 

-- 1. �������̺� �÷� �߰��ϱ�
alter table member2
add gender char(1) 

sp_help member2

--2. ���� ���̺� ���� �÷��� Ÿ�� �����ϱ� 
alter table member2
alter column gender char(2)

alter table member2
drop column gender

--3. ���̺� �� �� �� �� ��
drop table member2

sp_help member2

create table emp03(
empno int not null, --empno�� null���� ������� �ʾ� �� �� �� �� ��
ename varchar(20) --default null ��� - �� �� �� ��
)

insert into emp03(empno) values(0819)

select * from emp03

insert into emp03(ename) values('������') --�� 'empno'�� NULL ���� ������ �� �����ϴ�. empno�� notnull�� �ֱ� ������ null ��� ����

insert into emp03(empno, ename) values(7902,'������')

select * from emp03

create table emp04
(
	 empno int default 1000,
	 ename varchar(20)
)
sp_help emp04 --default Ȯ��

insert into emp04(empno, ename) values (1111,'�达')

select * from emp04

insert into emp04(ename) values ('�ھ�')
insert into emp04(ename) values ('�̾�')

select * from emp04

sp_helpconstraint emp04

-- DF__emp04__empno__37A5467C ���� �̸��� (�̸��� ������ ���߿� �����ϰų� �����Ҷ� ����ؾ���)

create table emp05 
(
	empno int constraint df_emp04_empno default 1000,
	ename varchar(20)
)
-- df_emp04_empno ������ ǥ�� / df_���̺��_�÷��� ��κ� �����ڰ� ������ ǥ�� ���

sp_helpconstraint emp05

create table user02(
	u_id int not null,
	u_name nvarchar(20),
	u_job varchar(50) constraint df_user02_u_job default 'IT'
)

sp_helpconstraint user02

insert into user02(u_id, u_name, u_job)
values(10,'������','����')

select * from user02

insert into user02(u_id, u_name)
values(20,'�赵��')

-- ȸ�����̺��� default ���Ͼ��°� .. ���Գ�¥ ( getdate())

--------------------------------------------------------------
-- ���� (constraint)
/*
Data intergrity�� ���� ��� ( �� �� �� )
������ ���
1. ���̺� ������ �����ϴ� ��� : create table �� ���
2. ������� ���̺� �����ϴ� ��� : alter table �� ��� *^^*

������ ����

1. NOT NULL

2. DEFAULT

3. PRIMARY KEY (not null + unique) >> �ֹι�ȣ, ���� , ����...�Ѱ��� row�� ��ȯ���� �� �ִ�.
                                   >> where num = 1,where jumin = 123456-1234567
								   >> primary�� �ϸ� �˻� �����ϰڱ�.. �ӵ� ����� ���� ���������� �ε��� ��������..
								   >> ���̺� �� 1�� ( ���� ) > 1�� 2��() 3��() >> ����Ű�� �����ϴ�.

4. UNIQUE  (�ߺ��� ��� ����)  >>  not null�� �������� ����
							   >> �˻� index 
							   >> �÷� �� ��ŭ 

5. CHECK ( ��  �Ǵ� �� �����͸� ���� �� ����, 1 ~ 10 ������ ) where gender in ('��','��')


6. FOREIGN KEY					>> T O D A Y P O I N T (�ܷ�Ű, ����Ű) ��������
                                >> ���̺�� ���̺��� [ ���踦 ���� ] �� ��� RDBMS
								>> ����) �θ� �ڽ�, master detail 
								>> emp .... dept
								>> Emp ���̺� deptno �÷��� det deptno �÷��� �����Ѵ�.(FK)
								>> dept detpno �÷��� emp deptno�÷��� ������ ���մϴ�.(PK)


*/
select * from emp
select * from dept

create table emp06(
	-- empno int primary key, �̷��� ���� ã�� �����
	empno int constraint pk_emp06_empno primary key, --pk_emp06_empno
	ename varchar(20),
)

sp_helpconstraint emp06

insert into emp06(empno, ename)
values(100, '������')

insert into emp06(empno, ename)  --PRIMARY KEY ���� ���� 'pk_emp06_empno'��(��) �����߽��ϴ�.
values(100,'������')

insert into emp06(ename) --�� 'empno'�� NULL ���� ������ �� �����ϴ�.
values('������') -- ������ NULL�� ����� �� �����ϴ�.

-- ���̺� �� 1�� (���)
-- ����Ű 

create table pktable 
(
	a int,
	b int,
	c int 
	
	constraint pk_pktable_a_b primary key(a,b) -- A���� B����
)

-- ����Ű ������ 
-- where b = 10 (������ ���� .. index�� ��Ž)
-- where a = 10 and b = 10( �������̽�..)
-- where a = 10 .... 

sp_helpconstraint pktable

/*
�̷� ���̺� ������ ����� ���� ����Ű�� ����

�λ����̺� 
2000  1  IT
2000  2  SALES

�з����̺�
2000  1 ��õ��
2000  2 ��õ��

*/

create table emp07
(
	empno int constraint uk_emp07_empno unique, --�ߺ������͸� ������� �ʾƿ� -- UNIQUE (non-clustered)
	ename varchar(20)

)
sp_helpconstraint emp07 

insert into emp07(empno, ename) values(1000, '����')
select * from emp07

insert into emp07(ename) values('����')
insert into emp07(ename) values('�ھ�')
--UNIQUE KEY ���� ���� 'uk_emp07_empno'��(��) ����
--�ߺ� Ű ���� (<NULL>)�Դϴ�.

create table emp08(
empno int not null constraint uk_emp08_empno unique,
ename varchar(20)
)

-- �׷��� empno int not null constraint uk_emp08_empno unique�� >>primary key�� ������ �þƴ�?
-- �ƴ� �ٸ����� constraint�� �÷�������ŭ priamry�� 1���� �� ������

--�ߺ����� ������� ������ null�� ����ϰ� null�� �ߺ������� �Ѵ� 

create table emp09(
	u_id int constraint pk_emp09_u_id primary key,
	u_name varchar(20) not null,
	reg_num1 char(6) not null constraint uk_emp09_regnum1 unique,
	reg_num2 char(7) not null constraint uk_emp09_regnum2 unique,
	u_job nvarchar(20) constraint df_emp09_u_job default 'IT'
)

sp_helpconstraint emp09


create table emp11(
	empno int constraint pk_emp10_empno primary key,
	ename varchar(20) not null,
	gender char(2) constraint ck_emp10_emmp10_gender check(gender in ( '��','��'))
)

sp_helpconstraint emp11

insert into emp11(empno, ename, gender) values(1000,'��','��')
--INSERT ���� CHECK ���� ���� "ck_emp10_emmp10_gender"��(��) �浹�߽��ϴ�.

insert into emp11(empno, ename, gender) values(1000,'��','��')

-- ���� �� ��
select * from emp

select * from dept

-- MSSQL�� NOT NULL ���� ���� �÷��� ���� .. PK�� �����ϰ� �Ǿ�����
alter table dept
alter column deptno int not null

alter table dept 
add constraint pk_dept_deptno primary key(deptno)
--���̺� 'dept'�� Null ��� ���� PRIMARY KEY ���� ������ ������ �� �����ϴ�
-- not null�� �͸� �߰������� pk�� �� �� ����

alter table emp
add constraint fk_emp_deptno foreign key(deptno) references dept(deptno)
--�����Ǵ� ���̺� 'dept'�� �ܷ� Ű 'fk_emp_deptno'�� ���� �� ��ϰ� ��ġ�ϴ� �⺻ Ű �Ǵ� �ĺ� Ű�� �����ϴ�.

-- �ݵ�� �����ϴ� ���̺� pk�� ����Ǿ�� �Ѵ�.
-- �� ������ fk �� �� ���� emp ���̺� empno�� dept���̺��� �����ִ� �����͸� �����

--�ɼ�
--identity(������)
-- ä��(��ȣǥ)
-- sequence (��ü ��ȣǥ) : oracle, mssql

create table board(
board int identity(1,1),
title varchar(20),
)

insert into board(title) values('�氡�氡')

select * from board

create table emp20(
	a int , 
	b int,
	c as a+b -- ���� ��
)

insert into emp20(a,b) values (100,300)

select * from emp20

-------------------------------------------------------------------
--VIEW ( �� �� �� �� �� ) 
-- ���� : Sql ���� ���
-- VIEW�� ��ü (create ..  drop������ �������) - �����͸� ���� ���� ����

Create view tbl_emp
as
	select empno, ename, job, deptno from emp

-- ������� : ���� ���̺� >> ���̺�ó�� ��� >>view�� ���� �����͸� ����

select * from tbl_emp --view�� ������ �ִ� sql������ �����

select * from tbl_emp where deptno = 10 --view�� ���� �����ִµ����ʹ� �� ������ �� �� ����


sp_help tbl_emp 
--owner : dbo	type : view	name : tbl_emp	2022-03-24 14:48:01.600

sp_helptext tbl_emp
--- select empno, ename, job, deptno from emp



--���� *** ( ���� �ܼ�ȭ >> �������� ���̺��� ���� ���  >> �並 ���� �������̺��� ����� ��� >> JOIN)
Create view v_emp --�μ���ȣ , �μ��̸�, ��� ... �Ź� �����ؾ���..
as
 select empno, ename, e.deptno, dname from emp e inner join dept d 
 on e.deptno = d.deptno

 select * from v_emp

 --�����ϰų� ���־��°� view�� �������� �並 ���� ��뤾 ����  �����ڳ�~

 --���) ������ ��� ������ �� �˰� �ִٸ� view�� ��¥��..(?)
 --������ salesman�� ������� �̸�, ����, ������ �����ִ� view�� ������

 create view vv_emp
 as
 select empno, sal, job from emp where job = 'salesman'

 select * from vv_emp 

 --�μ���ȣ�� 30���� ����� �̸�, �޿�, �μ���ȣ�� �����ִ� �並�ۼ�
create view vvv_emp
as
select ename, sal, deptno from emp where deptno =30

select * from vvv_emp

-- view�� ���̺��̸� DML �۾� �Ǵ�?
-- VIEW ���ؼ� Insert update delete �۾� ����
-- View ���ؼ� ���� ���̺��� view�� �� �� �ִ� �͸� 
-- �ٵ� ���� ����..����

select * from vvv_emp

begin tran
update vvv_emp set sal = 0 -- ���� �����ϴ� ���̺��� �����Ͱ� �ٲ�
select * from emp
select * from vvv_emp
rollback

--�μ��� ��� ������ ��� �ִ� view�� ����ÿ� inline view

create view empavg
as
select deptno , avg(sal) as 'avgsal' from emp group by deptno

select * from empavg

select * from emp e join empavg s 
on e.deptno = s.deptno and e.sal > s.avgsal

--1. ���� ( ������ ����(����) .. view�� ���� ���ϰ� )
--2. �������̺� (���ϴ� �����͸� ���� ) join ������ ó��

--������̺��� �̸��� ���޸� ��� �並 �ۼ��ϵ�, ������ ���������� ������ڳ�
-- view ������ order by ������� ������
create view view0002
as
select top 20 ename, sal from emp order by sal desc

select * from view0002

--1. 30�� �μ� ������� ���� �̸� ������ ��� view�� ������
create view emp3030
as
select job, ename, sal from emp where deptno = 30

--2. 30�� �μ� �������  ����, �̸�, ������ ��� VIEW�� ����µ�,
-- ������ �÷����� ����, ����̸�, �������� ALIAS�� �ְ� ������
-- 300���� ���� ����鸸 �����ϵ��� �϶�.

create view emp4044
as
select job as'����', ename as'����̸�', sal as '����' from emp where sal > 300 and deptno = 30

select * from emp4044


--4. �μ��� ��տ����� ��� VIEW�� �����, ��տ����� 2000 �̻���
-- �μ��� ����ϵ��� �϶�.

create view emp5050
as
select deptno, avg(sal) as '��տ���' from emp 
 group by deptno where avg(sal) >=2000
 

 begin tran
 update emp set sal = 0
 
 select* from emp with(nolock) -- ���� �ٸ������ Ʈ������������̶� �������ϰ� ������ -- ������Ʈ�Ȱ� ������
--�������� ����ȭ�� �������� ���Ѵ�
 

 select rownum, empno
from (
select row_number() over (order by empno) --empno�� ���ĵ� ���������� over ������ ���ϰ� row_num 
as rownum , empno
from emp
) T where t.rownum between 1 and 5 --pagesize = 5�� ���,


SELECT T.MEMBER_ID 

FROM ( 
       SELECT ROW_NUMBER() OVER (ORDER BY MEMBER_ID) AS ROWNUM, MEMBER_ID 
       FROM MEMBER_TABLE WITH (NOLOCK) ) T -- nolock�� �Ŵ� ���� : �Խù������־ ������ �Ϸ��� 
       WHERE T.ROWNUM BETWEEN ({pageNo} - 1) * {pageSize} + 1 AND {pageNo} * {pageSize}


select empno ,ename
from emp
order by empno offset 0 rows fetch next 5 rows only

select empno , ename
from emp
order by empno offset 5 rows fetch next 5 rows only


select empno , ename
from emp
order by empno offset 10 rows fetch next 5 rows only



with T(deptno,total)
as
    (select deptno , sum(sal+isnull(comm,0)) from emp group by deptno)
select * from T order by total desc; -- �μ���ȣ�� �ѱ޿��� ���� ������ ������


--Q1. DATETIME ������ Ÿ���� ������ @ymd ������ �����ϰ�,
--�� ������ GETDATE()�Լ��� ����Ͽ� ���� ��¥�ð��� ������ ���� ȭ�鿡 ����϶�.

DECLARE @ymd datetime
SET @ymd=GETDATE()
SELECT @ymd

--Q2. INT ������ Ÿ���� ������ @sal ������ �����ϰ�, 
--�� ������ 5000�̶�� �ʱⰪ�� �㵵�� �����϶�. 
--�׸��� EMP ���̺��� ������ @sal�� ����� �̸��� ������ ����϶�.

DECLARE @sal int
SET @sal=5000
SELECT ENAME, SAL
FROM EMP
WHERE SAL=@sal
-- �ϳ��� ��Ͼȿ��� �����ؾ���

-- EMP ���̺�κ��� ��տ����� ��� ������ �����ϰ�,
--�� ������ �̿��� ��տ��޺��� �� ���� ������ �޴� ����� ��� ������ ���

Declare @maxsal
set @maxsal =(select avg(sal) from emp)
select * from emp where sal >avg(sal)


DECLARE @avg int
SET @avg=(SELECT AVG(SAL) FROM EMP)
SELECT *
FROM EMP
WHERE SAL>@avg

--@1. ���� @i�� ������ ���� �����ϰ� @1�� ���� 100���� ���� ����
--100�̻��� ��츦 ������ ��� �޼����� �ٸ��� �Ѹ���
-- if ~ else ���� �ۼ��ض�

declare @i int
set @i = 250
if @i < 300
select convert(varchar(10),@i) + '�� 100���� �۽��ϴ�'
else
select convert(varchar(10),@i) + '�� 100���� Ů�ϴ�'

--begin ~ end ���
declare @sal int 
set @sal = 2000
if @sal > = 3000
	begin
		print '������ 3000�޷� �̻��� �����'
		select *
		from emp
		where sal >= 3000
	end
else
	begin
	print '������ 3000�޷� �̸��� �����'
		select *
		from emp
		where sal < 3000
	end
	/*
	declare
	set
	if
		begin

		end
	else
		begin

		end
	*/

-- case ~ when ~ then

select empno , ename, job, deptno,
		( 
		case deptno when 10 then 'A'	
					when 20 then 'B'
					when 30 then 'C'
					when 40 then 'D'
		else 
		   '�氡�氡'
		end
		) as '�ϳ����÷�' ,111 as '������1', 222 as '������2',333 as '������3' -- ���̺� �÷��� �ִ°� �ƴ϶� �������� �͵� �����Ͱ� ä������.
		from emp



		
select empno , ename, job, deptno,
		( 
		case        when deptno = 10 then 'aA'	
					when deptno between 20 and 30 then 'Bb'
					when deptno in (40, 50) then 'Cc'
		else 
		   '�氡�氡'
		end
		) as '�ϳ����÷�' ,111 as '������1', 222 as '������2',333 as '������3' -- ���̺� �÷��� �ִ°� �ƴ϶� �������� �͵� �����Ͱ� ä������.
		from emp

		select * from emp


-- while 1 ~ 10 ������ �� 
declare @i int, @sum int
set @i =1
set @sum = 0
while @i <=10 
	begin
		set @sum = @sum + @i
		set @i = @i +1
	end
	select @sum 
	/*
	while (i<=10)
	{ sum +=10;
	i++; }
	*/
--0325
	------------------------------------------------------------------
	--�� �� �� �� -- ex sp_constraint, sp_help ��¼��
	-- ���� : ���� , ����(�Ķ���͸� �����־ �ǰ� ����), ���� 
	create proc myproc
	as
	select empno, ename from emp

	exec myproc --���ν��� �� ��~

	alter proc myproc
	as
	select empno, ename, job, sal from emp

	exec myproc

	drop proc myproc

	sp_helptext myproc

	create proc myproc1
	as
	update emp
	set sal = 0

	begin tran
	exec myproc1
	select * from emp
	rollback

	--���ν��� �̸�
	-- �ý���.. ���ν���
	--sp_help
	--usp_emplist
	create proc usp_empAllList
	as
	select empno, ename, sal
	from emp

	exec usp_empAllList

	create proc usp_empUpdateSal
	as
	update emp
	set sal = sal *2

	begin tran
	exec usp_empUpdateSal
	select * from emp
	rollback

	-- * input �Ű����� ��� ���� 
	create proc myproc3
	@i int --input �Ķ����
	as
	select * from emp where empno = @i
	update emp 
	set sal = sal * @i
	select * from emp where empno = @i
	exec myproc3 7788
	exec myproc3 7902

	create proc myproc4
	@i int 
	as
	update emp
	set sal = sal *@i

	begin tran
	exec myproc4 100

	select * from emp
	rollback

	begin tran
	exec myproc4 --�Լ� 'myproc4'�� �Ű� ���� '@i'��(��) �ʿ������� �������� �ʾҽ��ϴ�.

	alter proc myproc4
	@i int = 2 -- ����Ʈ���� �� �� ����, �̷��� �Ķ���� ��� ����
	as
	update emp
	set sal = sal *@i

	create proc myproc5
	@sal int ,
	@deptno int
	as 
	select * from emp
	where sal < @sal and deptno = @deptno

	begin tran
	exec myproc5 4000, 20

	--pubs db�� title�̶�� ���̺��� å �̸��� ���� å�� ������ ��������
	--myproc6��� ���ν����� ������ �׸��� å �̸��� å�� ������ ����ڷκ��� ����¹ް�
	--���� �Է����� ������ defualt ��¼���� %�� null�� ��µ𵵷� ����
	select * from titles

	use pubs
	
	drop proc myproc66

	create proc myproc66
	@title varchar(50) = '%',
	@price int = null
	as
	if @price is null
		begin
			select title, price from titles
			where title like @title
		end
	else
		begin
			select title, price from titles
			where  price = @price and title like @title
		end
	
	exec myproc66
	exec myproc66 '%can%'
	select count(*) from titles

	select * from titles

	exec myproc66 @price = 19.99 --Ư�� �Ķ���͸� ������ @price
	exec myproc66 '%talk%', 19.99 -- straight talk ��¼��..
	
	--�ý��� ���ν���
	sp_tables
	sp_help titles
	sp_helpdb
	select * from titles

	--inpub & output
	create proc myproc7
	@a int, 
	@b int,
	@c int output -- ���� �̰��� ���� ��Ƽ� ��ſ� �� �� �� �ٰԿ�
	as
	set @c = @a + @b
	print @c

	exec myproc7 10,20 --�Լ� 'myproc7'�� �Ű� ���� '@c'��(��) �ʿ������� �������� �ʾҽ��ϴ�.
	-- output�̶�� �Լ��� �ۿ��� �����غ��ؾ���

	declare @out int 
	exec myproc7 10,20,@out
	select @out

-- Q2. ó�� �Է��� ���ڿ� 30�� ���� ��, 
-- ���� ���� �� ��° ���ڸ� ���� ���� ����ϴ� ���ν����� �ۼ��϶�.

	create proc myproc8
	@a int,
	@b int,
	@c int output,
	as
	set @c = (@a+30) *@b 
	

	declare @out int
	exec myproc8 10,20 @out output
	select @out as '�����'

	create proc myproc9
	@a int,
	@b int,
	@c int output,
	@d int output
	as
	set @c = @a + @b 
	set @d = @a * @b
	
	declare @out_1 int,  @out_2 int
	exec myproc9 10,20 ,@out_1 output, @out_2 output
	select @out_1 as 'data_1', @out_2 as 'data_2'

	-- output ���� return�� ��뵵 ����
	--return�� �޴¹���� �� Ʋ����
	use KosaDB

	create proc myproc10
	as
		declare @count int
		set @count = (select count(*) from emp)
		return @count

		declare @return int
		exec @return = myproc10
		select @return

-- return �Ǵ� ���� ������ ���� ������ ������ �� ����
-- ������ ���� ����
create proc myproc11
@empno int
as 
declare @exist bit
select @exist = count(*) from emp where empno =@empno
if @exist >0 
	begin
		return 1
	end
  else
	begin
		return -1
	end

	declare @exist int
	exec @exist = myproc11 7788 --�����Ͱ� ������ 1�� �����ض�.
	select @exist

	
	declare @exist int
	exec @exist = myproc11 1000 --�����Ͱ� ������ 1�� �����ض�.
	select @exist


	create proc usp_dept_insert
	@deptno int,
	@dname varchar(20),
	@loc varchar(20)
	as
	declare @err int

	begin try
	insert into dept(deptno, dname, loc)
	values (@deptno, @dname, @loc)
	end try
	
	begin catch
	set @err = @@error -- �ý��� ����
	end catch
	
	return @err

	sp_helpconstraint dept

	declare @result int
	exec @result = usp_dept_insert 100, 'IT','SEOUL'
	select @result -- 0 �� ������ ���� �������� ������ȣ..2627�� (�����̸Ӹ�Ű ���࿡ ���� ������ȣ)

	
	select * from dept

	-- ���� �޼����� ���� �;��


	create proc usp_dept_insert22
	@deptno int,
	@dname varchar(20),
	@loc varchar(20),
	@message varchar(200) output
	as

	begin try
	insert into dept(deptno, dname, loc)
	values (@deptno, @dname, @loc)
	end try
	
	begin catch
	set @message = ERROR_MESSAGE()
	end catch
	
	declare @msg varchar(200)
	exec usp_dept_insert22 200,'IT','BUSAN',@msg output
	select @msg --PRIMARY KEY ���� ���� 'pk_dept_deptno'��(��) �����߽��ϴ�. ��ü 'dbo.DEPT'�� �ߺ� Ű�� ������ �� �����ϴ�. �ߺ� Ű ���� (200)�Դϴ�.


	--emp ���̺� �μ���ȣ�� update�ϴ� ���ν���
	--logic�� ������� 
	create proc numnum
	@deptno int,
	@message varchar(200) output
	as begin try
		if(@deptno in (select deptno from dept)
		begin
		set @message = 1
		end try
		set @message = ERROR_MESSAGE()

		declare @msg varchar(200) 
		exec numnum 300,'it','��õ', @msg output
		select @msg 


--���� ���ν���
declare @dbname varchar(20), @tablename varchar(20)
set @dbname = 'kosadb'
set @tablename = 'emp'
exec ('use' + @dbname + ' select * from ' + @tablename)

create proc usp_db_table
@dbname varchar(20), 
@tablename varchar(20)
as 
exec ('use' + @dbname + ' select * from ' + @tablename)

exec usp_db_table 'pubs','titles'

exec usp_db_table 'kosadb','emp'

create proc usp_top_select 
@count int
as
select top(@count) * from emp
order by sal desc

exec usp_top_select 5


--����� ���� ���̺� 
Create Schema Users 
go 

use_kosaDB

--ȸ�������� ���� ���̺�� 
Create Table Info
(
	userID		varchar(20)		not null primary key,
	Name		varchar(20)		not null,
	password	varchar(30)		not null,
	email		varchar(20)		not null,
	mobile		varchar(13)		not null,
	zipCode		char(7)			not null,
	address		varchar(50)		not null,
	iDate		DateTime		not null,
	uDate		DateTime		not null
)
go

	
Create Table Active
(
	userID		varchar(20)		not null primary key
)
go

Create Table Deleted
(
	userID		varchar(20)		not null primary key
)
go


--ȸ������Ÿ�� �ٷ�� ���� �������ν����� 
alter Proc up_Get_UsersInfo
(
	@userID		varchar(20)
)
as
select userID, Name, password, email, mobile, zipCode, address, iDate, uDate
from Info where userid=@userID
go


Create PROC up_Get_LoginChk
	@UserID   varchar (20), 
	@Password varchar (30), 
	@iRet int output
AS
	SET @iRet = 0  
		IF NOT EXISTS(SELECT * FROM Active WHERE UserID  =  @UserID)
		SET @iRet  = -1 
ELSE
	BEGIN  
		IF NOT EXISTS(SELECT PASSWORD FROM Info WHERE USERID  = @UserID AND PASSWORD  =@Password)
			SET @iRet  = -2 
		ELSE 		
			SET @iRet  = 1 
	END 
go


--�̹� ��ϵ� ������ ���(userID:-1, email:-2)
Create Proc up_Add_UsersInfo

	@userID			varchar(20),
	@New_Name		varchar(20),
	@New_Password	varchar(30),
	@New_Email		varchar(20),
	@New_Mobile		varchar(13),
	@New_ZipCode	varchar(7),
	@New_Address	varchar(50),
	@iRetmsg		int output
as
SET @iRetmsg = 0 
    IF(EXISTS(SELECT USERID FROM INFO  WHERE UserID = @userID))
			SET @iRetmsg = -1 
		ELSE IF (EXISTS(SELECT email   FROM INFO  WHERE email = @New_Email))
			SET @iRetmsg = -2
	ELSE
		BEGIN 
			BEGIN TRAN
			INSERT INTO Info(userID, Name, password, email, mobile, zipCode, address, idate, udate) 
			VALUES (@userID, @New_Name, @New_password, @New_email, @New_mobile, @New_zipCode, @New_address,	
					GetDate(), GetDate())
				SET @iRetmsg = @@RowCount -- �ݿ��� ���� ����
				IF @iRetmsg >= 1 
					BEGIN 
						INSERT INTO Active( UserID ) VALUES ( @userID ) --ȸ������ ������
						SET @iRetmsg = @@RowCount
					END
				ELSE
					SET @iRetmsg = 0 
					IF @iRetmsg < 1
					begin
						ROLLBACK TRAN 	
					end
			  COMMIT TRAN 
		END
go 

Create Proc up_Update_UsersInfo
(
	@userID			varchar(20),
	@New_Name		varchar(20),
	@New_Password	varchar(30),
	@New_Email		varchar(20),
	@New_Mobile		varchar(13),
	@New_ZipCode	varchar(7),
	@New_Address	varchar(50)
)
as
UPDATE Info SET Name=@New_Name, password=@New_Password, email=@New_Email, 
	mobile=@New_Mobile, zipCode=@New_Zipcode, address=@New_Address
WHERE userID=@userID
go


Create Proc up_Delete_UsersInfo
(
	@userID		varchar(20)
)
as
	EXEC up_Delete_UsersActive @userID
	EXEC up_Delete_UsersDeleted @userID
	
	DELETE FROM Info
	WHERE userID=@userID
go

Create Proc up_Delete_UsersActive
(
	@userID		varchar(20)
)
as
	DELETE FROM Active WHERE userID=@userID
go 

Create Proc up_Delete_UsersDeleted
(
	@userID		varchar(20)
)
as
	DELETE FROM Deleted WHERE userID=@userID
go 


--�����ȣ �˻��� ���� ���ν��� 
/*Create Proc up_GetList_PostCode_Search
(
	@juso	varchar(50)
)
as
Select zipCode, zipSerial, sido, gugun, dong, ri, doseo, bungi, building, juso 
From PostCode 
Where juso like '%'+ LTrim(RTrim(@juso))+'%'


--test
exec up_GetList_PostCode_Search '����'
*/

--1. ȸ�������ϱ� 

declare @returnvalue int
exec up_Add_UsersInfo 'hong','ȫ�浿','0819','jaehyeon@naver.com',
'010-6210-5345','123-123','����� ������',@returnvalue output
select @returnvalue 

declare @returnvalue int
exec up_Add_UsersInfo 'hong2','ȫ�浿','0819','jaehyeon@naver.com',
'010-1234-1234','123-123','����� ������',@returnvalue output
select @returnvalue  -- -2 �� ��������� ����

select * from Info
select * from active

exec up_get_usersinfo 'hong'

exec up_Update_UsersInfo 'hong','ȫ�浿','0819','jaehyeon@naver.com',
'010-1111-1122','123-123','����� ���ϱ�'

exec up_Delete_UsersInfo 'hong'

select* from info

select *from active

--���ν����� ����� CRUD
-- create > insert
-- read > select
-- update > update
-- delete > delete 

-- ���� ���̺� ���ؼ� ... 5���� ����� ����
/*
c#���� model ����(DAO > C# �Լ� ����

ȸ�����̺��� member
public List<member> getAllmember(){
	������ ¥�ָ� �ʴϴ�...select * from emp
}

public member getAllMemberByUserId(string userid){
	����..select * from emp where empno = 7788
}

public int insertMember(member m){ (��ü�� �Ķ���ͷ� ����)
	����
}


��ü ������ ��ȸ (select * from emp)
���� ������ ��ȸ (select * from emp where empno = 7788 ) pk������ �ɸ� ��ȸ
����             (insert 
����			 (delete
����			 (update

�߰�
�˻���
���ڿ� �˻�, ����(�̸�, ���̷� �˻��ϴ� ����)
*/

--�Խ����� �����ؼ� ���̺� �ϳ� ����� �װɰ����� �ټ����� ���ν����� ����� ���� �ѽð� ���� ����

create table kosaboard(
	boardid int identity(1,1) constraint pk_kosaboard_boardid primary key,
	title nvarchar(30) not null,
	content nvarchar(2000) not null,
	userid nvarchar(20) not null,
	regdate datetime default getdate(),
	filename nvarchar(30),
)

-- ���ν��� �ټ��� �ִ��� ���Ѱ�... ������ ���� �ִ��� Ȱ���ؼ� �ǹ��� ������...;;;
-- ��ü��������ȸ , ���ϵ�������ȸ, ����, ����, ����

create proc kosaboard_check_all()
as
begin
update board set ���ٲ���? where �Ķ����
select boardid, title, content, userid, regdate, filename from kosaboard where (�Ķ����)
end


create proc kosaboard_check_all
as
select *  from kosaboard 

create proc data_check_one111111(
@boardid  int,
@title nvarchar(30),
@content nvarchar(2000),
@userid nvarchar(20),
@regdate nvarchar(100),
@filename nvarchar(30),
@user_num int output)

create proc data_check_one
@boardid  int,
@title nvarchar(30),
@content nvarchar(2000),
@userid nvarchar(20),
@regdate nvarchar(100),
@filename nvarchar(30),
@user_num int output
as
begin
set @user_num = 1
if not exists (select * from kosaboard where boardid = @boardid)
set @user_num = 0
else if not exists (select * from kosaboard where title = @title)
set @user_num = 2
else if not exists (select * from kosaboard where content = @content)
set @user_num = 3
else if not exists (select * from kosaboard where userid = @userid)
set @user_num = 4
else if not exists (select * from kosaboard where regdate = @regdate)
set @user_num = 5
else not exists  (select * from kosaboard where filename = @filename )
set @user_num = 6


drop proc data_check_one


create proc data_check_one11(
@boardid int,
@userid varchar(50),
@message1 varchar(50) output)
as
begin
if exists (select boardid from kosaboard where boardid = @boardid)
else if  exists(select userid from kosaboard where userid = @userid)
else set @message = ERROR_MESSAGE()
end




-- substring(), max(), min(), avg() �ý����Լ�
-- public string fn_sum(int val, int val2){ return val + val2 }

create function fn_sum
(@val01 int, @val02 int)
returns int -- public int ( ���� Ÿ���� ���� )
as
begin
	return (@val01 + @val02)-- return val + val2 (�Ķ���ͷ� ���� 01+02 ���� ���� ���� )
end


select dbo.fn_sum(100,200)

--�Լ��� ����� ����ϴ� �ڿ�
/*
����, ��¥�� ���õȰ��� �����ؼ� ... 
*/
create function fn_dateformat
(
	@indate datetime,
	@op char(1)
)
returns nchar(20)
as 
	begin
	 return convert(nvarchar(20), datepart(yy,@indate)) + @op + 
			convert(nvarchar(20), datepart(mm,@indate)) + @op +
			convert(nvarchar(20), datepart(dd,@indate))
	end

select dbo.fn_dateformat(getdate(),'/')
select dbo.fn_dateformat(getdate(),'.')

select empno, ename, hiredate from emp,dbo.fn_dateformat(hiredate,'-')
from emp

/*
�Ǽ�ȸ��

�޿����̺�
������ : ���޿�
�Ͽ��� : �Ϸ��ϴ� + ���ɰ�
�ð��� : �ð� * �ݾ�

��� �̸�  ���޿�  �ϴ�  �Ĵ�  �ð�  �ݾ�
100   ��     10
200   ��            100   10
300   ��                         5    500
400   ����   20

[��� �ึ��] �� �޿� ����Ҷ� ��� ���...�� �޶�...

Ŀ���� ���� �޿��� ī�����..���� ���ȴ�.
*/

-- �л� ���̺��� �� �л��� ���� ������ ������, 
--����,��,��,��,���� ������ ���� �����ϴ� Ŀ�� �ۼ� ��

create table student
(
id int primary key,
name varchar(20) not null,
value tinyint not null, -- ����
grade nchar(1) -- '��,��,��,��,��'
)

insert into student(id, name, value)
values(1, 'ö��', 60)
insert into student(id, name, value)
values(2, '����', 80)
insert into student(id, name, value)
values(3, '��ȣ', 50)

select * from student

--Ŀ������
declare std_cursor cursor --Ŀ�� ����
for
	select value from student -- Ŀ���� ���� ������ -- ����
	for update 
	open std_cursor-- �̶� select ~ �� ����Ǽ� �޸𸮿� �ö�
	declare @value tinyint, @grade nchar(1)
	fetch next from std_cursor into @value --�����ؼ� ������
	while(@@FETCH_STATUS =0) -- 0�̸� ��ӵ��ƿ���
	begin
		if(@value >=90)
			set @grade = '��'
		else if(@value >=80)
			set @grade = '��'
			else if(@value >=70)
			set @grade = '��'
			else if(@value >=60)
			set @grade = '��'
			else 
			set @grade = '��'
		update student
		set grade = @grade 
		where current of std_cursor

		fetch next from std_cursor into @value
	end
	close std_cursor
	deallocate std_cursor

-------------------------------------------

declare std_cursor cursor
for
select value
from student
for update
open std_cursor
declare @value tinyint
fetch next from std_cursor into @value
while (@@fetch_status=0)
	begin
		update student
		set grade=(case
			when @value between 90 and 100 then N'��'
			when @value between 80 and 89 then N'��'
			when @value between 70 and 79 then N'��'
			when @value between 60 and 69 then N'��'
			else N'��'
		end)
		where current of std_cursor -- Ŀ���� ����Ű�� ���� ���ڵ�
	fetch next from std_cursor into @value
end
close std_cursor
deallocate std_cursor
select * from student
-------------------------------------------
use northwind

declare employee_cusor cursor for
	select lastname, firstname
	from employees
	where lastname like 'b%' --�̸��� b�� �����ϴ� emp�� �̸��� �޸𸮿� �ø���!

open employee_cusor

fetch next from employee_cusor
while @@fetch_status = 0
begin
	fetch next from employee_cusor
end

close employee_cusor
deallocate employee_cusor

-----------------------------------

use testdb

drop table test
create table test(
col1 char(1),
col2 int
)

insert into test values('a',10)
insert into test values('b',20)
insert into test values('c',30)
insert into test values('d',40)
insert into test values('e',50)

declare @col1 char(1)
       ,@col2 int
       ,@col3 int

set @col3 = 0
declare cur_test cursor
	for select col1,col2 from test
open cur_test
	fetch next from cur_test into @col1, @col2
while @@fetch_status = 0
	begin
		set @col3  = @col3 + @col2   --���������� ���ϱ�
		select @col1 , @col2 , @col3
		fetch next from cur_test into @col1, @col2
	end

close cur_test
deallocate cur_test 

select * from test
---------------------------------------------------------

--�ᱹ���� Ŀ�������� ���ν����ȿ� ����ִ°�
create proc sal_date_process
as
	--Ŀ�������� ��

	--������ �Ǹ� ���ν��� ȣ��
	-- �����ٸ�..(��ġ���α׷��� ����)
	-- Ư�� �ð��� �Ǹ� �ڵ����� ...
	exec sal_date_process 


----------------------------------------
	CREATE TABLE MY_FRIEND(
NAME NVARCHAR(20),
AGE NUMERIC(3)
)

INSERT INTO MY_FRIEND(NAME,AGE)VALUES('ȫ�浿',20)
INSERT INTO MY_FRIEND(NAME,AGE)VALUES('ȫ���',25)
INSERT INTO MY_FRIEND(NAME,AGE)VALUES('��ö��',22)
INSERT INTO MY_FRIEND(NAME,AGE)VALUES('��μ�',27)


--���� ���� ��ȸ�� �÷��� ���� ������ �����ؾ��Ѵ�.
create proc update_cursor_friend
as
DECLARE 
@INDEX INT,
@NAME VARCHAR(100),
@AGE INT           

SET @INDEX = 0; --INDEX�ʱ�ȭ

DECLARE CUR CURSOR FOR   --CUR��� �̸��� Ŀ�� ����

SELECT --���� ��ȸ
NAME,
AGE                
FROM MY_FRIEND

OPEN CUR      --Ŀ�� ����
FETCH NEXT FROM CUR INTO @NAME,@AGE  --SELECT�� ���� @NAME,@AGE ������ �ִ´�.

--Ŀ�����̿��� ��ROW�� ���� 
WHILE @@FETCH_STATUS = 0
BEGIN
SET @INDEX = @INDEX + 1; --INDEX����

--SELECT �� �������� �������� ������ ������ �۾�
UPDATE MY_FRIEND
SET AGE = @AGE+1 --����+1
WHERE NAME = @NAME
	
FETCH NEXT FROM CUR INTO @NAME,@AGE	--����ROW�� �̵�
END

--Ŀ�� �ݰ� �ʱ�ȭ
CLOSE CUR
DEALLOCATE CUR


exec update_cursor_friend

select * from MY_FRIEND