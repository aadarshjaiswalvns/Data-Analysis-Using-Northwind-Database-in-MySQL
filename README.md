🛍️ Reliant Retail Ltd. – MySQL Analytics Project

📌 Project Overview
This project was developed for Reliant Retail Ltd., a fictional chain of online retail stores, to support data-driven business decisions using SQL queries on a transactional orders database. The database includes customers, products, orders, inventory, shipments, and addresses.

Goal: Solve 10 analytical questions to deliver insights on customer segmentation, inventory health, logistics, and product performance.

🔧 Tools & Technologies
SQL (MySQL)

Relational Database Design

ER Model with 7+ Tables

Joins, CASE, Subqueries, GROUP BY, HAVING, Aggregates

🧠 Key Business Questions Solved
Customer Segmentation
Categorized customers (A/B/C) based on account creation year and formatted names with gender-based titles.

Unsold Product Insights
Identified unsold products, calculated inventory value, and applied dynamic discounts (10–20%) based on price tiers.

Product Class Summary
Aggregated inventory value per product class, filtered by classes with > ₹100,000 in stock value.

Customer Cancellations
Found customers who cancelled all their orders using subqueries.

Logistics Performance
Evaluated Shipper DHL’s reach and performance by counting customers and consignments per city.

Inventory Health Check
Assessed inventory status (Low/Medium/Sufficient/No Sales) based on product category and quantity sold.

Carton Fit Analysis
Identified the largest order (by volume) that fits into a specific carton (carton_id = 10).

Cash Payment Analysis
Analyzed total quantity and value of products bought via Cash, filtering customers whose last names begin with 'G'.

Product Association (Market Basket)
Retrieved products frequently sold with product_id = 201, excluding cities Bangalore and New Delhi.

Order Filtering
Listed even-numbered shipped orders not sent to PIN codes starting with ‘5’, including quantity metrics.

📊 Sample ER Diagram (Simplified)
Tables: ONLINE_CUSTOMER, ORDER_HEADER, ORDER_ITEMS, PRODUCT, PRODUCT_CLASS, SHIPPER, ADDRESS, CARTON

✅ Outcomes
Demonstrated ability to write advanced SQL queries for real-world analytics scenarios.

Practiced data cleaning, logic-building, and performance-optimized querying.

Gained hands-on experience in inventory planning, customer behavior analysis, and delivery optimization.
