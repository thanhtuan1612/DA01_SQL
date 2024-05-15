-- ex1
select
FORMAT_DATE('%m-%Y', created_at) as month_year, 
count (order_id),
sum (num_of_item)
from bigquery-public-data.thelook_ecommerce.orders
group by month_year
-- ex 2  
select 
FORMAT_DATE('%m-%Y', created_at) as month_year,
avg(sale_price) as average_order_value,
count(distinct user_id) as distinct_users
from bigquery-public-data.thelook_ecommerce.order_items
group by month_year
-- ex3
with a as (select first_name, last_name, gender, age
from bigquery-public-data.thelook_ecommerce.users
where gender='M') 
with b as (select first_name, last_name, gender, age
from bigquery-public-data.thelook_ecommerce.users
where gender='F') 
select first_name, last_name, gender, age from  (select first_name, last_name, gender, age
from a 
where age=(select min(age) from a ) or age=(select max(age) from a ))
union
select first_name, last_name, gender, age from (select first_name, last_name, gender, age
from b 
where age=(select min(age) from b ) or age=(select max(age) from b ))
-- ex4
with a as (
select  product_id, created_at, sale_price,
FORMAT_DATE('%m-%Y', created_at) as month_year,
from bigquery-public-data.thelook_ecommerce.order_items)
select * from (
select product_id, created_at, sale_price,month_year,
dense_rank() over (partition by month_year order by sale_price) as stt
from a)
where stt <=5
-- ex5
with a as (select product_id, FORMAT_DATE('%Y'-'%m'-'%d', created_at) as dates, product_categor, sale_price
from 
(select a.product_id, b.product_category, a.created_at,t, a.sale_price
from bigquery-public-data.thelook_ecommerce.order_items as a
join bigquery-public-data.thelook_ecommerce.inventory_items as b
on a.product_id = b.product_id))
select product_category,dates,
sum (sale_price) over (partition by product_category,dates )
from a

