-- GABRIEL YANQUI
-- W08

use sakila;
-- Exercise 1
-- Construct a query against the film table that uses 
-- a filter condition with a noncorrelated subquery against 
-- the category table to find all action films 
-- (category.name = 'Action').

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            fc.film_id
        FROM
            film_category fc
                INNER JOIN
            category c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Action');
            
-- Exercise 2
-- Rework the query from Exercise 9-1 using a correlated 
-- subquery against the category and film_category tables 
-- to achieve the same results.

SELECT 
    f.title
FROM
    film f
WHERE
    EXISTS( SELECT 
            1
        FROM
            film_Category fc
                INNER JOIN
            category c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Action'
                AND fc.film_id = f.film_id);

-- Exercise 3
-- Join the following query to a subquery against the film_actor table to show the level of each actor:
-- The subquery against the film_actor table should count the number of rows for each actor using group 
-- by actor_id, and the count should be compared to the min_roles/max_roles columns to determine
-- which level each actor belongs to.

SELECT 
    actr.actor_id, grps.level
FROM
    (SELECT 
        actor_id, COUNT(*) num_roles
    FROM
        film_actor
    GROUP BY actor_id) actr
        INNER JOIN (
        SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles 
		UNION ALL 
		SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles 
		UNION ALL 
		SELECT 'Newcomer' level, 1 min_roles, 19 max_roles
		) grps ON actr.num_roles BETWEEN grps.min_roles AND grps.max_roles;
        
-- Exercise 4
-- Rewrite the following query with two subqueries into multicolumn subquery. The subquery should use a 
-- filtered cross join between the film and actor tables.

SELECT 
    fa.actor_id, fa.film_id
FROM
    film_actor fa
WHERE
    (fa.actor_id , fa.film_id) IN (SELECT 
            a.actor_id, f.film_id
        FROM
            actor a
                CROSS JOIN
            film f
        WHERE
            a.last_name = 'MONROE'
                AND f.rating = 'PG');
        
        
-- Exercise 5
-- Rewrite the following query with two subqueries into one with two correlated subqueries. 
-- Both of the subqueries should return null values.

SELECT 
    fa.actor_id, fa.film_id
FROM
    film_actor fa
WHERE
    EXISTS( SELECT 
            1
        FROM
            actor a
        WHERE
            a.actor_id = fa.actor_id
                AND a.last_name = 'MONROE')
        AND EXISTS( SELECT 
            1
        FROM
            film f
        WHERE
            f.film_id = fa.film_id
                AND f.rating = 'PG');
        
        
        
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    customer_id <> ALL (SELECT 
            customer_id
        FROM
            payment
        WHERE
            amount = 0);
        
        
SELECT 
    city_id, city
FROM
    city
WHERE
    country_id IN (SELECT 
            country_id
        FROM
            country
        WHERE
            country IN ('Canada' , 'Mexico'));
            
SELECT 
    film_id
FROM
    film
WHERE
    title LIKE '%HARRY';
    
    
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    customer_id NOT IN (SELECT 
            customer_id
        FROM
            payment
        WHERE
            amount = 0);
        
SELECT 
    *
FROM
    (SELECT 'Y' AS flag UNION ALL SELECT 'N' AS flag) decision;
        
        
        
        
        
        
        
        
