-- GABRIEL YANQUI
-- W05

use sakila;
-- Exercie 1
-- Construct a query that counts the number of rows in the payment table.

SELECT 
    COUNT(*)
FROM
    payment;

-- Exercie 2
-- Modify your query from Question 1 to count the number of payments made by each customer. 
-- Show the customer_id and the total amount paid for each customer.

SELECT 
    customer_id, COUNT(*), SUM(amount)
FROM
    payment
GROUP BY customer_id;

-- Exercie 3
-- Modify your query from Question 2 to include only those customers who have at least 40 payments.

SELECT 
    customer_id, COUNT(*), SUM(amount)
FROM
    payment
GROUP BY customer_id
HAVING COUNT(*) >= 40;
