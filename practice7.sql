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
WITH card_launch AS (SELECT card_name,
issued_amount,
MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
MIN(MAKE_DATE(issue_year, issue_month, 1)) OVER (PARTITION BY card_name) AS launch_date
FROM monthly_cards_issued)
SELECT 
card_name, 
issued_amount
FROM card_launch
WHERE issue_date = launch_date
ORDER BY issued_amount DESC;
-- ex3
with a as (SELECT 
user_id, 
spend, 
transaction_date, 
ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS row_num
FROM transactions)
SELECT 
user_id, 
spend, 
transaction_date
FROM a AS trans_num 
WHERE row_num = 3;
-- ex4 
WITH a AS ( SELECT transaction_date, user_id, product_id, 
RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) AS transaction_rank 
FROM user_transactions) 
SELECT 
transaction_date, 
user_id,
COUNT(product_id) AS purchase_count
FROM a
WHERE transaction_rank = 1 
GROUP BY transaction_date, user_id
ORDER BY transaction_date;
-- ex5
SELECT    
user_id,    
tweet_date,   
ROUND(AVG(tweet_count) OVER (PARTITION BY user_id ORDER BY tweet_date     
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_avg_3d
FROM tweets;
-- ex6
WITH payments AS (SELECT merchant_id, 
EXTRACT(EPOCH FROM transaction_timestamp - 
LAG(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount 
ORDER BY transaction_timestamp))/60 AS minute_difference 
FROM transactions) 
SELECT COUNT(merchant_id) AS payment_count
FROM payments 
WHERE minute_difference <= 10;
-- ex7 
WITH a AS (SELECT category, product, 
SUM(spend) AS total_spend,
RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking 
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product )
SELECT 
category, 
product, 
total_spend 
FROM a
WHERE ranking <= 2 
ORDER BY category, ranking;
-- ex8
WITH a as (SELECT artists.artist_name,
DENSE_RANK() OVER (ORDER BY COUNT(songs.song_id) DESC) AS artist_rank
FROM artists
INNER JOIN songs
ON artists.artist_id = songs.artist_id
INNER JOIN global_song_rank AS ranking
ON songs.song_id = ranking.song_id
WHERE ranking.rank <= 10
gROUP BY artists.artist_name)
SELECT artist_name, artist_rank
FROM a
WHERE artist_rank <= 5;
