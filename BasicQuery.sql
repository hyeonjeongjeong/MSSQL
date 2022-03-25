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
select round(3456.78, 0)

--6. 3의 4제곱을 구하고, 64의 제곱근을 구하라.
SELECT POWER(3,4), SQRT(64)
-->: 제곱근은 소수점 이하로 나타날 수 있기 때문에 float형으로 출력된다.


--7. 오늘날짜와 오늘날짜에서 10일을 더한 날짜를 출력하라.
select dateadd(dd,10,2022-03-22)

SELECT GETDATE(), GETDATE()+10

--8. 국제 표준으로 현재 날짜를 출력하라.
SELECT CONVERT(VARCHAR(20), GETDATE(), 112)

--9. 사원테이블에서 사원이름과 사원들의 오늘 날짜까지의 근무일수를 구하라.
select ename, (datediff(dd,hiredate,getdate()) from emp


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
select min(sal),job from emp group by job having job = 'CLERK'

--3. 커미션이 책정된 사원은 모두 몇 명인가?
select count(comm) from emp where comm is not null --count 함순,ㄴ null 무시하자나

--4. 직위가 'SALESMAN'이고 월급이 1000이상인 사원의
-- 이름과 월급을 출력하라.
select ename, sal from emp where job = 'SALESMAN' AND sal>=1000

--5. 부서별 평균월급을 출력하되, 평균월급이 2000보다
-- 큰 부서의 부서번호와 평균월급을 출력하라.
select avg(sal), deptno from emp group by deptno 
having avg(sal) > 2000 

--6. 사원테이블에서 커미션을 가장 많이 받는 사원 2명을
-- 출력하되 랭킹이 중복될 경우 동률처리를 하여 출력하라.
select top 2 with ties comm from emp order by comm desc

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

select max(sal) as'maxsal' ,deptno from emp where job !='CLERK' 
group by deptno having max(sal) >= 2000
order by maxsal desc

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
