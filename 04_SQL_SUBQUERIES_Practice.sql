-- Basic SQL Subquery Questions

-- 1. Find Customers with Orders
-- - Retrieve customer names who have placed at least one order.
-- - Use a subquery in the WHERE clause to check if the customer exists in the orders table.

use classicmodels;

select * from customers;
select * from orders;

select customerName from customers
where customerNumber in (select customerNumber from orders);

-- 2. Find Employees Working Under a Specific Manager
-- - Retrieve employee names who report to the manager with employee number 1002.
-- - Use a subquery to get the employees under this manager.

select * from employees;

-- select employeeNumber from employees 
-- where employeeNumber in (select employeeNumber from employees 
-- where reportsTo = 1002);

select employeeNumber from employees 
where reportsTo = 1002;


-- 3. List Products with Price Higher Than the Average Price
-- - Retrieve product names where the buyPrice is greater than the average buyPrice of all products.
-- - Use a subquery to calculate the average price.

select * from products;

select productName,productCode
from products where buyPrice > (select avg(buyPrice) from products);

-- 4. Find Customers Who Have Placed an Order for a Specific Product
-- - Retrieve customer names who have ordered the product '1969 Harley Davidson Ultimate Chopper'.
-- - Use a subquery to find the orderNumber associated with this product.

select * from customers;
select * from orders;
select * from orderdetails;
select * from products;

select customerName from customers
where customerNumber in (select customerNumber from orders  where orderNumber in
 (select orderNumber from orderdetails where productCode = (select ProductCode from products where productName = '1969 Harley Davidson Ultimate Chopper')));



-- 5. Retrieve Orders That Have the Maximum Quantity Ordered
-- - Find orderNumbers where the quantity ordered is the maximum among all orders.
-- - Use a subquery to find the maximum quantityOrdered.

select * from orders;
select * from orderdetails;

select orderNumber from orders
where orderNumber in (select orderNumber from orderdetails where quantityOrdered = (select MAX(quantityOrdered) from orderdetails));


-- 6. Find Customers Who Have Not Placed Any Orders
-- - Retrieve customer names who do not exist in the orders table.
-- - Use a NOT IN subquery to filter customers who haven't placed orders.

select customerName from customers
where customerNumber not in (select customerNumber from orders);
-- 7. Find the Most Expensive Product in Each Product Line
-- - Retrieve product name, product line, and price for the most expensive product in each product line.
-- - Use a subquery to get the maximum price for each product line.

select * from products;

select  productName, productLine, buyPrice from products
where buyPrice in  (select MAX(buyPrice) from products group by productLine);

select productName, productLine, buyPrice
from products p
where buyPrice = (
  select MAX(buyPrice)
  from products
  where productLine = p.productLine
);

-- 8. Find Employees Who Are Sales Representatives
-- - Retrieve employee names who are designated as 'Sales Rep' in the employees table.
-- - Use a subquery to filter employees based on jobTitle.

select * from employees;

select concat(firstName," ",lastName) as employeeName from employees
where jobTitle = 'Sales Rep';


-- 9. Find Customers Who Have Ordered More Than 5 Different Products
-- - Retrieve customer names who have ordered more than 5 distinct products.
-- - Use a subquery to count the number of distinct products ordered.
select * from customers;
select * from orders;
select * from orderdetails;
select * from products;

select customerName from customers 
where customerNumber in
 (select customerNumber from orders where orderNumber in
 (select orderNumber from orderdetails group by orderNumber having count(distinct productCode)>5));
 
 select customerName from customers
where customerNumber in (
  select o.customerNumber
  from orders o
  join orderdetails od on o.orderNumber = od.orderNumber
  group by o.customerNumber
  having count(distinct od.productCode) > 5
);
 

-- 10. Find Orders That Include a Product with a Specific Name
-- - Retrieve orderNumbers where at least one ordered product is '1969 Ford Mustang'.
-- - Use a subquery to find order numbers from the orderdetails table that contain this product.

select * from orders;
select * from orderdetails;
select * from products;

select orderNumber from orders
where orderNumber in (select orderNumber from orderdetails where productCode = (select productCode from products where productName = '1969 Ford Mustang'));
