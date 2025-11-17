

CREATE TABLE Dates (
    Id INT,
    Dt DATETIME
);
INSERT INTO Dates VALUES
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');

SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;

CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);

SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS T
GROUP BY rID;

CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');

SELECT 
    Id, 
    Vals
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;

CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);
INSERT INTO TestMaximum VALUES
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);

SELECT 
    ID, 
    Item, 
    Vals
FROM TestMaximum
WHERE (ID, Vals) IN (
    SELECT ID, MAX(Vals)
    FROM TestMaximum
    GROUP BY ID
);

CREATE TABLE SumOfMax (
    DetailedNumber INT,
    Vals INT,
    Id INT
);
INSERT INTO SumOfMax VALUES
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);

SELECT 
    Id,
    SUM(MaxVals) AS SumofMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVals
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS A
GROUP BY Id;

CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

SELECT 
    Id,
    a,
    b,
    CASE 
        WHEN a - b = 0 THEN ''
        ELSE CAST(a - b AS VARCHAR(20))
    END AS OUTPUT
FROM TheZeroPuzzle;


-- 7. Total revenue
SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue FROM Sales;

-- 8. Average unit price
SELECT AVG(UnitPrice) AS AvgUnitPrice FROM Sales;

-- 9. Total transactions
SELECT COUNT(*) AS TotalTransactions FROM Sales;

-- 10. Max quantity in single transaction
SELECT MAX(QuantitySold) AS MaxUnitsSold FROM Sales;

-- 11. Products sold per category
SELECT Category, COUNT(*) AS NumProductsSold
FROM Sales
GROUP BY Category;

-- 12. Total revenue per region
SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;

-- 13. Product generating highest total revenue
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

-- 14. Running total of revenue by date
SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningRevenue
FROM Sales;

-- 15. Category contribution to total sales
SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER () AS PercentageContribution
FROM Sales
GROUP BY Category;

-- 18. Customers with no purchases
SELECT c.*
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.CustomerID IS NULL;

-- 19. Total revenue per customer
SELECT 
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName;

-- 20. Customer with max revenue
SELECT TOP 1 
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

-- 21. Total sales per customer
SELECT 
    c.CustomerName,
    COUNT(*) AS NumSales
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName;


-- 22. Products sold at least once
SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;

-- 23. Most expensive product
SELECT TOP 1 * FROM Products ORDER BY SellingPrice DESC;

-- 24. Products priced above category average
SELECT *
FROM Products p
WHERE p.SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products p2
    WHERE p2.Category = p.Category
);
