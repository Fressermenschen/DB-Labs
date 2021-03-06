EXPLAIN ANALYZE SELECT "sum", address, city from store as s
JOIN (SELECT staff_id, SUM(amount) from payment
        GROUP by staff_id) as p on s.manager_staff_id = p.staff_id
JOIN address as a on a.address_id = s.address_id
JOIN city as c on c.city_id = a.city_id;

- the most expensive step is the JOIN (as Nested Loop) (cost = 328.09...)
- can be reduced by creating indexes
