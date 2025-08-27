--Creating database from the scratch
CREATE DATABASE retail_DB;

--Creating Schema inside the database
CREATE SCHEMA shop;

--Creating table inside the cshema above (allocate columns names and their data types)
CREATE TABLE retail_table(
            order_id INT,
            customer_name STRING,
            order_date DATE,
            product_category STRING,
            quantity INT,
            total_amount FLOAT
);

-- Rename the column BEFORE inserting data
ALTER TABLE retail_table
RENAME COLUMN total_amount TO price;

--Inserting value into the new table
INSERT INTO retail_table VALUES
(1, 'Lerato', '2025-08-01', 'Beverages', 3, 150.00),
(2, 'Thabo', '2025-08-02', 'Snacks', 2, 75.50),
(3, 'Naledi', '2025-08-03', 'Bakery', 5, 200.00),
(4, 'Kabelo', '2025-08-04', 'Beverages', 1, 50.00),
(5, 'Boitumelo', '2025-08-05', 'Snacks', 4, 120.75);

--Wanted to USE DROP 
DROP TABLE retail_table;

--Adding it again
--Creating table inside the cshema above (allocate columns names and their data types)
CREATE TABLE retail_table(
            order_id INT,
            customer_name STRING,
            order_date DATE,
            product_category STRING,
            quantity INT,
            total_amount FLOAT
);

--Inserting value into the new table
INSERT INTO retail_table VALUES
(1, 'Lerato', '2025-08-01', 'Beverages', 3, 150.00),
(2, 'Thabo', '2025-08-02', 'Snacks', 2, 75.50),
(3, 'Naledi', '2025-08-03', 'Bakery', 5, 200.00),
(4, 'Kabelo', '2025-08-04', 'Beverages', 1, 50.00),
(5, 'Boitumelo', '2025-08-05', 'Snacks', 4, 120.75);

-- Rename the column BEFORE inserting data
ALTER TABLE retail_table
RENAME COLUMN total_amount TO price;
--EDA--

--Examining the database
SELECT * FROM retail_db.shop.retail_table;

--Count the number of orders
SELECT count(order_id) AS order_count
FROM retail_db.shop.retail_table;

--Count the number of customer
SELECT count(order_id) AS customer_count
FROM retail_db.shop.retail_table;

--Sum revenue
SELECT SUM(quantity*price) AS total_revenue
FROM retail_db.shop.retail_table;

--Date 
SELECT DAYNAME(order_date) AS day_of_week,
        MONTH(order_date) AS month_name,
       
FROM retail_db.shop.retail_table;

--create the bucket month bucket
CASE 
    WHEN DAY(order_date) BETWEEN 1 AND 3 THEN 'Month Start'
   ELSE 'Other'
END AS month_period 
FROM retail_db.shop.retail_table;

SELECT DAYNAME(order_date) AS day_of_week,
        MONTH(order_date) AS month_name,
    CASE 
        WHEN DAY(order_date) BETWEEN 1 AND 3 THEN 'Month Start'
        ELSE 'Other'
    END AS month_period,

    SUM(quantity*price) AS total_revenue,
    count(order_id) AS order_count,
    quantity,
    customer_name,
    product_category
FROM retail_db.shop.retail_table
WHERE customer_name LIKE '%a%'
GROUP BY ALL
HAVING SUM(quantity*price)>1;

--Creating CTE 
WITH keneilwe AS (
SELECT SUM(price*quantity) AS total_amount,
        customer_name
FROM retail_db.shop.retail_table
GROUP BY customer_name
)

SELECT total_amount,
        customer_name
FROM keneilwe;
