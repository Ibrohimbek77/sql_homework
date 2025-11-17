
-- LESSON 21




SELECT *, 
       ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

SELECT ProductName,
       SUM(Quantity) AS TotalQuantity,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS QuantityRank
FROM ProductSales
GROUP BY ProductName;

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) t
WHERE rn = 1;

SELECT SaleID, ProductName, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

SELECT SaleID, ProductName, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales;

SELECT SaleID, ProductName, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (ORDER BY SaleDate);

SELECT ProductName, SaleDate, SaleAmount,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales;

SELECT ProductName, SaleDate, SaleAmount,
       ((LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) - SaleAmount)
        / SaleAmount * 100) AS PercentChange
FROM ProductSales;

SELECT ProductName, SaleDate, SaleAmount,
       CAST(SaleAmount AS DECIMAL(10,2)) / 
       NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0) AS RatioToPrev
FROM ProductSales;

SELECT ProductName, SaleDate, SaleAmount,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;

SELECT ProductName, SaleDate, SaleAmount
FROM (
    SELECT *, 
           CASE 
             WHEN SaleAmount > LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
             THEN 1 ELSE 0 END AS IncreasingFlag
    FROM ProductSales
) t
WHERE IncreasingFlag = 1;

SELECT ProductName, SaleDate, SaleAmount,
       SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS RunningTotal
FROM ProductSales;

SELECT ProductName, SaleDate, SaleAmount,
       AVG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate 
                             ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM ProductSales;

SELECT ProductName, SaleDate, SaleAmount,
       SaleAmount - AVG(SaleAmount) OVER (PARTITION BY ProductName) AS DiffFromAvg
FROM ProductSales;



SELECT Name, Department, Salary,
       DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employee
SELECT *
FROM (
    SELECT *, 
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM Employees1
) t
WHERE rnk <= 2;

SELECT *
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rnk
    FROM Employees1
) t
WHERE rnk = 1;


SELECT Department, Name, Salary,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY Salary) AS RunningTotal
FROM Employees1;

SELECT Department, Name, Salary,
       SUM(Salary) OVER (PARTITION BY Department) AS TotalDeptSalary
FROM Employees1;

SELECT Department, Name, Salary,
       AVG(Salary) OVER (PARTITION BY Department) AS AvgDeptSalary
FROM Employees1;

SELECT Name, Department, Salary,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromAvg
FROM Employees1;

SELECT Department, Name, Salary,
       AVG(Salary) OVER (PARTITION BY Department ORDER BY Salary 
                         ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg3
FROM Employees1;

SELECT Name, Department, Salary, HireDate
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS rn
    FROM Employees1
) t
WHERE rn <= 3;
