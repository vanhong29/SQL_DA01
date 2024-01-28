--Ex1
select count(*) as duplicate_companies
from (
SELECT company_id, title, description, count(*)
FROM job_listings
group by company_id, title, description
having count(*)>1
) as tbl_2

--Ex2
with top2_appliance AS(
SELECT category, product,sum(spend) as total_spend
FROM product_spend
where EXTRACT(year from transaction_date) = 2022 AND category='appliance'
group by category, product
order by sum(spend) desc
limit 2
),
top2_electronics AS(
SELECT category, product, sum(spend) as total_spend
FROM product_spend
where EXTRACT(year from transaction_date) = 2022 AND category='electronics'
group by category, product
order by sum(spend) desc
limit 2
)

select *
from top2_electronics
UNION 
select *
from top2_appliance

--Ex3

SELECT COUNT(policy_holder_id) AS member_count
FROM (
  SELECT
    policy_holder_id,
    COUNT(case_id) AS call_count
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
) AS call_records;

--Ex4
SELECT a.page_id
from pages a
left join page_likes b 
on a.page_id = b.page_id
group by a.page_id
having count(b.liked_date) = 0

--Ex5


--Ex6
with tbl as(
    select to_char(trans_date, 'YYYY-MM') as month, *
    from transactions
    -- group by to_char(trans_date, 'YYYY-MM'), country
)

select a.month, a.country, count(*) as trans_count,
(select count(*) as approved_count
from tbl as b
where b.state = 'approved' and b.country = a.country and b.month = a.month
group by b.month,b.country
),
(select sum(amount) as trans_total_amount
from tbl as c
where c.country = a.country and c.month = a.month
group by c.month,c.country
),
(select sum(amount) as approved_total_amount
from tbl as d
where d.state = 'approved' and d.country = a.country and d.month = a.month
group by d.month,d.country
)
from tbl as a
group by a.month, a.country


--Ex7
with product_year as(
select product_id, min(year) as first_year
from sales
group by product_id
)

select a.*, b.quantity, b.price
from product_year a left join sales b
on a.product_id = b.product_id and a.first_year = b.year

--Ex8
select customer_id
from customer
group by customer_id
having count(distinct product_key) = (select count(*) from product)

--Ex9
select customer_id
from customer
group by customer_id
having count(distinct product_key) = (select count(*) from product)

--Ex10
select count(*) as duplicate_companies
from (
SELECT company_id, title, description, count(*)
FROM job_listings
group by company_id, title, description
having count(*)>1
) as tbl_2

--Ex11
with user_rated_the_most as (
select 
(select name from users as b where b.user_id = a.user_id) as results
from movierating as a
group by user_id
order by count(rating) desc, results
limit 1
), movie_rated_highest as (
select 
(select title from movies where movies.movie_id = movierating.movie_id) as results
from movierating
where extract(year from movierating.created_at) =2020 and extract(month from movierating.created_at) = 2
group by movie_id
order by avg(rating) desc, results
limit 1
)

select *
from user_rated_the_most
union all
select *
from movie_rated_highest

--Ex12
with request as (
    select requester_id , count(*) 
    from RequestAccepted 
    group by requester_id 
)
, accept as (
    select accepter_id  , count(*) 
    from RequestAccepted 
    group by accepter_id  
)
select requester_id as id, sum(count) as num
from (
select *
from request
union all
select *
from accept
)
group by requester_id
order by sum(count) desc
limit 1










