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
DDL(Data Definition Language): 데이터 정의 언어, 데이터베이스 개체의 생성/변경/삭제을 목적으로 사용하는 언어
CREATE ... : 없는걸 만듬
ALTER ... : 수정
DROP ... :삭제

DCL(Data Control Language): 데이터 제어 언어, 데이터 제어를 정의하고 기술하는 언어, 누가 데이터를 제어할 수 있는지를 지정하는 언어.
DB관리자가 주로 하는 역할
GRANT : 허락해줌
REVOKE : grant 했다가 권한 줬던걸 빼앗음
Deny : 접근금지

DML(Data Manipulation Language): 데이터 조작 언어, 데이터 자체를 처리하고 조작하기 위한 언어
개발자가 해야하는 ~ 

SELECT : 60프로 >> 함수 , 조인, 서브쿼리, 뷰 등등

INSERT

UPDATE 

DELETE
*/


SELECT * FROM emp;

select * from dept;

select * from salgrade;

--1. 사원 테이블에 있는 모든 사원 데이터를 출력하세요
select * 
from emp;

--2. 특정 컬럼만 (사번, 이름 ,급여 )만 출력하세요
select empno , ename, sal 
from emp;

--3. 부서테이블에 있는 부서 번호, 부서이름 출력하세요
select deptno, dname from dept;

--4. 사원번호, 사원이름 컬럼명을 출력시 한글로 ..
select empno 사원번호, ename 사원이름 from emp;
select empno as '사원 번호', ename as '사원 이름' from emp;

--5. 사원테이블에서 직종을 출력하세요
-- 우리 회사에 직종이 몇개 있나?
select job from emp;
-- 중복된 열 제거하고 출력 distinct
select distinct job from emp;


--SQL (언어) 질의를 할 수 있는 언어
--연산자 
--1. 산술, 비교, 논리

--6. 사원테이블에서 사번empno, 이름ename, 급여sal, 300달러 인상된 급여를 출력하세요
select * from emp;
select empno, ename, sal, sal+300 as '인상급여' from emp;

--7. 사원테이블에서 사번, 이름, 급여, 연봉을 출력
select empno, ename, sal, sal*12 as '연봉' from emp;

--8. Null (필요악)  - 초급개발자는 이걸 잘써야한다
--회원 테이블 .. 회원번호 , 회원명, 핸드폰번호, 취미 (필수 입력, 옵션 null 허용)
select * from emp;

select empno, sal, comm from emp;
-- comm 데이터가 null >> 커미션을 받지 않는구나..
-- 0도 받지 않는거지만 수업용임.... 

--9. 사원테이블에서 사번, 이름, 직종, 급여, 수당, 급여+수당
select empno, ename, job,sal, comm , sal+comm  as'총급여' from emp;

--POINT ** Null 과의 모든 연산 결과는 >> Null
--NULL을 처리하는 함수..
--Oracle : nvl() >> select nvl(comm,0)
--Mysql : ifnull() >> select ifnull(comm.,0)
--Mssql : Isnull()

select sal+isnull(comm,0) from emp;
select empno, ename, job,sal, comm , sal+isnull(comm,0) as'총급여' from emp;

/*
실행순서 
selct 3
from  1
where 2
*/
--사원테이블에서 사번이 7788인 사원의 사번, 이름, 급여를 출력하세요
select empno, ename, sal
from emp
where empno =7788;

--사원테이블에서 사원이름이 smith 인 사원의 모든정보를 출력하시옹 
select * from emp where ename = 'SMITH';

--Oracle은 문자열 대소문자를 엄 격 하 게 구분함
--where ename = 'smith'; 안나옴
--어디에서든지 문자열 데이터는 있는 그대로 쓰자 ~~~ (소문자이던 대문자이던 그러면 어느 디비를 써도 문제업잔슴)

--사원테이블에서 입사일 1980년 12월 17일인 사원의 모든 정보 출력
--날짜데이터도 이름처럼 '' 사용해서 데이터 처리
select * from emp where hiredate ='1980-12-17';
select * from emp where hiredate ='80/12/17';

--직종이 saleman인 사원의 사번, 이름, 급여, 직종 출력
select empno, ename, sal, job
from emp
where job = 'SALESMAN';


--부서번호가 10번인 사원의 부서번호, 이름, 급여정보 출력
select deptno, ename, sal from emp where deptno ='10';

--비교연산
--사원 테이블에서 급여가 3000달러 이상인 사원의 이름과 월급을 출력하세요
select ename, sal from emp where sal>=3000

