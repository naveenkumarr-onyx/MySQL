-- Create the EmployeeDetails table:
CREATE TABLE EmployeeDetails (
  EmpId INT PRIMARY KEY,
  FullName VARCHAR(100),
  ManagerId INT,
  DateOfJoining DATE,
  City VARCHAR(50)
);

-- EmployeeDetails;
INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES
  (1, 'John Doe', 0, '2021-01-15', 'New York'),
  (2, 'Jane Smith', 1, '2020-06-03', 'London'),
  (3, 'Robert Johnson', 1, '2019-12-10', 'Chicago'),
  (4, 'Emily Davis', 3, '2022-02-28', 'Los Angeles'),
  (5, 'Michael Wilson', 1, '2020-08-21', 'Paris');

-- Create the EmployeeSalary table:
CREATE TABLE EmployeeSalary (
  EmpId INT,
  Project VARCHAR(100),
  Salary DECIMAL(10, 2),
  Variable DECIMAL(10, 2),
  PRIMARY KEY (EmpId, Project)
);
-- EmployeeSalary table:
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES
  (1, 'ProjectA', 5000.00, 1000.00),
  (2, 'ProjectB', 4500.00, 900.00),
  (3, 'ProjectC', 6000.00, 1200.00),
  (4, 'ProjectA', 5500.00, 1100.00),
  (5, 'ProjectB', 4800.00, 950.00);



-- 1)SQL query to fetch records that are present in one table but not in another table:
SELECT EmpId FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary)

-- 2)SQL query to fetch all the employees who are not working on any project:
SELECT * FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary)

-- 3)SQL query to fetch all the employees from EmployeeDetails who joined in the Year 2020:
SELECT * FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020

-- 4)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary:
SELECT * FROM EmployeeDetails
WHERE EmpId IN (SELECT EmpId FROM EmployeeSalary)

--5)Write an SQL query to fetch a project-wise count of employees:
SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project

-- 6)Fetch employee names and salaries even if the salary value is not present for the employee:
SELECT ed.FullName, es.Salary
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es ON ed.EmpId = es.EmpId;

-- 7)Write an SQL query to fetch all the Employees who are also managers:
SELECT ed.FullName
FROM EmployeeDetails ed
INNER JOIN EmployeeDetails ed2 ON ed.EmpId = ed2.ManagerId;

-- 8)Write an SQL query to fetch duplicate records from EmployeeDetails:
SELECT EmpId, COUNT(*) AS DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId
HAVING COUNT(*) > 1

--9)Write an SQL query to fetch only odd rows from the table:
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNum
  FROM EmployeeDetails
) AS t
WHERE RowNum % 2 = 1

--10)Write a query to find the 3rd highest salary from a table without using the top or limit keyword:
SELECT Salary
FROM EmployeeSalary
ORDER BY Salary DESC
OFFSET 2 ROWS
FETCH NEXT 1 ROWS ONLY

