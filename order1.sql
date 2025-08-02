create database retail_order_project

use retail_order_project

select * from orders1
--------------------------------------------



--Find top 10 highest revenue generating products

SELECT top 10
    product_id,
    SUM(Quantity * sale_Price) AS Total_Revenue
FROM orders1
GROUP BY product_id
ORDER BY Total_Revenue desc

--------------------------------------------

--Find top 5 highest selling products in each region

select distinct region from orders1 --[East,South,West,Central]


SELECT top 5 product_id AS Central_pid, SUM(quantity) AS total_quantity
FROM orders1
where region='central'
group by product_id
order by total_quantity desc

SELECT top 5 product_id AS East_pid, SUM(quantity) AS total_quantity
FROM orders1
where region='East'
group by product_id
order by total_quantity desc

SELECT top 5 product_id AS West_pid, SUM(quantity) AS total_quantity
FROM orders1
where region='West'
group by product_id
order by total_quantity desc

SELECT top 5 product_id AS South_pid, SUM(quantity) AS total_quantity
FROM orders1
where region='South'
group by product_id
order by total_quantity desc

--------------------------------------------



--Top 10 areas with highest number of orders

select top 10 postal_code, count(postal_code) as freq from orders1
group by postal_code
order by freq desc
--------------------------------------------


--Sub-Category with the highest total profit within each category

WITH category_profit AS (
    SELECT
        category,
        sub_category,
        SUM(profit) AS total_profit,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY SUM(profit) DESC) AS rn
    FROM
        orders1
    GROUP BY
        category, sub_category
)
SELECT
    category,
    sub_category,
    total_profit
FROM
    category_profit
WHERE
    rn = 1;
