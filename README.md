# 🛍️ Reliant Retail Ltd. – MySQL Analytics Project

## 📌 Project Overview
This project simulates real-world business analysis for *Reliant Retail Ltd.*, a fictional e-commerce company. Using a relational orders database, I answered 10 key business questions using advanced SQL techniques. The project covers customer segmentation, unsold product detection, inventory management, and logistics evaluation.

> **Goal:** Use MySQL to extract actionable insights from a multi-table transactional database to support data-driven decisions.

---

## 🧰 Tools & Technologies
- **MySQL**
- SQL Features Used: `JOIN`, `CASE`, `GROUP BY`, `HAVING`, `Subqueries`, `Aggregation`
- Data Types: Orders, Customers, Products, Shipments, Inventory, Geography

---

## 🧠 Business Questions Answered

1. **Customer Segmentation**
   - Classified customers as Category A/B/C based on their account creation year and gender (Mr./Ms.).

2. **Unsold Products & Discount Logic**
   - Identified unsold products and applied tiered discount logic (10%, 15%, 20%) based on price.

3. **Inventory Value by Product Class**
   - Computed inventory value for each product class and filtered those with value > ₹100,000.

4. **Order Cancellations**
   - Retrieved customers who canceled *all* their orders using a subquery.

5. **Shipper Logistics Performance**
   - Evaluated Shipper “DHL” performance by city in terms of customer count and consignments delivered.

6. **Inventory Health Status**
   - Categorized products as having Low/Medium/Sufficient inventory or No Sales, based on sales data and category logic.

7. **Carton Fit Volume Calculation**
   - Identified the largest order (by volume) that fits in a specific carton (`carton_id = 10`).

8. **Cash Payment Product Analysis**
   - Analyzed purchases by customers (whose last names start with "G") who paid in cash.

9. **Frequently Bought Together (Product ID 201)**
   - Found products sold together with `product_id = 201` but not shipped to Bangalore or New Delhi.

10. **Order Filtering by Address**
    - Listed even-numbered orders shipped to locations where the pincode does not start with '5'.

---

## 🧾 Sample ER Diagram (Simplified View)
> _Note: This is a conceptual summary based on table usage._
- **Tables Used:** `ONLINE_CUSTOMER`, `ORDER_HEADER`, `ORDER_ITEMS`, `PRODUCT`, `PRODUCT_CLASS`, `SHIPPER`, `ADDRESS`, `CARTON`

---

## 📈 Key Takeaways
- Translated real-world business logic into efficient and maintainable SQL.
- Built complex queries using layered `CASE`, nested subqueries, and multi-way joins.
- Strengthened my skills in database design interpretation and relational data analysis.
- Delivered actionable insights for marketing, inventory control, and logistics optimization.

---