--사원테이블에서 직종이 salesman이 아닌 사원의 사번과 이름, 직종을 출력하세요
select empno, ename, job from emp where job != 'SALESMEN';

--사원테이블에서 연봉이 3000달러 이상인 사원의 사번, 이름, 급여, 연봉을 출력하세요
select empno, ename, sal, sal*12 as'연봉' from emp where (sal *12) >3000;

--직종이 salesman이고 급여가 2000이상인 사원의 사번, 급여, 직종을 출력하세요
--and
select * from emp
where job = 'SALESMAN' and sal >= 1500;

--직종이 salesman이거나 급여가 2000이상인 사원의 사번, 급여, 직종을 출력하세요
select * from emp
where job = 'SALESMAN' or sal >= 1500;

-- 사원테이블에서 급여가 1000달러 이상 3000달러 이하인 사원의 사번,이름,급여 출력하세요
select empno, ename, sal from emp where 1000>=sal and sal<=3000

--between A and B ( =을 포함)
select empno, ename ,sal from emp where sal between 1000 and 3000;

--사원테이블에서 급여가 1000초과 3000미만인 사원의 사번, 이름, 급여를 출력하세요 // 이건어쩔수업이 이러케 써야댐
select empno, ename, sal from emp where 1000>sal and sal<3000 

--사원테이블에서 사번이 7788, 7902, 7369인 사원의 사번과 이름을 출력하세요
select empno, ename from emp where empno = 7788 or empno = 7902 or empno = 7369

-- in 연산자 ( 이러면 반복적으로 쓰지 않아도 되서 조왕)
select empno,ename from emp where empno in(7788,7902,7359);

----사원테이블에서 사번이 7788, 7902, 7369이 아닌 사원의 사번과 이름을 출력하세요
select empno, ename from emp where empno not in (7788,7902,7359);

--Like 연산자 (패턴 : 문자열)
--사원테이블에서 이름에 S로 시작하는 ^모든^(s로 시작해 뒤에 뭐가 와도 상관없다) 사원의 사번과 이름을 출력하세요
select * from emp where ename like 'S%'; 

--Like 연산자를 도와주는 wild card
--% 모든 것, (아무것도 없는 경우도 포함)
-- _ 한문자
--[] 안에 있는 문자
--[^] 다음에 있는 것은 제외함

--이름에 두번째 글짜가 A인 사원의 사번과 이름을 출력하세요
select * from emp where ename like '_A%' ; --a가 두번째

/*
WARD
MARTIN
JAMES
*/

-- 이름에 T가 두번 들어있는 사원 
-- TT, ATAT
select * from emp where ename like '%T%T%';
--SCOTT

--이름에 첫글자가 A , B , S 로 시작하는 사람들
select * from emp where ename like'[ABS]%';
/*
SMITH
ALLEN
BLAKE
SCOTT
ADAMS
*/
--이름의 첫글자가 A or S 시작하고 두번째 글짜가 C로 시작하지않는 솨뢈
select * from emp where ename like '[AS][^C]%'


--QUESTION
--1. 사원테이블에서 모든 데이터를 출력하라
select * from emp 

--2. 사원테이블에서 사원번호, 사원이름, 월급을 출력하라
select empno, ename, sal from emp

--3. 사원테이블에서 월급을 뽑는데 중복된 데이터가 없게 출력하라
select distinct sal from emp 

--4. 사원테이블에서 사원이름과 월급을 출력하는데 각각의 컬럼명을
-- '이 름','월 급'으로 바꿔서 출력하라. 단, ALIAS에 공백추가
select ename as '이 름', sal as '월 급' from emp 

--5. 사원테이블에서 사원이름, 월급을 뽑고, 월급과 커미션을  더한 값을
-- 출력하는데 컬럼명을 '실급여'이라고 해서 출력하라.
-- 단, NULL값은 나타나지 않게 하라.
select ename, sal, sal+isnull(comm,0)as '실급여' from emp 

--6. 사원테이블에서 'SCOTT'이라는 사원의 사원번호, 이름, 월급을 출력하라
select empno, ename, sal from emp where ename = 'SCOTT'


--7. 사원테이블에서 직위가 'SALESMAN'인 사원의 사원번호, 이름, 직위를
-- 출력하라
select empno, ename, job from emp where job = 'SALESMAN'

