select * from customers
select * from Employees
select * from orders

select 

--OrderID가 10300와 10400 사이면서, EmployeeID가  1인 직원의 FirstName과 
--그 직원이 관리하는 고객의CustomerID,  City, Country를 출력하시오. 
--그리고  출력된 결과물을 OrderID가 낮은순으로 정렬해라

select c.customerID, c.city, c.country, e.firstname
from orders o join customers c  on c.CustomerID = o.customerid 
join Employees e on e.EmployeeID = o.EmployeeID
where orderid between 10300 and 10400
order by orderid desc
