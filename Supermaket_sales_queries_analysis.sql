-- Data Exploration:
SELECT * FROM sales LIMIT 10;

ALTER TABLE Sales ADD Total FLOAT;

UPDATE Sales
SET Total = `Quantity Sold (kilo)` * `Unit Selling Price (RMB/kg)`;

-- Total Sales Analysis:
Select ItemCode, SUM(total) AS Total_Sales 
FROM sales
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 10;

-- Product Category Analysis:
SELECT CategoryName, COUNT(*) AS Count_Product
FROM product 
GROUP BY 1 
ORDER BY 2 DESC;

-- Sales Trend Analysis:
SELECT Year(Date) AS Sale_Date, SUM(total) AS Daily_Sales 
FROM sales
GROUP BY Sale_Date 
ORDER BY Sale_Date;

-- Gross Margin Analysis:
SELECT p.CategoryName, s.SaleOrReturn, SUM(s.Total)
FROM sales AS s
JOIN product AS p 
ON s.ItemCode = p.ItemCode
GROUP BY 1,2
Order By 1;


SELECT p.CategoryName, SUM(s.Total)
FROM sales AS s
JOIN product AS p 
ON s.ItemCode = p.ItemCode
GROUP BY 1
Order By 2;

-- Top Products:
SELECT p.ItemName, COUNT(s.ItemCode) AS Total_Quantity_Sold 
FROM sales AS s
JOIN product AS p ON s.ItemCode = p.ItemCode 
GROUP BY 1
ORDER BY Total_Quantity_Sold DESC LIMIT 10;

-- ---- ----------------------------------

-- Monthly Sales Analysis:
SELECT MONTH(date) AS Month, YEAR(date) AS Year, SUM(total) AS Monthly_Sales
FROM sales
GROUP BY Year, Month
ORDER BY Year, Month;

-- Sales Analysis by Day of Week:
SELECT DAYNAME(date) AS DayOfWeek, SUM(total) AS Sales
FROM sales
GROUP BY DayOfWeek
ORDER BY Sales DESC;

-- Average Discount Given:
SELECT s.ItemCode, Count(s.Discount) AS ProductCount_Discount, p.ItemName
FROM sales AS s
JOIN product AS p ON s.ItemCode = p.ItemCode
WHERE Discount = 'Yes'
GROUP BY 1,3
ORDER BY ProductCount_Discount DESC;

-- Product Return Analysis:
SELECT s.ItemCode, Count(s.SaleOrReturn) AS ProductCount_Return, p.ItemName
FROM sales AS s
JOIN product AS p ON s.ItemCode = p.ItemCode
WHERE SaleOrReturn = 'Return'
GROUP BY 1,3
ORDER BY ProductCount_Return DESC;

-- Category Return Analysis:
SELECT Count(s.SaleOrReturn) AS CategoryCount_Return, p.CategoryName
FROM sales AS s
JOIN product AS p ON s.ItemCode = p.ItemCode
WHERE SaleOrReturn = 'Return'
GROUP BY 2
ORDER BY CategoryCount_Return DESC;

-- Category Sale Analysis:
SELECT Count(s.SaleOrReturn) AS CategoryCount_Return, p.CategoryName
FROM sales AS s
JOIN product AS p ON s.ItemCode = p.ItemCode
WHERE SaleOrReturn = 'Sale'
GROUP BY 2
ORDER BY CategoryCount_Return DESC;

-- ------------------------------------------------------------------------------------------
-- Sales Analysis

-- Products contributing most to the sales:
SELECT ItemCode, SUM(total) AS product_sales 
FROM sales 
GROUP BY 1 
ORDER BY product_sales DESC LIMIT 10;


SELECT p.CategoryName, SUM(pl.LossRate)  AS PercentLossByCategory
FROM product As p
JOIN `producst lost` AS pl
ON p.ItemCode = pl.ItemCode
Group By 1
Order By PercentLossByCategory;

SELECT ItemName, LossRate
FROM `producst lost`
Order By 2 DESC;

-- -------------------------------------------------------------------

SELECT 
    `Item Code`,
    Count(`Sale or Return` = 'Sale') AS TotalSold,
    Count(`Sale or Return` = 'Returned') AS TotalReturned,
    (Count(`Sale or Return` = 'Returned') / Count(`Sale or Return` = 'Sale') * 100) AS ReturnRate
FROM 
    sales2
GROUP BY 
    1
ORDER BY 
    ReturnRate DESC;
