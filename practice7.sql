-- ex1 
with a as (SELECT
extract (year from transaction_date) as year,
product_id, spend as current_spend, 
LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id, extract(YEAR FROM transaction_date)) AS previousyear_spend 
FROM user_transactions)
Select year, product_id, current_spend, previousyear_spend,
round(100*(current_spend-previousyear_spend)/previousyear_spend) as rate 
from a 
-- ex2 
