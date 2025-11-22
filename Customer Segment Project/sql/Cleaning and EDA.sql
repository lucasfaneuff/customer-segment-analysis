DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
customer_id numeric,
year_of_birth numeric,
education varchar,
marital_status varchar,
income numeric,
kids_in_home numeric,
teens_in_home numeric,
date_joined varchar
)
CREATE TABLE sales (
customer_id numeric,
recency numeric,
wine_sales numeric,
fruit_sales numeric,
meat_sales numeric,
fish_sales numeric,
sweet_sales numeric,
gold_sales numeric,
deal_orders numeric,
web_orders numeric,
catalog_orders numeric,
store_orders numeric,
web_visits_monthly numeric,
campaign_3_accepted boolean,
campaign_4_accepted boolean,
campaign_5_accepted boolean,
campaign_1_accepted boolean,
campaign_2_accepted boolean,
complain boolean,
response boolean
)
-- format date_joined column
UPDATE customer 
SET date_joined = TO_DATE(date_joined, 'DD-MM-YYYY')

ALTER TABLE customer
ALTER COLUMN date_joined TYPE date
USING TO_DATE(date_joined, 'YYYY/MM/DD')

-- merge 2n cycle and master
UPDATE customer
SET education = 'Master'
WHERE education = '2n Cycle'

-- drop  records with YOLO AND Absurd
DELETE FROM customer
WHERE marital_status = 'YOLO'
OR marital_status = 'Absurd'

-- merge alone and single
UPDATE customer
SET marital_status = 'Single'
WHERE marital_status = 'Alone'

-- EDA
-- Dimensions exploration
SELECT distinct education FROM customer

SELECT distinct marital_status FROM customer

-- number of each type of order for each education level
-- find out some customer ids in sales table arent in customer
SELECT education, sum(web_orders), sum(catalog_orders), sum(store_orders)
FROM sales AS s
LEFT JOIN customer AS c
ON s.customer_id = c.customer_id
GROUP BY education

-- finds customer ids in sales table not present in customer table
SELECT *
FROM sales AS s
LEFT JOIN customer AS c
ON s.customer_id = c.customer_id
WHERE education IS NULL

DELETE FROM sales
WHERE customer_id = '7734'
OR customer_id = '492'
OR customer_id = '4369'
OR customer_id = '11133'

-- number of each type of order for each marital status
SELECT marital_status, sum(web_orders), sum(catalog_orders), sum(store_orders)
FROM sales AS s
LEFT JOIN customer AS c
ON s.customer_id = c.customer_id
GROUP BY marital_status

-- Date exploration
SELECT min(date_joined), max(date_joined), max(date_joined) - min(date_joined)
FROM customer

-- Measures exploration
-- create total_price field
ALTER TABLE sales
ADD COLUMN total_price numeric

UPDATE sales
SET total_price = wine_sales + fruit_sales + meat_sales + fish_sales + sweet_sales + gold_sales
-- create total_orders field
ALTER TABLE sales
ADD COLUMN total_orders numeric

UPDATE sales
SET total_orders = web_orders + catalog_orders + store_orders

-- sales exploration
SELECT 'Total_Sales' as measure_name, sum(total_price) AS measure_value FROM sales
UNION ALL
SELECT 'Max_Sales', max(total_price) FROM sales
UNION ALL
SELECT 'Total_Orders', sum(total_orders) FROM sales
UNION ALL
SELECT 'Avg_Price_Per_Order', sum(total_price) / sum(total_orders) FROM sales
UNION ALL
SELECT 'Total_Customers', count(customer_id) FROM sales
UNION ALL
SELECT 'Avg_Sales_Per_Customer', avg(total_price) FROM sales
UNION ALL
SELECT 'Deal_Order_Pct', sum(deal_orders) / sum(total_orders) * 100 FROM sales

-- Magnitude exploration
-- education exploration
SELECT education,
sum(total_price) AS total_sales, avg(total_price) AS avg_customer_sales,
sum(total_orders) AS total_orders, avg(total_orders) AS avg_number_of_orders
FROM sales AS s
LEFT JOIN customer AS c
ON s.customer_id = c.customer_id
GROUP BY education
ORDER BY total_sales desc 

SELECT marital_status,
sum(total_price) AS total_sales, avg(total_price) AS avg_customer_sales,
sum(total_orders) AS total_orders, avg(total_orders) avg_number_of_orders
FROM sales AS s
LEFT JOIN customer AS c
ON s.customer_id = c.customer_id
GROUP BY marital_status
ORDER BY total_sales desc

-- Ranking
SELECT customer_id, total_price,
DENSE_RANK() OVER(ORDER BY total_price desc)
FROM sales


SELECT * FROM CUSTOMER

SELECT * FROM sales