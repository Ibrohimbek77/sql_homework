

























--task1
--Using Products, Suppliers table List all combinations of product names and supplier names.

SELECT Products.ProductName, Suppliers.SupplierName FROM Products CROSS JOIN Suppliers
ORDER BY Suppliers.SupplierName 

--task2
--Using Departments, Employees table Get all combinations of departments and employees.

SELECT Departments.DepartmentName, Employees.Name FROM Departments CROSS JOIN Employees
ORDER BY Departments.DepartmentName

--task3
--Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name

SELECT 
	Suppliers.SupplierName,
	Products.ProductName
FROM Suppliers 
JOIN Products
ON Suppliers.SupplierID = Products.SupplierID
ORDER BY Suppliers.SupplierName


--second solution
SELECT 
	Suppliers.SupplierName,
	Products.ProductName
FROM Suppliers 
CROSS JOIN Products
WHERE Suppliers.SupplierID = Products.SupplierID
ORDER BY Suppliers.SupplierName

--task4
--Using Orders, Customers table List customer names and their orders ID.

SELECT Customers.FirstName + ' ' + Customers.LastName, 
	   Orders.OrderID
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID


--second solution
SELECT Customers.FirstName + ' ' + Customers.LastName, 
	   Orders.OrderID
FROM Customers
CROSS JOIN Orders
WHERE Customers.CustomerID = Orders.CustomerID

--task5
--Using Courses, Students table Get all combinations of students and courses.

SELECT 
	Courses.CourseName, 
	Students.Name 
FROM Courses
CROSS JOIN Students
ORDER BY Courses.CourseName

--task6
--Using Products, Orders table Get product names and orders where product IDs match.

SELECT 
	Products.ProductName,
	Orders.OrderID
FROM Products
JOIN Orders
ON Products.ProductID = Orders.ProductID
ORDER BY Products.ProductName

--second solution
SELECT 
	Products.ProductName,
	Orders.OrderID
FROM Products
CROSS JOIN Orders
WHERE Products.ProductID = Orders.ProductID
ORDER BY Products.ProductName

--task7
--Using Departments, Employees table List employees whose DepartmentID matches the department.


SELECT 
	Employees.Name,
	Departments.DepartmentName
FROM Employees
JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID
ORDER BY Employees.Name


--second solution
SELECT 
	Employees.Name,
	Departments.DepartmentName
FROM Employees
CROSS JOIN Departments
WHERE Employees.DepartmentID = Departments.DepartmentID
ORDER BY Employees.Name

--task8
--Using Students, Enrollments table List student names and their enrolled course IDs.

SELECT 
	Students.Name,
	Enrollments.CourseID
FROM Students
JOIN Enrollments
ON Students.StudentID = Enrollments.StudentID
ORDER BY Enrollments.CourseID


--second solution
SELECT 
	Students.Name,
	Enrollments.CourseID
FROM Students
CROSS JOIN Enrollments
WHERE Students.StudentID = Enrollments.StudentID
ORDER BY Enrollments.CourseID

--task9
--Using Payments, Orders table List all orders that have matching payments.

SELECT
	Orders.OrderID,
	Payments.PaymentID
FROM Orders
CROSS JOIN Payments
WHERE ORDERS.OrderID = Payments.OrderID

--task10
--Using Orders, Products table Show orders where product price is more than 100.

SELECT 
	Orders.OrderID,
	Products.ProductID,
	Products.Price
FROM Orders
CROSS JOIN Products
WHERE Orders.ProductID = Products.ProductID AND Products.Price < 100

--task11
--Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.

SELECT 
	Employees.Name,
	Departments.DepartmentName
FROM Employees
CROSS JOIN Departments
WHERE Employees.DepartmentID != Departments.DepartmentID
ORDER BY Employees.Name

--task12
--Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.

SELECT 
	Orders.OrderID,
	Products.ProductName,
	Orders.Quantity,
	Products.StockQuantity
FROM Orders
CROSS JOIN Products
WHERE Orders.Quantity > Products.StockQuantity AND Orders.ProductID = Products.ProductID
ORDER BY Products.ProductName

