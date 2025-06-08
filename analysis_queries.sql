Use Orders;

-- 1. Write a query to display customer full name with their title (Mr/Ms), both first name and last name are in upper case, customer email id, 
-- customer creation date and display customer’s category after applying below categorization rules:
-- i. IF customer creation date Year <2005 Then Category A
-- ii. IF customer creation date Year >=2005 and <2011 Then Category B
-- iii. iii)IF customer creation date Year>= 2011 Then Category C
-- Hint: Use CASE statement, no permanent change in table required. 

select * from ONLINE_CUSTOMER;

select CASE
when CUSTOMER_GENDER = 'M' Then 'MR.'
				Else 'Ms.'
                End as TITLE,
concat(upper(CUSTOMER_FNAME),' ',upper(CUSTOMER_LNAME)) as Full_Name , CUSTOMER_EMAIL,CUSTOMER_CREATION_DATE,CASE
when year(CUSTOMER_CREATION_DATE) < 2005 then  'A'
when year(CUSTOMER_CREATION_DATE) >= 2005 AND year(CUSTOMER_CREATION_DATE) < 2011 then 'B'
Else 'C'
END as CATEGORY
from ONLINE_CUSTOMER;

-- ----------------------------------------------------------------------------------------------------------------------------------------

-- 2. Write a query to display the following information for the products, which have not been sold: product_id, product_desc, product_quantity_avail,
-- product_price, inventory values (product_quantity_avail*product_price), New_Price after applying discount as per
-- below criteria. Sort the output with respect to decreasing value of Inventory_Value.
-- i) IF Product Price > 20,000 then apply 20% discount
-- ii) IF Product Price > 10,000 then apply 15% discount
-- iii) IF Product Price =< 10,000 then apply 10% discount
-- # Hint: Use CASE statement, no permanent change in table required.
-- [NOTE: TABLES to be used - PRODUCT, ORDER_ITEMS TABLE]

select * from product;
select * from order_items;

select  p.product_id, p.product_desc, p.product_quantity_avail, p.product_price, p.product_quantity_avail*p.product_price as inventory_values ,CASE
        WHEN p.product_price > 20000 THEN p.product_price * 0.80
        WHEN p.product_price > 10000 THEN p.product_price * 0.85
        ELSE p.product_price * 0.90
    END AS new_price
from product p join order_items o
on p.product_id = o.product_id;

select  product_id, product_desc, product_quantity_avail, product_price, product_quantity_avail*product_price as inventory_values ,CASE
        WHEN product_price > 20000 THEN product_price * 0.80
        WHEN product_price > 10000 THEN product_price * 0.85
        ELSE product_price * 0.90
    END AS new_price
from product;

-- ----------------------------------------------------------------------------------------------------------------------------------------

--  3. Write a query to display Product_class_code, Product_class_description, Count of Product type in each product class, Inventory Value
-- (product_quantity_avail*product_price).Information should be displayed for only those product_class_code which have more than
-- 1,00,000. Inventory Value. Sort the output with respect to decreasing value of Inventory_Value.
-- [NOTE: TABLES to be used - PRODUCT, PRODUCT_CLASS]


select * from product;
select * from product_class;


SELECT pc.PRODUCT_CLASS_CODE,pc.PRODUCT_CLASS_DESC,COUNT(p.product_id) AS product_count,SUM(p.product_quantity_avail * p.product_price) AS inventory_value
FROM PRODUCT p JOIN PRODUCT_CLASS pc 
ON p.PRODUCT_CLASS_Code = pc.PRODUCT_CLASS_code
GROUP BY pc.PRODUCT_CLASS_CODE
HAVING inventory_value > 100000
ORDER BY inventory_value DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------

-- 4. Write a query to display customer_id, full name, customer_email, customer_phone and
-- country of customers who have cancelled all the orders placed by them
-- [NOTE: TABLES to be used - ONLINE_CUSTOMER, ADDRESSS,OREDER_HEADER]


select * from ONLINE_CUSTOMER; -- C  CUSTOMER_ID ADDRESS_ID
select * from ADDRESS;  -- A  ADDRESS_ID
select * from ORDER_HEADER; -- 0  CUSTOMER_ID

SELECT  C.customer_id, CONCAT(C.CUSTOMER_FNAME,' ',C.CUSTOMER_LNAME) AS full_name, C.customer_email, C.customer_phone,A.COUNTRY
FROM ONLINE_CUSTOMER C JOIN ADDRESS A
ON C.ADDRESS_ID = A.ADDRESS_ID
JOIN ORDER_HEADER O 
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE O.ORDER_STATUS = 'Cancelled';

SELECT C.customer_id, CONCAT(C.customer_fname, ' ', C.customer_lname) AS full_name, C.customer_email, C.customer_phone, A.country
FROM online_customer C JOIN address A 
ON C.address_id = A.address_id
WHERE C.customer_id IN (SELECT customer_id FROM order_header
        GROUP BY customer_id
        HAVING COUNT(*) = SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END));

-- ----------------------------------------------------------------------------------------------------------------------------------------

