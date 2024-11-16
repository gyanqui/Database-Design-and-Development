-- GABRIEL YANQUI
-- W09

-- Exercise 1
-- Using the following table definitions and data, write a query that returns each 
-- customer name along with their total payments (these names differ from the 
-- textbook because they're the ones in the sakila database):

-- Include all customers (while the examples filter on last_name and payment_id), even if no payment records exist for that customer.
use sakila;
-- Query whole customer table
SELECT
    c.first_name,
    SUM(p.amount) AS total_payments
FROM
    customer c
LEFT OUTER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id, c.first_name;
    
-- Query only 3 CUSTOMERS
SELECT 
    c.first_name, 
    SUM(p.amount) AS total_payments
FROM
    customer c
        LEFT OUTER JOIN
    payment p ON c.customer_id = p.customer_id
WHERE
    c.customer_id IN (1 , 4, 210)
GROUP BY c.first_name;    
    
-- Exercise 2
-- Reformulate your query from Question 1 to use the other outer join type (for example, 
-- if you used a LEFT outer join in Exercise 10-1, use a RIGHT outer join this time) such 
-- that the results are identical to Question 1.

-- Query whole customer table
SELECT
    c.first_name, 
    SUM(p.amount) AS total_payments
FROM
    payment p
        RIGHT OUTER JOIN
    customer c ON p.customer_id = c.customer_id
GROUP BY 
	c.customer_id, c.first_name;

-- Query only 3 CUSTOMERS
SELECT
    c.first_name, 
    SUM(p.amount) AS total_payments
FROM
    payment p
        RIGHT OUTER JOIN
    customer c ON p.customer_id = c.customer_id
WHERE
    c.customer_id IN (1 , 4, 210)
GROUP BY c.first_name;

-- Exercise 3
-- 	Devise a query that will generate the set {1,2,3, ..., 99, 100}. 
-- (Hint: use a cross join with at least two FROM clause subqueries.)

SELECT 
    ones.x + tens.x + 1 AS Generated_List
FROM
    (SELECT 0 x UNION ALL SELECT 1 x UNION ALL SELECT 2 x UNION ALL SELECT 3 x UNION ALL SELECT 4 x UNION ALL SELECT 5 x UNION ALL SELECT 6 x UNION ALL SELECT 7 x UNION ALL SELECT 8 x UNION ALL SELECT 9 x) ones
        CROSS JOIN
    (SELECT 0 x UNION ALL SELECT 10 x UNION ALL SELECT 20 x UNION ALL SELECT 30 x UNION ALL SELECT 40 x UNION ALL SELECT 50 x UNION ALL SELECT 60 x UNION ALL SELECT 70 x UNION ALL SELECT 80 x UNION ALL SELECT 90 x) tens
 ORDER BY 
	Generated_List;
   
-- Exercise 4
-- Using the following query as your starting point. Rewrite the query to use a RIGHT JOIN and return the same result set.

SELECT 
    f.film_id, f.title, 
    i.inventory_id
FROM
    film f
LEFT JOIN
    inventory i 
    ON f.film_id = i.film_id
WHERE
    f.title REGEXP '^RA(I|N).*$'
ORDER BY 
	f.film_id , f.title , i.inventory_id;

-- Rewrite Query - RIGHT OUTER JOIN
SELECT 
    f.film_id, f.title, 
    i.inventory_id
FROM
    inventory i
RIGHT JOIN
    film f
    ON i.film_id = f.film_id
WHERE
    f.title REGEXP '^RA(I|N).*$'
ORDER BY 
	f.film_id , f.title , i.inventory_id;

-- Exercise 5
-- Using the following query as your starting point. Rewrite the query to use a RIGHT JOIN and return the same 
-- result set minus the result set of an INNER JOIN without using set operators or subqueries.
SELECT   f.film_id, f.title, i.inventory_id
FROM     film f LEFT JOIN inventory i
ON       f.film_id = i.film_id
WHERE    f.title REGEXP '^RA(I|N).*$'
ORDER BY f.film_id, f.title, i.inventory_id;

-- Rewrite Query - RIGHT OUTER JOIN
SELECT 
    f.film_id, f.title, 
    i.inventory_id
FROM
    inventory i
RIGHT JOIN
    film f
    ON i.film_id = f.film_id 
WHERE
    f.title REGEXP '^RA(I|N).*$'
	AND i.inventory_id IS NULL
ORDER BY 
	f.film_id , f.title , i.inventory_id;

