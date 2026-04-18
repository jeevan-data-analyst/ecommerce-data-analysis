create database product_analysis;
use product_analysis;


# All Products

SELECT COUNT(*) as total_products FROM redpasta_new;

# Mapping Distribution

select `Map Status`,
count(*) as Total_Products from redpasta_new
group by `Map Status`;

# % map status and No Map status
 select `Map Status`,
 count(*) as Total,
 round(count(*)*100/(select count(*) from redpasta_new),2) as percentage
 from redpasta_new
 group by `Map Status`;
 
 # Conditional Counting (count only no map)
 select 
 sum( case when `Map status`= 'No Map' Then 1 else 0 end) as Total_nomap
 from redpasta_new;
 
# No map by brand

select
Brand,
Count(*) as no_map_count
from redpasta_new
where `Map Status`='No Map'
group by Brand
order by no_map_count desc Limit 10;

# % No map by Unit size

select
`Size Unit`,
count(*) as total_products,
sum(case when `Map Status`= 'No Map' then 1 else 0 end) as no_map_count,
round(
      sum(case when `Map Status`= 'No Map' then 1 else 0 end)*100/count(*),2)
      as no_map_percentage
from redpasta_new
group by `Size Unit`
order by no_map_percentage desc;

# % Mapping by brand
select
Brand,
count(*) as total_product,
sum(case when `Map Status`='Mapped' then 1 else 0 end) as Total_mapped,
round(
      sum(case when `Map Status`='Mapped' then 1 else 0 end)*100/count(*),2)
      as mapped_percentage
from redpasta_new
group by brand
order by mapped_percentage desc;  


###

select distinct `Size Unit`
from redpasta_new;

##
select Brand,
count(*) as total_products,
sum(Case when `Map Status`='No Map' then 1 else 0 end) as no_map
from redpasta_new
group by Brand;

##

select Brand,
count(*) as total
from  redpasta_new
group by Brand
having count(*)>10;

## Sub query1

select Brand, 
count(*) as total from redpasta_new
where Brand in(
select brand from redpasta_new
group by Brand
Having count(*)>10)
group by Brand;
## Sub query2
select * from redpasta_new
where Brand in(
select Brand from redpasta_new
group by Brand 
Having count(*)>10);

## Show brands with more than 10 products AND count how many are ‘No Map`

select Brand,
count(*) as total,
sum(case when `Map Status`='No map' then 1 else 0 end) as Total_Nomap
from redpasta_new
group by Brand
having count(*)>10;

## % of No Map per Brand where total products > 10

select Brand,
count(*) as total,
round(sum(case when`Map Status`='No Map'then 1 else 0 end)*100.0/count(*),2)as no_map_percentage
from redpasta_new
group by Brand
having count(*)>10
order by no_map_percentage desc;

## Show top 5 brands where:No Map % is highest,AND total products >10 AND Missing Brand Flag = 0”

select Brand,
round(sum(case when `Map Status`='No Map' then 1 else 0 end)*100.0/count(*),2) as map_percentage
from redpasta_new where `Missing brand Flag`=0  
group by Brand
having count(*)>10
order by map_percentage desc 
limit 5;

## No Map % > 50%, AND total products > 10, AND Missing Brand Flag = 0”

select Brand,
count(*) as total_product,
round(sum(case when `Map Status`='No Map' then 1 else 0 end)*100.0/count(*),2) as nomap_percentage
from redpasta_new
where `Missing brand Flag`=0
group by Brand
having nomap_percentage>50
order by nomap_percentage Asc;





