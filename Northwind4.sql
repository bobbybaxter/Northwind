-- I need a list of sales figures broken down by category name.
-- Include the total amount sold over all time
-- And the total number of items sold.

select 
	c.CategoryName, 
	sum(sub.DiscountedTotal) as TotalRevenue, 
	sum(sub.Quantity) as TotalItemsSold
--select *
from Categories c
	join Products p on p.CategoryID = c.CategoryID
	join [Order Details] o on o.ProductID = p.ProductID
	join (
		select
			OrderID, 
			sum(UnitPrice * Quantity) as PreDiscountedTotal,
			cast(sum((UnitPrice * Discount)*Quantity) as money) as DiscountPrice,
			cast(sum(UnitPrice * Quantity) - (Quantity*sum(UnitPrice * Discount)) as money) as DiscountedTotal,
			Quantity,
			Discount
		from 
			[Order Details]
		group by 
			OrderID,
			Quantity,
			Discount
		) as sub on sub.OrderID = o.OrderID
group by c.CategoryName