# Write your MySQL query statement below
SELECT  user_id
        , MAX(CASE WHEN activity_type = 'free_trial' THEN avg_duration END) AS trial_avg_duration
        , MAX(CASE WHEN activity_type = 'paid' THEN avg_duration END) AS paid_avg_duration
  FROM
        (
        SELECT  user_id
                , activity_type
                , ROUND(SUM(activity_duration) / COUNT(activity_date), 2) AS avg_duration 
        FROM  UserActivity
        GROUP
            BY  user_id
                , activity_type
        ) T
 GROUP
    BY  user_id
HAVING  COUNT(CASE WHEN activity_type IN ('free_trial', 'paid') THEN 1 END) >= 2