use sakila;
-- EXERCISE 1
-- Create a view definition that can be used by the following query to generate the given results from this query:
-- mysql> SELECT title
--    -> ,      category_name
--    -> ,      first_name
--    -> ,      last_name
--    -> FROM   film_ctgry_actor
--    -> WHERE  last_name = 'FAWCETT';
    
CREATE VIEW film_ctgry_actor AS
SELECT 
    f.title,
    c.name AS category_name,
    a.first_name,
    a.last_name
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN film_actor fa ON fa.film_id = f.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id;

SELECT 
	title,      
	category_name,      
    first_name,      
    last_name
 FROM   film_ctgry_actor
 WHERE  last_name = 'FAWCETT';
 
 
-- EXERCISE 2
-- The film rental company manager would like to have a report that includes the name of every country, 
-- along with the total payments for all customers who live in each country. Generate a view definition 
-- that queries the country table and uses a scalar subquery to calculate a value for a column named tot_payments.
CREATE VIEW country_payments AS
SELECT 
    c.country,
    (
        SELECT SUM(p.amount)
        FROM city ct
        INNER JOIN address a ON ct.city_id = a.city_id
        INNER JOIN customer cst ON a.address_id = cst.address_id
        INNER JOIN payment p ON cst.customer_id = p.customer_id
        WHERE ct.country_id = c.country_id
    ) AS tot_payments
FROM country c;

-- EXERCISE 3
-- Write a nonupdateable view that displays the following result set or any subset of columns in a single row where 
-- there's a column name for each rating. 
CREATE VIEW rating_distribution AS
SELECT
    SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS G,
    SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS PG,
    SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS PG_13,
    SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS R,
    SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS NC_17
FROM
    film;

	SELECT *
	FROM   rating_distribution;
    
SELECT g
FROM   rating_distribution;

SELECT G
FROM   rating_distribution;

-- EXERCISE 4
-- Write a nonupdateable actor_films_by_year view that displays the following ordered result set from the actor, 
-- film_actor, and film tables.
CREATE VIEW actor_films_by_year AS
SELECT
    CONCAT(UPPER(a.last_name), ', ', UPPER(a.first_name)) AS full_name,
    f.release_year,
    COUNT(fa.film_id) AS films_made
FROM
    actor a
INNER JOIN
    film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN
    film f ON fa.film_id = f.film_id
GROUP BY
    CONCAT(UPPER(a.last_name), ', ', UPPER(a.first_name)), f.release_year
ORDER BY
    full_name ASC;
    
SELECT * 
FROM actor_films_by_year;

-- EXERCISE 5
-- Write a nonupdateable rental_stats view that returns the rating column and a rent_ratio column calculated by 
-- dividing the num_rentals by inventory_cnt column value found in the film_stats view of Chapter 14 (Learning SQL). 
-- The rental_stats view should have the following structure when you describe it.
CREATE VIEW film_stats
AS
SELECT f.film_id, f.title, f.description, f.rating,
 (SELECT c.name
  FROM category c
    INNER JOIN film_category fc
    ON c.category_id = fc.category_id
  WHERE fc.film_id = f.film_id) category_name,
 (SELECT count(*)
  FROM film_actor fa
  WHERE fa.film_id = f.film_id
 ) num_actors,
 (SELECT count(*)
  FROM inventory i
  WHERE i.film_id = f.film_id
 ) inventory_cnt,
 (SELECT count(*)
  FROM inventory i
    INNER JOIN rental r
    ON i.inventory_id = r.inventory_id
  WHERE i.film_id = f.film_id
 ) num_rentals
FROM film f;

CREATE VIEW rental_stats AS
SELECT 
    rating,
    CAST(num_rentals AS DECIMAL(24, 4)) / NULLIF(inventory_cnt, 0) AS rent_ratio
FROM 
    film_stats;

SELECT   *
FROM     rental_stats
WHERE    rent_ratio > 4
ORDER BY rating;

-- Code to get the columns name of any table
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'rental';