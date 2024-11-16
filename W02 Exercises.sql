-- GABRIEL YANQUI
-- W02

use sakila;

-- Exercise 1
-- Write the SQL statement that retrieves the actor ID, first name, and last name 
-- for all actors. Sort results by last name and then by first name.

SELECT 
    actor_id, first_name, last_name
FROM
    actor
ORDER BY 3 , 2;

-- Exercise 2
-- Write the SQL statement that retrieves the actor ID, first name, and last name 
-- for all actors whose last name equals 'WILLIAMS' or 'DAVIS'.

SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    last_name IN ('WILLIAMS' , 'DAVIS');

-- Exercise 3
-- Write a query against the rental table that returns the IDs of the customers who rented 
-- a film on July 5, 2005 (use the rental.rental_date column, and you can use the date() 
-- function to ignore the time component). Include a single row for each distinct customer ID.

SELECT DISTINCT
    customer_id
FROM
    rental
WHERE
    DATE(rental_date) = '2005-07-05';

-- Exercise 4
-- Fill in the blanks (denoted by <#>) for this multi table query:

SELECT 
    c.email, r.return_date
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
ORDER BY 1 ASC;