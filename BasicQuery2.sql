use Northwind
--무역회사
select * from employees

select * from orders

-- 사원의 ID와 사원의 이름(LASTNAME) 
--그리고 그 사원을 관리하는 관리자의 ID와 관리자의 이름을 출력하라
-- 단 컬럼이름은 각각 사원ID, 사원이름, 관리자ID, 관리자이름이라고 함

select e.employeeID , e.lastname, m.lastname , m.employeeID
from Employees e left outer  join Employees m
on e.reportsto = m.employeeID

use pubs

select * from titles
select * from authors
select * from titleauthor

--3개의 테이블에서 작가 아이디, 책 id, 작가이름(lastname), 
--책이름, 가격정보를 출력하시오

select a.au_id, t.title_id,  a.au_lname, t.title, t.price 
from titleauthor ta inner join authors a on ta.au_id = a.au_id
inner join titles t on ta.title_id = t.title_id

select * from titleauthor ta join authors a on ta.au_id = a.au_id

