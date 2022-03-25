Use KosaDB
--JOIN
--조인 실습테이블

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
조인 : 한개 이상의 테이블에서 데이터를 가져오는 방법

종류 
inner join
crose join
outer join
self join
nonequi join

표현법
각 벤더 ( oracle, mysql, mssql ) 문법이 존재
표준문법 : ansi 문법
*/

--1. INNER JOIN	 -- inner는 생략가능 default가 inner join 이다.

--sql 문법임..;;
select * from m , s where m1 = s1

select m1, m2, s2 from m,s where m1 = s1

--ANSI 문법
select * from m inner join s on m1 = s1

select  m.m1, m.m2 , s.s1, s.s2 from m,s inner join s on m.m1 = s.s1

--사원테이블에서 사번, 이름, 부서번호, 부서이름을 출력하시오
select * from emp
select * from dept

select emp.empno, emp.ename, emp.deptno, dept.dname from emp inner join dept 
on emp.deptno = dept.deptno

-- 완성된 구문
select e.empno, e.ename, e.deptno, d.dname from emp e  join dept d
on e.deptno = d.deptno

----------------------------------------------------------------
--cross join(조건이 없는 조인) 모든 가능한 경우의 수를 보여줌
select * from m,s

--ANSI 
select * from m cross join s

--------------------------------------------------------------
--outer join
--조인에 만족하지 않는 데이터가 생성
--남는 데이터를 가져오는 방법(null때문에 생기는 문제)
-- 조인 조건을 선행하고 남는 조건을 가져오는 ~..

--내부적으로 inner join 선행하고 주종관계를 파악해서 남는 데이터를 들고 오는 방법
--left / right
select * from m left outer join s -- m이 주인임..s는 노예..? 
on m.m1 =s.s1 

select *
from m right outer join s --s가 주인.. m이 노예...
on m.m1 = s.s1

--원리 : left와 right을 합한거 >> union
select * from m full outer join s
on m.m1 = s.s1




----------------------------------------------------------------
/* UNION 합집합--

1. 대응 되는 [컬럼의 수]가 [일치]하여야 함
2. 대응 되는 [컬럼의 자료형(타입)] [일치]
3. 중복 제거
첫번째 테이블에 두번째 테이블 놈들이 놀러가는것
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
union --중복제거
select * from emp

select * from emp
union all
select * from emp
----------------------------------------------------------------

--self join (한개의 테이블을 2개처럼)
--자신의 특정 컬럼의 자신의 특정 컬럼을 참조

--사번, 이름, 관리자사번, 관리자이름을 출력하세요
select e.empno, e.ename, m.empno, m.ename from emp e inner join emp m 
on e.mgr = m.empno 

--^^ 문제 발생 사원은 총 14명
--현재 데이터는 13명 
--null은 조인의 대상이 아니다. -> 이럴떄 left outer join
select e.empno, e.ename, m.empno, m.ename
from emp e left outer join emp m 
on e.mgr = m.empno 
---------------------------------------------------------------
--nonequi join
select * from emp


select e.empno, e.ename, e.sal, s.grade from emp e inner join salgrade s
on e.sal between s.LOSAL and s.HISAL
--1대1로 맵핑되는 컬럼이 업구나... 근데 조인 가능... >> innerjoin 으로 해결


--테이블 2, 3, 4개 조인
select m.m1, m.m2, s.s2, x.X2 
from m join s on m.m1 = s.s1 
	   join x on s.s1 = x.x1
	   join y on x.x1 = y.y1


--사원의 사번, 이름, 급여, 급여등급, 부서번호, 부서이름을 출력하시오
select * from emp e join dept d on e.deptno = d.DEPTNO
join salgrade s on e.sal between s.losal and s.hisal

--부서번호가 10번인 사원들의 부서번호, 부서이름, 사원번호, 사원이름을 출력

select *
from emp e join dept d on e.deptno = d.deptno
where e.deptno = 10

--부서번호가 20번이하인 사원들의 부서번호, 부서이름, 사원번호 ,사원이름을 출력하되
--낮은순으로 정렬해라

select *
from emp e join dept d on e.deptno = d.deptno
where e.deptno <=20 order by d.deptno desc



-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
select ename, empno, deptno from emp

select * from dept
select * from emp
select * from salgrade

-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.
select e.ename, e.job, d.deptno, d.dname
from emp e join dept d on e.deptno = d.deptno where d.dname = 'dallas'

-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
select e.ename, d.dname  from emp e join dept d on e.deptno = d.deptno 
where  e.ename LIKE '%A%'


-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 
--출력하는데 월급이 3000이상인 사원을 출력하라.
select d.dname, e.sal,e.ename from emp e join dept d on e.DEPTNO = d.DEPTNO
where sal >= 3000


-- 5. 직위가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
select e.job, e.ename, d.dname from emp e join dept d on e.deptno = d.deptno
where job = 'salesman'


select * from dept
select * from emp
select * from salgrade

-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
select e.empno as '사원번호', e.ename as '사원이름', e.sal*12 as '연봉', e.sal*12+isnull(comm,0) as '실급여', s.grade as '급여등급'
FROM EMP E inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
where COMM IS NOT NULL


-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
 
 select d.deptno , d.dname, e.ename, e.sal, s.grade 
 from emp e join dept d on  e.deptno = d.deptno
inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.DEPTNO=10


-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름, 
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된 
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로 
-- 정렬하라.

select d.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on  e.deptno = d.deptno 
inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE  E.DEPTNO<=20
order by deptno asc , sal desc 

-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.

select e.empno as'사원번호', e.ename as'사원이름', e.mgr as'관리자번호', e.ename as '관리자명'
from emp e inner join emp m 
on e.mgr = m.empno 


-----------------------------------------------------------------
--Subquery

--johnes 가 받는 급여보다  더 많은 급여를 받는 사원의 이름과 급여를 출력해요
select sal from emp where ename ='jones'
select ename, sal from emp where sal > 2975


select ename, sal from emp 
where sal>(select sal from emp where ename ='jones')

/*
1. 괄호안에 있어야함..
2. 단독으로 실행 가능 해야함
3. 단일 컬럼으로 구성되야함 (select sal , detpno 이건 안되용)

결과가 하나의 컬럼, 하나의 컬럼의 데이터가 1개? 2개? 여러개?

실행순서 
서브쿼리가 메인쿼리보다 우선

종류
single row subquery : 결과가 1개의 row ( < > >= = )
multi row subquery : 결과가 여러개의 row인 경우( in, not in, any, all )
구분하는 이유는 사용하는 연산자가 달라서 
*/

