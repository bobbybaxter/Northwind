-- What are our 10 most expensive products?

select top(10) ProductID, ProductName, UnitPrice
from Products
order by UnitPrice desc