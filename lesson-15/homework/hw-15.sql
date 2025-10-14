1. Find Employees with Minimum Salary
Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);


SELECT *
FROM employees
WHERE salary = (SELECT
					MIN(salary)
				FROM employees)
	
	
WITH MinSalary AS(
	SELECT 
		MIN(Salary) AS MinSalar
	FROM employees
)
SELECT e.*
FROM employees AS e
JOIN MinSalary AS m
	ON e.salary = m.MinSalar




2. Find Products Above Average Price
Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products)




3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

DROP TABLE IF EXISTS employees


CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);


SELECT * FROM 
employees
WHERE department_id = (SELECT id FROM departments WHERE department_name = 'Sales')

4. Find Customers with No Orders
Task: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);


 SELECT * 
 FROM customers
 WHERE customer_id NOT IN(SELECT customer_id FROM orders)



 5. Find Products with Max Price in Each Category
Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);


SELECT *
FROM products AS P
WHERE price = (SELECT MAX(price) FROM products WHERE category_id = P.category_id GROUP BY category_id)



6. Find Employees in Department with Highest Average Salary
Task: Retrieve employees working in the department with the highest average salary. Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);


SELECT * FROM employees
WHERE department_id = (SELECT
						department_id 
						FROM employees 
						GROUP BY department_id 
						HAVING(AVG(salary) = (SELECT 
												MAX(t.w) 
												FROM (SELECT 
														AVG(salary) AS w 
														FROM employees GROUP BY department_id) AS t)))






7. Find Employees Earning Above Department Average
Task: Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);

SELECT E.*, D.department_name
FROM employees AS E
JOIN departments AS D
	ON E.department_id = D.id
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = E.department_id GROUP BY department_id )



8. Find Students with Highest Grade per Course
Task: Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);


SELECT * 
FROM students AS S
JOIN grades AS G
	ON S.student_id = G.student_id

SELECT * 
FROM students AS S
JOIN grades AS G
	ON S.student_id = G.student_id
WHERE S.student_id = (SELECT student_id from grades AS Gtemp WHERE grade = (SELECT MAX(grade) FROM grades WHERE course_id = G.course_id))





9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);


SELECT * FROM products AS P
WHERE id = (SELECT id FROM products
			WHERE category_id = P.category_id
			ORDER BY price DESC 
			OFFSET 2 rows 
			FETCH next 1 row only)


10. Find Employees whose Salary Between Company Average and Department Max Salary
Task: Retrieve employees with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id)

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);


select * from employees

SELECT * 
FROM employees AS E
WHERE salary > ( SELECT AVG(salary) FROM employees WHERE department_id = E.department_id) AND salary < (SELECT MAX(salary) FROM employees WHERE department_id = E.department_id)




