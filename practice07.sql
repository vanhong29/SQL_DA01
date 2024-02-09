SELECT extract(year from transaction_date) as year, product_id,
sum(spend) as curr_year_spend,
lag(sum(spend)) over(PARTITION BY product_id ORDER BY extract(year from transaction_date)) as prev_year_spend,
ROUND((sum(spend) - lag(sum(spend)) over(PARTITION BY product_id ORDER BY extract(year from transaction_date)))*100/lag(sum(spend)) over(PARTITION BY product_id ORDER BY extract(year from transaction_date)),2)
FROM user_transactions
group by extract(year from transaction_date), product_id

