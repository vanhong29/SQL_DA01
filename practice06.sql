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














