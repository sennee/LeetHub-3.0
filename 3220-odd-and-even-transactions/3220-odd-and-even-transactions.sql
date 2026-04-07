# Write your MySQL query statement below
SELECT  transaction_date
        , COALESCE(SUM(CASE WHEN MOD(amount, 2) <> 0 THEN amount END), 0) AS odd_sum
        , COALESCE(SUM(CASE WHEN MOD(amount,2) = 0 THEN amount END), 0) AS even_sum
  FROM  transactions
 GROUP
    BY  transaction_date
 ORDER 
    BY  transaction_date ASC