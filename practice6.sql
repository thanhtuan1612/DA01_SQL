-- ex1
WITH job_count_cte AS (
SELECT 
company_id, 
title, 
description, 
COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description)
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count > 1;
-- ex2
WITH ranked_spending_cte AS (
SELECT 
category, 
product, 
SUM(spend) AS total_spend,
RANK() OVER (
PARTITION BY category 
ORDER BY SUM(spend) DESC) AS ranking 
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product )
SELECT 
  category, 
  product, 
  total_spend 
FROM ranked_spending_cte 
WHERE ranking <= 2 
ORDER BY category, ranking;
-- ex3
with a as (SELECT policy_holder_id, 
count(case_id) as sum_call
FROM callers 
group by policy_holder_id
having count(case_id) >=3)
select 
 count (policy_holder_id)
 from a  
 -- ex4
SELECT page_id
FROM pages
EXCEPT
SELECT page_id
FROM page_likes;
-- ex5
SELECT 
EXTRACT(MONTH FROM curr_month.event_date) AS mth, 
COUNT(DISTINCT curr_month.user_id) AS monthly_active_users 
FROM user_actions AS curr_month
WHERE EXISTS ( SELECT last_month.user_id 
FROM user_actions AS last_month
WHERE last_month.user_id = curr_month.user_id
AND EXTRACT(MONTH FROM last_month.event_date) =
EXTRACT(MONTH FROM curr_month.event_date - interval '1 month'))
AND EXTRACT(MONTH FROM curr_month.event_date) = 7
AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date);
-- ex6 
SELECT
Date_format(trans_date, '%Y-%m') AS month,
country AS country,
count(id) AS trans_count,
SUM(case WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(case WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM
transactions
GROUP BY
Date_format(trans_date, '%Y-%m') ,
country;
-- ex7
SELECT
product_id,
year AS first_year,
quantity,
price
FROM Sales
WHERE(product_id, year) IN (SELECT
product_id,
MIN(year) AS year
FROM Sales
 GROUP BY product_id);
-- ex8
select customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select count(distinct product_key) from Product)
-- ex9
select employee_id from Employees
where salary < 30000
and manager_id not in (select employee_id from Employees)
order by employee_id;
-- ex10
WITH job_count_cte AS (
SELECT 
company_id, 
title, 
description, 
COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description)
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count > 1;
-- ex11
WITH cte AS (SELECT mr.*, u.name, m.title
FROM MovieRating mr
LEFT JOIN Users u ON mr.user_id = u.user_id
LEFT JOIN Movies m ON mr.movie_id = m.movie_id)
(SELECT name AS results
FROM cte 
GROUP BY name
ORDER BY COUNT(*) DESC, name
LIMIT 1)
UNION ALL
(SELECT title
FROM cte
WHERE DATE_FORMAT(created_at, "%Y-%m") = "2020-02"
GROUP BY title
ORDER BY AVG(rating) DESC, title
LIMIT 1)
-- ex12
WITH a as (SELECT requester_id, accepter_id FROM RequestAccepted
UNION
SELECT accepter_id, requester_id FROM RequestAccepted)
SELECT requester_id as id, COUNT(accepter_id) as num
FROM a
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
