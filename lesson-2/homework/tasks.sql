CREATE DATABASE HOMEWORK2
USE HOMEWORK2

--Basic-Level Tasks (10)
--TASK1
CREATE TABLE Employees(EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))

--TASK2
INSERT INTO Employees(Name, EmpID, Salary) Values ('PANDA', 1, 45.6)

INSERT INTO Employees(Name, EmpID, Salary) Values ('Kuritsa', 2, 45.6), ('Loshadka', 3, 89.0) 

SELECT * FROM Employees

--TASK3
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1
SELECT * FROM Employees

--TASK4
DELETE FROM Employees
WHERE EmpID = 2
SELECT * FROM Employees

--TASK5
--DELETE - removes certain part of a table like rows
--TRUNCATE - completely cleans up the whole of the table without deleting the talbe itself
--DROP - completely removes the table or a column from the server

--TASK6
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100)
SELECT * FROM Employees

--TASK7
ALTER TABLE Employees
ADD Department VARCHAR(50)
SELECT * FROM Employees

--TASK8
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT
SELECT * FROM Employees

--TASK9
CREATE TABLE Departments 
( DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50) )
SELECT * FROM Departments

--TASK10
TRUNCATE TABLE Employees
SELECT * FROM Employees

--Intermediate-Level Tasks (6)
--TASK11

INSERT INTO Departments(DepartmentID, DepartmentName)
SELECT 341238670, 'HeavyGunProductions' UNION ALL
SELECT 341238671, 'HeavyMachineProductions' UNION ALL
SELECT 341238672, 'NuclearEnergyHarvest' UNION ALL
SELECT 341238673, 'RadarDetectionSecurity' UNION ALL
SELECT 341238675, 'CommandCenter' UNION ALL

SELECT * FROM Departments

--TASK12
INSERT INTO Employees(EmpID,Name,Salary,Department)
VALUES (1, 'Huston', 5470, 'Logistics'),
(2, 'Alex', 6700, 'HeavyArms'),
(3, 'Michael', 3200, 'FoodProduction'),
(4, 'Williams', 1700, 'CleaningStaff'),
(5, 'Abraham', 8900, 'CoreEngineMaintenance' ),
(6, 'Hommy', 2500, 'Orphanage')

UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000
SELECT * FROM Employees

--TASK13
--WHAT?
TRUNCATE TABLE Employees
SELECT * FROM Employees

--TASK14
ALTER TABLE Employees
DROP COLUMN Department

--TASK15
EXEC sp_rename 'HOMEWORK2.dbo.Employees','StaffMembers'
SELECT * FROM StaffMembers

--TASK16
DROP TABLE Departments

--Advanced-Level Tasks (9)
--TASK17&&18

CREATE TABLE Products
(ProductID INT PRIMARY KEY, 
ProductName VARCHAR(80), 
Category VARCHAR(80), 
Price DECIMAL(10,2) CHECK (Price > 0), 
ExpiratiobDate VARCHAR(10))

--TASK19
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50
SELECT * FROM Products

--TASK20
EXEC sp_rename 'Products.Category','ProductCategory','COLUMN'

--TASK21
INSERT INTO Products(ProductID,ProductName,ProductCategory,Price,StockQuantity,ExpiratiobDate)
VALUES (32451, 'Shampoo', 'washing', 17, 221, 'NONE'),
(63451, 'Vacuum Cleaner', 'HouseHold', 320, 76, 'NONE'),
(11234, 'Apple', 'Food', 3, 5000, '05.09.2025'),
(11674, 'Sink', 'Furniture', 117, 50, 'NONOE'),
(11252, 'Juice', 'Food', 7, 3200, '07.09.2025')

SELECT * FROM Products

--TASK22
SELECT * INTO Products_Backup
FROM Products

SELECT * FROM Products_Backup

--TASK23
EXEC sp_rename 'HOMEWORK2.dbo.Products','Inventory' 

SELECT * FROM Inventory

--TASK24
ALTER TABLE Inventory
DROP CONSTRAINT CK__Products__Price__3A81B327

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT 

ALTER TABLE Inventory
WITH NOCHECK
ADD CONSTRAINT Inventory_Price CHECK (Price > 0)

--TASK25

ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5)

SELECT * FROM Inventory

--ALTER TABLE Inventory
--ADD CONSTRAINT PK_Inventory_Price PRIMARY KEY(ProductCode)