-- 직종이 salesman인 사원들과 같은 급여를 받는 사원들의 사번, 이름, 급여정보를 출력하세요
select sal from emp where job = 'salesman'

select empno , ename, sal from emp
where sal in (select sal from emp where job = 'salesman')

-- 부서번호가 10번인 사원들과 같은 급여를 받는 사원들의 목록을 출력하세요
select * from emp where sal in (select sal from emp where deptno = '10')

select sal from emp where deptno = '10'

--부하직원이 있는 사원의 사번과 이름을 출력하세요
-- 자기의 사번이 mgr에 한번 나오면
select mgr from emp

select * from emp where empno in (select mgr from emp)
--empno=7902 or empno=7788 or empno = 1123 ....

--부하직원이 없는 사원의 사번과 이름을 출력하세요
--mgr 컬럼에 본인의 사번이 업으면 ( 관리자 가 아 님 )
 select * from emp where empno not in (select mgr from emp)
 --empno!=7902 and empno!=7369 and ...null >> null과의 모든 연산은 null

 select mgr from emp where empno not in (select isnull(mgr,0) from emp)

 --20번 부서의 사원 중에서 급여를 가장 많이 받는 사원보다 더 많은 급여을 받는 모든 사원 정보 출력
select * from emp where sal >(select max(sal) from emp where deptno = 20)

select * from emp where sal > all(select sal from emp where deptno = 20)
--where sal > data and sal > data and sal> data and..

select max(sal) from emp where deptno = 20

--20번 부서의 사원 중 가장 적은 월급을 받는 사원들보다 더 많은 월급을 받는 사원들의 이름과 월급을 출력해사

select ename, sal from emp where sal > (select min(sal) from emp where deptno =20)

/*
select > subquery
from > subquery
where > subquery

ALL(and) <--반대--> ANY(or)

*/
select ename, sal from emp 
where sal > any(select sal from emp where deptno =20)

--where sal>800 or sal > 2975 or sal >3000 or sal >1100 or sal >3000

--직업이 'salesman'인 사원과 같은 부서에서 근무하고, 같은 월급을 받는 사람들의 이름, 월급. 부서번호를 출력하라.
select deptno from emp where job ='salesman'

select sal from emp where job = 'salesman'

select ename, sal, deptno 
from emp where deptno in (select deptno from emp where job ='salesman')
and sal in (select sal from emp where job = 'salesman')


--자기 부서의 평균 월급보다 더 많은 월급을 받는 사원들의 이름. 월급 부서번호, 부서별 평균월급을 구하시오

select avg(sal) from emp where deptno = '10'

/*
부서별 평균월급을 담고 있는 테이블이 업음..  메모리를 잠시 생성.. subquery .. from 가상테이블
--1. if평균월급을 담고 있는 테이블이 존재한다면
10번부터.. 평균 2916
20번 부서 평균..2175
30번 부서 평균..1566.

--2. 서브쿼리가 from절뒤에 사용할 수 있음
*/

--실무에서 개 마니 씀 /테이블이 하나 있으면 조겠는데 create는 좀 그렇고 서브쿼리로 가상테이블을 하나 만들어서 사용하자
-- in live view
select * 
from emp e inner join (select deptno, avg(sal) as avgsal from emp  group by deptno)d
on e.deptno = d.deptno
where e.sal > d.avgsal


--TIP) 내가 셀렉하는게 단일? 여러개 (JOIN)하다가 해결 안되면 SUB QUERY) >> in line view(가상테이블)
 
 --1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
 select * from emp where sal > 800

 select ename,sal from emp where sal > ( select sal from emp where sal > 800)

--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
select sal from emp where deptno = '10'
select ename, sal, deptno from emp where sal in (select sal from emp where deptno = '10')

--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.
select deptno from emp where ename = 'blake'
select ename, hiredate from emp where deptno in ( select deptno from emp where ename = 'blake')


--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
select sal from emp where sal>avg(sal)
select empno, ename from emp where sal in (select sal from emp where sal>avg(sal))
order by sal asc


--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
select deptno from emp where ename LIKE '%T%'
select empno, ename from emp where deptno in (select deptno from emp where ename LIKE '%T%')



--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL 또는 ANY 연산자를 사용할 것)
select  max(sal) from emp where deptno ='30'

select ename, empno, sal from emp 
where sal >all ( select -- max(Sal)과 같은 효과
  sal from emp where deptno =30)

select * from emp;

select * from dept;

select * from salgrade;

--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
select * from dept where loc ='dallas'

select e.ename, d.deptno, e.job from emp e join dept d 
on d.deptno in ( select d.deptno from dept where loc ='dallas')

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.
select * from dept where dname = 'sales'

select e.empno, e.ename, e.job from emp e join dept d
on d.dname in (select * from dept where dname = 'sales')


--9. 'KING'에게 보고하는 모든 사원 mrg이 7398인놈들  의 이름과 급여를 출력하라.
select * from emp where mgr ='7839' 

SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO
		FROM EMP
		WHERE ENAME='KING')

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,
-- 급여를 출력하라.
select avg(sal) from emp where ename Like '%s%'

select empno, ename, sal from emp
--where deptno in (select DEPTNO from emp where ename Like '%s%')
WHERE SAL > (SELECT AVG(SAL)
		FROM EMP)
