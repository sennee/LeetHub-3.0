# Write your MySQL query statement below
SELECT  DISTINCT Tree.id         
        , CASE 
            WHEN Tree.p_id IS NULL THEN 'Root'
            WHEN p_Tree.p_id IS NOT NULL THEN 'Inner'
            WHEN p_Tree.p_id IS NULL THEN 'Leaf'
        END AS type
  FROM  Tree
  LEFT
  JOIN  Tree AS p_Tree
    ON  Tree.id = p_Tree.p_id