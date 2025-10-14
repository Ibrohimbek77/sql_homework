
--Easy tasks
--task1

SELECT
	LEFT(Name, CHARINDEX(',', Name, 1) - 1) AS Name,
	RIGHT(Name,LEN(Name) - CHARINDEX(',', Name, 1) ) AS Surname
FROM TestMultipleColumns	

--task2

SELECT * 
FROM TestPercent
WHERE Strs LIKE '^%' ESCAPE '^'

 --second solution
SELECT *
FROM TestPercent
WHERE Strs LIKE '[%]'

--task3

SELECT
	S.id,
	split.value
FROM Splitter AS S
CROSS APPLY string_split(S.Vals, '.') AS split


--task4


SELECT * 
FROM testDots
WHERE PATINDEX('%.%.%.%', Vals) > 0

--task5



SELECT *,
	(LEN(texts) - LEN(REPLACE(texts, ' ', ''))) AS SpacesNum
FROM CountSpaces


--task6


SELECT * FROM Employees

SELECT E.*,
	   M.SALARY AS ManagerSalary
FROM Employees AS E
JOIN Employees AS M 
	ON E.MANAGER_ID = M.EMPLOYEE_ID
WHERE E.SALARY > M.SALARY

--task7

SELECT 
	EMPLOYEE_ID,
	FIRST_NAME,
	LAST_NAME,
	HIRE_DATE,
	DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 14


--Medium Tasks
--task1


SELECT * FROM weather

SELECT
	TheDay.Id
FROM weather AS theDay
JOIN weather thePreviousDay 
	ON DATEDIFF(DAY,thePreviousDay.RecordDate, theDay.RecordDate) = 1 AND theDay.Temperature > thePreviousDay.Temperature

--task2



SELECT
	player_id,
	MIN(event_date) AS fisrtLogin
FROM Activity
GROUP BY player_id


--task3



SELECT 
    SUBSTRING(
        fruit_list,
        CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1,
        ISNULL(CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1), LEN(fruit_list) + 1)
            - CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) - 1
    ) AS ThirdItem
FROM fruits;

--task4

SELECT
    EMPLOYEE_ID,
    IIF(DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1, 'New Hire',
        IIF(DATEDIFF(YEAR, HIRE_DATE, GETDATE()) >= 1 AND DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 5, 'Junior',
            IIF(DATEDIFF(YEAR, HIRE_DATE, GETDATE()) >= 5 AND DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 10, 'Mid-Level',
                IIF(DATEDIFF(YEAR, HIRE_DATE, GETDATE()) >= 10 AND DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 20, 'Senior',
                    IIF(DATEDIFF(YEAR, HIRE_DATE, GETDATE()) >= 20, 'Veteran', 'Unidentified')))))
    AS EmploymentStage
FROM Employees;




--task5



SELECT
	id,	
	SUBSTRING(Vals, 1 , IIF (PATINDEX('%[^0-9]%', Vals + 'a') - 1 > 0, PATINDEX('%[^0-9]%', Vals + 'a') - 1, NULL ) ) AS Numbers,
	LEN(SUBSTRING(Vals, 1 ,PATINDEX('%[^0-9]%', Vals + 'a') - 1 ))
FROM GetIntegers


--Difficult Tasks
--task1


--so i want you to provide a cleaner and a better more optimal soultion

SELECT 
	CONCAT(
		IIF(PATINDEX('%[A-Z],[A-Z]%', Vals) > 1, SUBSTRING(Vals, 1, PATINDEX('%[A-Z],[A-Z]%', Vals) - 1), NULL),
		SUBSTRING(Vals,PATINDEX('%[A-Z],[A-Z]%', Vals) + 2, 1),
		',', 
		SUBSTRING(Vals,PATINDEX('%[A-Z],[A-Z]%', Vals), 1), 
		IIF(
			LEN(VALS) > PATINDEX('%[A-Z],[A-Z]%', Vals) + 2,
			SUBSTRING(
				Vals, 
				PATINDEX('%[A-Z],[A-Z]%', Vals) + 3,
				LEN(Vals) - PATINDEX('%[A-Z],[A-Z]%', Vals) + 2), 
			NULL)
	)
FROM MultipleVals

--task2


CREATE TABLE Characters(Character VARCHAR(1))

DECLARE @index1 INT = 0
DECLARE @character VARCHAR(1)
DECLARE @text1 VARCHAR(80) = 'sdgfhsdgfhs@121313131'

WHILE (@index1 < LEN(@text1))
BEGIN
	SET @character = SUBSTRING(@text1, @index1 + 1, 1)
	INSERT INTO Characters VALUES(@character)
	
	SET @index1 += 1
END

SELECT * FROM Characters

--task3


SELECT
	player_id,
	device_id
FROM Activity as A1
WHERE event_date = (SELECT  MIN(event_date) FROM Activity AS A2 WHERE A1.player_id = A2.player_id group by player_id)




select device_id , 1 from Activity

select device_id, MIN(event_date) from Activity


--task4


DECLARE @integers VARCHAR(50) = '', @characters VARCHAR(50) = ''
DECLARE @index2 INT = 0
DECLARE @text2 VARCHAR(80) = 'rtcfvty34redt'

WHILE (@index2 < LEN(@text2))
BEGIN 
	IF(SUBSTRING(@text2, @index2 + 1, 1) LIKE '[0-9]')
	BEGIN
		SET @integers += SUBSTRING(@text2, @index2 + 1, 1)
	END
	ELSE IF(SUBSTRING(@text2, @index2 + 1, 1) LIKE '[A-Z]')
	BEGIN
		SET @characters += SUBSTRING(@text2, @index2 + 1, 1)
	END

	SET @index2 += 1
END

SELECT 
	@integers AS Integers, 
	@characters AS Characters
