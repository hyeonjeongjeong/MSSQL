use Northwind
--����ȸ��
select * from employees

select * from orders

-- ����� ID�� ����� �̸�(LASTNAME) 
--�׸��� �� ����� �����ϴ� �������� ID�� �������� �̸��� ����϶�
-- �� �÷��̸��� ���� ���ID, ����̸�, ������ID, �������̸��̶�� ��

select e.employeeID , e.lastname, m.lastname , m.employeeID
from Employees e left outer  join Employees m
on e.reportsto = m.employeeID

use pubs

select * from titles
select * from authors
select * from titleauthor

--3���� ���̺��� �۰� ���̵�, å id, �۰��̸�(lastname), 
--å�̸�, ���������� ����Ͻÿ�

select a.au_id, t.title_id,  a.au_lname, t.title, t.price 
from titleauthor ta inner join authors a on ta.au_id = a.au_id
inner join titles t on ta.title_id = t.title_id

select * from titleauthor ta join authors a on ta.au_id = a.au_id

