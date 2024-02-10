--Ex1
with a as (
select *, rank() over(partition by customer_id order by order_date) as rank
from delivery
order by customer_id, order_date
)

select count(*) * 100 / (
    select count(distinct customer_id)
    from delivery
) as immediate_percentage 
from a
where a.rank = 1 and a.order_date = a.customer_pref_delivery_date 

--Ex2
-- Write your PostgreSQL query statement below
select round(cast(count(*) as decimal) / (select count(distinct player_id) from activity),2) as fraction
from (
select *,
lead(event_date) over(partition by player_id) - event_date as day_diff
from activity
) as a
where a.day_diff = 1

--Ex3
-- Write your PostgreSQL query statement below
select id,
case
    when (select count(*) from seat)%2=1 and id = (select count(*) from seat) then student
    when id%2=1 then lead(student) over(order by id)
    else lag(student) over(order by id)
end as student
from seat

--Ex4


















