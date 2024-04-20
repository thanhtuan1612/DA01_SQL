-- ex1
select name
from students
where marks > 75
order by right(name,3), id
-- ex 2
select user_id,
concat(upper(left(name,1)), lower(right(name,length(name)-1))) as name
from users
order by user_id
-- ex3
SELECT  manufacturer,
'$' || round(Sum(total_sales)/1000000,0) || ' ' || 'million'
FROM pharmacy_sales
group by manufacturer
order by Sum(total_sales) desc
-- ex4
SELECT 
extract(month from submit_date) as mth,
product_id,
round(AVG(stars),2)
FROM reviews
group by extract(month from submit_date), product_id
order by extract(month from submit_date), product_id
-- ex5 
SELECT sender_id, COUNT(message_id) as message_count 
FROM messages
WHERE EXTRACT(year FROM sent_date) = '2022' AND EXTRACT(month FROM sent_date) = '08'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2 ;
-- ex6
select tweet_id
from Tweets
where length(content) > 15;
-- ex7 
select activity_date as day, count(distinct(user_id)) as active_users from Activity
where activity_date between "2019-06-28" and "2019-07-27"
group by activity_date;
-- ex8 
select count(employee_id) as number_emplyee
from employee
where extract(month from joining_day) between 1 and 7
and extract(year from joining_day)= 2022
-- ex9 
select position('a' in first_name) as position
from worker
where first_name= 'Amitah'
-- ex10
select 
substring(title, lenght(winery)+2,4)
from winemag_p2
where country='Macedonia'