AND DEPTNO IN(SELECT DEPTNO
		FROM EMP
		WHERE ENAME LIKE '%S%')


--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
select comm from emp where comm is not null

select ename, sal, empno from emp 
where deptno in (select deptno from emp where comm is not null)
and SAL IN(SELECT SAL
FROM EMP WHERE COMM IS NOT NULL)


--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.
select sal, comm from emp where deptno = '30'

select ename, sal, comm from emp 
where comm not in (select isnull(comm,0) from emp where deptno = '30')


--13. 사원번호, 이름, 월급, 그리고 월급누적을 출력하라.
SELECT E.EMPNO, E.ENAME, E.SAL, SUM(D.SAL)
FROM EMP E, (SELECT EMPNO, SAL
		FROM EMP) D
WHERE E.EMPNO>=D.EMPNO
GROUP BY E.EMPNO, E.ENAME, E.SAL

---------------------------------------------------------------
--DML (insert , update, delete) 무 조 건 암 기 ---
/* 데이터 조 작 어
insert ... 실반영 
insert , update, delete .. begin tran이라는 작업을 같이 걸어서 commit까지 그냥 처리

*/
create table Test(
userid int
)
insert into Test(userid) values(100) --실반영
select * from Test
begin tran
insert into Test(userid) values(200)

rollback
--완료 / 취소( commit & rollback ) 명령어를 ..
select * from Test

begin tran
delete from Test
select * from Test
commit
/*
mssql DML 작업에 대해 autocommit 함
begin tran 
DML 작성하시면 
commit , rollback 서버에 실행

oracle dml 작업에 대해 default begin tran 
begin tran 생략..
insert..
반드시 commit & rollback 실행..

*****TRANSACTION***** : 하나의 논리적인 작업 단위 ( 성 공 OR 실 패 ) LOCK 이 기본
최대 한 단순하게 하는게 서버에 조음
은행 업무 
A 계좌 -> B 계좌로 이체 
업무의 특성은 commit & rollback 

여기서부 터 ...
A = A - 1000
B = B + 1000
여기까지 하나의 단위로....

*/

-- insert
--1. 전체 컬럼의 데이터 삽입하기

insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(9999, '홍길동', 'IT', 7902,getdate(), 3000, 100, 10)

select * from emp

insert into emp
values(9991, '홍동', 'IT', 7902,getdate(), 3000, 100, 10)

-- 특정 컬럼에 데이터 삽입 ( 반드시 컬럼명 명시 )
insert into emp
values(5555, '아무개', 800) --(x)

insert into emp(empno, ename, sal) -- 안쓴 데이터는 null 값이 들어감
values( 9992, '아무개',800)

insert into emp(empno, ename, hiredate, deptno)
values(9998, '깜보','2022-01-01', 10)

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
rollback -- 비긴트레인 한 시점부터 다 취소~

--------------------------------------------------------
----DELETE ---
-- 사원번호 7902 데이터를 삭제하시오
begin tran
delete from emp where empno = 7902
select * from emp where empno = 7902
rollback

begin tran
delete from emp
select * from emp
rollback

/*
부가적인 옵션

1. select into ( 테이블 생성 및 데이터 insert 까지)
2. insert ~ select ( 대량 데이터 삽 입 )
*/
select *
into emp01
from emp -- emp01 테이블 만들고 데이터 insert 한방에 해결 

select * from emp01

select empno , ename, job, sal 
into emp02
from emp
where 'A' ='B' 

select * from emp02

----------------------------------------------------------------

insert into emp (empno, ename)
values (1111,'AAA')
--values 대신에 select 절 사용할 수 있음

insert into emp02(empno, ename, job, sal)
select empno, ename, job, sal from emp where deptno = 10

select * from emp02

--실습 --------------------------------------------------------
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
-- 모든 실습문제는 EMP 테이블의 데이터 보존을 위해 BEGIN TRAN...
-- ROLLBACK TRAN 구문을 사용할 것

select * into emptest from emp
select * from emptest

-- 1. EMP 테이블에서 사원번호가 7499번인 사원의 월급을 5000달러로 바꿔라.

update emptest set sal = 5000 where empno = 7499

-- 2. EMP테이블에서 부서번호가 20번인 사원들의 월급을 4000달러로 바꿔라.
update emptest set sal = 4000 where deptno = 20


-- 3. DEPT 테이블에 아래의 조건으로 데이터를 입력하라.
-- 부서번호: 50, 부서위치: BOSTON,  부서명: RESERCH

insert into dept(deptno, loc, dname) 
values(50, 'BOSTON', 'RESEACH')


-- 4. 사원번호가 7698번인 사원의 부서번호를 7499번 사원의 
--부서번호로 바꿔라.
 
 update emptest set deptno = (select deptno from emptest where empno=7499)
where empno = 7698

-- 5. EMP 테이블에 아래와 같은 데이터를 삽입하라.
-- 사원번호: 9900, 사원이름: JACKSON, 직업: SALESMAN, 부서번호: 10

insert into emptest(empno, ename, job, deptno)
values (9900, 'JACKSON', 'SALESMAN', 10)

-- 6. INSERT...SELECT 문을 이용하여 직업이 'SALESMAN'인
-- 사원의 사원번호, 이름, 직업을 EMP 테이블에 입력하라.

insert into emptest(empno, ename, job) 
select empno, ename, job from emptest where job = 'SALESMAN'


-- 7. 사원번호가 7369번인 사원과 같은 직업을 가진 사원들의
-- 월급을 7698번 사원의 월급으로 수정하라.
update emptest set sal=(select sal from emptest where empno = 7698)
where job = (select job from emptest where empno = 7369)


-- 8. SCOTT과 같은 직업을 가진 사원을 모두 삭제하라.
delete from emptest where job =(select job from emptest where ename='scott')


