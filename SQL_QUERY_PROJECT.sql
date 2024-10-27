create table retail_sales
    ( transactions_id INT primary key,
	  sale_date DATE,
	  sale_time TIME,
	  customer_id INT,
	  gender VARCHAR(15),
	  age INT,
	  category VARCHAR(15),
	  quantiy INT,
	  price_per_unit FLOAT,
	  cogs FLOAT,
	  total_sale FLOAT
	 );

	 select * from retail_sales 
	 where 
	    transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or 
		customer_id is null
		or
		gender is null
		or
		category is null
		or
		quantiy is null
		or
		cogs is null
		or
		total_sale is null

    -------
	
DATA CLEANING

    delete from retail_sales
	where 
	    transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or 
		customer_id is null
		or
		gender is null
		or
		category is null
		or
		quantiy is null
		or
		cogs is null
		or
		total_sale is null;

		------
--DATA EXPLORATION
  - HOW MANY SALES DO WE HAVE?
     SELECT COUNT(*) as total_sale FROM retail_sales

  - HOW MANY distinct CUSTOMERS DO WE HAVE?
     SELECT COUNT(distinct customer_id) as total_sale FROM retail_sales

  -	HOW MANY category DO WE HAVE?
      SELECT distinct category FROM retail_sales

--BUSINESS KEY PROBLEMS AND SOLUTIONS-- 
--MY ANALYSIS AND FINDINDS--

  Q1-- WRITE THE SQL QUERY TO RETRIEVE ALL THE COLUMNS FOR SALES MADE ON "2022-11-05" ?

  SOL--
       select * from retail_sales where sale_date = '2022-11-05';

  Q2-- WRITE THE SQL QUERY TO RETRIEVE ALL THE TRANSACTIONS WHERE THE CATEGORY IS CLOTHING AND QUANTITY SOLD IS MORE THAN 4 IN THE MONTH OF NOV-2022?  

  SOL--
       select * from retail_sales
	   where category = 'Clothing' 
	   AND quantiy >= 4 
	   AND to_char(sale_date,'yyyy-mm') = '2022-11'

  Q3-- WRITE THE SQL QUERY TO CALCULATE TOTAL SALES FOR EACH CATEGORY?

  SOL--
       select category, sum(total_sale) as net_sale from retail_sales
	   group by 1

  Q4--	WRITE THE SQL QUERY TO FIND THE AVERAGE AGE OF THE PERSON WHO PURCHASED ITEMS FROM THE BEAUTY CATEGORY?

  SOL-- 
       select round(avg(age),2)
	   from retail_sales 
	   where category = 'Beauty' 

  Q5-- 	WRITE THE SQL QUERY TO FIND ALL THE TRANSACTIONS WHERE TOTAL SALE IS GREATER THEN 1000?  

  SOL--
      select * from retail_sales
	   where total_sale > 1000

  Q6--  WRITE THE SQL QUERY TO FIND TOTAL NUMBER OF TRANSACTIONS (TRANSACTIONS_ID) MADE BY EACH GENDER IN EACH CATEGORY?
  SOL--
       select category, gender,
	   count(*) as transactions
	   from retail_sales 
	   group by category, gender
	   order by 1

  Q7--  WRITE THE SQL QUERY TO CALCULATE AVERAGE SALE FOR EACH MONTH AND FIND OUT BEST SELLING MONTH IN EACH YEAR?
  SOL--
       select
	   year, month, avg_sale from
	   (
	   select 
	   extract( YEAR FROM sale_date) as year,
	   extract( MONTH FROM sale_date) as month,
	   avg(total_sale) as avg_sale,
	   rank() over( partition by  extract( YEAR FROM sale_date) order by avg(total_sale) desc )as rank
	   from retail_sales
	   group by 1, 2
	   ) as t1
	   where rank = 1

  Q8-- 	WRITE THE SQL QUERY TO FIND TOP 5 CUSTOMERS ON THE HIGHEST TOTAL SALE?
  SOL--
       select customer_id,
	   sum(total_sale) as total_sale
	   from retail_sales
	   group by 1
	   order by 2 desc
	   limit 5

  Q9-- 	WRITE THE SQL QUERY FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY?
  SOL--
       select category, count(distinct customer_id)
	   from retail_sales
       group by category

  Q10-- WRITE THE SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS ( EXAMPLE: MORNING < 12, AFTERNOON BETWEEN 12-17 , EVENING >17) ?
  SOL--
       with hourly_sale
	   as
	   (
	   select *,
	        case
			   when extract(hour from sale_time) < 12 then 'morning'
			   when extract(hour from sale_time) between 12 and 17 then 'afternoon'
			   else 'evening'
			end as shift  
		from retail_sales	   
		)
		select shift, count(*) as total_orders
		from hourly_sale 
		group by shift

		---END OF PROJECT---
		
       
        
       
	   