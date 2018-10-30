USE sakila;

# Query 1a:
SELECT first_name, last_name
FROM actor;

# Query 1b:
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS "Actor Name"
FROM actor;

# Query 2a:
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

# Query 2b:
SELECT *
FROM actor
WHERE last_name LIKE "%gen%";

# Query 2c:
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE "%li%"
ORDER BY last_name, first_name ASC;

# Query 2d:
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

# Query 3a: 
ALTER TABLE actor
ADD COLUMN description BLOB;

# Query 3b:
ALTER TABLE actor
DROP COLUMN description;

# Query 4a: 
SELECT last_name, COUNT(last_name) AS "Count of Last Name"
FROM actor
GROUP BY last_name;

# Query 4b: 
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

# Query 4c:
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "Groucho" AND last_name = "Williams";

# Query 4d: 
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "Harpo" AND last_name = "Williams";

# Query 5a:
SHOW CREATE TABLE address;

# Query 6a:
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN address a
ON s.address_id = a.address_id;

# Query 6b: 
SELECT s.first_name, s.last_name, SUM(amount) AS "Total"
FROM payment p
LEFT JOIN staff s
ON p.staff_id = s.staff_id
WHERE STR_TO_DATE(`payment_date`,'%Y-%m-%d') 
	BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY S.staff_id;

# Query 6c: 
SELECT title, SUM(a.film_id) AS "Num of Actors"
FROM film f
INNER JOIN film_actor a
ON f.film_id = a.film_id
GROUP BY title;

# Query 6d:
SELECT COUNT(film_id)
FROM inventory
WHERE film_id IN (
	SELECT film_id
	FROM film
	WHERE title = "Hunchback Impossible"
);

# Query 6e:
SELECT first_name, last_name, SUM(amount) AS "Total Amount Paid"
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY last_name;

# Query 7a:
SELECT title
FROM film
WHERE (title LIKE "Q%" or title LIKE "K%") AND language_id IN (
	SELECT language_id
	FROM language
	WHERE name = "English"
);

# Query 7b:
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	WHERE film_id IN (
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
	)
);

# Query 7c:
SELECT first_name, last_name, email
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city cc
ON a.city_id = cc.city_id
INNER JOIN country ccc
ON cc.country_id = ccc.country_id
WHERE ccc.country = "Canada";
        
# Query 7d:
SELECT title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN (
		SELECT category_id
		FROM category
		WHERE name = "family"
	
    )
);

# Query 7e:
SELECT title
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY r.inventory_id
ORDER BY COUNT(rental_id) DESC;

# Query 7f:
SELECT store_id, SUM(amount) AS "Total"
FROM payment p
INNER JOIN staff s
ON p.staff_id = s.staff_id
GROUP BY store_id;

# Query 7g:
SELECT store_id, city, country
FROM store s
INNER JOIN address a 
ON s.address_id = a.address_id
INNER JOIN city c
ON a.city_id = c.city_id
INNER JOIN country cc
ON c.country_id = cc.country_id;

# Query 7h: 
SELECT name, SUM(amount) AS "Total"
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY c.category_id
ORDER BY SUM(amount) DESC
LIMIT 5;

# Query 8a:
CREATE VIEW top_five_genres AS (
	SELECT name, SUM(amount) AS "Total"
	FROM category c
	INNER JOIN film_category fc
	ON c.category_id = fc.category_id
	INNER JOIN inventory i
	ON i.film_id = fc.film_id
	INNER JOIN rental r
	ON i.inventory_id = r.inventory_id
	INNER JOIN payment p
	ON r.rental_id = p.rental_id
	GROUP BY c.category_id
	ORDER BY SUM(amount) DESC
	LIMIT 5
);

# Query 8b:
SELECT * FROM top_five_genres;

# Query 8c:
DROP VIEW top_five_genres;
