--task1

SELECT
	O.OrderId,
	C.FirstName + ' ' + C.LastName AS CustomerName,
	O.OrderDate
FROM Orders AS O
JOIN Customers AS C
	ON O.CustomerID = C.CustomerID AND O.OrderDate > '2022.12.31' 

--task2

SELECT
	E.Name AS EmployeeName,
	D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID AND D.DepartmentName IN ('Sales','Marketing')

--task3

SELECT
	D.DepartmentName,
	MAX(E.Salary) AS MaxSalary
FROM Departments AS D
JOIN Employees AS E
	ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName

--task4

SELECT
	C.FirstName + ' ' + C.LastName AS CustomerName,
	O.OrderId,
	O.OrderDate
FROM Orders AS O
JOIN Customers AS C
	ON O.CustomerID = C.CustomerID AND C.Country = 'USA' AND O.OrderDate BETWEEN '2023.01.01' AND '2023.12.31'

--task5

SELECT
	C.FirstName + ' ' + C.LastName,
	COUNT(O.OrderId) AS TotalOrders
FROM Customers AS C
JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName

--task6

SELECT
	P.ProductName,
	S.SupplierName	
FROM Products AS P
JOIN Suppliers AS S
	ON P.SupplierID = S.SupplierID AND S.SupplierName IN ('Gadget Supplies', 'Clothing Mart')

--task7

SELECT
	C.FirstName + ' ' + C.LastName AS CustomerName,
	MAX(O.OrderDate) AS MostRecentOrderDate
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName

--task8

SELECT
	C.FirstName AS CustomerName,
	O.TotalAmount AS OrderTotal
FROM Customers AS C
JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
WHERE O.TotalAmount > 500

--task9

SELECT
	P.ProductName,
	S.SaleDate,
	S.SaleAmount
FROM Products AS P
JOIN Sales AS S
	ON P.ProductID = S.ProductID AND (S.SaleDate BETWEEN '2022.01.01' AND '2022.12.31' OR S.SaleAmount > 400)

--task10

SELECT
	P.ProductName,
	SUM(S.SaleAmount) AS TotalSalesAmount
FROM Products AS P
JOIN Sales AS S
	ON P.ProductID = S.ProductID
GROUP BY P.ProductName

--task11

SELECT
	E.Name AS EmployeeName,
	D.DepartmentName,
	E.Salary
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID AND D.DepartmentName = 'Human Resources' AND E.Salary > 60000

--task12

SELECT
	P.ProductName,
	S.SaleDate,
	P.StockQuantity
FROM Products AS P
JOIN Sales AS S
	ON P.ProductID = S.ProductID AND S.SaleDate BETWEEN '2023.01.01' AND '2023.12.31' AND P.StockQuantity > 100

--task13

SELECT
	E.Name AS EmployeeName,
	D.DepartmentName,
	E.HireDate
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID AND(D.DepartmentName = 'Sales' OR E.HireDate > '2020.12.31')

--task14

SELECT
	C.FirstName AS CustomerName,
	O.OrderId,
	C.Address,
	O.OrderDate
FROM Customers AS C
JOIN Orders AS O
	ON C.CustomerID = O.CustomerID AND C.Country = 'USA' AND C.Address LIKE '[0-9][0-9][0-9][0-9]%'

--task15

SELECT
	P.ProductName,
	P.Category,
	S.SaleAmount
FROM Products AS P
JOIN Sales AS S
	ON P.ProductID = S.ProductID AND (P.Category = 1 OR S.SaleAmount > 350)

--task16

SELECT
	C.CategoryName,
	COUNT(P.ProductId) ProductCount
FROM Categories AS C
JOIN Products AS P
	ON C.CategoryID = P.Category
GROUP BY C.CategoryName

--task17

SELECT
	C.FirstName AS CustomerName,
	C.City,
	O.OrderId,
	O.TotalAmount
FROM Customers AS C
JOIN Orders AS O
	ON C.CustomerID = O.CustomerID AND C.City = 'Los Angeles' AND O.TotalAmount > 300

--task18

SELECT
	E.Name AS EmployeeName,
	D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID AND ((D.DepartmentName = 'HR' OR D.DepartmentName = 'Finance') OR E.Name LIKE '%[AEUOI]%[AEUOI]%[AEUOI]%[AEUOI]%')

--task19

SELECT
	E.Name AS EmployeeName,
	D.DepartmentName,
	E.Salary
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID AND (D.DepartmentName = 'Sales' OR D.DepartmentName = 'Marketing') AND E.Salary > 60000

	
