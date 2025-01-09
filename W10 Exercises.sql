use sakila;

-- Conditional Logic Example
SELECT 
    first_name,
    last_name,
    CASE
        WHEN active = 1 THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END activity_type
FROM
    customer;

-- SEARCHED CASE EXPRESSION EXAMPLE
CASE
	WHEN category.name IN ('Children', 'Family', 'Sports', 'Animation')
		THEN 'All Ages'
    WHEN category.name = 'Horror'
		THEN 'Adult'
    WHEN category.name = ('Music', 'Games')
		THEN 'Teens'
    ELSE 'Other'
END

-- SIMPLE CASE EXPRESSION EXAMPLE
CASE category.name
	WHEN 'Children' THEN 'All Ages'
	WHEN 'Family' THEN 'All Ages'
	WHEN 'Sports' THEN 'All Ages'
	WHEN 'Animation' THEN 'All Ages'
	WHEN 'Horror' THEN 'Adult'
	WHEN 'Music' THEN 'Teens'
	WHEN 'Games' THEN 'Teens'
	ELSE 'Other'
END


 -- CHECKING FOR EXISTENCE EXAMPLE
 SELECT 
    a.first_name, 
    a.last_name,
    CASE
        WHEN EXISTS (
            SELECT 1 
            FROM film_actor fa
            INNER JOIN film f ON fa.film_id = f.film_id
            WHERE fa.actor_id = a.actor_id
            AND f.rating = 'G'
        ) THEN 'Y'
        ELSE 'N'
    END AS g_actor,
    
    CASE
        WHEN EXISTS (
            SELECT 1 
            FROM film_actor fa
            INNER JOIN film f ON fa.film_id = f.film_id
            WHERE fa.actor_id = a.actor_id
            AND f.rating = 'PG'
        ) THEN 'Y'
        ELSE 'N'
    END AS pg_actor,
    
    CASE
        WHEN EXISTS (
            SELECT 1 
            FROM film_actor fa
            INNER JOIN film f ON fa.film_id = f.film_id
            WHERE fa.actor_id = a.actor_id
            AND f.rating = 'NC-17'
        ) THEN 'Y'
        ELSE 'N'
    END AS nc17_actor

FROM actor a
WHERE a.last_name LIKE 'S%' OR a.first_name LIKE 'S%';

-- EXAMPLE 2
SELECT 
    f.title,
    CASE 
        WHEN (SELECT COUNT(*) 
              FROM inventory i 
              WHERE i.film_id = f.film_id) = 0 THEN 'Out Of Stock'
        WHEN (SELECT COUNT(*) 
              FROM inventory i 
              WHERE i.film_id = f.film_id) = 1 THEN 'Scarce'
        WHEN (SELECT COUNT(*) 
              FROM inventory i 
              WHERE i.film_id = f.film_id) = 3 THEN 'Available'
        WHEN (SELECT COUNT(*) 
              FROM inventory i 
              WHERE i.film_id = f.film_id) = 4 THEN 'Available'
        ELSE 'Common'
    END AS film_availability
FROM film f;

-- CONDITIONAL UPDATE EXAMPLE
UPDATE 
	customer
SET active =
	CASE
		WHEN 90 <= (SELECT datediff(now(), max(rental_date))
		FROM rental r
		WHERE r.customer_id = customer.customer_id)
		THEN 0
		ELSE 1
	END
WHERE 
	active = 1;

-- HANDLING NULL VALUES EXAMPLE
SELECT 
    c.first_name, 
    c.last_name,
    CASE
        WHEN a.address IS NULL THEN 'Unknown'
        ELSE a.address
    END AS address,
    CASE
        WHEN ct.city IS NULL THEN 'Unknown'
        ELSE ct.city
    END AS city,
    CASE
        WHEN cn.country IS NULL THEN 'Unknown'
        ELSE cn.country
    END AS country
FROM customer c
LEFT OUTER JOIN address a
    ON c.address_id = a.address_id
LEFT OUTER JOIN city ct
    ON a.city_id = ct.city_id
LEFT OUTER JOIN country cn
    ON ct.country_id = cn.country_id;
    
    
    
