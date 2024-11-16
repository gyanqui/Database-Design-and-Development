-- W04 Exercise(s)
-- GABRIEL YANQUI

-- Exercise 5-1
-- Fill in the blanks (denoted by <#>) for the following query to obtain the results that follow:
USE sakila;
SELECT c.first_name, c.last_name, a.address, ct.city
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE a.district = 'California';

-- Exercise 5-2
-- Write a query that returns the title of every film in which an actor with the first name JOHN appeared.
SELECT 
	f.title 
FROM 
	film f
JOIN 
	film_actor fa ON f.film_id = fa.film_id
JOIN 
	actor a ON fa.actor_id = a.actor_id
WHERE 
	a.first_name = "JOHN";

-- Exercise 5-3
-- Construct a query that returns all addresses that are in the same city. You will need to join the address
-- table to itself, and each row should include two different addresses.

SELECT
	a1.address addr1, a2.address addr2, a1.city_id
FROM
	address a1
JOIN 
	address a2 ON a1.city_id = a2.city_id
AND a1.address < a2.address;

-- Exercesi 5-4
-- Write a query that shows all the films starring Joe Swank that have a length between 90 and 120 minutes. 
SELECT
	f.title,
    f.length
FROM 
	film f
JOIN 
	film_actor fa ON f.film_id = fa.film_id
JOIN 
	actor a ON fa.actor_id = a.actor_id
WHERE 1=1 
	AND a.first_name = "JOE" 
    AND a.last_name = "Swank"
    AND f.length BETWEEN 90 AND 120;

-- Exercesi 5-5
-- Write a query that shows how many rentals are associated with each of the two staff members.
SELECT
	st.first_name,
    st.last_name,
    count(r.rental_id)
FROM
	staff st
JOIN
	rental r ON st.staff_id = r.staff_id
GROUP BY 
	st.first_name,
    st.last_name
ORDER BY
	st.first_name;
