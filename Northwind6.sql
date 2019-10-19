-- In what quarter in 1997 did we have the most revenue?

-- top(1) QuarterNum / sum(DiscountedTotal) as TotalRevenue
-- order by TotalRevenue desc

select top(1) year(OrderDate) as Year, QuarterNum, sum(DiscountedTotal) as TotalRevenue
from Orders o
	join (
		select OrderID, (datepart(quarter,OrderDate)) as QuarterNum
		from Orders
		) as sub on sub.OrderID = o.OrderID
	join (
		select
			OrderID, 
			ProductID,
			sum(UnitPrice * Quantity) as PreDiscountedTotal,
			cast(sum((UnitPrice * Discount)*Quantity) as money) as DiscountPrice,
			cast(sum(UnitPrice * Quantity) - (Quantity*sum(UnitPrice * Discount)) as money) as DiscountedTotal,
			Quantity,
			Discount
		from 
			[Order Details]
		group by 
			OrderID,
			ProductID,
			Quantity,
			Discount
		) as od on od.OrderID = o.OrderID
	join Products p on p.ProductID = od.ProductID
where year(OrderDate) = 1997
group by
	year(OrderDate),
	QuarterNum
order by TotalRevenue desc