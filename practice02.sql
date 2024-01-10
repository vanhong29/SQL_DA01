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
SELECT user_id, (MAX(date(post_date)) - MIN(date(post_date))) as days_between
FROM posts
where post_date <= '01/01/2022'
group by user_id
HAVING MAX(date(post_date)) - MIN(date(post_date)) > 0
ORDER BY user_id

--Ex7
SELECT card_name, max(issued_amount) - min (issued_amount) as difference
FROM monthly_cards_issued
group by card_name
order by max(issued_amount) - min (issued_amount) DESC

--Ex8
SELECT manufacturer, count(*) as drug_count, sum(tbl.profit) * -1 AS total_loss
FROM
(SELECT manufacturer, product_id, SUM(total_sales) - SUM(cogs) as profit
FROM pharmacy_sales
GROUP BY manufacturer, product_id 
HAVING SUM(total_sales) - SUM(cogs) < 0) as tbl
GROUP BY manufacturer
ORDER BY sum(tbl.profit) * -1 DESC

select manufacturer, count(*), (sum(total_sales) - sum (cogs)) * -1
from pharmacy_sales
where total_sales < cogs
group by manufacturer
order by (sum(total_sales) - sum (cogs))*-1 desc

--Ex9
select *
from cinema
where id%2=1 and description <> 'boring'
order by rating DESC

--Ex10

select teacher_id,  count( distinct subject_id) as cnt
from teacher
group by teacher_id

--Ex11
select user_id, count(follower_id) as followers_count
from followers
group by user_id

--Ex12
select class
from courses
group by class
having count(student) >= 5















