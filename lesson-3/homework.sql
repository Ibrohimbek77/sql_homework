CREATE DATABASE HOMEWORK3;
GO
USE HOMEWORK3

--TASK1
--BULK INSERT [TABLE_NAME]
--FROM(FILE_PATH)
--WITH(
--	FIELDTERMINATOR = 'DEFINE'
--	ROWTERMINATOR = 'DEFINE'
--	FIRSTROW = DEFINE
--)
--USED TO INSERT DATA INTO TABLES FROM files 

--TASK2
--txt, csv, dat, log

--TASK3
--Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2))
CREATE TABLE Products(ProductId INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))

--TASK4
INSERT INTO Products(ProductId, ProductName, Price) 
VALUES (1,'Water',1.99),
(2,'Soap',5.99),
(3,'Cake',35.99)

--TASK5
--NULL means a value can be empty -> point to nothing
--NOT NULL means value must be present -> initialized when creating an instance

--TASK6
ALTER TABLE Products
ADD CONSTRAINT UQ_Products_ProductName UNIQUE(ProductName)

--TASK7
--UNIQUE forses the devloper to add a unique name to each product on the table -> gives error otherwise -> it is unlikely it is a real error more of a warning type stuff

--TASK8
ALTER TABLE Products
ADD CategoryID INT

--TASK9
CREATE TABLE Categories(CategoryId INT PRIMARY KEY, CategoryName VARCHAR(50) UNIQUE)

--TASK10
--IDENTITY is a sequence of increneting numbers when each new instance of a raw is filled with that values incremented by a seed -> use for primary keys or auto Id generation
--nume INT IDENTITY(seed, increment_value) -> can not insert value manually

--TASK11
BULK INSERT Products
FROM 'C:\Users\user\Documents\SQL Server Management Studio\some_random_text.txt'
WITH (
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 1
)

--TASK12
INSERT INTO Categories(CategoryId, CategoryName) VALUES
(3415,'Drink'),
(1341,'Food'),
(2365,'BuildMaterial')

ALTER TABLE Products
ADD CONSTRAINT FK_Products_CategoryID FOREIGN KEY(CategoryID) references Categories(CategoryId)



SELECT * FROM Products b
join Categories a on b.CategoryId = a.CategoryID

--TASK13
-- Both primary key and unique forcess the developer to insert unique values but primsry key is used in combination with foreign key to interconnect tables and create a tree system

--TASK14

ALTER TABLE Products
ADD CONSTRAINT CK_Products_Price CHECK(Price > 0)

--TASK15

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0

--TASK16

INSERT INTO Products 
SELECT 7, 'Concrete', NULL, 2365, 143

UPDATE Products
SET Price = ISNULL(Price, 1)

--TASK17
--Foreign key can have as many duplucates as neede -> used to refer to primary key -> foreign key allows grouping of elemets

--TASK18
CREATE TABLE Customers(FristName VARCHAR(50), LastName VARCHAR(50), Age INT CHECK(Age >=18), Orders VARCHAR(80))

--TASK19

CREATE TABLE IDENTITY_CHECK(BasicId INT IDENTITY(100, 10))

--TASK20 

CREATE TABLE OrderDetails(OrderId INT, ProductId INT, OrderTime DATE, OrderState VARCHAR(25), PRIMARY KEY(OrderId, ProductId))

--TASK21
--COALESCE - used to chnage multiple null values into something else
--ISNULL - works only with one value

--TASk22
CREATE TABLE Employees(EmpId INT PRIMARY KEY, Email VARCHAR(50) UNIQUE)

--TASK23
CREATE TABLE Rooms(EmpId INT,CONSTRAINT FK_Rooms_EmpId FOREIGN KEY(EmpId) REFERENCES Employees(EmpId) ON DELETE CASCADE ON UPDATE CASCADE) 









