# Write your MySQL query statement below
SELECT  ip
        , COUNT(log_id) AS invalid_count
  FROM
        (
        SELECT  log_id
                , ip
                , CASE 
                    WHEN CAST(REGEXP_SUBSTR(ip, '[0-9]+', 1, 1) AS UNSIGNED) > 255
                        OR CAST(REGEXP_SUBSTR(ip, '[0-9]+', 1, 2) AS UNSIGNED) > 255
                        OR CAST(REGEXP_SUBSTR(ip, '[0-9]+', 1, 3) AS UNSIGNED) > 255
                        OR CAST(REGEXP_SUBSTR(ip, '[0-9]+', 1, 4) AS UNSIGNED) > 255
                        OR SUBSTRING(REGEXP_SUBSTR(ip, '[0-9]+', 1, 1), 1, 1) = '0'
                        OR SUBSTRING(REGEXP_SUBSTR(ip, '[0-9]+', 1, 2), 1, 1) = '0'
                        OR SUBSTRING(REGEXP_SUBSTR(ip, '[0-9]+', 1, 3), 1, 1) = '0'
                        OR SUBSTRING(REGEXP_SUBSTR(ip, '[0-9]+', 1, 4), 1, 1) = '0'
                        OR REGEXP_SUBSTR(ip, '[0-9]+', 1, 4) IS NULL
                        OR REGEXP_SUBSTR(ip, '[0-9]+', 1, 5) IS NOT NULL
                        THEN 'invalid'
                    ELSE 'valid'
                END AS flag
        FROM  logs
        ) T
 WHERE  flag = 'invalid'
 GROUP
    BY  ip
 ORDER 
    BY  COUNT(log_id) DESC, ip DESC