-- 9. 'SCOTT'의 월급을 'SMITH'의 월급과 같게 수정하라.
update emptest set sal =(select sal from emptest where ename = 'smith')
where ename ='scott'
select * from emp

-- 10. 'ALLEN'의 직업을 'SCOTT'의 직업과 같게 수정하라.
update emptest set job =(select job from emptest where ename='scott')

-- 11. 사원번호가 7499번인 사원과 같은 직업을 가진 사원들의
-- 입사일을 오늘날짜로 변경하라.
update emptest set hiredate =getdate() where job =( select job from emptest where empno = 7499)


-- 12. SCOTT과 같은 직업을 가진 사원들의 월급을 0으로 수정하라.
update emptest set sal =0 where job =( select job from emptest where ename = 'scott')
begin tran 

select * from emptest



----------------------------------------------------------------------------------------------
--0324
-- DDL 정의어 >> Create , alter , drop
-- 1. DB 만들었지롱
-- 2. 그 저장소안에 .. TABLE 생성하고 놀쟈


sp_helpDB kosadb --DB 기본 정보 조회하기 

-- DDL table 생성
create table emp10  -- class emp10 { public int empno {get;set;} }
(
	empno int,
	ename nvarchar(20),
	hiredate datetime

)

/*
char(10) >> 영문자 ,특수문자, 공백 10자 or 한글 5자 저장하는 타입    >> 고정길이 문자열
varchar(10) >> 영문자 ,특수문자, 공백 10자 or 한글 5자 저장하는 타입 >> 가변길이 문자열

데이터가 '남' 또는 '여' / 주민번호 등의 고정된 데이터는 char를 써야댄다.
create table T ( gender char(2))   (0)  >> 내부적으로 성능이 좋음 
create table T ( gender varchar(2))

데이터가 사람의 이름 : ... 이수한무, 정재현 ...
create table T (name char(50))  >> 6바이트 들어가도 >> 50바이트 그대로 잡고있음
create table T (name varchar(50)) >> 6바이트가 들어가도 >> 6바이트 잡음

영문자와 한글을 섞어쓰면 ?
unicode 
create table T ( gender nchar(4))   >>  개수 4글자 (영문자 특수문자 공백 상관없이 4글자 )
create table T ( gender nvarchar(4))
*/

-- 테이블 정보

sp_help emp10 -- 암 기 

insert into emp10(empno, ename, hiredate)
values (100,'정재현',getdate())

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
values(1,'김정우','서울시','1996-12-12','댄스')

select * from member2
-- hobby >> null

insert into member2(id)
values(3)

select * from member2 

-- 1. 기존테이블에 컬럼 추가하기
alter table member2
add gender char(1) 

sp_help member2

--2. 기존 테이블에 기존 컬럼에 타입 변경하기 
alter table member2
alter column gender char(2)

alter table member2
drop column gender

--3. 테이블 삭 제 해 버 림
drop table member2

sp_help member2

create table emp03(
empno int not null, --empno는 null값을 허락하지 않아 넌 필 수 입 력
ename varchar(20) --default null 허용 - 부 가 입 력
)

insert into emp03(empno) values(0819)

select * from emp03

insert into emp03(ename) values('정재현') --열 'empno'에 NULL 값을 삽입할 수 없습니다. empno는 notnull이 있기 때문에 null 허용 안함

insert into emp03(empno, ename) values(7902,'김정우')

select * from emp03

create table emp04
(
	 empno int default 1000,
	 ename varchar(20)
)
sp_help emp04 --default 확인

insert into emp04(empno, ename) values (1111,'김씨')

select * from emp04

insert into emp04(ename) values ('박씨')
insert into emp04(ename) values ('이씨')

select * from emp04

sp_helpconstraint emp04

-- DF__emp04__empno__37A5467C 제약 이름임 (이름을 가지고 나중에 수정하거나 삭제할때 사용해야함)

create table emp05 
(
	empno int constraint df_emp04_empno default 1000,
	ename varchar(20)
)
-- df_emp04_empno 관용적 표현 / df_테이블명_컬럼명 대부분 개발자가 관용적 표현 사용

sp_helpconstraint emp05

create table user02(
	u_id int not null,
	u_name nvarchar(20),
	u_job varchar(50) constraint df_user02_u_job default 'IT'
)

sp_helpconstraint user02

insert into user02(u_id, u_name, u_job)
values(10,'정재현','가수')

select * from user02

insert into user02(u_id, u_name)
values(20,'김도영')

-- 회원테이블에서 default 마니쓰는거 .. 가입날짜 ( getdate())

--------------------------------------------------------------
-- 제약 (constraint)
/*
Data intergrity를 위한 방법 ( 무 결 성 )
제약의 방법
1. 테이블 생성시 정의하는 방법 : create table 문 사용
2. 만들어진 테이블에 정의하는 방법 : alter table 문 사용 *^^*

제약의 종류

1. NOT NULL

2. DEFAULT

3. PRIMARY KEY (not null + unique) >> 주민번호, 순번 , 지문...한개의 row를 반환받을 수 있다.
                                   >> where num = 1,where jumin = 123456-1234567
								   >> primary를 하면 검색 마니하겠군.. 속도 향상을 위해 내부적으로 인덱스 만들어야지..
								   >> 테이블 당 1개 ( 묶음 ) > 1개 2개() 3개() >> 복합키가 가능하다.

4. UNIQUE  (중복값 허락 안함)  >>  not null을 강제하지 않음
							   >> 검색 index 
							   >> 컬럼 수 만큼 

5. CHECK ( 남  또는 여 데이터만 들어올 수 있음, 1 ~ 10 까지만 ) where gender in ('남','여')


6. FOREIGN KEY					>> T O D A Y P O I N T (외래키, 참조키) 참조제약
                                >> 테이블과 테이블간의 [ 관계를 성립 ] 시 사용 RDBMS
								>> 관계) 부모 자식, master detail 
								>> emp .... dept
								>> Emp 테이블에 deptno 컬럼이 det deptno 컬럼을 참조한다.(FK)
								>> dept detpno 컬럼은 emp deptno컬럼에 참조를 당합니다.(PK)


*/
select * from emp
select * from dept

