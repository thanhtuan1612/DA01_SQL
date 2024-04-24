-- ex1
SELECT 
sum(case
when device_type = 'laptop' then 1 else 0
END) as laptop_views,
sum(CASE
when device_type in ('tablet','phone' ) then 1 else 0
END) as mobile_views
FROM viewership;
-- ex2
select x,y,z,
case
when x+y>z and x+z>y and y+z>x then 'Yes' else 'No'
END as triangle
from triangle
-- ex3
  WITH uncategorised_calls AS 
( SELECT COUNT(case_id) AS uncategorised_calls
  FROM callers
  WHERE call_category = 'n/a' OR call_category IS NULL)
  
SELECT ROUND(100.0 * uncategorised_calls::NUMERIC / (SELECT COUNT(*)
  FROM callers), 1) AS call_percentage
FROM uncategorised_calls;
-- ex4
select name from customer
where referee_id<>2 or referee_id is null
-- ex5
select survived, 
       sum(case when pclass = 1 then 1 else 0 end) as first_class,
       sum(case when pclass = 2 then 1 else 0 end) as second_class,
       sum(case when pclass = 3 then 1 else 0 end) as third_class
from titanic 
group by survived;  
