# Write your MySQL query statement below
SELECT  student_id
        , subject
        , MAX(CASE WHEN first_score = 1 THEN score END) AS first_score
        , MAX(CASE WHEN latest_score = 1 THEN score END) AS latest_score
  FROM
        (
        SELECT  student_id
                , subject
                , score
                , ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date ASC) AS first_score
                , ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) AS latest_score
        FROM  Scores
        ) T
 WHERE  first_score = 1 OR latest_score = 1
 GROUP
    BY  student_id
        , subject
HAVING  MAX(CASE WHEN first_score = 1 THEN score END) < MAX(CASE WHEN latest_score = 1 THEN score END)
 ORDER
    BY  student_id
        , subject