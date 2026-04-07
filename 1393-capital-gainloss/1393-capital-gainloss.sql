# Write your MySQL query statement below
SELECT  stock_name
        , SUM(sum_price) AS capital_gain_loss
  FROM 
        (
        SELECT  stock_name
                , operation
                , CASE 
                    WHEN operation = 'Sell' THEN SUM(price)
                    WHEN operation = 'Buy' THEN -SUM(price)
                END AS sum_price
          FROM  Stocks
         GROUP
            BY  stock_name
                , operation
        ) T
 GROUP
    BY  stock_name
 ORDER 
    BY  stock_name ASC