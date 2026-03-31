# Write your MySQL query statement below
SELECT  Department
        , Employee
        , Salary
  FROM
(
SELECT  Department.name AS Department
        , Employee.name AS Employee
        , Employee.salary AS Salary
        , DENSE_RANK() OVER(PARTITION BY Department.id ORDER BY Employee.salary DESC) AS rnk
  FROM  Employee
 INNER
  JOIN  Department
    ON  Employee.departmentId = Department.id
) T
 WHERE  rnk = 1