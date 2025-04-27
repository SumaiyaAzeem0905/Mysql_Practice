
use sample;
select * from employees;


-- 1>  Find the top 3 highest earning departments
--     Write an SQL query to retrieve the department-wise total salary from the employees table.

--       Only include departments where total salary exceeds 200,000.
--       Display the results in descending order of total salary.
--       Limit the result to top 3 departments.
select sum(salary) as total_salary, department 
from employees
group by department
having total_salary>200000
order by total_salary desc
limit 3;


-- 2>  Find courses with more than 10 students, sorted by student count
--     Write an SQL query to count the number of students in each course from the students table.

--       Include only courses where the number of students is greater than 10.
--       Sort the results in descending order of student count.
select * from students_info;

select count(id) as total_students, course 
from students_info
group by course
having total_students>10
order by total_students desc;


-- 3> Find the average order amount per customer, but only for customers who have placed at least 5 orders
--    Write an SQL query to calculate the average order amount for each customer from the orders table.

--       Only include customers who have placed at least 5 orders.
--       Display results in descending order of average order amount.
select * from orders;

select avg(order_amount) as avg_amount, count(customer_name) as cnt
from orders
group by customer_name
having cnt>4
order by avg_amount desc;

select customer_name, avg(order_amount) as avg_order_amount 
from orders
group by customer_name
having count(*) > 4
order by avg_order_amount desc;


-- 4> Find the total sales per product category, but only for categories where total sales exceed $50,000
--    Write an SQL query to calculate the total sales amount per product category from the sales table.

--      Only include categories where total sales exceed 50,000.
--      Sort the results in descending order of total sales.
select * from sales;

select sum(price) as total_sale, category
from sales
group by category
having total_sale>30000
order by total_sale desc;


-- 5> Find the most profitable store locations based on revenue
--    Write an SQL query to calculate the total revenue per store location from the transactions table.

--      Only include stores where total revenue exceeds 100,000.
--      Display the results sorted in descending order of total revenue.

select * from transactions;

select sum(price) as total_revenue, store_location
from transactions
group by store_location
having total_revenue>1000
order by total_revenue desc;
