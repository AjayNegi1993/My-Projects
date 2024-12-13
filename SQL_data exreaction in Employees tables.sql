create database Project;
Use Project;
create table Employees( Emp_id int, First_name varchar(10), Last_name varchar (20), Department varchar(20), Salary int);
insert into Employees(Emp_id, First_name , Last_name , Department , Salary) values
(101,'Emma','Watson','Sales',50000),
(102,'Rupert','Grint','Sales',90000),
(103,'Tom','Felton','HR',35000),
(104,'Fred','kilosky','Sales',98000),
(105,'Kristen','Agarwal','HR',41000),
(106,'Clark','klent','Admin',55000),
(107,'Chris','Evans','Sales',20000),
(108,'Virat','Kohli','HR',19000),
(109,'Bruce','Wayne','Sales',17000),
(110,'Fred','Verma','Finance',28000),
(111,'Bruce','Banner','Finance',48000),
(112,'Kyla','waltman','Sales',67000),
(113,'Tont','Stark','Admin',78000),
(114,'Robin','Johnson','HR',81000),
(115,'Elizabeth','Olsen','Sales',70000),
(116,'Scarlett','Johnansson','HR',63000),
(117,'Johny','George','HR',55000),
(118,'Virat','Kohli','Finance',59000),
(119,'Wanda','Sharma','Finance',50000),
(120,'Steve','Rodgers','Admin',12000),
(121,'Thor','Gupta','HR',80000),
(122,'John','Cena','Admin',88000),
(123,'Pat','Cummins','Admin',95000),
(124,'David','Warner','Finance',30000);

select* from Employees;

Q.1 find out the highest earning employees details from each department?

with New_table as (select*, DENSE_RANK() over(partition by Department order by Salary desc) as Salary_Rank from Employees)
     select* from New_table where Salary_Rank=1;


Q.2 find out the highest and lowest earning employees details from each department?


with New_table as (select*, DENSE_RANK() over(partition by Department order by Salary desc) as Highest_earning,
         DENSE_RANK() over(partition by Department order by Salary Asc) as Lowest_earning
         from Employees),
     New_table2 as (select*, 
         case when Highest_earning=1 then 'highest_earning_employee' else ' ' end as abc,
         case when Lowest_earning=1 then 'lowest_earning_employee' else ' ' end pqr
         from New_table) 

select New_table2.Emp_id, New_table2.First_name, New_table2.Last_name, New_table2.Department, New_table2.Salary, New_table2.abc, New_table2.pqr from New_table2 
where abc='highest_earning_employee' or pqr='lowest_earning_employee';
		 
		 
Q.3 Find the 4th largest salary with the emp details?

with New_table1 as (select*, DENSE_RANK() over(order by salary desc) as Denserank from Employees)
     select* from New_table1 where Denserank=4;

Q.4 sort the emp_id in ascending order and give me every alternate record.

select* from Employees where Emp_id % 2!=0;

Q.5 give me the details for the last 5 employees?

With New_table1 as (select*, ROW_NUMBER() over (order by Emp_id) as rownumber from employees)
     select* from New_table1 where rownumber> (select count(*) from New_table1)-5;
		 
		 