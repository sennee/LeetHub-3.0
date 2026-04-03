# Write your MySQL query statement below
SELECT  Users.user_id AS buyer_id
        , Users.join_date
        , COUNT(CASE WHEN YEAR(Orders.order_date) = 2019 AND Items.item_id IS NOT NULL THEN Orders.order_id END) AS orders_in_2019
  FROM  Users
  LEFT  
  JOIN  Orders
    ON  Orders.buyer_id = Users.user_id
  LEFT
  JOIN  Items
    ON  Orders.item_id = Items.item_id
 GROUP
    BY  Users.user_id
        , Users.join_date
 ORDER
    BY  Users.user_id ASC