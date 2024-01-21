-- Ex1

select b.continent, floor(avg(a.population))
from city a
join country b
on a.countrycode = b.code
group by b.continent
order by floor(avg(a.population))

--Ex2
SELECT 
round(cast (sum (case 
  when b.signup_action = 'Confirmed' then 1
  else 0
end) as decimal) / cast(count( distinct a.email_id) as decimal),2) as confirm_rate
from emails as a left join texts as b 
on a.email_id = b.email_id


-- Ex3
select b.age_bucket,
round(sum(CASE
  when a.activity_type = 'send' then time_spent
  else 0
END) / sum(a.time_spent) * 100,2)  as send_perc,
round(sum(CASE
  when a.activity_type = 'open' then time_spent
  else 0
END) / sum(a.time_spent) * 100 ,2) as send_perc
from activities a join age_breakdown b 
on a.user_id = b.user_id AND a.activity_type IN ('send','open')
group by b.age_bucket

-- Ex4
SELECT a.customer_id
FROM customer_contracts a left join products b
on a.product_id = b.product_id
group by a.customer_id
having count(distinct b.product_category) >= 3
ORDER BY customer_id

-- Ex5
select mng.employee_id, mng.name, count(*) as reports_count, round(avg(emp.age),0) as average_age
from employees as mng
join employees as emp
on mng.employee_id = emp.reports_to

--Ex6
select b.product_name, SUM(a.unit) as unit
from orders as a join products b 
on a.product_id = b.product_id AND extract(month from a.order_date) = 2
group by b.product_name
having SUM(a.unit) >= 100

--Ex7
SELECT a.page_id
FROM pages a
left join page_likes b
on a.page_id = b.page_id
group by a.page_id
having count(b.user_id) = 0

-------------------MID-TERM---------------------

--Ex1
select distinct replacement_cost
from film
order by replacement_cost

--Ex2
select
case
	when replacement_cost between 9.99 AND 19.99 then 'low'
	when replacement_cost between 20 AND 24.99 then 'medium'
	when replacement_cost between 25 AND 29.99 then 'high'
end as replacement_level,
count(*)
from film
group by 
case
	when replacement_cost between 9.99 AND 19.99 then 'low'
	when replacement_cost between 20 AND 24.99 then 'medium'
	when replacement_cost between 25 AND 29.99 then 'high'
end

--Ex3
select a.title, a.length, c.name
from film a
join film_category b
on a.film_id = b.film_id
join category c
on b.category_id = c.category_id
where c.name in ('Drama','Sports')
order by a.length desc

--Ex4
select c.name, count(*)
from film a
join film_category b
on a.film_id = b.film_id
join category c
on b.category_id = c.category_id
group by c.name
order by count(*) desc

--Ex5
select b.first_name,b.last_name, count(distinct a.film_id)
from film_actor a
join actor b
on a.actor_id = b.actor_id
group by a.actor_id, b.first_name,b.last_name
order by count(distinct a.film_id) desc

--Ex6

select count(*)
from address a
left join customer b
on a.address_id = b.address_id
where b.customer_id is null

--Ex7

select d.city, sum(a.amount)
from payment a
join customer b
on a.customer_id = b.customer_id
join address c
on b.address_id = c.address_id
join city d
on c.city_id = d.city_id
group by d.city
order by sum(a.amount) desc

--Ex8

select concat(d.city || ', '|| e.country), sum(a.amount)
from payment a
join customer b
on a.customer_id = b.customer_id
join address c
on b.address_id = c.address_id
join city d
on c.city_id = d.city_id
join country e
on e.country_id = d.country_id
group by d.city, e.country
order by sum(a.amount) desc













































































