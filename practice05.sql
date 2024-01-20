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


--Ex7









