Easy Tasks

    

Medium Tasks

    

--task1

Create a numbers table using a recursive query from 1 to 1000.


CREATE TABLE Numbers(numbers INT);

WITH GenerateNums AS(
    SELECT 1 AS N
    UNION ALL
    SELECT N + 1 FROM GenerateNums WHERE N < 1000
) 
INSERT INTO Numbers(numbers)
SELECT * FROM GenerateNums
OPTION (MAXRECURSION 1000)

SELECT * FROM Numbers


--task2


Write a query to find the total sales per employee using a derived table.(Sales, Employees)


SELECT * FROM Sales


WITH CTE AS(
    SELECT EmployeeID, 
           SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT E.*, CTE.TotalSales FROM Employees AS E
JOIN CTE
    ON E.EmployeeID = CTE.EmployeeID



--task3 

Create a CTE to find the average salary of employees.(Employees)

SELECT * FROM Employees;

WITH AverageSalary AS(
    SELECT
        DepartmentID,
        AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
)
SELECT * FROM AverageSalary


--task4


Write a query using a derived table to find the highest sales for each product.(Sales, Products)

SELECT P.*, HighestSales.HighestSales FROM Products AS P
JOIN (SELECT ProductID, MAX(SalesAmount) AS HighestSales FROM Sales GROUP BY ProductID) AS HighestSales
    ON P.ProductID = HighestSales.ProductID;


--task5


    Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.;


WITH Doubles AS(
    SELECT 1 AS Num 
    UNION ALL
    SELECT Num * 2
    FROM Doubles
    WHERE Num * 2 < 1000000
)
SELECT * FROM Doubles


--task6

Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
    
WITH EmpMoreThanFive AS(
    SELECT EmployeeID,
           COUNT(Salesamount) AS SalesQuantity
    FROM Sales
    GROUP BY EmployeeID
    HAVING(COUNT(Salesamount) > 5) 
)
SELECT E.* FROM Employees AS E 
JOIN EmpMoreThanFive AS N
    ON E.EmployeeID = N.EmployeeID


--task7


    Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

WITH Greater AS(
    SELECT 
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
    HAVING(SUM(SalesAmount) > 500)
)
SELECT P.*, G.TotalSales
FROM Products AS P
JOIN Greater AS G 
    ON P.ProductID = G.ProductID


--task8


Create a CTE to find employees with salaries above the average salary.(Employees)

WITH SalaryAboveAVG AS (
    SELECT 
        DepartmentID,
        AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
)
SELECT E.*, S.AvgSalary  FROM Employees AS E
JOIN SalaryAboveAVG AS S
    ON E.DepartmentID = S.DepartmentID AND E.Salary > S.AvgSalary


--Medium tasks

--task1


    Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)



SELECT TOP (5) *
FROM Employees AS E
JOIN (
    SELECT 
        EmployeeID,
        COUNT(SalesAmount) AS OrderNum
    FROM Sales
    GROUP BY EmployeeID
) AS T 
    ON E.EmployeeID = T.EmployeeID
ORDER BY T.OrderNum DESC;


--task2


    Write a query using a derived table to find the sales per product category.(Sales, Products)



SELECT 
    P.CategoryID,
    SUM(SalesPerProduct.TotalSales) AS SalesPerCategory
FROM Products AS P 
JOIN (
    SELECT 
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) AS SalesPerProduct
    ON P.ProductID = SalesPerProduct.ProductID
GROUP BY CategoryID


--task3

Write a script to return the factorial of each value next to it.(Numbers1)



SELECT * FROM Numbers1;

WITH C AS(
    SELECT 
        Number,
        1 AS NUM,
        1 AS Factorial 
    FROM Numbers1
    UNION ALL
    SELECT 
        Number,
        NUM + 1,
        Factorial * (NUM + 1)
    FROM C
    WHERE NUM < Number
)
SELECT 
    Number,
    MAX(Factorial) AS Factorial
FROM C
GROUP BY Number
ORDER BY Number ASC

--task4

    This script uses recursion to split a string into rows of substrings for each character in the string.(Example)


SELECT * FROM Example;


SELECT * FROM Example
CROSS APPLY string_split(String, ) AS t 


WITH CTE AS(
    SELECT 
        1 AS Indexation,
        String,
        SUBSTRING(String, 1, 1) AS TheChar
    FROM Example
    UNION ALL 
    SELECT 
        Indexation + 1,
        String,
        SUBSTRING(String, Indexation + 1, 1)
    FROM CTE
    WHERE Indexation < LEN(String)
)
SELECT 
    String,
    TheChar
FROM CTE
ORDER BY String


--task5

    Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)



