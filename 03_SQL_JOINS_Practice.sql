-- Questions

-- 1. Find the total sales revenue per customer using joins with orders and orderdetails tables. Filter
-- customers whose total sales exceed $100,000 and sort results in descending order.
use classicmodels;
select * from orders;
select * from orderdetails;

select sum(one.quantityOrdered*one.priceEach) as total_revenue, two.customerNumber
from orderdetails one natural join orders two
group by two.customerNumber
having total_revenue>100000
order by total_revenue desc;

SELECT SUM(two.quantityOrdered * two.priceEach) as TOTAL_PRICE, one.customerNumber
from orders one natural join orderdetails two 
GROUP BY one.customerNumber
ORDER BY TOTAL_PRICE DESC;


-- 2. Find the top 5 product lines by total quantity sold using joins with products and orderdetails.
-- Include product lines where total quantity sold exceeds 500 units and sort in descending order.
select * from products;
select * from orderdetails;

select sum(quantityOrdered) as total_order, productLine
from products p natural join orderdetails o
group by productLine
having total_order>500
order by total_order desc
limit 5;


-- 3. Find the total revenue generated per sales representative using employees, customers, orders,
-- and orderdetails tables. Filter employees with total revenue above $200,000 and sort results in descending order.
select * from employees;
select * from customers;
select * from orders;
select * from orderdetails;

SELECT 
    e.employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS salesRepName,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY e.employeeNumber, salesRepName
HAVING totalRevenue > 200000
ORDER BY totalRevenue DESC;


-- 4. Find the average order value per customer using joins with orders and orderdetails tables. Include
-- customers who placed at least 5 orders and sort results in descending order.
select * from orders;
select * from orderdetails;

select avg(quantityOrdered) as order_value, count(orderNumber) as order_placed,customerNumber
from orderdetails natural join orders
group by customerNumber
having order_placed >4
order by order_value desc;


-- 5. Find the most popular products based on total sales revenue using joins with products and
-- orderdetails. Filter products where total revenue exceeds $50,000 and sort in descending order.
select * from products;
select * from orderdetails;

SELECT p.productCode, p.productName,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName
HAVING totalRevenue > 50000
ORDER BY totalRevenue DESC;


-- 6. Find the most profitable months based on total sales revenue using joins with orders and
-- orderdetails tables. Include months with total revenue exceeding $75,000 and sort results in descending order.
select * from orders;
select * from orderdetails;

SELECT DATE_FORMAT(o.orderDate, '%m') AS orderMonth,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY orderMonth
HAVING totalRevenue > 75000
ORDER BY totalRevenue DESC;


-- 7. Find the top 3 countries by total sales revenue using joins with customers, orders, and
-- orderdetails tables. Sort the results in descending order and limit to top 3 countries.
select * from customers;
select * from orders;
select * from orderdetails;
select * from products;
select * from employees;

select c.country, sum(od.quantityOrdered * od.priceEach) as total_revenue
from customers c 
join orders o on(c.customerNumber=o.customerNumber)
join orderdetails od on(o.orderNumber=od.orderNumber)
group by country
order by total_revenue desc
limit 3;


-- 8. Find the total number of orders handled by each employee using joins with customers and orders.
-- Include employees handling more than 20 orders and sort results in descending order.
SELECT 
    e.employeeNumber,
    COUNT(o.orderNumber) AS totalOrders
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY e.employeeNumber, employeeName
HAVING totalOrders > 20
ORDER BY totalOrders DESC;


-- 9. Find the top 5 customers with the highest number of orders using joins with orders table. Sort
-- results in descending order and limit to top 5 customers.
SELECT 
    c.customerNumber,
    c.customerName,
    COUNT(o.orderNumber) AS totalOrders
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY totalOrders DESC
LIMIT 5;


-- 10. Find the employees with the highest number of customers assigned using joins with customers.
-- Include employees with more than 10 customers and sort results in descending order.
SELECT 
    e.employeeNumber,
    COUNT(c.customerNumber) AS totalCustomers
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
HAVING totalCustomers > 3
ORDER BY totalCustomers DESC;

-- Advanced JOINS

-- Find the top 5 customers who have ordered the most distinct products. Count the number of distinct products ordered by each customer.
--  Retrieve customer name and number of distinct products ordered.
-- Sort in descending order and limit to top 5 customers.
select count(distinct od.productCode), customerNumber
from customers c join orders o on(p.customerNumber=od.customerNumber)
join orderdetails od ON o.orderNumber = od.orderNumber
group by c.customerNumber, c.customerName
order by distinctProductsOrdered DESC
limit 5;


-- Find products that have never been ordered
-- Use a LEFT JOIN between products and orderdetails.
-- Retrieve product name and product code where orderNumber IS NULL.
select p.productCode,p.productName
from products p left join orderdetails od on(p.productCode=od.productCode)
where od.orderNumber=null;


-- Identify customers who have ordered all available product lines
-- Retrieve customer name who has placed orders from every product line in the products table.
select * from customers;
select * from orders;
select * from products;

select c.customerName from customers c
join orders o on(c.customerNumber=o.customerNumber)
join orderdetails od on(o.orderNumber=od.orderNumber)
join products p on(od.productCode=p.productCode)
group by c.customerNumber,c.customerName
HAVING COUNT(DISTINCT p.productLine) = (
    SELECT COUNT(DISTINCT productLine) FROM products
);



 -- Find employees who have not made a sale in the last 6 months
-- Retrieve employee name and last sale date.
-- Filter employees who haven't had any sales in the past 6 months.
SELECT 
    e.employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    MAX(o.orderDate) AS lastSaleDate
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY e.employeeNumber, employeeName
HAVING lastSaleDate IS NULL OR lastSaleDate < CURDATE() - INTERVAL 6 MONTH;


 -- Detect order numbers that contain both 'Ships' and 'Trains' products
-- Find orders that contain both product categories:
-- 'Ships' from the product line
-- 'Trains' from the product line.
SELECT o.orderNumber
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productLine IN ('Ships', 'Trains')
GROUP BY o.orderNumber
HAVING COUNT(DISTINCT p.productLine) = 2;




