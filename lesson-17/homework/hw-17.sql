

--task1

--1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region


SELECT * FROM #RegionSales;

SELECT DISTINCT
    R.Region,
    D.Distributor,
    ISNULL(S.Sales, 0) AS Sales 
FROM #RegionSales AS R 
CROSS JOIN #RegionSales AS D 
LEFT JOIN #RegionSales AS S 
    ON R.Region = S.Region AND D.Distributor = S.Distributor
ORDER BY D.Distributor


2. Find managers with at least five direct reports

SQL Setup:

CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

SELECT * FROM Employee

SELECT M.name
FROM Employee AS M 
JOIN Employee AS E 
    ON M.id = E.managerId
GROUP BY M.id, M.name 
HAVING(COUNT(E.id) > 4)

--task3 

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.


CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

SELECT * FROM Products
SELECT * FROM Orders


SELECT
    product_name,
    SUM(unit) AS unit
FROM Orders AS o
JOIN Products AS P
    ON O.product_id = P.product_id
WHERE order_date BETWEEN '2020-02-01' AND '2020-02-28'
GROUP BY product_name
HAVING(SUM(unit) > 99)
ORDER BY SUM(unit) DESC 


--task4

--4. Write an SQL statement that returns the vendor from which each customer has placed the most orders



SELECT 
    CustomerID,
    Vendor
FROM Orders AS O 
GROUP BY CustomerID, Vendor
HAVING(COUNT(Vendor) > ALL(
    SELECT 
        COUNT(Vendor)
    FROM Orders
    WHERE CustomerID = O.CustomerID AND Vendor != O.Vendor
    GROUP BY CustomerID, Vendor
))
ORDER BY CustomerID


5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

Example Input:

DECLARE @Check_Prime INT = 91;
DECLARE @Num INT = 2;
-- Your WHILE-based SQL logic here

WHILE (@Num < @Check_Prime)
BEGIN
    IF(@Check_Prime = 1)
        BEGIN
            SET @Num = @Check_Prime + 1
        END
    ELSE IF(@Check_Prime % @Num = 0)
    BEGIN
        SET @Num = @Check_Prime + 1
    END
    
    SET @Num += 1
END

SELECT (IIF(@Check_Prime = @Num, 'This is a Prime number', 'This is not a Prime number')) AS [Statement]



--task6

--6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');



SELECT
    D_id.Device_id,
    N.num_of_locations,
    L.max_signal_location,
    S.no_of_Signals
FROM 
(
    SELECT DISTINCT
        Device_id
    FROM Device
) AS D_id 
JOIN
(
SELECT 
    Device_id,
    Locations AS max_signal_location,
    COUNT(Locations) AS numsvisited
FROM Device
GROUP BY Device_id, Locations
) AS L 
    ON D_id.Device_id = L.Device_id AND L.numsvisited = (SELECT MAX(num) FROM (SELECT COUNT(Locations) as num FROM Device WHERE Device_id = L.Device_id GROUP BY Device_id, Locations) AS temp)
JOIN 
(
    SELECT
        Device_id,
        COUNT(Locations) AS no_of_Signals
    FROM Device 
    GROUP BY Device_id
) AS S 
    ON D_id.Device_id = S.Device_id
JOIN
(
    SELECT
        Device_id,
        COUNT(Locations) AS num_of_locations
    FROM (
        SELECT DISTINCT
            Device_id,
            Locations
        FROM Device
    ) as temp 
    GROUP BY Device_id
) as N 
    ON D_id.Device_id = N.Device_id



--task7


SELECT 
    EmpID,
    EmpName,
    Salary
FROM Employee AS E 
WHERE Salary > (SELECT AVG(salary) FROM Employee WHERE DeptID = E.DeptID) 


--task8


SELECT * FROM Numbers 
SELECT * FROM Tickets




WITH NumWithID AS
(
    SELECT 
        Number, 
        ROW_NUMBER() OVER(ORDER BY Number) AS NumID 
        FROM Numbers
),
GuessedNums AS 
(
SELECT
    T.TicketID,
    T.Number AS Number1,
    N.number AS Number2,
    NumID
FROM Tickets AS T 
LEFT JOIN 
NumWithID AS N
    ON T.Number = N.Number
),
CTE AS
(
    SELECT 
    TicketID,
    SUM(NumID) AS Sum,
    CASE WHEN SUM(NumID) = (SELECT SUM(NumID) FROM NumWithID)  THEN 100
         WHEN SUM(NumID) IS NULL OR SUM(NumID) = 0 THEN 0
         ELSE 10
         END AS MoneyWon
FROM
GuessedNums
GROUP BY TicketID
)
SELECT SUM(MoneyWon) AS MoneyWon FROM CTE 

--task9


WITH DiffPlatforms AS 
(
    SELECT 
        Spend_date,
        Platform,
        SUM(Amount) AS TotalAmount,
        COUNT(User_id) AS TotalUsers
    FROM Spending
    GROUP BY Spend_date, Platform
),
CrossPlatform AS
(
    SELECT
        Spend_date,
        'Both' AS Platform,
        SUM(Amount) AS TotalAmount,
        COUNT(DISTINCT User_id) AS TotalUsers
    FROM Spending
    GROUP BY Spend_date
)
SELECT  *
FROM DiffPlatforms AS D 
UNION ALL
SELECT *
FROM CrossPlatform
ORDER BY Spend_date ASC, Platform DESC


--task10



WITH CTE AS 
(
    SELECT 
        Product,
        Quantity,
        1 AS CountNum
    FROM Grouped
    UNION ALL
    SELECT
        Product,
        Quantity,
        CountNum + 1
    FROM CTE
    WHERE CountNum < Quantity
)
SELECT 
    Product,
    1 AS Quantity
FROM CTE
ORDER BY Product


SELECT * FROM Grouped





create table t (i int, b VARCHAR(20));

insert into t VALUES(1,'a'),(2,'b'),(3,'c');
