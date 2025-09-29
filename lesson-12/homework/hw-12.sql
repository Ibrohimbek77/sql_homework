--puzzle 1
SELECT
	P.FirstName,
	P.LastName,
	A.city,
	A.state 
FROM Person AS P
LEFT JOIN Address AS A
	ON P.personId = A.personId

--puzzle 2

SELECT
	E.Name AS EmployeeName
FROM Employee AS E
WHERE E.Salary > (SELECT Salary from Employee WHERE id = E.ManagerId)



--puzzle 3


SELECT
	MIN(id),
	email
FROM Emails
GROUP BY email
HAVING (COUNT(email)) > 1



--puzzle 4

CREATE TABLE Persons (
    id INT PRIMARY KEY,
    email VARCHAR(50) NOT NULL
);

INSERT INTO Persons(id, email) VALUES
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com'),
(4, 'alice@example.com'),
(5, 'bob@example.com');

select * from Persons

DELETE FROM Persons
WHERE id NOT IN(
	SELECT
		MIN(id)
	FROM Persons
	GROUP BY email)

--puzzle 5

SELECT DISTINCT
	G.ParentName
FROM girls AS G
LEFT JOIN boys AS B
	ON G.ParentName = B.ParentName
WHERE B.ParentName IS NULL


--puzzle 6

SELECT
	SUM(CASE WHEN freight > 50 THEN freight ELSE 0 END) AS TotalFreight,
	MIN(freight)
FROM TSQL2012.Sales.Orders
GROUP BY custid

--puzzle 7

SELECT
	ISNULL(C1.Item,'') AS Item_Cart_1,
	ISNULL(C2.Item,'') AS Item_Cart_2
FROM Cart1 AS C1
FULL JOIN Cart2 AS C2
	ON C1.Item = C2.Item

--puzzle 8

SELECT
	C.name
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.id =O.customerId
WHERE O.customerId IS NULL

--puzzle 9 
SELECT
	ST.Student_name,
	SB.subject_name,
	COUNT(EX.student_id)
FROM Students AS ST
CROSS JOIN Subjects AS SB
LEFT JOIN Examinations AS EX
	ON ST.student_id = EX.student_id AND SB.subject_name = EX.subject_name
GROUP BY ST.student_name, SB.subject_name
