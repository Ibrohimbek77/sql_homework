--Write a query to select the top 5 employees from the Employees table.
--Use SELECT DISTINCT to select unique Category values from the Products table.
--Write a query that filters the Products table to show products with Price > 100.
--Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
--Order the results of a Products table by Price in ascending order.
--Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and DepartmentName = 'HR'.
--Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
--Write a query that shows all products with Price BETWEEN 50 AND 100.
--Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
--After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order.
--Write a query to select the top 10 products from the Products table, ordered by Price DESC.
--Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
--Write a query that selects distinct Category and Price from the Products table.
--Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or DepartmentName = 'Marketing'.
--Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
--Write a query to display all products with Price <= 1000 and StockQuantity > 50, sorted by Stock in ascending order.
--Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
--Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
--Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table
--Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SaleAmount DESC.
--Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
--Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
--Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products)
--Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
--Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
--Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
--Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date)



--TASK1
select top(5) * from Employees

--task2
SELECT DISTINCT [Category] FROM Products 

--task3
SELECT * FrOM Products
WHERE Price > 100

--task4
SELECT * FROM Customers
WHERE FirstName LIKE 'A%'

--task5
SELECT * FROM Products
ORDER BY Price --ASC

--task6
SELECT * FROM Employees
WHERE Salary >= 60000 AND DepartmentName = 'HR'

--task7
UPDATE Employees
SET Email = ISNULL(Email, 'noemail@example.com')

--task8
SELECT * FROM Products
WHERE Price BETWEEN 50 AND 100

--task9
SELECT DISTINCT [Category],[ProductName] FROM Products

--task10
SELECT DISTINCT [Category],[ProductName] FROM Products
ORDER BY ProductName DESC

--task11
SELECT TOP(10) * FROM Products
ORDER BY Price DESC

--task12
SELECT COALESCE(FirstName, LastName) FROM Employees 

--task13
SELECT DISTINCT Category, Price FROM Products

--task14
SELECT * FROM Employees
WHERE Age BETWEEN 30 AND 40 OR DepartmentName = 'Marketing'

--task15
SELECT TOP 10 * FROM Employees
ORDER BY Salary DESC OFFSET 10 ROWS 

--task16
SELECT * FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity

--task17
SELECT * FROM Products
WHere ProductName LIKE '%e%'

--task18
SELECT * FROM Employees
WHERE DepartmentName IN ('HR','IT','Finance')


--task19
SELECT * FROM Customers
ORDER BY City, PostalCode DESC

--task20
SELECT TOP(5) * FROM Sales
ORDER BY SaleAmount DESC

--task21
SELECT FirstName + ' ' + LastName AS FullName
FROM Employees

--task22
SELECT DISTINCT Category, ProductName, Price FROM Products
WHERE Price > 50

--task23
SELECT * FROM Products
WHERE Price < 0.1 * (SELECT Avg(Price) FROM Products)

--task24
SELECT * FROM Employees
WHERE Age < 30 AND DepartmentName = 'HR' OR DepartmentName = 'IT'

--task25
SELECT * FROM Employees
WHERE Email LIKE '%@gmail.com'

--task26
SELECT * FROM Employees
WHERE Salary > ALL(SELECT Salary FROM Employees WHERE DepartmentName = 'Sales')

--task27
SELECT * FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180,(SELECT MAX(OrderDate) FROM Orders)) AND (SELECT MAX(OrderDate) FROM Orders)



