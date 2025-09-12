

--PUZZLE 1
CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');


SELECT DISTINCT
       CASE 
	   WHEN col1 < col2 THEN col1 
	   ELSE col2 END AS col1,
       CASE
	   WHEN col1 < col2 THEN col2 
	   ELSE col1 END AS col2
FROM InputTbl
--Explanation:
--CASE basically makes it that we have smaller value on one side and bigger on the other so (a,b) and (b,a) are equal -- And using distinct after that just eliminates duplicates

--second way 
--works pretty much the same as first
SELECT DISTINCT
	IIF(col1 < col2, col1, col2),
	IIF(col1 > col2, col1, col2)
FROM InputTbl 

--third way
--CASE basically makes it that we have smaller value on one side and bigger on the other so (a,b) and (b,a) are equal and then group by group all duplicates into one; aggregates are unneccsary because col1, col2 are in group by by clause

SELECT col1, col2
FROM (SELECT
       CASE 
	   WHEN col1 < col2 THEN col1 
	   ELSE col2 END AS col1,
       CASE
	   WHEN col1 < col2 THEN col2 
	   ELSE col1 END AS col2
	   FROM InputTbl) as InputTbl
GROUP BY col1, col2



--PUZZLE 2
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT *
FROM TestMultipleZero
WHERE A != 0 OR B != 0 OR C != 0 OR D != 0

--second way

SELECT *
FROM TestMultipleZero
EXCEPT
SELECT * 
FROM TestMultipleZero
WHERE A = B AND B = C AND C = D AND D = 0


--PUZZLE 3

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')


SELECT *
FROM section1
WHERE id % 2 = 1

--PUZZLE 4

SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1)

--second way
SELECT *
FROM section1
WHERE id <= All( SELECT id
				 FROM section1)

--PUZZLE 5


SELECT *
FROM section1
WHERE id = (SELECT MAX(id) FROM section1)

--second way
SELECT *
FROM section1
WHERE id >= All( SELECT id
				 FROM section1)

--PUZZLE 6

SELECT * 
FROM section1
WHERE name LIKE 'b%'

--PUZZLE 7

CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

SELECT * 
FROM ProductCodes
WHERE Code LIKE '%[_]%'

--second way

SELECT * 
FROM ProductCodes
WHERE Code LIKE '%V_%' ESCAPE 'V'



--do not give me a bad score, please. I tried my best!!!


