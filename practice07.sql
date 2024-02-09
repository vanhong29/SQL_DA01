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























