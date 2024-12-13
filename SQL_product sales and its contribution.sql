use ajay;
create table Products(category varchar(20), name varchar(20), sales int);
insert into Products(category,name, sales) values
('Electronics','laptop',70000),
('Electronics','TV',78000),
('Electronics','Earphones',10000),
('Electronics','Mobile',50000),
('Electronics','laptop',83000),
('Electronics','TV',49000),
('Electronics','laptop',50000),
('Electronics','Computer',71000),
('Electronics','Camera',50000),
('Electronics','Camera',67000),
('Electronics','TV',36000),
('Electronics','AC',50000),
('Electronics','laptop',54000),
('Electronics','AC',45000),
('Electronics','Computer',39000),
('Electronics','Earphones',90000),
('Electronics','Computer',55000),
('Electronics','Speaker',45000),
('Electronics','AC',60000),
('Electronics','laptop',23000),
('Electronics','Camera',65000),
('Electronics','TV',98000),
('Electronics','Speaker',50000),
('Electronics','Earphones',85000),
('Electronics','laptop',90000),
('Electronics','AC',79000),
('Electronics','TV',61000),
('Electronics','laptop',80000),
('Electronics','AC',80000),
('Electronics','TV',50000),
('Electronics','Earphones',58000),
('Electronics','AC',88000),
('Electronics','Speaker',75000),
('Electronics','AC',40000),
('Electronics','Speaker',50000),
('Electronics','Speaker',85000),
('Electronics','Mobile',95000),
('Electronics','Mobile',77000),
('Electronics','Mobile',50000);

select * from Products;

#Q1. Give me the top 4 products by sales.

select top 4 * from Products order by sales desc;

#Q2. give me the contribution of each products in the total sales.


with new_table1 as (select name, cast(sum(sales) as real) as product_sales from Products group by name),

     new_table2 as (select *, cast(sum(product_sales) over() as real) as Total_sales from new_table1)

	 select*, concat(round((product_sales/Total_sales )*100,2 ), '%') as Product_contribution from new_table2;


#Q3. find out how many products contribute to near 80% of total sales.


with new_table1 as (select name, cast(sum(sales) as real) as product_sales from Products group by name),

     new_table2 as (select *, cast(sum(product_sales) over() as real) as Total_sales from new_table1),
	 
	 new_table3 as (select	 new_table2.name, new_table2.product_sales, new_table2.Total_sales, 
	 (Total_sales)* 0.8 as maximum_80_of_sales,
	 sum(product_sales) over(order by product_sales desc rows between unbounded preceding and 0 preceding) as cumulative_sales
	 from new_table2)

	 select* from new_table3 where cumulative_sales<maximum_80_of_sales  order by product_sales desc;


Q4 find out the average sales and tell how many products are doing good and doing above the average sales and vice-versa.

 with new_table1 as (select name, sum(sales) as product_wise_sales from Products group by name),
      new_table2 as (select*, sum(product_wise_sales) over() as total_sales from new_table1),
	  new_table3 as (select*, total_sales/8 as average_sales_product_wise from new_table2)

	  select*,
	  case when product_wise_sales> average_sales_product_wise then 'above average and doing good' else 'below average and not doing good' end as result
	  from new_table3;




	 



     