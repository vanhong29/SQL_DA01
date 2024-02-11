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

with a as (
select visited_on,
sum(amount) as amount
from customer
group by visited_on
order by visited_on ),
b as (
select a.visited_on,
sum(amount) over (order by visited_on rows between 6 preceding and current row) as amount,
round(sum(amount) over (order by visited_on rows between 6 preceding and current row)/7,2) as average_amount
from a
)


select *
from b
where b.visited_on >= 6+ (select min(visited_on) from customer)

--Ex5
-- Write your PostgreSQL query statement below

with tbl_same_position as (
    select *,
    lead(lat) over(order by lat) - lat as lat_after,
    lag(lat) over(order by lat) - lat as lat_before,
    lead(lon) over(order by lon) - lon as lon_after,
    lag(lon) over(order by lon) - lon as lon_before
    from insurance
), tbl_diff_location as (
select b.pid, b.tiv_2015, b.tiv_2016, b.lat, b.lon
from tbl_same_position as b
where (b.lat_before <> 0 or b.lat_before is null ) and (b.lon_before <> 0 or b.lon_before is null ) and (b.lat_after <> 0 or b.lat_after is null) 
and( b.lon_after <> 0 or b.lon_after is null )
), tbl_same_amount as (
    select *,
    lead(tiv_2015) over(order by tiv_2015) - tiv_2015 as diff_15_after,
    lag(tiv_2015) over(order by tiv_2015) - tiv_2015 as diff_15_before
    from tbl_diff_location as c
)

select sum(c.tiv_2016) as tiv_2016
from tbl_same_amount as c
where c.diff_15_after = 0 or c.diff_15_before = 0

--Ex6
-- Write your PostgreSQL query statement below
select d.department as Department, d.name as Employee, d.salary as Salary
from (
select *,
dense_rank() over (partition by c.department order by c.salary desc) as rank
from (
select b.name as department, a.name, a.salary
from employee a left join department b
on a.departmentId= b.id
) as c
) as d
where d.rank <= 3

--Ex7

-- Write your PostgreSQL query statement below
select b.person_name
from (
select a.turn, a.person_id, a.person_name, a.weight,
sum(weight) over (order by turn) as total_weight
from queue as a
order by turn
) as b
where b.total_weight <= 1000
order by b.total_weight desc
limit 1

--Ex8

-- Write your PostgreSQL query statement below
with tbl as(
select *,
row_number() over (partition by product_id order by change_date) as rank
from products as a
order by product_id
), tbl2 as (
    select *
    from tbl as a
    where a.change_date > '2019-08-16' and rank = 1 OR (a.change_date <= '2019-08-16')
), tbl3 as (
select b.product_id, b.new_price as price, b.change_date
from tbl2 as b
where b.rank =
(select count(*) 
from tbl2 as c
where c.product_id = b.product_id
group by c.product_id)
)

select c.product_id,
case
    when c.change_date > '2019-08-16' then 10
    else c.price
end
from tbl3 as c










































































