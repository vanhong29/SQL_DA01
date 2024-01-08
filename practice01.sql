-- Ex1
SELECT name
FROM city
WHERE countrycode = 'USA' AND population > 120000

-- Ex 2
select * from city 
where countrycode = 'JPN'

-- Ex3
select city, state from station

-- Ex4
select distinct city from station
where city LIKE 'a%' OR city LIKE 'e%' OR city like 'i%' OR city like 'o%' or city like 'u%'

-- Ex5
select distinct city from station
where city LIKE '%a' OR city LIKE '%e' OR city like '%i' OR city like '%o' or city like '%u'

-- Ex6
select distinct city from station
where city not LIKE 'a%' AND city not LIKE 'e%' AND city not like 'i%' AND city not like 'o%' AND city not like 'u%'

-- Ex7
select name
from employee
order by name

-- Ex8
select name from employee
where salary > 2000 and months < 10

-- Ex9
select product_id
from products
where low_fats = 'Y' and recyclable='Y'

--Ex10
select name
from  customer
where referee_id <> 2 OR referee_id is null

-- Ex11
select name, population, area
from world
where population >= 25000000 OR area >= 3000000

-- Ex12
select distinct author_id as id
from views
where author_id = viewer_id
order by author_id 

-- Ex13
SELECT part, assembly_step FROM parts_assembly
where finish_date is NULL

-- Ex14
select * from lyft_drivers
where yearly_salary <= 30000 OR yearly_salary >= 70000


