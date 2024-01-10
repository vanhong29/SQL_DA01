--Ex1
SELECT DISTINCT city
FROM station
WHERE id%2 = 0
  
--Ex2
SELECT COUNT(*) - COUNT(DISTINCT city) FROM station

--Ex3
SELECT CEILING(AVG(salary) - AVG(replace(salary,'0','')))
FROM employees

--Ex4
SELECT ROUND((SUM(item_COUNT * order_occurrences) / SUM(order_occurrences)),1) 
FROM items_per_order;

--Ex5
SELECT candidate_id FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(*) >= 3

--Ex6
SELECT user_id, (MAX(date(post_date)) - MIN(date(post_date))) as days_between
FROM posts
WHERE post_date <= '01/01/2022'
GROUP BY user_id
HAVING MAX(date(post_date)) - MIN(date(post_date)) > 0
ORDER BY user_id

--Ex7
SELECT card_name, MAX(issued_amount) - MIN (issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY MAX(issued_amount) - MIN (issued_amount) DESC

--Ex8
SELECT manufacturer, COUNT(*) as drug_COUNT, SUM(tbl.profit) * -1 AS total_loss
FROM
(SELECT manufacturer, product_id, SUM(total_sales) - SUM(cogs) as profit
FROM pharmacy_sales
GROUP BY manufacturer, product_id 
HAVING SUM(total_sales) - SUM(cogs) < 0) as tbl
GROUP BY manufacturer
ORDER BY SUM(tbl.profit) * -1 DESC

SELECT manufacturer, COUNT(*), (SUM(total_sales) - SUM (cogs)) * -1
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY (SUM(total_sales) - SUM (cogs))*-1 desc

--Ex9
SELECT *
FROM cinema
WHERE id%2=1 and description <> 'boring'
ORDER BY rating DESC

--Ex10

SELECT teacher_id,  COUNT( DISTINCT subject_id) as cnt
FROM teacher
GROUP BY teacher_id

--Ex11
SELECT user_id, COUNT(follower_id) as followers_COUNT
FROM followers
GROUP BY user_id

--Ex12
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(student) >= 5