WITH SalesDifference AS
(
    SELECT 
        MONTH(SaleDate) AS Month_before,
        SUM(SalesAmount) AS TotalSalesMonth
    FROM Sales
    GROUP BY MONTH(SaleDate)
)
SELECT 
    MONTH(S_now.SaleDate) AS Month_now,
    SUM(S_now.SalesAmount) AS TotalSales_now,
    S_b.Month_before,
    S_b.TotalSalesMonth AS TotalSales_before,
    (SUM(S_now.SalesAmount) - S_b.TotalSalesMonth) AS Sales_Difference
FROM Sales AS S_now
JOIN SalesDifference AS S_b 
    ON MONTH(S_now.SaleDate) = S_b.Month_before + 1
GROUP BY MONTH(S_now.SaleDate),S_b.Month_before,S_b.TotalSalesMonth



--task6


    Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)



SELECT 
    E.DepartmentID,
    SUM(MadeSales.TotalSales) AS TotalSalesInSquare
FROM Employees AS E
JOIN 
(
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS MadeSales
    ON E.EmployeeID = MadeSales.EmployeeID
GROUP BY DepartmentID
HAVING(SUM(MadeSales.TotalSales) > 45000)






--Difficult Tasks

--task1

    This script uses recursion to calculate Fibonacci numbers
    


WITH FibonachiNumbers AS
(
    SELECT
        0 AS  FibonachiNum,
        1 as num2
    UNION ALL 
    SELECT
        FibonachiNum + num2,
        FibonachiNum
    FROM FibonachiNumbers
    WHERE FibonachiNum < 200
)
SELECT FibonachiNum FROM FibonachiNumbers



--task2


Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

SELECT * FROM FindSameCharacters

SELECT ( REPLACE('aaa','a', ''))


SELECT * FROM FindSameCharacters
WHERE LEN(Vals) > 1 AND LEN(REPLACE(Vals, LEFT(Vals,1), '')) = 0



--task3

Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
   

DECLARE @n INT = 5;

WITH CTE AS
(
    SELECT 
        1 AS N,
        CAST('1' AS VARCHAR(200)) AS [Sequence] 
    UNION ALL
    SELECT 
        N + 1,
        CAST([Sequence] + CAST(N + 1 AS VARCHAR(200)) AS VARCHAR(200))
    FROM CTE
    WHERE N < @n
)
SELECT * INTO Numbers
FROM CTE 

SELECT * FROM Numbers

DROP TABLE IF EXISTS Numbers



--task4


Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
    
SELECT 
    E.EmployeeID,
    FirstName,
    LastName,
    SUM(S.SalesAmount) AS LastSixMonths
FROM Employees AS E 
JOIN
(
    SELECT SaleDate, EmployeeID, SalesAmount
    FROM Sales
    WHERE (DATEDIFF(MONTH, SaleDate, (SELECT MAX(SaleDate) FROM Sales))) < 6
) AS S 
    ON E.EmployeeID = S.EmployeeID
GROUP BY E.EmployeeID, FirstName, LastName
ORDER BY EmployeeID





--task5


Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)


SELECT * FROM RemoveDuplicateIntsFromNames

SELECT 
    Pawan_slug_name,
    PATINDEX('%[0-9]%',Pawan_slug_name) AS GirstINT,
    CASE 
        WHEN LEN(REPLACE(Pawan_slug_name, (SUBSTRING(Pawan_slug_name,PATINDEX('%[0-9]%',Pawan_slug_name), 1)), '' ))  = LEN(Pawan_slug_name) - 1 THEN Pawan_slug_name
        WHEN LEN(REPLACE(Pawan_slug_name, (SUBSTRING(Pawan_slug_name,PATINDEX('%[0-9]%',Pawan_slug_name), 1)), '' )) < LEN(Pawan_slug_name) THEN REPLACE(Pawan_slug_name, (SUBSTRING(Pawan_slug_name,PATINDEX('%[0-9]%',Pawan_slug_name), 1)), '' )
        END
FROM RemoveDuplicateIntsFromNames



UPDATE RemoveDuplicateIntsFromNames
SET Pawan_slug_name =
            CASE 
                WHEN LEN(REPLACE(SUBSTRING(Pawan_slug_name,PATINDEX('%[0-9]%',Pawan_slug_name) + 1, LEN(Pawan_slug_name)) + 'a', SUBSTRING(Pawan_slug_name,PATINDEX('%[0-9]%',Pawan_slug_name), 1 ), '')) = 1
                    THEN REPLACE(Pawan_slug_name, SUBSTRING(Pawan_slug_name,PATINDEX('%[0-9]%',Pawan_slug_name),1), '')
                ELSE
                    Pawan_slug_name
                END
                

SELECT * FROM RemoveDuplicateIntsFromNames