/*********************************************************
**********************************************************
EXERCISES
**********************************************************
*********************************************************/
-- EXERCISE 1
-- Rewrite the following query, which uses a simple CASE expression, so that the same results 
-- are achieved using a searched CASE expression. Try to use as few WHEN clauses as possible.
SELECT name,
  CASE name
    WHEN 'English' THEN 'latin1'
    WHEN 'Italian' THEN 'latin1'
    WHEN 'French' THEN 'latin1'
    WHEN 'German' THEN 'latin1'
    WHEN 'Japanese' THEN 'utf8'
    WHEN 'Mandarin' THEN 'utf8'
    ELSE 'Unknown'
  END character_set
FROM language;

-- SOLUTION
SELECT name,
  CASE
    WHEN name IN ('English', 'Italian', 'French', 'German') THEN 'latin1'
    WHEN name IN ('Japanese', 'Mandarin') THEN 'utf8'
    ELSE 'Unknown'
  END character_set
FROM language;

-- EXERCISE 2
-- Rewrite the following query so that the result set contains a single row with five 
-- columns (one for each rating). Name the five columns (G, PG, PG_13, R, and NC_17).
SELECT 
    rating, COUNT(*)
FROM
    film
GROUP BY rating;

-- SOLUTION
SELECT 
    SUM(CASE
		WHEN rating = 'G'
			THEN 1
            ELSE 0
		END) G,
    SUM(CASE
		WHEN rating = 'PG'
			THEN 1
            ELSE 0
		END) PG,
    SUM(CASE
		WHEN rating = 'PG-13'
			THEN 1
            ELSE 0
		END) 'PG-13',
    SUM(CASE
		WHEN rating = 'R'
			THEN 1
            ELSE 0
		END) R_rating,
    SUM(CASE
		WHEN rating = 'NC-17'
			THEN 1
            ELSE 0
		END) 'NC-17'
FROM
    film;

-- EXERCISE 3

SELECT 
    LEFT(last_name, 1) AS starts_with,
    SUM(CASE
        WHEN active = 1 THEN 1
        ELSE 0
    END) AS active_count,
    SUM(CASE
        WHEN active = 0 THEN 1
        ELSE 0
    END) AS inactive_count
FROM
    customer
GROUP BY LEFT(last_name, 1)
HAVING COUNT(last_name) > 0
ORDER BY starts_with;

-- EXERCISE 4
WITH Alphabet AS (
    SELECT 'A' AS letter
    UNION ALL SELECT 'B'
    UNION ALL SELECT 'C'
    UNION ALL SELECT 'D'
    UNION ALL SELECT 'E'
    UNION ALL SELECT 'F'
    UNION ALL SELECT 'G'
    UNION ALL SELECT 'H'
    UNION ALL SELECT 'I'
    UNION ALL SELECT 'J'
    UNION ALL SELECT 'K'
    UNION ALL SELECT 'L'
    UNION ALL SELECT 'M'
    UNION ALL SELECT 'N'
    UNION ALL SELECT 'O'
    UNION ALL SELECT 'P'
    UNION ALL SELECT 'Q'
    UNION ALL SELECT 'R'
    UNION ALL SELECT 'S'
    UNION ALL SELECT 'T'
    UNION ALL SELECT 'U'
    UNION ALL SELECT 'V'
    UNION ALL SELECT 'W'
    UNION ALL SELECT 'X'
    UNION ALL SELECT 'Y'
    UNION ALL SELECT 'Z'
)

SELECT 
    Alphabet.letter AS starts_with,
    CASE 
        WHEN SUM(CASE WHEN c.active = 1 THEN 1 ELSE 0 END) IS NULL THEN 0
        ELSE SUM(CASE WHEN c.active = 1 THEN 1 ELSE 0 END)
    END AS active_count,
    CASE 
        WHEN SUM(CASE WHEN c.active = 0 THEN 1 ELSE 0 END) IS NULL THEN 0
        ELSE SUM(CASE WHEN c.active = 0 THEN 1 ELSE 0 END)
    END AS inactive_count
FROM Alphabet
LEFT OUTER JOIN (
    SELECT LEFT(last_name, 1) AS starts_with, active
    FROM customer
) AS c ON Alphabet.letter = c.starts_with
GROUP BY Alphabet.letter
ORDER BY Alphabet.letter;

-- EXERCISE 5
SELECT 
    LEFT(last_name, 1) AS starts_with,
    SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count,
    SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM customer
GROUP BY LEFT(last_name, 1)
HAVING SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) > 30
ORDER BY starts_with;

