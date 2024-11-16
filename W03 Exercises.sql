-- W03 Exercise(s)
-- GABRIEL YANQUI

-- Exercise 4-1
-- Which of the payment IDs would be returned by the following filter conditions?
USE sakila;
SELECT payment_id
FROM payment
WHERE payment_id BETWEEN 101 AND 120 AND customer_id <> 5 AND (amount > 8 OR date(payment_date) = '2005-08-23');


-- Exercise 4-2
-- Which of the payment IDs would be returned by the following filter conditions?
SELECT payment_id
FROM payment
WHERE payment_id BETWEEN 101 AND 120 AND customer_id = 5 AND NOT (amount > 6 OR date(payment_date) = '2005-06-19');

-- Exercise 4-3
-- Construct a query that retrieves all rows from the payments table where the amount is either 1.98, 7.98, or 9.98.

SELECT amount
FROM payment
WHERE amount IN (1.98, 7.98, 9.98);

-- Exercise 4-4
-- Construct a query that finds all customers whose last name contains an A in the second position and a W anywhere after the A.
SELECT first_name, last_name
FROM customer
WHERE last_name LIKE '_A%W%';


