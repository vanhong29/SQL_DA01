--Ex1

select name
from students
where marks >75
order by right(name, 3), id

--Ex2

select user_id, concat(upper(left(name, 1)) , lower(right(name, length(name) - 1))) as name
from users

--Ex3
SELECT manufacturer, '$' || floor(round(sum(total_sales),-6)/1000000) || ' million' as sales_mil
FROM pharmacy_sales
group by manufacturer
order by floor(round(sum(total_sales),-6)/1000000) DESC, manufacturer desc

--Ex4
SELECT extract(month from submit_date), product_id as product, ROUND(AVG(stars),2)
FROM reviews
group by extract(month from submit_date), product_id
order by extract(month from submit_date), product_id

--Ex5
SELECT sender_id, count(*)
FROM messages
WHERE TO_CHAR(sent_date, 'mm-yyyy') = '08-2022'
group by sender_id
order by count(*) DESC
limit 2

--Ex6

select tweet_id
from tweets
where length(content) > 15

--Ex7

select activity_date as day, count(distinct user_id) as active_users
from activity
where DATE_SUB('2019-07-27', INTERVAL 30 DAY) <= activity_date AND activity_date <= '2019-07-27'
group by activity_date

  
--Ex8
select count(*)
from employees
where extract(month from joining_date)>=1 AND extract(month from joining_date) <= 7 AND extract(year from joining_date) = 2022

--Ex9
select position('a' IN first_name)
from worker
where first_name =  'Amitah'

--Ex10
select REGEXP_REPLACE(title,'[0-9]{4}',''), substring(title from '[0-9]{4}')
from winemag_p2
where country = 'Macedonia'

select winery, substring(title from length(winery) + 2 for 4)
from winemag_p2
where country = 'Macedonia'