create table emp06(
	-- empno int primary key, 이렇게 쓰면 찾기 어려워
	empno int constraint pk_emp06_empno primary key, --pk_emp06_empno
	ename varchar(20),
)

sp_helpconstraint emp06

insert into emp06(empno, ename)
values(100, '김유신')

insert into emp06(empno, ename)  --PRIMARY KEY 제약 조건 'pk_emp06_empno'을(를) 위반했습니다.
values(100,'정재현')

insert into emp06(ename) --열 'empno'에 NULL 값을 삽입할 수 없습니다.
values('김유신') -- 열에는 NULL을 사용할 수 없습니다.

-- 테이블 당 1개 (묶어서)
-- 복합키 

create table pktable 
(
	a int,
	b int,
	c int 
	
	constraint pk_pktable_a_b primary key(a,b) -- A먼저 B다음
)

-- 복합키 순서가 
-- where b = 10 (문제가 있음 .. index를 안탐)
-- where a = 10 and b = 10( 조은케이스..)
-- where a = 10 .... 

sp_helpconstraint pktable

/*
이력 테이블 데이터 설계는 보통 복합키가 나옴

인사테이블 
2000  1  IT
2000  2  SALES

학력테이블
2000  1 인천고
2000  2 인천대

*/

create table emp07
(
	empno int constraint uk_emp07_empno unique, --중복데이터를 허락하지 않아요 -- UNIQUE (non-clustered)
	ename varchar(20)

)
sp_helpconstraint emp07 

insert into emp07(empno, ename) values(1000, '정씨')
select * from emp07

insert into emp07(ename) values('정씨')
insert into emp07(ename) values('박씨')
--UNIQUE KEY 제약 조건 'uk_emp07_empno'을(를) 위반
--중복 키 값은 (<NULL>)입니다.

create table emp08(
empno int not null constraint uk_emp08_empno unique,
ename varchar(20)
)

-- 그러면 empno int not null constraint uk_emp08_empno unique은 >>primary key랑 같은ㄱ ㅓ아님?
-- 아뉘 다르지롱 constraint는 컬럼갯수만큼 priamry는 1개만 할 수있음

--중복값을 허락하지 않지만 null은 허용하고 null도 중복쪠끄를 한다 

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
	gender char(2) constraint ck_emp10_emmp10_gender check(gender in ( '남','여'))
)

sp_helpconstraint emp11

insert into emp11(empno, ename, gender) values(1000,'김','중')
--INSERT 문이 CHECK 제약 조건 "ck_emp10_emmp10_gender"과(와) 충돌했습니다.

insert into emp11(empno, ename, gender) values(1000,'김','남')

-- 참조 제 약
select * from emp

select * from dept

-- MSSQL은 NOT NULL 하지 않은 컬럼에 대해 .. PK를 못구하게 되어있음
alter table dept
alter column deptno int not null

alter table dept 
add constraint pk_dept_deptno primary key(deptno)
--테이블 'dept'의 Null 허용 열에 PRIMARY KEY 제약 조건을 정의할 수 없습니다
-- not null한 것만 추가적으로 pk를 걸 수 있음

alter table emp
add constraint fk_emp_deptno foreign key(deptno) references dept(deptno)
--참조되는 테이블 'dept'에 외래 키 'fk_emp_deptno'의 참조 열 목록과 일치하는 기본 키 또는 후보 키가 없습니다.

-- 반드시 참조하는 테이블에 pk가 선행되어야 한다.
-- 그 다음에 fk 할 수 있음 emp 테이블에 empno는 dept테이블이 갖고있는 데이터만 허용함

--옵션
--identity(증가분)
-- 채번(번호표)
-- sequence (객체 번호표) : oracle, mssql

create table board(
board int identity(1,1),
title varchar(20),
)

insert into board(title) values('방가방가')

select * from board

create table emp20(
	a int , 
	b int,
	c as a+b -- 계산된 열
)

insert into emp20(a,b) values (100,300)

select * from emp20

-------------------------------------------------------------------
--VIEW ( 가 상 테 이 블 ) 
-- 어떤사람 : Sql 문장 덩어리
-- VIEW는 객체 (create ..  drop전까지 살아있음) - 데이터를 갖고 있지 않음

Create view tbl_emp
as
	select empno, ename, job, deptno from emp

-- ㅅㅏ용법 : 가상 테이블 >> 테이블처럼 사용 >>view를 통해 데이터를 본다

select * from tbl_emp --view가 가지고 있는 sql문장이 실행됨

select * from tbl_emp where deptno = 10 --view를 통해 볼수있는데이터는 다 가지고 놀 수 있음


sp_help tbl_emp 
--owner : dbo	type : view	name : tbl_emp	2022-03-24 14:48:01.600

sp_helptext tbl_emp
--- select empno, ename, job, deptno from emp



--편리성 *** ( 쿼리 단순화 >> 물리적인 테이블이 없는 경우  >> 뷰를 통해 가상테이블을 만들어 사용 >> JOIN)
Create view v_emp --부서번호 , 부서이름, 사번 ... 매번 조인해야함..
as
 select empno, ename, e.deptno, dname from emp e inner join dept d 
 on e.deptno = d.deptno

 select * from v_emp

 --복잡하거나 자주쓰는건 view를 만들어놓고 뷰를 통해 사용ㅎ ㅏ면  편하자나~

 --결과) 기존에 배운 쿼리를 다 알고 있다면 view는 공짜로..(?)
 --직업이 salesman인 사람들의 이름, 월급, 직업만 보여주는 view를 만들어라

 create view vv_emp
 as
 select empno, sal, job from emp where job = 'salesman'

 select * from vv_emp 

 --부서번호가 30번인 사원의 이름, 급여, 부서번호를 보여주는 뷰를작성
