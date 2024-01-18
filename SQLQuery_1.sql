USE SALES;
--A. KPI's
--1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

--2. Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales;

--3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales;

--4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

--5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_per_Order
FROM pizza_sales;

--B. Hourly Trend for Total Pizzas Sold
SELECT DATEPART(HOUR, order_time) AS Order_Hours, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);

--C. Weekly Trend for Total Orders
SELECT 
    DATEPART(ISO_WEEK, order_date) AS WeekNumber, 
    YEAR(order_date) AS YEAR,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY 
    DATEPART(ISO_WEEK, order_date),
    YEAR(order_date)
ORDER BY 
    Year, WeekNumber;


--D. Percentage of Sales by Pizza Category
SELECT pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10, 2)) AS Total_Revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10, 2)) AS pcg
FROM pizza_sales
GROUP BY pizza_category;

--E. Percentage of Sales by Pizza Size
SELECT pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10, 2)) AS Total_Sale,
    CAST(SUM(quantity) * 100 / (SELECT SUM(quantity) FROM pizza_sales) AS DECIMAL(10, 2)) AS pcg
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

--F. Total Pizza Sold by Pizza Category
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

--I. Top 5 Best Sellers 
--Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

--Total Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

--Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

--J. Bottom 5 Best Sellers
--Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

--Total Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;

--Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;
