/* =========================
   LESSON 22 — AggregATED WINDOW FUNCTIONS
   All tasks in one script (SQL Server)
   ========================= */

-- Create sales_data table and insert rows
CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East');


/* ---------------------------
   EASY QUESTIONS
   --------------------------- */

-- Task 1: Compute Running Total Sales per Customer
SELECT
    sale_id, customer_id, order_date, total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_per_customer
FROM sales_data
ORDER BY customer_id, order_date;

-- Task 2: Count the number of orders per product_category (using window)
SELECT
    sale_id, product_category,
    COUNT(*) OVER (PARTITION BY product_category) AS orders_in_category
FROM sales_data
ORDER BY product_category;

-- Task 3: Find the maximum total_amount per product_category
SELECT
    sale_id, product_category, total_amount,
    MAX(total_amount) OVER (PARTITION BY product_category) AS max_total_in_category
FROM sales_data
ORDER BY product_category, total_amount DESC;

-- Task 4: Find the minimum unit_price per product_category
SELECT
    sale_id, product_category, unit_price,
    MIN(unit_price) OVER (PARTITION BY product_category) AS min_price_in_category
FROM sales_data
ORDER BY product_category, unit_price;

-- Task 5: Moving average of sales over 3 days (prev, curr, next) by order_date
SELECT
    sale_id, order_date, total_amount,
    AVG(total_amount) OVER (ORDER BY order_date
                            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_3days
FROM sales_data
ORDER BY order_date;

-- Task 6: Total sales per region (window)
SELECT
    region, sale_id, total_amount,
    SUM(total_amount) OVER (PARTITION BY region) AS total_sales_region
FROM sales_data
ORDER BY region;

-- Task 7: Rank customers based on their total purchase amount (overall)
SELECT
    customer_id,
    SUM(total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_by_spend
FROM sales_data
GROUP BY customer_id
ORDER BY total_spent DESC;

-- Task 8: Difference between current and previous sale amount per customer
SELECT
    sale_id, customer_id, order_date, total_amount,
    total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS diff_from_prev
FROM sales_data
ORDER BY customer_id, order_date;

-- Task 9: Top 3 most expensive products in each category (by unit_price)
SELECT product_category, product_name, unit_price
FROM (
    SELECT product_category, product_name, unit_price,
           DENSE_RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS price_rank
    FROM sales_data
) t
WHERE price_rank <= 3
ORDER BY product_category, price_rank;

-- Task 10: Cumulative sum of sales per region by order_date
SELECT
    region, order_date, total_amount,
    SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_by_region
FROM sales_data
ORDER BY region, order_date;


/* ---------------------------
   MEDIUM QUESTIONS
   --------------------------- */

-- Task 11: Compute cumulative revenue per product_category
SELECT
    product_category, order_date, total_amount,
    SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue_category
FROM sales_data
ORDER BY product_category, order_date;

-- Task 12: Sum of previous values for IDs 1..5 (sample)
CREATE TABLE NumData (ID INT);
INSERT INTO NumData VALUES (1),(2),(3),(4),(5);

SELECT
    ID,
    SUM(ID) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM NumData
ORDER BY ID;

-- Task 13: Sum of previous values for OneColumn sample
CREATE TABLE OneColumn (Value SMALLINT);
INSERT INTO OneColumn VALUES (10),(20),(30),(40),(100);

SELECT
    Value,
    SUM(Value) OVER (ORDER BY (SELECT NULL)
                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumOfPrevious
FROM OneColumn;

-- Task 14: Find customers who purchased from more than one product_category
SELECT customer_id
FROM (
    SELECT customer_id, COUNT(DISTINCT product_category) AS cnt
    FROM sales_data
    GROUP BY customer_id
) t
WHERE cnt > 1;

-- Task 15: Customers with above-average spending in their region
SELECT customer_id, region, total_spent
FROM (
    SELECT customer_id, region, SUM(total_amount) AS total_spent,
           AVG(SUM(total_amount)) OVER (PARTITION BY region) AS region_avg
    FROM sales_data
    GROUP BY region, customer_id
) t
WHERE total_spent > region_avg
ORDER BY region, total_spent DESC;

-- Task 16: Rank customers by total spending within each region (ties get same rank)
SELECT
    region, customer_id, total_spent,
    RANK() OVER (PARTITION BY region ORDER BY total_spent DESC) AS region_rank
FROM (
    SELECT region, customer_id, SUM(total_amount) AS total_spent
    FROM sales_data
    GROUP BY region, customer_id
) x
ORDER BY region, region_rank;

-- Task 17: Running total (cumulative_sales) per customer ordered by order_date
SELECT
    customer_id, order_date, total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;

-- Task 18: Sales growth rate per month compared to previous month
SELECT
    YEAR(order_date) as yr,
    MONTH(order_date) as mth,
    SUM(total_amount) AS month_total,
    LAG(SUM(total_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) AS prev_month_total,
    CASE WHEN LAG(SUM(total_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) IS NULL THEN NULL
         WHEN LAG(SUM(total_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) = 0 THEN NULL
         ELSE (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date))) * 100.0
              / LAG(SUM(total_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date))
    END AS growth_rate_pct
FROM sales_data
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY yr, mth;

-- Task 19: Identify customers whose total_amount is higher than their last order's total_amount
SELECT
    sale_id, customer_id, order_date, total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_amount,
    CASE WHEN total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date)
         THEN 1 ELSE 0 END AS is_higher_than_previous
FROM sales_data
ORDER BY customer_id, order_date;


/* ---------------------------
   HARD QUESTIONS
   --------------------------- */

-- Task 20: Identify products (unit_price) above the average product price (within dataset)
SELECT
    product_name, product_category, unit_price,
    AVG(unit_price) OVER () AS overall_avg_price
FROM sales_data
WHERE unit_price > AVG(unit_price) OVER ()
ORDER BY product_category, unit_price DESC;

-- Task 21: Show sum(Val1+Val2) for each group at group's first row only (single select)
CREATE TABLE MyData (Id INT, Grp INT, Val1 INT, Val2 INT);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

SELECT
    Id, Grp, Val1, Val2,
    CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
         THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
    END AS Tot
FROM MyData
ORDER BY Grp, Id;

-- Task 22: TheSumPuzzle — sum Cost per ID; Quantity: sum distinct quantities per ID
CREATE TABLE TheSumPuzzle (ID INT, Cost INT, Quantity INT);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

SELECT
    ID,
    SUM(Cost) AS Cost,
    SUM(DISTINCT Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID
ORDER BY ID;

-- Task 23: Find gaps in seat numbers (showing ranges missing)
CREATE TABLE Seats (SeatNumber INT);
INSERT INTO Seats VALUES
(7),(13),(14),(15),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(52),(53),(54);

-- Build contiguous groups, then detect gaps between groups and before first
WITH ordered AS (
    SELECT DISTINCT SeatNumber
    FROM Seats
), numbered AS (
    SELECT SeatNumber, ROW_NUMBER() OVER (ORDER BY SeatNumber) AS rn
    FROM ordered
), grp AS (
    SELECT SeatNumber, rn, SeatNumber - rn AS grp_key
    FROM numbered
), bounds AS (
    SELECT grp_key, MIN(SeatNumber) AS grp_start, MAX(SeatNumber) AS grp_end
    FROM grp
    GROUP BY grp_key
), gaps AS (
    -- gap before first group if any
    SELECT CASE WHEN (SELECT MIN(grp_start) FROM bounds) > 1
                THEN 1 ELSE NULL END AS gap_start,
           CASE WHEN (SELECT MIN(grp_start) FROM bounds) > 1
                THEN (SELECT MIN(grp_start) FROM bounds) - 1 ELSE NULL END AS gap_end
    WHERE (SELECT MIN(grp_start) FROM bounds) > 1

    UNION ALL

    -- gaps between groups
    SELECT b.grp_end + 1 AS gap_start, n.grp_start - 1 AS gap_end
    FROM bounds b
    JOIN bounds n ON n.grp_start = (
        SELECT MIN(grp_start) FROM bounds WHERE grp_start > b.grp_start
    )
    WHERE n.grp_start - b.grp_end > 1
)
SELECT gap_start AS [Gap Start], gap_end AS [Gap End]
FROM gaps
ORDER BY gap_start;
