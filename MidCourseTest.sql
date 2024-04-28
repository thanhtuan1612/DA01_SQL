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
Select  c.name,
count(a.title)
from film as a
join film_category as b on a.film_id=b.film_id
join category as c on b.category_id=c.category_id
group by  c.name
-- ex5
select  b.first_name, b.last_name, count(a.film_id)
from film_actor as a
join actor as b on a.actor_id=b.actor_id
group by b.first_name, b.last_name
order by count(a.film_id) desc
-- ex6
select a.address, b.customer_id
from address as a
left join customer as b on a.address_id=b.address_id
where b.customer_id is null
-- ex7
select a.city,
sum(d.amount)
from city as a
join address as b on a.city_id=b.city_id
join customer as c on b.address_id=c.address_id
join payment as d on c.customer_id=d.customer_id
group by a.city
order by sum(d.amount) desc
-- ex8
select a.city, e.country,
sum(d.amount)
from city as a
join address as b on a.city_id=b.city_id
join customer as c on b.address_id=c.address_id
join payment as d on c.customer_id=d.customer_id
join country as e on a.country_id=e.country_id
group by a.city, e.country
order by sum(d.amount) 
