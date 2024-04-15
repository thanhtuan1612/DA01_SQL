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
