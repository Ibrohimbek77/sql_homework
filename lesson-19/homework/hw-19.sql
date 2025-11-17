--task 1

CREATE PROCEDURE task1Procedure
AS 
BEGIN
    CREATE TABLE #EmployeeBonus(EmployeeID INT, FullName VARCHAR(100), Department VARCHAR(50), Salary DECIMAL(10,2), BonusAmount DECIMAL(10,2));
    INSERT INTO #EmployeeBonus 
    SELECT 
        EmployeeID,
        CONCAT(FirstName,LastName),
        DB.Department,
        Salary,
        (Salary * DB.BonusPercentage) / 100
    FROM Employees AS E 
    JOIN DepartmentBonus DB 
        ON E.Department = DB.Department

    SELECT * FROM #EmployeeBonus
END



EXEC task1Procedure




--task 2



CREATE PROCEDURE UpdateSalaries
    @Department VARCHAR(50),
    @UpdatePercentage DECIMAL(10,2)
AS
BEGIN
    UPdATE Employees
    SET Salary += (Salary * (@UpdatePercentage/100))
    WHERE Department = @Department

    SELECT
        Department,
        Salary
    FROM Employees
    WHERE Department = @Department 
END




EXECUTE UpdateSalaries IT, 33.3





--task 3


    MERGE INTO Products_Current AS PC 
    USING Products_New AS PN
        ON PC.ProductID = PN.ProductID

    WHEN MATCHED THEN 
        UPDATE SET PC.ProductName = PN.ProductName, PC.Price = PN.Price

    WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (PN.ProductID, PN.ProductName, PN.Price)

    WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

    
--task 4

SELECT 
    T1.id,
    CASE 
        WHEN SUM(T1.p_id) IS NOT NULL AND SUM(T2.id) IS NOT NULL 
            THEN 'Inner'
        WHEN SUM(T1.p_id) IS NOT NULL 
            THEN 'Leaf'
        WHEN SUM(T2.id) IS NOT NULL
            THEN 'Root'
        ELSE 'Unknown'
        END AS type
FROM Tree AS T1
LEFT JOIN Tree AS T2
    ON T1.id = T2.p_id
GROUP BY T1.id


--task 5

SELECT
    S.user_id,
    IIF(COUNT([action]) = 0 , 0 ,CAST((SUM(IIF([action] = 'Confirmed', 1, 0))) AS DECIMAL(10,2))/ CAST(COUNT([action]) AS DECIMAL(10,2))) AS confirmation_rate
FROM Signups AS S 
LEFT JOIN Confirmations AS C 
    ON S.user_id = C.user_id
GROUP BY S.user_id


--task 6
SELECT *
FROM Employees AS E1
WHERE salary < ALL(
    SElECT salary FROM Employees
    WHERE id != E1.id AND salary != E1.salary
)  



--task 7



CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS 
BEGIN
    SELECT
        ProductName,
        SUM(Quantity) AS [Total Quantity Sold],
        (SUM(Quantity) * Price) AS [Total Sales Amount],
        MIN(SaleDate) AS [First Sale Date],
        MAX(SaleDate) AS [Last Sale Date]
    FROM Products AS P 
    JOIN Sales AS S  
        ON P.ProductID = S.ProductID
    --WHERE P.ProductID = @ProductID
    GROUP BY ProductName, Price
END;





EXECUTE GetProductSalesSummary 1