-- 5.Write a query to display Shipper name, City to which it is catering, num of customer
-- catered by the shipper in the city and number of consignments delivered to that city for Shipper DHL 
-- [NOTE: TABLES to be used - SHIPPER, ONLINE_CUSTOMER, ADDRESSS,ORDER_HEADER]

select * from SHIPPER; -- s.SHIPPER_ID
select * from ONLINE_CUSTOMER; -- ADDRESS_ID ,CUSTOMER_ID.c
select * from ADDRESS; -- a.ADDRESS_ID
select * from ORDER_HEADER; -- oh.SHIPPER_ID , CUSTOMER_ID.oh

select s.SHIPPER_NAME,a.CITY,count(distinct c.CUSTOMER_ID) as No_OF_Customers,count(oh.ORDER_ID) as No_OF_Cosignments
from SHIPPER s join ORDER_HEADER oh
on s.SHIPPER_ID = oh.SHIPPER_ID
join ONLINE_CUSTOMER c 
on oh.CUSTOMER_ID = c.CUSTOMER_ID
join address a 
on a.ADDRESS_ID = c.ADDRESS_ID
group by s.SHIPPER_NAME,a.CITY
having s.SHIPPER_NAME = 'DHL';


SELECT S.SHIPPER_NAME, A.CITY, COUNT(DISTINCT OC.CUSTOMER_ID) AS NUM_CUSTOMERS, COUNT(OH.ORDER_ID) AS NUM_CONSIGNMENTS
FROM SHIPPER S JOIN ORDER_HEADER OH 
ON S.SHIPPER_ID = OH.SHIPPER_ID
JOIN ONLINE_CUSTOMER OC ON OH.CUSTOMER_ID = OC.CUSTOMER_ID
JOIN ADDRESS A ON OC.ADDRESS_ID = A.ADDRESS_ID
WHERE S.SHIPPER_NAME = 'DHL'
GROUP BY S.SHIPPER_NAME, A.CITY;
--  ---------------------------------------------------------------------------------------------------------------------------------------------

-- 6. 6. Write a query to display product_id, product_desc, product_quantity_avail, quantity sold and show inventory Status of products as below as per below condition:

-- i. For Electronics and Computer categories, if sales till date is Zero then show 'No Sales in past, give discount to reduce inventory', if inventory quantity is 
-- less than 10% of quantity sold, show 'Low inventory, need to add inventory', if inventory quantity is less than 50% of quantity sold, show 'Medium inventory, need -- to addsome inventory', if inventory quantity is more or equal to 50% of quantity sold,show 'Sufficient inventory'.

-- ii. For Mobiles and Watches categories, if sales till date is Zero then show 'No Sales in past, give discount to reduce inventory', if inventory quantity is less than 20% of quantity sold, show 'Low inventory, need to add inventory', if inventory quantity is less than 60% of quantity sold, show 'Medium inventory, need to add some inventory', if inventory quantity is more or equal to 60% of quantity sold, show 'Sufficient inventory'.

-- iii. Rest of the categories, if sales till date is Zero then show 'No Sales in past, give discount to reduce inventory', if inventory quantity is less than 30% of quantity sold, show 'Low inventory, need to add inventory', if inventory quantity is less than 70% of quantity sold, show 'Medium inventory, need to add some inventory', if inventory quantity is more or equal to 70% of quantity sold, show 'Sufficient inventory' (USE SUB-QUERY) [NOTE: TABLES to be used - PRODUCT, PRODUCT_CLASS, ORDER_ITEMS]












--  ---------------------------------------------------------------------------------------------------------------------------------------------

-- 7. Write a query to display order_id and volume of the biggest order (in terms of volume)
-- that can fit in carton id 10 [NOTE: TABLES to be used - CARTON, ORDER_ITEMS, PRODUCT]

select * from CARTON; -- 
select * from ORDER_ITEMS; -- 
select * from PRODUCT; -- 

SELECT oi.order_id,SUM(p.len * p.width * p.height * oi.PRODUCT_QUANTITY) AS total_volume
FROM ORDER_ITEMS oi JOIN PRODUCT p 
ON oi.product_id = p.product_id
GROUP BY oi.order_id
HAVING total_volume <= (SELECT len * width * height FROM CARTON
						WHERE carton_id = 10)
ORDER BY total_volume DESC
LIMIT 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------

-- 8.Write a query to display customer id, customer full name, total quantity and total value
-- (quantity*price) shipped where mode of payment is Cash and customer last name starts with 'G'
-- [NOTE: TABLES to be used - ONLINE_CUSTOMER, ORDER_ITEMS, PRODUCT,ORDER_HEADER]

select * from ORDER_ITEMS; -- ORDER_ID,PRODUCT_ID
select * from ONLINE_CUSTOMER; -- ADDRESS_ID ,CUSTOMER_ID
select * from PRODUCT; -- PRODUCT_ID
select * from ORDER_HEADER; --  CUSTOMER_ID ,ORDER_ID

