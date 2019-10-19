-- What is the cost after discount for each order?
-- Discounts should be applied as a percentage off.

select OrderId, sum(DiscountedTotal)
from
	(
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
		Discount) as sub
group by OrderId