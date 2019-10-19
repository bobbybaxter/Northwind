-- What products are currently for sale (not discontinued)?

select *
from Products
where Discontinued = 0