

CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');



--task1


SELECT * 
FROM #Sales AS S1
WHERE EXISTS(
    SELECT SaleDate
    FROM #Sales S2
    WHERE SaleDate BETWEEN '2024-03-01' AND '2024-03-31' AND S1.SaleDate = S2.SaleDate
)


--task2

SELECT TOP 1
    Product,
    TotalSales
FROM (
    SELECT 
        Product,
        SUM(Price * Quantity) AS TotalSales
    FROM #Sales
    GROUP BY Product
) AS Revenue
ORDER BY TotalSales DESC

SELECT * FROM #Sales

--task3

SELECT 
    MAX(Price * Quantity) AS TotalSales
FROM #Sales 
WHERE (Price * Quantity) < (
    SELECT 
    MAX(Price * Quantity) AS TotalSales
    FROM #Sales    
)

--task4


SELECT
    DATEPART(YEAR, SaleDate) AS SaleYear,
    DATEPART(MONTH, SaleDate) AS SaleMonth,
    (SELECT
        SUM(Quantity) 
    FROM #Sales AS S1
    WHERE DATEPART(MONTH, S1.SaleDate) = DATEPART(MONTH, S2.SaleDate) AND DATEPART(YEAR, S1.SaleDate) = DATEPART(YEAR, S2.SaleDate)) AS TotalItemsSold
FROM #Sales AS S2
GROUP BY DATEPART(YEAR, SaleDate), DATEPART(MONTH, SaleDate)



--task5

SELECT
    CustomerName,
    Product
FROM #Sales AS S1
WHERE EXISTS(
    SELECT 1
    FROM #Sales AS S2
    WHERE S1.Product = S2.Product AND S1.CustomerName != S2.CustomerName
)
ORDER BY Product


--task6

create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')




SELECT * FROM Fruits

SELECT 
    Name,
    ISNULL(Apple, 0) AS Apple,
    ISNULL(Orange, 0) AS Orange,
    ISNULL(Banana, 0) AS Banana
FROM Fruits
PIVOT(
    COUNT(Fruit) FOR Fruit IN ([Apple], [Orange],[Banana])
)AS pvt 



--task7


create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)

SELECT * FROM Family

SELECT 
    F1.ParentId,
    F1.ChildID,
    F2.ChildID AS ChildId2
FROM Family AS F1
LEFT JOIN Family AS F2
    ON F1.ChildID = F2.ParentId








WITH CTE AS 
(
    SELECT
        ParentId,
        ChildID
    FROM Family
    UNION ALL
    SELECT
        F1.ParentId,
        F2.ChildID
    FROM CTE AS F1
    JOIN Family AS F2
        ON F1.ChildID = F2.ParentId
)
SELECT * FROM CTE
ORDER BY ParentId


--task8

CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

SELECT *
FROM #Orders AS O1
WHERE EXISTS(
    SELECT 1
    FROM #Orders AS O2
    WHERE O1.CustomerID = O2.CustomerID AND O2.DeliveryState LIKE 'CA'
) AND O1.DeliveryState LIKE 'TX'





--task9


create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')


UPDATE #residents
SET address = STUFF(address, CHARINDEX('age', address), 0, CONCAT('name=', fullname, ' '))
WHERE CHARINDEX(fullname, address) = 0

--task10
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);



WITH RoutesFromTashkent AS 
(
    SELECT
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(120)) AS Routes,
        ArrivalCity,
        Cost
    FROM #Routes
    WHERE DepartureCity LIKE 'Tashkent'
    UNION ALL
    SELECT
        CAST(Routes + ' - ' + R2.ArrivalCity AS VARCHAR(120)) AS Routes,
        R2.ArrivalCity,
        R1.Cost + R2.Cost AS Cost
    FROM RoutesFromTashkent AS R1
    JOIN #Routes AS R2
        ON R1.ArrivalCity = R2.DepartureCity
),
RoutesToKhorezm AS 
(
    SELECT *
    FROM RoutesFromTashkent
    WHERE ArrivalCity LIKE 'Khorezm'
)
SELECT 
    Routes,
    Cost
FROM RoutesToKhorezm
WHERE Cost = (SELECT MAX(Cost) FROM RoutesToKhorezm) OR Cost = (SELECT MIN(Cost) FROM RoutesToKhorezm)

 
--task11




SELECT
    ID,
    Vals,
    SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END)
        OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductRank
FROM #RankingPuzzle;


--task12
SELECT 
    EmployeeName,
    Department,
    SalesAmount
FROM #EmployeeSales e
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);

--task13
SELECT DISTINCT e.EmployeeName, e.SalesMonth, e.SalesYear, e.SalesAmount
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales s
    WHERE s.SalesMonth = e.SalesMonth
      AND s.SalesYear = e.SalesYear
    GROUP BY s.SalesMonth, s.SalesYear
    HAVING e.SalesAmount = MAX(s.SalesAmount)
);

--task14
SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth
    FROM #EmployeeSales s
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales x
        WHERE x.EmployeeName = e.EmployeeName
          AND x.SalesMonth = s.SalesMonth
    )
);


--task15
SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT AVG(Price) FROM Products
);

--task16
SELECT Name, Stock
FROM Products
WHERE Stock < (
    SELECT MAX(Stock) FROM Products
);

--task17
SELECT Name, Category
FROM Products
WHERE Category = (
    SELECT Category
    FROM Products
    WHERE Name = 'Laptop'
);


--task18

SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);


--task19
SELECT Name, Category, Price
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);


--task20

SELECT DISTINCT p.Name
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);


--task21

SELECT p.Name, o.Quantity
FROM Orders o
JOIN Products p ON p.ProductID = o.ProductID
WHERE o.Quantity > (
    SELECT AVG(Quantity)
    FROM Orders
);


--task22

SELECT p.Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);


--task23

SELECT TOP 1 
    p.Name,
    SUM(o.Quantity) AS TotalOrdered
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalOrdered DESC;


