# Write your MySQL query statement below
SELECT  id
        , visit_date
        , people
  FROM
        (
        SELECT  id
                , visit_date
                , people
                , COUNT(id) OVER(PARTITION BY `group`) AS cnt
        FROM
                (
                SELECT  id
                        , visit_date
                        , people
                        -- , ROW_NUMBER() OVER(ORDER BY visit_date ASC) AS rnk
                        , id - ROW_NUMBER() OVER(ORDER BY visit_date ASC) AS `group`
                FROM  Stadium
                WHERE people >= 100
                ) T1
        ) T2
 WHERE  cnt >= 3
 ORDER
    BY  visit_date ASC