create view vvv_emp
as
select ename, sal, deptno from emp where deptno =30

select * from vvv_emp

-- view도 테이블이면 DML 작업 되뇨?
-- VIEW 통해서 Insert update delete 작업 가능
-- View 통해서 원본 테이블에서 view가 볼 수 있는 것만 
-- 근데 하지 마셈..ㅎㅎ

select * from vvv_emp

begin tran
update vvv_emp set sal = 0 -- 실제 참조하는 테이블의 데이터가 바뀜
select * from emp
select * from vvv_emp
rollback

--부서별 평균 월급을 담고 있는 view를 만드시오 inline view

create view empavg
as
select deptno , avg(sal) as 'avgsal' from emp group by deptno

select * from empavg

select * from emp e join empavg s 
on e.deptno = s.deptno and e.sal > s.avgsal

--1. 편리성 ( 복잡한 쿼리(조인) .. view를 만들어서 편하게 )
--2. 가상테이블 (원하는 데이터를 만들어서 ) join 같은것 처리

--사원테이블에서 이름과 월급만 담는 뷰를 작성하되, 월급이 높은순으로 출력하자나
-- view 생성시 order by 사용하지 마세요
create view view0002
as
select top 20 ename, sal from emp order by sal desc

select * from view0002

--1. 30번 부서 사원들의 직위 이름 월급을 담는 view를 만들어라
create view emp3030
as
select job, ename, sal from emp where deptno = 30

--2. 30번 부서 사원들의  직위, 이름, 월급을 담는 VIEW를 만드는데,
-- 각각의 컬럼명을 직위, 사원이름, 월급으로 ALIAS를 주고 월급이
-- 300보다 많은 사원들만 추출하도록 하라.

create view emp4044
as
select job as'직위', ename as'사원이름', sal as '월급' from emp where sal > 300 and deptno = 30

select * from emp4044


--4. 부서별 평균월급을 담는 VIEW를 만들되, 평균월급이 2000 이상인
-- 부서만 출력하도록 하라.

create view emp5050
as
select deptno, avg(sal) as '평균월급' from emp 
 group by deptno where avg(sal) >=2000
 

 begin tran
 update emp set sal = 0
 
 select* from emp with(nolock) -- 나는 다른사람이 트랜잭션진행중이라도 락해제하고 볼거임 -- 업데이트된걸 보여줌
--데이터의 동기화는 보장하지 못한당
 

 select rownum, empno
from (
select row_number() over (order by empno) --empno가 정렬된 기준위에서 over 순번을 붙일게 row_num 
as rownum , empno
from emp
) T where t.rownum between 1 and 5 --pagesize = 5인 경우,


SELECT T.MEMBER_ID 

FROM ( 
       SELECT ROW_NUMBER() OVER (ORDER BY MEMBER_ID) AS ROWNUM, MEMBER_ID 
       FROM MEMBER_TABLE WITH (NOLOCK) ) T -- nolock을 거는 이유 : 게시물쓰고있어도 ㄱㅊ게 하려고 
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
select * from T order by total desc; -- 부서번호별 총급여가 많은 순으로 나열함


--Q1. DATETIME 데이터 타입을 가지는 @ymd 변수를 선언하고,
--이 변수에 GETDATE()함수를 사용하여 현재 날짜시간을 저장한 다음 화면에 출력하라.

DECLARE @ymd datetime
SET @ymd=GETDATE()
SELECT @ymd

--Q2. INT 데이터 타입을 가지는 @sal 변수를 선언하고, 
--이 변수에 5000이라는 초기값을 담도록 지정하라. 
--그리고 EMP 테이블에서 월급이 @sal인 사원의 이름과 월급을 출력하라.

DECLARE @sal int
SET @sal=5000
SELECT ENAME, SAL
FROM EMP
WHERE SAL=@sal
-- 하나의 블록안에서 실행해야함

-- EMP 테이블로부터 평균월급을 담는 변수를 선언하고,
--이 변수를 이용해 평균월급보다 더 많은 월급을 받는 사원의 모든 정보를 출력

Declare @maxsal
set @maxsal =(select avg(sal) from emp)
select * from emp where sal >avg(sal)


DECLARE @avg int
SET @avg=(SELECT AVG(SAL) FROM EMP)
SELECT *
FROM EMP
WHERE SAL>@avg

--@1. 변수 @i에 임의의 값을 설정하고 @1의 값이 100보다 작을 경우와
--100이상일 경우를 나누어 출력 메세지를 다르게 뿌리는
-- if ~ else 문을 작성해라

declare @i int
set @i = 250
if @i < 300
select convert(varchar(10),@i) + '은 100보다 작습니다'
else
select convert(varchar(10),@i) + '은 100보다 큽니다'

--begin ~ end 블록
declare @sal int 
set @sal = 2000
if @sal > = 3000
	begin
		print '월급이 3000달러 이상인 사원들'
		select *
		from emp
		where sal >= 3000
	end
else
	begin
	print '월급이 3000달러 미만인 사원들'
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
		   '방가방가'
		end
		) as '하나의컬럼' ,111 as '데이터1', 222 as '데이터2',333 as '데이터3' -- 테이블에 컬럼이 있는게 아니라 인위적인 것도 데이터가 채워진다.
		from emp



		
select empno , ename, job, deptno,
		( 
		case        when deptno = 10 then 'aA'	
					when deptno between 20 and 30 then 'Bb'
					when deptno in (40, 50) then 'Cc'
		else 
		   '방가방가'
		end
		) as '하나의컬럼' ,111 as '데이터1', 222 as '데이터2',333 as '데이터3' -- 테이블에 컬럼이 있는게 아니라 인위적인 것도 데이터가 채워진다.
		from emp

		select * from emp


