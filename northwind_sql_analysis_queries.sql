
-- Northwind SQL Analysis Queries

-- 1. Total Sales by Country
SELECT o.ship_country_region AS Country,
       ROUND(SUM(od.unit_price * od.quantity), 2) AS TotalSales
FROM northwind.orders o
JOIN northwind.order_details od ON o.id = od.order_id
GROUP BY o.ship_country_region
ORDER BY TotalSales DESC;

-- 2. Top 5 Customers by Revenue
SELECT c.company AS Customer,
       ROUND(SUM(od.unit_price * od.quantity), 2) AS Revenue
FROM northwind.customers c
JOIN northwind.orders o ON c.id = o.customer_id
JOIN northwind.order_details od ON o.id = od.order_id
GROUP BY c.company
ORDER BY Revenue DESC
LIMIT 5;

-- 3. Monthly Sales Trend
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS Month,
       ROUND(SUM(od.unit_price * od.quantity), 2) AS MonthlySales
FROM northwind.orders o
JOIN northwind.order_details od ON o.id = od.order_id
GROUP BY Month
ORDER BY Month;

-- 4. Top 5 Best-Selling Products
SELECT p.product_name,
       SUM(od.quantity) AS TotalQuantity
FROM northwind.products p
JOIN northwind.order_details od ON p.id = od.product_id
GROUP BY p.product_name
ORDER BY TotalQuantity DESC
LIMIT 5;

-- 5. Revenue by Employee (Sales Rep)
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee,
       ROUND(SUM(od.unit_price * od.quantity), 2) AS Revenue
FROM northwind.employees e
JOIN northwind.orders o ON e.id = o.employee_id
JOIN northwind.order_details od ON o.id = od.order_id
GROUP BY Employee
ORDER BY Revenue DESC;
