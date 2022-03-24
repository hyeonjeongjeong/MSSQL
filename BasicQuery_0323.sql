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