-- while 1 ~ 10 까지의 합 
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
	--프 로 시 저 -- ex sp_constraint, sp_help 어쩌구
	-- 장점 : 보안 , 성능(파라미터를 쓸수있어서 되게 넓음), 관리 
	create proc myproc
	as
	select empno, ename from emp

	exec myproc --프로시저 출 력~

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

	--프로시저 이름
	-- 시스템.. 프로시저
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

	-- * input 매개변수 사용 가능 
	create proc myproc3
	@i int --input 파라미터
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
	exec myproc4 --함수 'myproc4'에 매개 변수 '@i'이(가) 필요하지만 제공되지 않았습니다.

	alter proc myproc4
	@i int = 2 -- 디폴트값을 줄 수 있음, 이러면 파라미터 업어도 되쟈나
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

	--pubs db의 title이라는 테이블에서 책 이름고 ㅏ그 책의 가격을 가져오는
	--myproc6라는 프로시저를 만들어라 그리고 책 이름과 책의 가격은 사용자로부터 ㅇ비력받고
	--값을 입력하지 않으면 defualt 어쩌구로 %와 null로 출력디도록 지정
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

	exec myproc66 @price = 19.99 --특정 파라미터만 변수면 @price
	exec myproc66 '%talk%', 19.99 -- straight talk 어쩌구..
	
	--시스템 프로시저
	sp_tables
	sp_help titles
	sp_helpdb
	select * from titles

	--inpub & output
	create proc myproc7
	@a int, 
	@b int,
	@c int output -- 나는 이것을 값을 담아서 당신에 게 돌 려 줄게요
	as
	set @c = @a + @b
	print @c

	exec myproc7 10,20 --함수 'myproc7'에 매개 변수 '@c'이(가) 필요하지만 제공되지 않았습니다.
	-- output이라는 함수는 밖에서 받을준비를해야함

	declare @out int 
	exec myproc7 10,20,@out
	select @out

-- Q2. 처음 입력한 숫자에 30을 더한 후, 
-- 더한 값에 두 번째 숫자를 곱한 값을 출력하는 프로시저를 작성하라.

	create proc myproc8
	@a int,
	@b int,
	@c int output,
	as
	set @c = (@a+30) *@b 
	

	declare @out int
	exec myproc8 10,20 @out output
	select @out as '결과값'

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

	-- output 말고 return을 사용도 가능
	--return은 받는방법이 좀 틀려짐
	use KosaDB

	create proc myproc10
	as
		declare @count int
		set @count = (select count(*) from emp)
		return @count

		declare @return int
		exec @return = myproc10
		select @return

-- return 되는 값의 유무에 따라 로직을 제어할 수 있음
-- 데이터 존재 유무
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
	exec @exist = myproc11 7788 --데이터가 있으면 1을 리턴해라.
	select @exist

	
	declare @exist int
	exec @exist = myproc11 1000 --데이터가 있으면 1을 리턴해라.
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
	set @err = @@error -- 시스템 변수
	end catch
	
	return @err

	sp_helpconstraint dept

	declare @result int
	exec @result = usp_dept_insert 100, 'IT','SEOUL'
	select @result -- 0 이 나오면 정상 나머지는 에러번호..2627번 (프라이머리키 제약에 대한 에러번호)

	
	select * from dept

	-- 에러 메세지를 보고 싶어요


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
	select @msg --PRIMARY KEY 제약 조건 'pk_dept_deptno'을(를) 위반했습니다. 개체 'dbo.DEPT'에 중복 키를 삽입할 수 없습니다. 중복 키 값은 (200)입니다.


	--emp 테이블에 부서번호를 update하는 프로시저
	--logic은 마음대로 
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
		exec numnum 300,'it','인천', @msg output
		select @msg 


--동적 프로시저
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


--사용자 정보 테이블 
Create Schema Users 
go 

use_kosaDB

--회원정보를 위한 테이블들 
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


--회원데이타를 다루기 위한 저장프로시져들 
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


--이미 등록된 유저의 경우(userID:-1, email:-2)
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
				SET @iRetmsg = @@RowCount -- 반영된 행의 갯수
				IF @iRetmsg >= 1 
					BEGIN 
						INSERT INTO Active( UserID ) VALUES ( @userID ) --회원가입 성공시
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


--우편번호 검색을 위한 프로시져 
/*Create Proc up_GetList_PostCode_Search
(
	@juso	varchar(50)
)
as
Select zipCode, zipSerial, sido, gugun, dong, ri, doseo, bungi, building, juso 
From PostCode 
Where juso like '%'+ LTrim(RTrim(@juso))+'%'


--test
exec up_GetList_PostCode_Search '역삼'
*/

--1. 회원가입하기 

declare @returnvalue int
exec up_Add_UsersInfo 'hong','홍길동','0819','jaehyeon@naver.com',
'010-6210-5345','123-123','서울시 강남구',@returnvalue output
select @returnvalue 

declare @returnvalue int
exec up_Add_UsersInfo 'hong2','홍길동','0819','jaehyeon@naver.com',
'010-1234-1234','123-123','서울시 강남구',@returnvalue output
select @returnvalue  -- -2 가 결과값으로 나옴

select * from Info
select * from active

exec up_get_usersinfo 'hong'

exec up_Update_UsersInfo 'hong','홍길동','0819','jaehyeon@naver.com',
'010-1111-1122','123-123','서울시 성북구'

exec up_Delete_UsersInfo 'hong'

select* from info

select *from active

--프로시저를 사용한 CRUD
-- create > insert
-- read > select
-- update > update
-- delete > delete 

-- 단일 테이블에 대해서 ... 5개의 기능을 만듬
/*
c#에서 model 구성(DAO > C# 함수 만듬

회원테이블이 member
public List<member> getAllmember(){
	쿼리를 짜주면 됨니다...select * from emp
}

public member getAllMemberByUserId(string userid){
	쿼리..select * from emp where empno = 7788
}

public int insertMember(member m){ (객체를 파라미터로 받음)
	쿼리
}


전체 데이터 조회 (select * from emp)
단일 데이터 조회 (select * from emp where empno = 7788 ) pk제약이 걸린 조회
삽입             (insert 
삭제			 (delete
수정			 (update

추가
검색들
문자열 검색, 조건(이름, 나이로 검색하는 거임)
*/

