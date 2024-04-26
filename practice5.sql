-- ex1
select a.continent,floor( avg(b.population))
from country as a
inner join city as b
on a.code=b.countrycode
group by  a.continent
-- ex2
select 
round(1.0*sum(case when t.signup_action = 'Confirmed' then 1 else 0 end)::DECIMAL
/count (e.user_id),2) as comfirmcomfirm_rate
from emails as e 
join texts as t  on e.email_id = t.email_id
-- ex3
SELECT 
b.age_bucket, 
ROUND(100.0 * 
SUM(a.time_spent) FILTER (WHERE a.activity_type = 'send')/
SUM(a.time_spent),2) AS send_perc, 
ROUND(100.0 * 
SUM(a.time_spent) FILTER (WHERE a.activity_type = 'open')/
SUM(a.time_spent),2) AS open_perc
FROM activities as a 
INNER JOIN age_breakdown AS b  
ON a.user_id = b.user_id 
WHERE a.activity_type IN ('send', 'open') 
GROUP BY b.age_bucket;
-- ex4
WITH supercloud AS (SELECT 
a.customer_id, 
COUNT(DISTINCT b.product_category) as unique_count
FROM customer_contracts AS a  
LEFT JOIN products as b   
ON a.product_id = b.product_id
GROUP BY a.customer_id)
SELECT customer_id
FROM supercloud
WHERE unique_count = (SELECT COUNT(DISTINCT product_category) 
FROM products)
ORDER BY customer_id;
-- ex5
select a.reports_to as employee_id,
b.name,
count(a.reports_to) as reports_count,
round(avg(a.age),0) as average_age
from employees as a
join employees as b
on a.reports_to=b.employee_id
group by a.reports_to
order by a.reports_to
-- ex6 
select a.product_name, sum(unit) as unit
from Products a
left join Orders b
on a.product_id = b.product_id
where b.order_date between '2020-02-01' and '2020-02-29'
group by a.product_id
having sum(unit) >= 100
-- ex7
SELECT page_id
FROM pages
EXCEPT
SELECT page_id
FROM page_likes;
