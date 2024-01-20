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