--게시판을 가정해서 테이블 하나 만들고 그걸가지고 다섯개의 프로시저를 만들기 오후 한시간 정도 과제

create table kosaboard(
	boardid int identity(1,1) constraint pk_kosaboard_boardid primary key,
	title nvarchar(30) not null,
	content nvarchar(2000) not null,
	userid nvarchar(20) not null,
	regdate datetime default getdate(),
	filename nvarchar(30),
)

-- 프로시저 다섯개 최대한 예뿌게... 조별로 배운거 최대한 활용해서 실무에 가깝게...;;;
-- 전체데이터조회 , 단일데이터조회, 삽입, 삭제, 수정

create proc kosaboard_check_all()
as
begin
update board set 뭘바꾸지? where 파라미터
select boardid, title, content, userid, regdate, filename from kosaboard where (파라미터)
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




-- substring(), max(), min(), avg() 시스템함수
-- public string fn_sum(int val, int val2){ return val + val2 }

create function fn_sum
(@val01 int, @val02 int)
returns int -- public int ( 리턴 타입을 정의 )
as
begin
	return (@val01 + @val02)-- return val + val2 (파라미터로 받은 01+02 리턴 값을 정의 )
end


select dbo.fn_sum(100,200)

--함수를 만들어 사용하는 자원
/*
문자, 날짜에 관련된것을 조작해서 ... 
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
건설회사

급여테이블
정규직 : 월급여
일용직 : 하루일당 + 점심갑
시간직 : 시간 * 금액

사번 이름  월급여  일당  식대  시간  금액
100   정     10
200   일            100   10
300   시                         5    500
400   정기   20

[모든 행마다] 총 급여 계산할때 계산 방식...이 달라...

커서는 보통 급여나 카드명세서..에서 사용된다.
*/

-- 학생 테이블에서 각 학생의 시험 점수를 가지고, 
--‘수,우,미,양,가’ 형식의 값을 지정하는 커서 작성 예

create table student
(
id int primary key,
name varchar(20) not null,
value tinyint not null, -- 점수
grade nchar(1) -- '수,우,미,양,가'
)

insert into student(id, name, value)
values(1, '철수', 60)
insert into student(id, name, value)
values(2, '영희', 80)
insert into student(id, name, value)
values(3, '인호', 50)

select * from student

--커서예시
declare std_cursor cursor --커서 선언
for
	select value from student -- 커서가 쓰는 데이터 -- 원본
	for update 
	open std_cursor-- 이때 select ~ 가 실행되서 메모리에 올라감
	declare @value tinyint, @grade nchar(1)
	fetch next from std_cursor into @value --접근해서 가져옴
	while(@@FETCH_STATUS =0) -- 0이면 계속돌아요잉
	begin
		if(@value >=90)
			set @grade = '수'
		else if(@value >=80)
			set @grade = '우'
			else if(@value >=70)
			set @grade = '미'
			else if(@value >=60)
			set @grade = '양'
			else 
			set @grade = '가'
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
			when @value between 90 and 100 then N'수'
			when @value between 80 and 89 then N'우'
			when @value between 70 and 79 then N'미'
			when @value between 60 and 69 then N'양'
			else N'가'
		end)
		where current of std_cursor -- 커서가 가리키는 현재 레코드
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
	where lastname like 'b%' --이름이 b로 시작하는 emp의 이름을 메모리에 올릴게!

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
		set @col3  = @col3 + @col2   --누적데이터 구하기
		select @col1 , @col2 , @col3
		fetch next from cur_test into @col1, @col2
	end

close cur_test
deallocate cur_test 

select * from test
---------------------------------------------------------

--결국에는 커서내용을 프로시저안에 집어넣는겨
create proc sal_date_process
as
	--커서내용이 들어감

	--연말이 되면 프로시저 호출
	-- 스케줄링..(배치프로그램을 만듬)
	-- 특정 시간이 되면 자동으로 ...
	exec sal_date_process 


----------------------------------------
	CREATE TABLE MY_FRIEND(
NAME NVARCHAR(20),
AGE NUMERIC(3)
)

INSERT INTO MY_FRIEND(NAME,AGE)VALUES('홍길동',20)
INSERT INTO MY_FRIEND(NAME,AGE)VALUES('홍길순',25)
INSERT INTO MY_FRIEND(NAME,AGE)VALUES('김철수',22)
INSERT INTO MY_FRIEND(NAME,AGE)VALUES('김민수',27)


--변수 선언 조회한 컬럼을 담을 변수도 선언해야한다.
create proc update_cursor_friend
as
DECLARE 
@INDEX INT,
@NAME VARCHAR(100),
@AGE INT           

SET @INDEX = 0; --INDEX초기화

DECLARE CUR CURSOR FOR   --CUR라는 이름의 커서 선언

SELECT --쿼리 조회
NAME,
AGE                
FROM MY_FRIEND

OPEN CUR      --커서 오픈
FETCH NEXT FROM CUR INTO @NAME,@AGE  --SELECT한 값을 @NAME,@AGE 변수에 넣는다.

--커서를이용해 한ROW씩 읽음 
WHILE @@FETCH_STATUS = 0
BEGIN
SET @INDEX = @INDEX + 1; --INDEX증가

--SELECT 한 데이터의 행집합을 가지고 수행할 작업
UPDATE MY_FRIEND
SET AGE = @AGE+1 --나이+1
WHERE NAME = @NAME
	
FETCH NEXT FROM CUR INTO @NAME,@AGE	--다음ROW로 이동
END

--커서 닫고 초기화
CLOSE CUR
DEALLOCATE CUR


exec update_cursor_friend

select * from MY_FRIEND