select * from customers
select * from Employees
select * from orders

select 

--OrderID�� 10300�� 10400 ���̸鼭, EmployeeID��  1�� ������ FirstName�� 
--�� ������ �����ϴ� ����CustomerID,  City, Country�� ����Ͻÿ�. 
--�׸���  ��µ� ������� OrderID�� ���������� �����ض�

select c.customerID, c.city, c.country, e.firstname
from orders o join customers c  on c.CustomerID = o.customerid 
join Employees e on e.EmployeeID = o.EmployeeID
where orderid between 10300 and 10400
order by orderid desc
