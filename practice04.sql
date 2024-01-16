--Ex1
SELECT 
sum(CASE
  WHEN device_type = 'laptop' then 1
  else 0
END) as laptop_reviews,
sum(CASE
  WHEN device_type IN ('tablet','phone') then 1
  else 0
END) as mobile_views
FROM viewership

--Ex2
select *,
case
   when 
   (x between abs(y-z) AND y+z) AND
   (y between abs(x-z) AND x + z) AND
   (z between abs(x-y) AND x + y)
   then 'Yes'
   ELSE 'No'
end as triangle
from triangle

-- Ex3

SELECT 
round(SUM(
CASE
  when call_category = 'n/a' OR call_category is null then 1
  else 0
end
) / count(*) * 100, 1) as call_percentage
from callers

--Ex4
SELECT name
from customer
where referee_id <> 2 or referee_id is null

-- Ex5
select pclass, 
sum(
case
    when survived = 1 then 1
    else 0
end
) as survived,
sum(
case
    when survived = 0 then 1
    else 0
end
) as not_survived
from titanic
group by pclass

















