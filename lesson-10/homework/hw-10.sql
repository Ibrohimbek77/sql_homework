--task1

SELECT
	Name AS EmployeeName,
	Salary,
	DepartmentName
FROM Employees AS E
JOIN Departments AS D ON E.DepartmentID = D.DepartmentID 

--task2

SELECT
	FirstName,
	LastName,
	OrderDate
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
WHERE O.OrderDate BETWEEN '2023.01.01' AND '2023.12.31'

--task3

SELECT
	NAME AS EmployeeName,
	DepartmentName
FROM Employees AS E
LEFT JOIN Departments AS D ON E.DepartmentID = D.DepartmentID 

--task4

SELECT
	SupplierName,
	ProductName
FROM Suppliers AS S
LEFT JOIN Products AS P ON S.SupplierID = P.SupplierID

--task5

SELECT
	O.OrderID,
	OrderDate,
	PaymentDate,
	Amount
FROM Orders AS O
FULL JOIN Payments AS P
ON O.OrderID = P.OrderID

--task6

SELECT
	E.Name AS EmployeeName,
	M.NAME AS EmployeeName
FROM Employees AS E
JOIN Employees AS M
	ON E.ManagerID = M.EmployeeID

--task7

SELECT
	Name AS StudentName,
	CourseName
FROM Students AS S
JOIN Enrollments AS E 
	ON S.StudentID = E.StudentID
JOIN Courses AS C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Math 101'

--task8

SELECT
	C.FirstName,
	C.LastName,
	SUM(Quantity) AS Quantity
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName,C.CustomerID
HAVING(SUM(Quantity)) > 3

--task9

SELECT
	E.Name AS EployeeName,
	D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources'

--task11

SELECT
	D.DepartmentName,
	COUNT(EmployeeID) AS EmployeeCount
FROM Departments AS D
JOIN Employees AS E 
	ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentID,DepartmentName
HAVING(COUNT(EmployeeID)) > 5

--task12

SELECT
	P.ProductID,
	P.ProductName
FROM Products AS P
LEFT JOIN Sales AS S
	ON P.ProductID = S.ProductID
WHERE S.ProductID IS NULL

--task12

SELECT
	C.FirstNAme,
	C.LastName,
	COUNT(OrderID) TotalOrders
FROM Customers AS C
JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName, C.CustomerID

--task13

SELECT
	E.Name AS EmployeeName,
	D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID

--task14

SELECT DISTINCT
	CASE WHEN E1.Name < E2.Name THEN E1.Name ELSE E2.Name END AS Employee1,
    CASE WHEN E1.Name < E2.Name THEN E2.Name ELSE E1.Name END AS Employee2,
	M.Name AS ManagerID
FROM Employees AS E1
JOIN Employees AS E2 
	ON E1.ManagerID = E2.ManagerID AND E1.EmployeeID != E2.EmployeeID
JOIN Employees AS M 
	ON E2.ManagerID = M.EmployeeID

--task15

SELECT
	O.OrderID,
	O.OrderDate,
	C.FirstName,
	C.LastName
FROM Orders AS O
JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
WHERE O.OrderDate BETWEEN '2022.01.01' AND '2022.12.31'

--task16

SELECT
	E.Name,
	E.Salary,
	D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales' AND E.Salary > 60000

--task17

SELECT 
	O.OrderID,
	O.OrderDate,
	P.PaymentDate,
	P.Amount
FROM Orders AS O
JOIN Payments AS P
	ON O.OrderID = P.OrderID

--task18

SELECT
	P.ProductID,
	P.ProductName
FROM Products AS P
LEFT JOIN Orders AS O
	ON P.ProductID = O.ProductID
WHERE O.OrderID IS NULL

--task19

SELECT
	Name AS EmployeeName,
	Salary
FROM Employees AS E
WHERE Salary > (SELECT AVG(SALARY) FROM Employees WHERE DepartmentID = E.DepartmentID)

--task20

SELECT
	O.OrderID,
	O.OrderDate
FROM Orders AS O
LEFT JOIN Payments AS P
	ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL AND O.OrderDate < '2020.01.01'

--task21

SELECT
	P.ProductID,
	P.ProductName
FROM Products AS P
LEFT JOIN Categories AS C
	ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL

--task22

--task23

SELECT
	E.Name AS EmployeeName,
	D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
	ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%'

--task24

SELECT
	S.SaleID,
	P.ProductName,
	S.SaleAmount
FROM Sales AS S
JOIN Products AS P
	ON S.ProductID = P.ProductID
WHERE S.SaleAmount > 500

--task25

SELECT
	S.StudentID,
	S.Name AS StudetnName
FROM Students AS S
LEFT JOIN Enrollments AS E
	ON S.StudentID = E.StudentID
LEFT JOIN Courses AS C
	ON E.CourseID = C.CourseID AND C.CourseName = 'Math 101'
WHERE C.CourseID IS NULL

--task26

SELECT
	O.OrderID,
	O.OrderDate,
	P.PaymentID
FROM Orders AS O
LEFT JOIN Payments AS P
	ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL

--task27

SELECT
	P.ProductID,
	P.ProductName,
	C.CategoryName
FROM Products AS P
JOIN Categories AS C
	ON P.Category = C.CategoryID AND (C.CategoryName = 'Electronics' OR C.CategoryName = 'Furniture')





