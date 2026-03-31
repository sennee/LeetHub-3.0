# Write your MySQL query statement below
SELECT  Trips.request_at AS Day
        , ROUND(COUNT(CASE WHEN Trips.status LIKE 'cancelled%' THEN 1 END)/COUNT(Trips.id), 2) AS `Cancellation Rate`
  FROM  Trips
 INNER
  JOIN  Users AS C
    ON  Trips.client_id = C.users_id
        AND C.banned = 'No'
 INNER
  JOIN  Users AS D
    ON  Trips.driver_id = D.users_id
        AND D.banned = 'No'
 WHERE Trips.request_at BETWEEN '2013-10-01' AND '2013-10-03'    
 GROUP
    BY  Trips.request_at