--8. 사원테이블에서 사원번호가 7499, 7521, 7654인 사원의 사원번호, 이름
-- 월급을 출력하라
select empno, ename, sal from emp where empno in (7788,7521,7654)

--9. 사원테이블에서 월급이 1500에서 3000사이인 사원의 사원번호, 이름,
-- 월급을 출력하라.
select empno, ename, sal from emp where sal between 1500 and 3000

--10. 사원테이블에서 이름의 첫글자가 A이고 마지막 글자가 N이 아닌 사원의
-- 이름을 출력하라
select ename from emp where ename LIKE'A%[^N]'


create table TLike(
col1 int,
col2 varchar(10) -->10바이트 (한글 5자, 영어,특수,공백 10자)
)

go --위에 블록이 문제가없으면 밑에꺼 실행하쇼잉
insert into TLike(col1, col2) values(10, '10')
insert into TLike(col1, col2) values(20, '10%')
insert into TLike(col1, col2) values(30, '20')

select * from TLike

select * from TLike where col2 like '%10%'
--10%만 검색하고십은데 ..;; 특수문자로 인식함..;; %를 문자 그대로 인식시켜야되는데
select * from TLike where col2 like '%10E%%' escape 'E' 
--ESCAPE E라고하는 문자를 데이터로 인식할고야 >> 10E%

--TODAY POINT 
--사원테이블에서 커미션이 책정되어있지 않은 (받지않는)
--사원의 이름과 커미션을 출력해라 (단, comm = 0 인것은 받는것으로 인정)
-- select * from emp where comm = null; 이런문법업음..;;
--null 조건은
--1. isnull
--2. is not null
select * from emp where comm is null
--수당을 받는 사원들은
select * from emp where comm is not null

--함수
--문자함수, 숫자함수 ,날짜함수 ,계산함수, 시스템 함수..

--1. 문자함수
select lower('ABC')
select upper('abc')

select upper(ename)as 'ename' from emp 

select 100+100+100
select ename + ' is a ' + job from emp -- + 연산 or 결합(문자열)

select substring ('abcd',1,3)
select substring ('abcd',3,1) --1 자기자신임

select left('abcd',3)
select right('abcd',3)

--사원테이블에서 사원의 이름에서 첫글자는 대문자로 나머지는 소문자로 출력하세요
--a() b() c() 불가능
select left (ename,1) + left(ename,2) from emp
select upper(left(ename,1)) + lower(substring(ename,2,len(ename))) from emp 

select len('abcd') 
select len(ename) from emp
select len('a      b')
select len('       a')
select len('a       ') -- len 함수는 후행공백을 인지하지 못한다.

select datalength('abc') --3byte
select datalength('홍길동') --6byte

--공백제거
select '>' + '      a' + '<'
-->a<
select '>' + ltrim('      a') + '<'
-->a<
select '>' +rtrim('a          ') + '<'
select '>' +rtrim(ltrim('a          ')) + '<'

--replace
select replace ('abcd','a','NEWNEW') --1번에서 a라는 글자를 찾아 newnew로 대체해라

--'홍      길      동'
select '>' + '홍      길      동' '<'

--데이터 안쪽에 공백이 있음..;; 이 공백을 없애서 출력
select replace('홍      길      동',' ','')

--숫자함수
--round 반올림함수
select round(123.45,1) --123.50 소수이하 첫번째 자리까지 남겨라잉 
select round(123.45,2) --123.45
select round(123.45,0) --123
select round(123.55,0) --124.00

--승 함수 ..? 
select power(2,4) --2의4승


--CEILING : 지정된 숫자보다 큰 최소 정수를 반환하여 출력
select CEILING(1234.5678), CEILING(123.45), CEILING(-1234.56)

--FLOOR : 지정된 숫자보다 작은 최대 정수를 반환하여 출력
select FLOOR (1234.5678), FLOOR(123.45), FLOOR(-1234.56)--1234 123 1235

--날짜함수
select getdate()

--Oracle : select sysdate
select dateadd(yy,10,getdate()) --연도에다가 10을 더해잉
select dateadd(dd,100,getdate())
select dateadd(mm,5,getdate())

select dateadd(yy,10,'2022-01-01')

select datediff(yy,'2010-12-12','2022-1-13'); 
select datediff(mm,'2010-12-12','2022-1-13');
select datediff(dd,'2010-12-12','2022-1-13');-- 연도의 차이를 구해라

