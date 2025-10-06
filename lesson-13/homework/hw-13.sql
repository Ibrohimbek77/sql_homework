--PUZZLE 1
SELECT
	CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, LAST_NAME)
FROM Employees

--PUZZLE 2

UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, 124, 999)

--PUZZLE 3

SELECT
	FIRST_NAME AS FirstName,
	LEN(FIRST_NAME) AS NameLength
FROM Employees
WHERE FIRST_NAME LIKE '[AJM]%'
ORDER BY FIRST_NAME


--PUZZLE 4
SELECT
	SUM(Salary) TotalSalaryPerM_id
FROM Employees
GROUP BY MANAGER_ID

--PUZZLE 5

SELECT
	Year1,
	CASE WHEN Max1 > Max2 AND Max1 > Max3 THEN Max1
		 WHEN Max2 > Max3 THEN Max2
		 ELSE Max3
		 END AS MaxOfAll
FROM TestMax

--PUZZLE 6

SELECT * FROM cinema

-- id % 2 == 1 odd AND description != boring
SELECT *
FROM cinema
WHERE id % 2 = 1 AND description != 'boring'

--PUZZLE 7
SELECT * FROM SingleOrder
ORDER BY Id DESC

--PUZZLE 8
SELECT
	COALESCE(ssn, passportid, itin,NULL)
FROM person

SELECT * FROM person

--Mediumm Level
--PUZZLE 1

SELECT 
	LEFT(FULLNAME,CHARINDEX(' ', FULLNAME) - 1  ) AS FirstName,
	SUBSTRING(FULLNAME, CHARINDEX(' ' , FULLNAME) + 1, CHARINDEX(' ', FULLNAME, CHARINDEX(' ', FULLNAME) + 1) - CHARINDEX(' ', FULLNAME) - 1 ) AS MiddleName,
	RIGHT(FULLNAME,LEN(FULLNAME) - CHARINDEX(' ', FULLNAME, CHARINDEX(' ', FULLNAME) + 1)  ) AS LastName
FROM Students


--PUZZLE 2

SELECT *
FROM Orders
WHERE DeliveryState = 'CA'

--PUZZLE 3

--first solution
SELECT STRING_AGG(String, ' ')
	WITHIN GROUP(ORDER BY SequenceNumber) AS ConcatenatedString
FROM DMLTable

--second solution
SELECT 
	CONCAT_WS(' ', (SELECT String FROM DMLTable WHERE SequenceNumber = 1 ), (SELECT String FROM DMLTable WHERE SequenceNumber = 2 ), (SELECT String FROM DMLTable WHERE SequenceNumber = 3 ),
	(SELECT String FROM DMLTable WHERE SequenceNumber = 4 ), (SELECT String FROM DMLTable WHERE SequenceNumber = 5 ), (SELECT String FROM DMLTable WHERE SequenceNumber = 6 ), (SELECT String FROM DMLTable WHERE SequenceNumber = 7 ), 
	(SELECT String FROM DMLTable WHERE SequenceNumber = 8 ), (SELECT String FROM DMLTable WHERE SequenceNumber = 9 ))


--PUZZLE 4

SELECT *
FROM Employees
WHERE CONCAT(FIRST_NAME, LAST_NAME) LIKE '%a%a%a%'

--PUZZLE 5

SELECT
	COUNT(EMPLOYEE_ID) AS TotalNumberOfWorkers,
	(SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) >= 3 THEN 1 ELSE 0 END )/COUNT(HIRE_DATE) * 100) AS WorkedMoreThanThreeYears
FROM Employees
GROUP BY DEPARTMENT_ID

--Hard level PUZZLES
--PUZZLE 1

SELECT
	S1.Grade + CASE WHEN S2.Grade IS NOT NULL THEN S2.Grade ELSE 0 END AS SumOfValues
FROM Students AS S1
LEFT JOIN Students AS S2
	ON S1.StudentID = S2.StudentID + 1

--PUZZLE 2

SELECT DISTINCT
	CASE WHEN S1.StudentName > S2.StudentName THEN S1.StudentName ELSE S2.StudentName END Student1,
	CASE WHEN S2.StudentName > S1.StudentName THEN S1.StudentName ELSE S2.StudentName END AS Student2
FROM Student AS S1
JOIN Student AS S2
	ON S1.Birthday = S2.Birthday AND S1.StudentName != S2.StudentName

--PUZZLE 3

select * from PlayerScores

SELECT
	CASE WHEN PlayerA > PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
	CASE WHEN PlayerB > PlayerA THEN PlayerA ELSE PlayerB END AS Player2,
	SUM(Score)
FROM PlayerScores
GROUP BY 
	CASE WHEN PlayerA > PlayerB THEN PlayerA ELSE PlayerB END,
	CASE WHEN PlayerB > PlayerA THEN PlayerA ELSE PlayerB END
--PUZZLE 4

SELECT 'tf56sd#%OqH'


--uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.

DECLARE @UpperCase VARCHAR(50) = '', @LowerCase VARCHAR(50) = '', @Numbers VARCHAR(50) = '', @Symbols VARCHAR(50) = ''
DECLARE @Text VARCHAR (100) = 'tf56sd#%OqH'
DECLARE @Size INT = LEN(@Text), @CurrentINDEX INT = 0

WHILE (@CurrentINDEX < @Size)
BEGIN
	IF ( ASCII(SUBSTRING(@Text, @CurrentINDEX + 1, 1)) BETWEEN 65 AND 90 )
	BEGIN			
		SET @UpperCase += (SUBSTRING(@Text, @CurrentINDEX + 1, 1))
	END

	ELSE IF ( ASCII(SUBSTRING(@Text, @CurrentINDEX + 1, 1)) BETWEEN 97 AND 122)
	BEGIN
		SET @LowerCase += (SUBSTRING(@Text, @CurrentINDEX + 1, 1)) 
	END

	ELSE IF ( ASCII(SUBSTRING(@Text, @CurrentINDEX + 1, 1)) BETWEEN 48 AND 57)
	BEGIN
		SET @Numbers += (SUBSTRING(@Text, @CurrentINDEX + 1, 1))
	END

	ELSE 
	BEGIN
		SET @Symbols += (SUBSTRING(@Text, @CurrentINDEX + 1, 1))
	END

	SET @CurrentIndex += 1;
END
		
SELECT @UpperCase AS UpperCase, 
	   @LowerCase AS LowerCase, 
	   @Numbers AS Numbers, 
	   @Symbols AS Symbols	







