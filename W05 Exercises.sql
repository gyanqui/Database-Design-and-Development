-- W05
-- Gabriel Yanqui

-- Exercie 1
-- Write a compound query that finds the first and last names of all actors and customers 
-- whose last name starts withL and returns the following result set.
use sakila;
SELECT 
    first_name, 
    last_name
FROM 
    actor
WHERE
    last_name LIKE "L%"
UNION
SELECT
    first_name, 
    last_name
FROM 
    customer
WHERE
    last_name LIKE "L%";
    
-- Exercie 2
-- Sort the results from the previous question by the last_name column.

SELECT 
    first_name, 
    last_name
FROM 
    actor
WHERE
    last_name LIKE "L%"
UNION
SELECT
    first_name, 
    last_name
FROM 
    customer
WHERE
    last_name LIKE "L%"
ORDER BY
    last_name;