--단, 조건이 월은 30일까지
select ename,
datediff(dd,hiredate,getdate()) / 365 as '년',
(datediff(dd,hiredate,getdate())% 365)/30 as '개월',
(datediff(dd,hiredate,getdate())% 365) % 30 as '일'
from emp

--오늘부터 연말 12월31일까지 며칠 남았냐?
select datediff(dd,'2022-03-22','2022-12-31')

select year(getdate())
select month(getdate())
select day(getdate())

--문자 , 숫자, 날짜함수 기본적인건 사용해야한다 ( 특히 숫자 날짜 ***)

--형변환 함수 매우매우 중요스 ( today point)
select convert(int,'100') + 100
select convert(int,'100A') + 100 --varchar 값 '100A'을(를) 데이터 형식 int(으)로 변환하지 못했습니다.

--오라클 select * from dual;
select convert(varchar(20),sal) + '급여입니다' 
from emp

select ename +' 의 사번은' + convert(varchar(20),empno) + '입니다' as 'fullname'
from emp

--집계함수
--sum() avg() max() min() count()

select sum(sal) from emp
select avg(sal) from emp
select max(sal) from emp
select min(sal) from emp
select count(empno) from emp

/*
1. 집계 함수는 null 값을 무시한다 (단, count(*) 제외)
2. select 절에 집계함수 이외에 다른 컬럼이 오면 반드시 그 컬럼은 group by 절에 명시되어야한다.
*/

select comm from emp --14개
select count(comm) from emp -- 6개 왜냐 null은 제외해야해
select comm from emp where comm is not null

--comm의 평균
select avg(comm) from emp --721 우리 회사는 받는 사원수를 기준..집계함수는 null 무시
select (300 + 200 + 30 + 300 + 3500 + 0) /6 --721 회사는 사원수를 기준
select (300 + 200 + 30 + 300 + 3500 + 0) /14 --309 회사는 받는사원수를 기준

--우리는 사원수를 기준으로 할거야..
select avg(isnull(comm,0)) from emp --309 -- ****TODAY POINT****

--집계함수의 결과는 1건 
select avg(sal), sum(sal), max(sal), min(sal), count(sal) from emp

select deptno, avg(sal), sum(sal), max(sal), min(sal), count(sal) from emp 
group by deptno --select 절에 집계함수 이외에 다른 컬럼이 오면 반드시 그 컬럼은 group by 절에 명시

select deptno, job, avg(sal)
from emp group by deptno, job
order by deptno asc --정렬 deptno를 asc / desc

--from 절의 조건절 where
-- groupt by 조건절은 having 

-- << 단일 테이블 모든 구문) >>
/*
select   5
from     1
where    2  
group by 3
having   4
order by 6 성능상 젤 안조음 
*/

--직종별 평균 월급을 구하되 컬럼에 가명칭은 평균, 평균월급이 높은 순으로 정렬하슈
select job ,avg(sal) as '평균' from emp group by job order by 평균 desc 
--순서상 orderby 가 제일 나중이니까 쓸수있다 이말씀~

--mssql top n 쿼리
--사원테이블에서 월급을 가장 마니받는 사원 5명의 이름과 급여를 출력해라
select top 5 ename , sal from emp order by sal desc 


select top 2 with ties ename , sal from emp order by sal desc -- 동률처리하기

select top 50 percent ename, sal from emp order by sal desc

--직업별 총 월급을 구하고 총 월급이 5000달러 이상인 모든 사원 데이터를 출력해라

select job, sum(sal) from emp where sum(sal)>5000 group by job  

select sum(sal) as'sumsal' from emp where deptno != 10 group by job having sum(sal)>5000 order by sumsal desc

--부서별 월급의 합을 구하고 그 총합이 10000 달러 이상인 사원 데이터를 출력하세요
select deptno, sum(sal) as 'subsal' from emp group by deptno having sum(sal) >= 10000 

--부서별 총월급을 구호되 30번 부서를 제외하고 
-- 그 총 월급이 8000달러 이상인 부서만 나오게하고
--총월급이 높은 순으로 출력하시오

select deptno, sum(sal) as '총월급' 
from emp
where deptno != 30 
group by deptno 
having sum(sal) >= 8000 order by 총월급 desc 


--부서별 평균 월급을 구하되 커미션이 책정된 사원만 가져오고
-- 평균월급이 2000달러 이상인 부서만 나오게 하고
--평균 월급이 높은 순으로 출력하시옹

select deptno, avg(sal) as '평균월급' from emp where comm is not null 
group by deptno having avg(sal) >= 2000 order by 평균월급 desc

