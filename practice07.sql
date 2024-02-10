--Ex1
SELECT extract(year from transaction_date) as year, product_id,
sum(spend) as curr_year_spend,
lag(sum(spend)) over(PARTITION BY product_id ORDER BY extract(year from transaction_date)) as prev_year_spend,
ROUND((sum(spend) - lag(sum(spend)) over(PARTITION BY product_id ORDER BY extract(year from transaction_date)))*100/lag(sum(spend)) over(PARTITION BY product_id ORDER BY extract(year from transaction_date)),2)
FROM user_transactions
group by extract(year from transaction_date), product_id

--Ex2
SELECT DISTINCT card_name,
FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) as issued_amount
FROM monthly_cards_issued
ORDER BY FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) DESC

--Ex3
select tbl.user_id, tbl.spend, tbl.transaction_date
from (
SELECT user_id, spend, transaction_date,
row_number() over(PARTITION BY user_id order by transaction_date) as stt
from transactions
) as tbl
where tbl.stt = 3

--Ex4
select tbl.transaction_date, tbl.user_id, tbl.purchase_count
from
(SELECT transaction_date, user_id, count(*) as purchase_count,
RANK() over (PARTITION BY user_id order by transaction_date desc) as stt
FROM user_transactions 
group by transaction_date, user_id
) as tbl
where tbl.stt = 1
order by tbl.transaction_date

-- Ex5

select user_id, tweet_date,
ROUND(avg(tweet_count) over(PARTITION BY user_id order by tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2)as rolling_avg_3d
from tweets

--Ex6
with tbl as (
SELECT merchant_id, credit_card_id, amount,
transaction_timestamp,
lead(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id),
lead(amount) OVER(PARTITION BY merchant_id, credit_card_id),
lead(amount) OVER(PARTITION BY merchant_id, credit_card_id) - amount as amount_diff,
extract(EPOCH FROM (lead(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id) - transaction_timestamp)) / 60 as minute_diff
FROM transactions
)

select count(*) as payment_count
from tbl
where tbl.amount_diff = 0 and tbl.minute_diff <= 10


--Ex7
  
with a as 
(
select category, product, sum(spend) as total_spend,
RANK() over(PARTITION BY category ORDER BY sum(spend) desc ) as stt
from product_spend 
where EXTRACT(year from transaction_date) = 2022
group by category, product
order by category, product
)

select a.category, a.product, a.total_spend
from a 
where a.stt <= 2
group by category, product, a.total_spend
order by a.category, a.total_spend DESC


--Ex8
with b as (
select tbl.artist_name, count(*) as no_top_10
from
(select *
from
(select *
from global_song_rank 
where rank <= 10
) as a 
JOIN songs b on a.song_id = b.song_id
join artists c on c.artist_id = b.artist_id ) as tbl
group by tbl.artist_name
)

select *
from (
select b.artist_name, 
dense_RANK() OVER(order by b.no_top_10 desc) as artist_rank
from b 
) as c
where c.artist_rank <= 5













































