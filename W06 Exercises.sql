-- W06
-- Gabriel Yanqui

-- EXERCISE 1
-- Write a query that returns the 17th through 25th characters of the string 
-- 'Please find the substring in this string' by using a "Parsed" column alias, 
-- such as the following:

SELECT 
    SUBSTRING('Please find the substring in this string',17, 9) AS parsed;
    
-- EXERCISE 2
-- Write a query that returns three columns. The first column should be the absolute 
-- value of -25.76823 with an alias of 'abs', the second column should be the sign 
-- (-1,0, or 1) of the number -25.76823 with an alias of 'sign', and the third column 
-- should be the number -25.76823 rounded to the nearest hundredth with an alias of 'round'. 
-- It should return the following:
    
SELECT
    ABS(-25.76823) AS abs,
    SIGN(-25.76823) AS sign,
    ROUND(-25.76823, 2) AS round;
    
-- EXERCISE 3
-- Write a query that returns just the month portion of the current date with a column 
-- alias of 'month' (for example, the number displayed changes with the day you run the query).

SELECT
    EXTRACT(MONTH FROM current_date()) AS month;
    
    
    
    
    
    
