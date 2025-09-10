
--task1
SELECT ProductName AS Name FROM Products

--task2
SELECT * FROM Customers AS Clients

--task3
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted

--task4
SELECT * FROM Products
INTERSECT
SELECT * FROM Products_Discounted

--task5
SELECT DISTINCT FirstName, Country From Customers

--task6
SELECT 
	Price,
	CASE
	WHEN Price > 1000 THEN 'High'
	ELSE 'Low'
	END AS PriceRating
	FROM Products

--task7
SELECT
	StockQuantity,
	IIF(StockQuantity > 100, 'Yes', 'No') AS Codition
	FROM Products_Discounted

--task8

SELECT * FROM Products
INTERSECT
SELECT * FROM Products_Discounted

--task9

SELECT * FROM Products
EXCEPT
SELECT * FROM Products_Discounted

--task10
SELECT
	Price,
	IIF(Price > 1000, 'Expensive', 'Affordable') AS Recommendation
	FROM Products

--task11

SELECT *
FROM Employees
WHERE Age < 25 OR Salary > 60000

--task12

UPDATE Employees
SET Salary = Salary * 1.1
WHERE DepartmentName = 'HR' OR EmployeeID = 5

--task13

SELECT SaleAmount,
	CASE 
	WHEN SaleAmount > 500 THEN 'Top Tier'
	WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
	ELSE 'Low Tier'
	END AS SalaryCategory
	FROM Sales

--task 14

SELECT CustomerID FROM Customers
EXCEPT
SELECT CustomerID FROM Sales

--task15

SELECT CustomerId,
	   Quantity,
	   CASE 
	   WHEN Quantity = 1 THEN '1%'
	   WHEN Quantity BETWEEN 1 AND 3 THEN '3%'
	   ELSE '7%'
	   END AS DiscountPercentage
	   FROM Orders





















