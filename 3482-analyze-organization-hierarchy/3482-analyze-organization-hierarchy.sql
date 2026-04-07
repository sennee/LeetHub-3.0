WITH RECURSIVE employee_paths (employee_id, employee_name, level) AS
(
  SELECT employee_id, employee_name, 1 AS level
    FROM Employees
    WHERE manager_id IS NULL
  UNION ALL
  SELECT e.employee_id, e.employee_name, ep.level + 1
    FROM employee_paths AS ep 
    JOIN Employees AS e
      ON ep.employee_id = e.manager_id
),
team_tree AS (
    -- 각 직원을 루트로 시작
    SELECT 
        employee_id AS root_id,
        employee_id,
        salary
    FROM Employees

    UNION ALL

    -- 하위 직원 확장
    SELECT 
        tt.root_id,
        e.employee_id,
        e.salary
    FROM team_tree tt
    JOIN Employees e
        ON tt.employee_id = e.manager_id
),
T_size AS (
SELECT  root_id
        , COUNT(*) - 1  AS team_size
        , SUM(salary)   AS budget 
  FROM  team_tree
 GROUP
    BY  root_id
)
SELECT  T_level.employee_id
        , T_level.employee_name
        , T_level.level
        , T_size.team_size
        , T_size.budget
  FROM  employee_paths AS T_level
  LEFT
  JOIN  T_size
    ON  T_level.employee_id = T_size.root_id
 ORDER
    BY  T_level.level ASC
        , T_size.budget DESC
        , T_level.employee_name ASC