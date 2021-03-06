/*ex1.1*/
SELECT DISTINCT title,rating,category.name FROM film 
	JOIN film_category ON film_category.film_id = film.film_id
	JOIN category ON film_category.category_id = category.category_id
	JOIN inventory ON film.film_id = inventory.film_id 
	JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE (rating = 'R' OR rating = 'PG-13')
	AND (category.name = 'Horror' OR category.name = 'Sci-Fi')
	AND (rental.return_date is NOT null)

/*ex1.2*/
SELECT "sum", address, city from store as s
JOIN (SELECT staff_id, SUM(amount) from payment
        GROUP by staff_id) as p on s.manager_staff_id = p.staff_id
JOIN address as a on a.address_id = s.address_id
JOIN city as c on c.city_id = a.city_id;
