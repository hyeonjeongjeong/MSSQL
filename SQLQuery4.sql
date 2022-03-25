Create table Grade (
	empno int constraint pk_Grade_empno primary key,
	ename varchar(10) not null,
	korean int constraint ck_Grade_korean check(korean in (0)),
	english int constraint ck_Grade_english check(english in (0)),
	mathmatics int constraint mathmatics check(mathmatics in(0)),
	score int as (korean + english + mathmatics),
	average int as(korean + english + mathmatics)/3
	majorcode int not null constraint uk_Major_majorcode unique
)

alter table Grade
add constraint fk_Grade_majorcode foreign key(majorcode) references major(majorcode)

sp_helpconstraint Major 
sp_helpconstraint grade

Create table Major(
	majorcode int constraint pk_Major_Majorcode primary key,
	majorname varchar(20) not null
)

insert into grade(empno, ename,korean, english, mathmatics)
values(1,'정재현',100,100,100)
insert into grade(empno, ename,korean, english,mathmatics)
values(1,'김재현',50,10,70)
insert into grade(empno, ename,korean, english, mathmatics)
values(1,'이재현',50,60,70)
insert into grade(empno, ename,korean, english,mathmatics)
values(1,'박재현',80,100,100)
insert into grade(empno, ename,korean, english, mathmatics)
values(1,'최재현',90,100,90)
insert into grade(empno, ename,korean, english, mathmatics)
values(1,'제갈재현',85,85,85)


insert into major(majorcode, majorname)
values(10,'컴퓨터공학과')
insert into major(majorcode, majorname)
values(20,'떡볶이공학과')
insert into major(majorcode, majorname)
values(30,'정보통신공학과')
insert into major(majorcode, majorname)
values(40,'안알려줌과')
insert into major(majorcode, majorname)
values(50,'집에가는과')

select* from major



데이터베이스 pubs 문제

use Northwind

select * from orders
select * from customers
select * from [Order Details]
select * from Products
select * from Employees
select * from EmployeeTerritories
select * from Territories

 --shipCity가 'LONDON'인 주문id orderid, 주문날짜 orderdate ,제품id productid  제품가격 unitprice , 주문량 quantity 을 출력하세요, 제품번호 낮은 순으로 정렬하세요
 select o.orderid, o.orderdate, d.ProductID, d.UnitPrice, d.Quantity  from orders o join [Order Details] d on o.orderid = d.orderid 
order by d.productid asc
​

-- 사번 employleeID, lastname, 관리자의 사번 reportsto, 관리자의 lastname 출력하기 (lastname 오름차순)
select e.EmployeeID, e.lastname, s.EmployeeID, s.lastname from Employees e join Employees s on e.EmployeeID = s.ReportsTo order by e.lastname asc
​

 --Customer 테이블에서 CustomerID가 다르고 도시가 같은 Customer ID A와 B를 도시 기준으로 정렬하여 출력하세요

select customerID, city from customers
where city in (select city from Customers group by city) 

select c.customerID,t.city from customers c join Customers t on c.city = t.city
where c.city = t.City and c.CustomerID != t.CustomerID order by c.city





select * from customers
where city in (select city from Customers group by city)

