-- ex1
Select NAME from city
where POPULATION>120000 AND COUNTRYCODE= 'USA'
-- ex2
Select * from city
where countrycode='JPN'
-- ex3
Select city, state from station
-- ex4
Select distinct city from station
where city like 'a%' or city like 'e%'  or  city like 'i%'  or city like 'o%'  or city like 'u%'  
-- ex5
Select distinct city from station
where city like '%a' or city like '%e'  or  city like '%i'  or city like '%o'  or city like '%u'  
-- ex6
Select distinct city from station
where city not like 'a%' and city not like 'e%'  and  city not like 'i%'  and city not like 'o%'  and city not like 'u%'
-- ex7
select name from employee
order by name
-- ex8
Select name from Employee
where salary >2000 and months <10
-- ex9 
select product_id from products
where low_fats='Y'and recyclable='Y'
--ex10
select name from customer
where referee_id<>2 or referee_id is null
-- ex11
select name, area, population from world
where area>= 3000000 or population >= 25000000
-- ex12
select distinct author_id as id from views
where author_id=viewer_id
order by author_id
-- ex13
Select part, assembly_step  from parts_assembly
where finish_date is NULL
-- ex14
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary>=70000
-- ex15
select * from uber_advertising
where money_spent >100000 and year=2019