--task13
--Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.

SELECT
	Customers.FirstName,
	Sales.ProductID,
	Sales.SaleAmount
FROM Customers
CROSS JOIN Sales
WHERE Sales.SaleAmount > 500 AND Customers.CustomerID = Sales.CustomerID

--task14
--Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.

SELECT 
	Students.Name,
	Courses.CourseName
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
ORDER BY Students.Name

--task15
--Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.

SELECT 
	Products.ProductName,
	Suppliers.SupplierName
FROM Products
CROSS JOIN Suppliers
WHERE Products.SupplierID = Suppliers.SupplierID AND Suppliers.SupplierName LIKE '%Tech%'
ORDER BY Suppliers.SupplierName

--task16
--Using Orders, Payments table Show orders where payment amount is less than total amount.

SELECT
	Orders.OrderID,
	Payments.PaymentID,
	Orders.TotalAmount,
	Payments.Amount
FROM Orders
JOIN Payments 
ON Orders.OrderID = Payments.OrderID
WHERE Orders.TotalAmount > Payments.Amount
	
--task17
--Using Employees and Departments tables, get the Department Name for each employee.

SELECT 
	Employees.Name,
	Departments.DepartmentName
FROM Employees
JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID
ORDER BY Employees.Name

--task18
--Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.

SELECT 
	a.ProductName,
	b.CategoryName
FROM Products AS a
JOIN Categories AS b
ON a.Category = b.CategoryID
WHERE b.CategoryName = 'Electronics' OR b.CategoryName = 'Furniture'
ORDER BY b.CategoryName

--task19
--Using Sales, Customers table Show all sales from customers who are from 'USA'.

SELECT 
	Customers.Country,
	Customers.CustomerID,
	Sales.SaleID
FROM Customers
JOIN Sales
ON Customers.CustomerID = Sales.CustomerID
WHERE Customers.Country = 'USA'
ORDER BY Customers.CustomerID

--task20
--Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.

SELECT 
	Customers.CustomerID,
	Orders.OrderID,
	Customers.Country,
	Orders.TotalAmount
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.TotalAmount > 100 AND Customers.Country = 'Germany'

--task21
--Using Employees table List all pairs of employees from different departments.

SELECT
	a.Name AS FirstEmployee,
	a.DepartmentID AS FirstEmployeeDepartment,
	b.Name AS SecondEmployee,
	b.DepartmentID AS SecondEmployeeDepartment
FROM Employees AS a
JOIN Employees AS b
ON a.DepartmentID != b.DepartmentID
ORDER BY FirstEmployee 

--task22
--Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).

SELECT
	Payments.Amount,
	Products.Price * Orders.Quantity AS NeedToPay,
	Payments.PaymentID
FROM Payments
JOIN Orders ON Payments.OrderID = Orders.OrderID
JOIN Products ON Orders.ProductID = Products.ProductID
WHERE Orders.Quantity * Products.Price != Payments.Amount

--task23
--Using Students, Enrollments, Courses table Find students who are not enrolled in any course.

SELECT 
	Students.StudentID,
	Students.Name,
	Courses.CourseID,
	Courses.CourseName
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Courses.CourseID = Enrollments.CourseID


SELECT Name from Students
EXCEPT
SELECT 
	Students.Name
FROM Students JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Courses.CourseID = Enrollments.CourseID


SELECT * FROM Students
SELECT * FROM Enrollments
SELECT * FROM Courses

--task24
--Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.

SELECT * FROM Employees

SELECT 
	A.Name,
	A.EmployeeID,
	A.Salary
FROM Employees AS A
WHERE A.EmployeeID = ANY(SELECT ManagerID FROM Employees) AND A.Salary <= ALL( SELECT Salary FROM Employees WHERE ManagerID = A.EmployeeID)

--task25
--Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.

SELECT * FROM Payments
SELECT * FROM Orders
SELECT * FROM Customers


SELECT 
	Orders.OrderID
FROM Orders
WHERE Orders.CustomerID = ANY(SELECT Customers.CustomerID FROM CUstomers) AND Orders.OrderID != ALL(SELECT Payments.OrderID FROM Payments)

