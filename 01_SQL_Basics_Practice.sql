create database practice;
use practice;

-- Questions

-- 1.Write an SQL query to create a table named students with columns: student_id (Primary Key), name, age, course, and admission_date.
create table student_details(id int, name varchar(20), age int, course varchar(15), admission_date date);


-- 2.Write an SQL query to add a new column email to the students table.
alter table student_details
add column email varchar(20);


-- 3.How can you change the datatype of the age column from INT to TINYINT in the students table?
alter table student_details
modify age tinyint;


-- 4.Write an SQL query to rename the column name to full_name in the students table.
alter table student_details
rename column name to full_name;

desc student_details;


-- 5.Write an SQL query to insert a new record and multiple values into the students table with sample values.
insert into student_details values(101, 'Sumaiya', 20, 'CS', '2018-02-09', 'sample@if.com'); 
insert into student_details values(102, 'Azeem', 21, 'DS', '2019-01-02', 'acdc@if.com');
insert into student_details values(103, 'Lalkot', 22, 'AI', '2020-03-05', 'samdsdse@if.com');
insert into student_details values(104, 'Isha', 23, 'ML', '2021-05-05', 'ssims@if.com');
insert into student_details values(105, 'Srivastava', 24, 'IT', '2022-07-09', 'igiigie@if.com');


-- 6.Write an SQL query to update the course of a student whose student_id is 101.
update student_details set course='CSE'
where id=101;


-- 7.How would you delete a student record where the student_id is 102?
delete from student_details
where id=102;


-- 8.Write an SQL query to select all columns from the students table.
select * from student_details;


-- 9.How do you start a transaction in MySQL?
-- 10.Write an SQL query to insert a new record into the students table inside a transaction.
-- 11.How can you create a savepoint inside a transaction?
-- 12.Write an SQL query to rollback to a specific savepoint in a transaction.
-- 13.How do you commit a transaction in MySQL?

start transaction;
insert into student_details values(106,'nida',25,'FSD','2023-09-09','example@ig.com');
savepoint sp1;

start transaction;
update student_details set id=102
where id=103;
savepoint sp2;

start transaction;
update student_details set id=104
where id=105;
savepoint sp2;
rollback to sp2;
commit;


-- 14.Write an SQL query to count the total number of students in the students table.
select count(full_name)
from student_details;

use sample;

-- 15.How can you find the total sum of all students' fees from a table named payments?
select sum(fees) from payments;


-- 16.Write an SQL query to find the maximum age of students in the students table.
select max(age) from students;


-- 17.How can you find the minimum admission date in the students table?
select min(admission_date) from students;


-- 18.Write an SQL query to calculate the average age of students in the students table.
select avg(age) from students;


-- 19.Write an SQL query to group students by course and count the number of students in each course.
select count(full_name),course
from students
group by course;


-- 20.How can you find the total sum of fees collected per course in the payments table?
select sum(fees),course from payments
group by course;


-- 21.Write an SQL query to find the average age of students in each course.
select avg(age) from students
group by course;


-- 22.How can you filter departments that have more than 5 students using the HAVING clause?
select count(full_name) as cnt,course  from students
group by course having cnt>5;


-- 23.Write an SQL query to find courses where total fees collected is greater than 50,000 using the HAVING clause.
select sum(fees) as total_fees, course from payments
group by course having total_fees>40000;














