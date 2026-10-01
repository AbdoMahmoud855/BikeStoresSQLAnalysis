---Write a query to rank each customer based on the total value of their orders, with 1 being the highest order value. 
select o.customer_id,sum(oi.quantity * oi.list_price) as totalprice,
rank() over( order by sum(oi.quantity * oi.list_price) desc ) as rank
from sales.orders as o
inner join sales.order_items as oi 
on o.order_id = oi.order_id
group by o.customer_id
-------------------------------------------.
--Write a query to find the second highest unit price of products in each category.
with rank_product as (
select c.category_name ,p.product_name,p.list_price,
Dense_Rank () over (partition by c.category_id order by p.list_price desc ) as Rank
from production.products as p
inner join production.categories as c
on p.category_id= c.category_id )
select *
from rank_product as r
where rank = 2
--------------------------------------------------
--Write a query to calculate the total sales amount each employee made and include a running total (cumulative sum) of these sales. 
with total_Sales_employee as(
select o.staff_id,sum(oi.quantity * oi.list_price)  as totalpriceperemp
from sales.orders as o
inner join sales.order_items as oi 
on o.order_id = oi.order_id
group by o.staff_id
)
select  staff_id,totalpriceperemp,sum(totalpriceperemp) over(order by totalpriceperemp desc  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as totalprice
from total_Sales_employee
------------------------------------------------
--Write a query to find the employees whose average order value is higher than the average order value of all employees. 
select o.staff_id,AVG(oi.quantity * oi.list_price)  as Avg, ( 
select 
AVG(oi.quantity * oi.list_price)  as Avg_total 
from sales.order_items as oi )
from sales.orders as o 
inner join sales.order_items as oi  
on o.order_id = oi.order_id 
group by o.staff_id   
having (select 
AVG(oi.quantity * oi.list_price)  as Avg_total 
from sales.order_items as oi ) < (AVG(oi.quantity * oi.list_price) ) 
----------------------------------
--Write a query to find the employee who processed the most orders each year.
with RankEmployee as(

select o.staff_id, COUNT(o.staff_id) as totalOrder,YEAR(o.order_date) as year ,
Row_Number() over( partition by year( o.order_date ) order by COUNT(o.staff_id) desc ) as rank
from sales.orders as o 
group by o.staff_id ,  YEAR(o.order_date)
)
select * 
from RankEmployee as r
where rank=1

--Write a query to find the top 3 most expensive products in each category.
with mostProduct as (select c.category_name , p.product_name , p.list_price , Dense_rank() over (partition by c.category_name order by p.list_price desc ) as rank
from production.products as p 
inner join production.categories as c
on p.category_id = c.category_id)
select *
from mostProduct 
where rank <= 3
order by list_price desc

--
WITH product_RANK AS (
SELECT 
		C.category_name,
		P.product_name,
		P.list_price,
		ROW_NUMBER() OVER (PARTITION BY C.category_id ORDER BY P.list_price DESC ) AS RANK
FROM production.products AS P
INNER JOIN production.categories AS C
	ON P.category_id=C.category_id

)
SELECT*
FROM product_RANK
WHERE RANK<=3











