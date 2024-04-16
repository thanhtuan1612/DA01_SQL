-- ex1
SELECT DISTINCT CITY FROM STATION WHERE MOD(ID,2)=0 ORDER BY CITY
-- ex2
select (count(CITY)- count(distinct CITY)) from STATION; 
-- ex3
select ceil(avg(salary)-avg(replace(salary,0,''))) from EMPLOYEES;
-- ex4
SELECT ROUND(1.0*SUM(ITEM_COUNT*ORDER_OCCURRENCES)/SUM(ORDER_OCCURRENCES),1) AS MEAN
FROM ITEMS_PER_ORDER;
-- ex5
SELECT candidate_id FROM candidates
WHERE skill in ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(candidate_id)=3
ORDER BY candidate_id;
-- ex6
SELECT user_id, count(post_date), 
max (post_date)-min(post_date) 
FROM posts
where extract(year from post_date)=2021
group by user_id
having count(post_date) >1
-- ex7
SELECT card_name,
max(issued_amount)-min(issued_amount)
FROM monthly_cards_issued
group by card_name
order by (max(issued_amount)-min(issued_amount)) DESC
-- ex8
select manufacturer, count(distinct product_id) as drug_count, sum(cogs - total_sales) as total_loss
from pharmacy_sales 
where cogs > total_sales
group by manufacturer
order by total_loss desc; 
-- ex9
select id,movie,description,rating 
from Cinema 
where id%2!=0 and description!='boring' 
order by rating desc;
-- ex10
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id
ORDER BY NULL;
-- ex11
SELECT user_id, COUNT(1) AS followers_count
FROM Followers
GROUP BY 1
ORDER BY 1;
-- ex12
SELECT class
FROM Courses
GROUP BY 1
HAVING COUNT(1) >= 5;
