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
