--Ex1
select distinct city
from station
where id%2 = 0
  
--Ex2
select count(*) - count(distinct city) from station

--Ex3
select ceiling(AVG(salary) - AVG(replace(salary,'0','')))
from employees

--Ex4
SELECT ROUND((SUM(item_count * order_occurrences) / SUM(order_occurrences)),1) 
FROM items_per_order;

--Ex5
SELECT candidate_id FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING count(*) >= 3

--Ex6

