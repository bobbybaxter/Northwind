-- What is the undiscounted subtotal for each Order (identified by OrderID)

select
	OrderID, 
	sum(UnitPrice * Quantity) as Total
from 
	[Order Details]
group by 
	OrderID