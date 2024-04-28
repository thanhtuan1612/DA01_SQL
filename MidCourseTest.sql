-- ex1
select min(distinct replacement_cost)  from film
-- ex2
select 
case
when replacement_cost between 9.99 and 19.99 then 'low'
when replacement_cost between 20.00 and 24.99 then 'medium'
when  replacement_cost between 25.00 and 29.99 then 'high'
end as category,
count(*) as so_luong
from film
group by category
-- ex3
  Select a.title, a.length , c.name
from film as a
join film_category as b on a.film_id=b.film_id
join category as c on b.category_id=c.category_id
where c.name='Drama' or c.name='Sports'
order by a.length desc
-- ex4
