/* ============================================================
   PRACTICE FILE: AGGREGATE FUNCTIONS & TEXT FUNCTIONS
   Table: Products
   Instructions: Write the SQL query below each question.
   ============================================================ */


/* ------------------------------------------------------------
   STEP 1: CREATE TABLE
   ------------------------------------------------------------ */

create database practice;
use practice;

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    city VARCHAR(50),
    price INT,
    description VARCHAR(100)
);


/* ------------------------------------------------------------
   STEP 2: INSERT DATA
   ------------------------------------------------------------ */

INSERT INTO Products VALUES
(1, 'wireless mouse', 'Electronics', 'Bangalore', 799, 'compact wireless mouse'),
(2, 'Office Chair', 'Furniture', 'Delhi', 4500, 'ergonomic office chair'),
(3, 'BLUETOOTH SPEAKER', 'Electronics', 'Bangalore', 2200, 'portable bluetooth speaker'),
(4, 'Study Table', 'Furniture', 'Mumbai', 3800, 'wooden study table'),
(5, 'laptop stand', 'Electronics', 'Pune', 1200, 'adjustable laptop stand'),
(6, 'Bookshelf', 'Furniture', 'Delhi', 3200, 'wall mounted bookshelf'),
(7, 'Table Lamp', 'Electronics', 'Mumbai', 950, 'LED table lamp'),
(8, '  Yoga Mat  ', 'Fitness', 'Bangalore', 600, 'non-slip yoga mat');


select * from Products ;

/* ============================================================
   SECTION A: AGGREGATE FUNCTIONS
   ============================================================ */

-- Q1. Find the total number of products.
select count(product_name) from Products; 


-- Q2. Find the total value of all products (sum of prices).
select sum(price) as total_product from Products;

-- Q3. Find the average price of products.
select avg(price) as average_price from Products;

-- Q4. Find the most expensive and least expensive product price.
select product_name,max(price) as expensive ,min(price) as least_expensive
from Products
group by product_name;

-- Q5. Find how many products exist in each category.
 

-- Q6. Find the average price per city.
select city, avg(price) as average_price_per_city
from Products
group by city;

-- Q7. Find categories where the average price is more than 2000.
select city,round(sum(price),2) as Avg_price_city_wise
from Products
group by city
having Avg_price_city_wise >2000
order by Avg_price_city_wise desc;

-- Q8. Find the total price of products per city, sorted from highest to lowest.
select city, sum(price) as total_price
from Products
group by city;

-- Q9. Find the number of distinct cities the products are available in.
select city, count(distinct product_name) from Products; 



/* ============================================================
   SECTION B: TEXT FUNCTIONS
   ============================================================ */

-- Q1. Display all product names in uppercase and lowercase.
select product_name,
concat(
upper(substring(trim(product_name),1,1) ),
lower(substring(trim(product_name),2))
) as updated_name
from Products ;


-- Q2. Remove the extra spaces from the product_name column and display the cleaned result.
select product_name,
trim(product_name) as updated_name
from Products ;

-- Q3. Find the length of each product_name (after removing spaces).
select Product_name,
length(trim(product_name)) as length
from Products ;


-- Q4. Extract the first 5 characters of each description.
select description,
    left(description, 5) as first_5_characters
from Products;

-- Q5. Combine product_name and category into a single column separated by a hyphen.
select
    CONCAT(product_name, ' - ', category) as product_category
from Products;
-- Q6. Replace the word 'table' with 'desk' in the description column.
select description,
replace(description, 'table', 'desk') AS updated_description
from Products;

-- Q7. Convert each product_name into proper case (first letter capital, rest lowercase).
select product_name,
    CONCAT(
        UPPER(LEFT(TRIM(product_name),1)),
        LOWER(SUBSTRING(TRIM(product_name),2))
    ) as proper_case
from Products;

-- Q8. Find all products whose description contains the word 'wireless'.
select *
from Products
where description LIKE '%wireless%';

-- Q9. Find all products whose product_name starts with the letter 'B' (case-insensitive).

select * from Products
where UPPER(TRIM(product_name)) LIKE 'B%';