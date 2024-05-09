-- ex1 
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN priceeach TYPE numeric USING (trim(sales)::float)
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN sales TYPE float USING (trim(sales)::float)
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderlinenumber TYPE numeric USING (trim(orderlinenumber)::numeric)
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ordernumber TYPE numeric USING (trim(ordernumber)::numeric)
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN quantityordered TYPE numeric USING (trim(quantityordered)::numeric)
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderdate TYPE TIMESTAMP USING (trim(orderdate)::TIMESTAMP)
-- ex2 
Select * from sales_dataset_rfm_prj
where ordernumber is null or ordernumber=''
or quantityordered is null or quantityordered ='' 
or priceeach is null or priceeach ='' 
or orderlinenumber is null or orderlinenumber ='' 
or sales is null or sales =''
or orderdate is null or orderdate =''
-- ex3
alter table sales_dataset_rfm_prj
add column CONTACTFIRSTNAME varchar(50);
alter table sales_dataset_rfm_prj  
add column CONTACTLASTNAME varchar(50);
update sales_dataset_rfm_prj
set CONTACTFIRSTNAME = left(contactfullname, position('-' in contactfullname)-1);  
update sales_dataset_rfm_prj
set CONTACTLASTNAME = right (contactfullname, position('-' in contactfullname))
-- ex4
alter table sales_dataset_rfm_prj
add column QTR_ID varchar(50);
alter table sales_dataset_rfm_prj
add column MONTH_ID varchar(50);
alter table sales_dataset_rfm_prj
add column YEAR_ID varchar(50);
update sales_dataset_rfm_prj
set QTR_ID = extract (quarter from orderdate);
update sales_dataset_rfm_prj
set MONTH_ID = extract (month from orderdate);
update sales_dataset_rfm_prj
set YEAR_ID = extract (year from orderdate);
-- ex5
-- c1
with a as (select Q1-1.5*IQR as min_value, Q3+1.5*IQR as max_value from 
(select 
percentile_cont (0.25) within group (order by QUANTITYORDERED) as Q1
percentile_cont (0.75) within group (order by QUANTITYORDERED) as Q3
percentile_cont (0.75) within group (order by QUANTITYORDERED)-percentile_cont (0.25) within group (order by QUANTITYORDERED) as IQR
from sales_dataset_rfm_prj))
select * from sales_dataset_rfm_prj
where QUANTITYORDERED < (select min_value from a) or QUANTITYORDERED > (select max_value from a)
-- c2
with a as 
  ( select QUANTITYORDERED, (select avg(QUANTITYORDERED) from sales_dataset_rfm_prj) as avg) , (select stddev(QUANTITYORDERED) from sales_dataset_rfm_prj) as stddev) from sales_dataset_rfm_prj
select  (QUANTITYORDERED-avg)/stddev as z_score from a
where abs((QUANTITYORDERED-avg)/stddev) >3
-- ex6 
create table SALES_DATASET_RFM_PRJ_CLEAN
 as select * from sales_dataset_rfm_prj;