SELECT C.CUSTOMER_ID,CONCAT(C.CUSTOMER_FNAME,' ',C.CUSTOMER_LNAME) AS FULL_NAME,SUM(P.PRODUCT_QUANTITY_AVAIL),SUM(OI.PRODUCT_QUANTITY*P.PRODUCT_PRICE) AS TOTAL_VALUE
FROM ONLINE_CUSTOMER C JOIN ORDER_HEADER OH
ON C.CUSTOMER_ID = OH.CUSTOMER_ID
JOIN ORDER_ITEMS OI 
ON OI.ORDER_ID = OH.ORDER_ID
JOIN PRODUCT P 
ON P.PRODUCT_ID = OI.PRODUCT_ID
WHERE OH.PAYMENT_MODE = 'CASH' AND C.CUSTOMER_LNAME LIKE 'G%'
GROUP BY C.CUSTOMER_ID;

SELECT oc.customer_id,CONCAT(oc.CUSTOMER_FNAME, ' ', oc.CUSTOMER_LNAME) AS full_name,SUM(oi.PRODUCT_QUANTITY) AS total_quantity,
SUM(oi.PRODUCT_QUANTITY * p.product_price) AS total_value
FROM ONLINE_CUSTOMER oc
JOIN ORDER_HEADER oh ON oc.customer_id = oh.customer_id
JOIN ORDER_ITEMS oi ON oh.order_id = oi.order_id
JOIN PRODUCT p ON oi.product_id = p.product_id
WHERE oh.payment_mode = 'Cash' AND oc.CUSTOMER_LNAME LIKE 'G%'
GROUP BY oc.customer_id, full_name;

-- ------------------------------------------------------------------------------------------------------------------------------------------

-- 9.Write a query to display product_id, product_desc and total quantity of products which
-- are sold together with product id 201 and are not shipped to city Bangalore and New Delhi.
-- Display the output in descending order with respect to the tot_qty. (USE SUB-QUERY)
-- [NOTE: TABLES to be used – ORDER_ITEMS, PRODUCT, ORDER_HEADER,ONLINE_CUSTOMER, ADDRESS]

select * from ORDER_ITEMS; -- ORDER_ID,PRODUCT_ID
select * from ONLINE_CUSTOMER; -- ADDRESS_ID ,CUSTOMER_ID
select * from PRODUCT; -- P.PRODUCT_ID
select * from ADDRESS; -- ADDRESS_ID
select * from ORDER_HEADER; -- CUSTOMER_ID ,ORDER_ID

SELECT OI.PRODUCT_ID,P.PRODUCT_DESC,SUM(OI.PRODUCT_QUANTITY) AS TOTAL_QUANTITY
FROM ORDER_ITEMS OI JOIN ORDER_HEADER OH ON OI.ORDER_ID = OH.ORDER_ID
JOIN PRODUCT P ON P.PRODUCT_ID = OI.PRODUCT_ID
WHERE 
OI.ORDER_ID IN (SELECT ORDER_ID FROM ORDER_ITEMS WHERE PRODUCT_ID = 201)
AND 
OH.CUSTOMER_ID NOT IN (SELECT OC.CUSTOMER_ID FROM ONLINE_CUSTOMER OC JOIN ADDRESS A ON OC.ADDRESS_ID = A.ADDRESS_ID 
							WHERE A.CITY NOT IN ('Bangalore','New Delhi'))
GROUP BY OI.PRODUCT_ID, P.PRODUCT_DESC
ORDER BY TOTAL_QUANTITY DESC;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 10.Write a query to display the order_id,customer_id and customer fullname, total
-- quantity of products shipped for order ids which are even and shipped to address where
-- pincode is not starting with "5" [NOTE: TABLES to be used – ONLINE_CUSTOMER, ORDER_HEADER,ORDER_ITEMS, ADDRESS]

select * from ORDER_ITEMS; -- ORDER_ID,PRODUCT_ID
select * from ONLINE_CUSTOMER; -- ADDRESS_ID ,CUSTOMER_ID 
select * from ADDRESS; -- ADDRESS_ID
select * from ORDER_HEADER; -- CUSTOMER_ID ,ORDER_ID

SELECT OI.ORDER_ID,OC.CUSTOMER_ID,CONCAT(CUSTOMER_FNAME,' ',CUSTOMER_LNAME) AS FULL_NAME,SUM(OI.PRODUCT_QUANTITY) AS TOTAL_PRODUCT_QUANTITY
FROM ONLINE_CUSTOMER OC JOIN ORDER_HEADER OH ON OC.CUSTOMER_ID = OH.CUSTOMER_ID
JOIN ORDER_ITEMS OI ON OI.ORDER_ID = OH.ORDER_ID 
JOIN ADDRESS A ON A.ADDRESS_ID = OC.ADDRESS_ID
WHERE  MOD(OH.ORDER_ID, 2) = 0 AND OH.ORDER_STATUS = 'Shipped' AND A.PINCODE NOT LIKE '5%'
GROUP BY OI.ORDER_ID,FULL_NAME,OC.CUSTOMER_ID;