--QUESTION
--1. 사원 테이블에서 사원이름을 첫글자는 대문자로, 나머지는 소문자로 출력하라
select upper(left(ename,1)) + lower(substring(ename,2,8)) from emp 

--2. 사원테이블에서 사원이름을 뽑고 또 이름의 두번째 글자부터 네번째 글자까지
-- 출력하라.
select substring(ename, 2,len(ename)) from emp

--3. 사원테이블의 사원 이름의 철자 개수를 출력하라.
select len(ename) from emp 

--4. 사원테이블에서 사원 이름의 앞 글자 하나와 마지막 글자 하나만 출력하되 
-- 모두 소문자로 각각 출력하라. -- 모르겠음
select LOWER(LEFT(ENAME,1)), LOWER(RIGHT(ENAME,1)) from emp


--5. 3456.78의 소수점 첫번째 자리에서 반올림하라.
select round(3456.78, 1)

--6. 3의 4제곱을 구하고, 64의 제곱근을 구하라.
SELECT POWER(3,4), SQRT(64)
-->: 제곱근은 소수점 이하로 나타날 수 있기 때문에 float형으로 출력된다.


--7. 오늘날짜와 오늘날짜에서 10일을 더한 날짜를 출력하라.
select dateadd(dd,10,2022-03-22)

--8. 국제 표준으로 현재 날짜를 출력하라.
SELECT CONVERT(VARCHAR(20), GETDATE(), 112)

--9. 사원테이블에서 사원이름과 사원들의 오늘 날짜까지의 근무일수를 구하라.
select ename, (datediff(dd,hiredate,getdate())% 365) % 30 as '근무일수' from emp


--10. 위 문제에서 근무일수를 00년 00개월 00일 근무하였는지
--확인할 수 있도록 변환하라.(단, 한 달을 30일로 계산하라)
-- 예)
--  | ENAME	| 근무일수		|
--  | KING		| 00년 00개월 00일	| -- 모르겠음

select ename, 
convert (varchar(20), datediff(dd,hiredate, getdate())/365) +'년'+
convert(varchar(20), datediff(dd,hiredate,getdate())%365/30)+'월'+
convert(varchar(20), datediff(dd,hiredate, getdate())%365%30) +'일' from emp


--1. 사원테이블에서 부서별 최대 월급을 출력하라.
select max(sal) as'최대월급', deptno from emp group by deptno

--2. 사원테이블에서 직위별 최소 월급을 구하되 직위가 
-- CLERK인 것만 출력하라.
select min(sal) from emp group by job having job = 'CLERK'

--3. 커미션이 책정된 사원은 모두 몇 명인가?
select count(comm) from emp where comm is not null

--4. 직위가 'SALESMAN'이고 월급이 1000이상인 사원의
-- 이름과 월급을 출력하라.
select ename, sal from emp where job = 'SALESMAN' AND sal>=1000

--5. 부서별 평균월급을 출력하되, 평균월급이 2000보다
-- 큰 부서의 부서번호와 평균월급을 출력하라.
select avg(sal), deptno from emp group by deptno 
having avg(sal) > 2000 

--6. 사원테이블에서 커미션을 가장 많이 받는 사원 2명을
-- 출력하되 랭킹이 중복될 경우 동률처리를 하여 출력하라.
select top 2 with ties comm from emp 

--7. 직위가 MANAGER인 사원을 뽑는데 월급이 높은 사람
-- 순으로 이름, 직위, 월급을 출력하라.
select ename, job, sal from emp where job = 'MANAGER' order by sal desc

--8. 각 직위별로 총월급을 출력하되 월급이 낮은 순으로
-- 출력하라.
select sum(sal),job from emp group by job order by sum(sal) asc

--9. 직위별 총월급을 출력하되, 직위가 'MANAGER'인
-- 사원들은 제외하라. 그리고 그 총월급이 5000보다 
-- 큰 직위와 총월급만 출력하라.
select job, sum(sal) from emp where job != 'MANAGER' 
group by job having sum(sal)>5000

--10. 직위별 최대월급을 출력하되, 직위가 'CLERK'인 
-- 사원들은 제외하라. 그리고 그 최대월급이 2000 이상인
-- 직위와 최대월급을 최대 월급이 높은 순으로 정렬하여 
-- 출력하라.

select max(sal),deptno from emp where job !='CLERK' 
group by deptno having max(sal) > 2000
order by max(sal) desc
