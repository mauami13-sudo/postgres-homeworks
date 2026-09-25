-- 1. Заказы, отправленные в города, заканчивающиеся на 'burg'.
--    Без повторений: город, страна
SELECT DISTINCT ship_city, ship_country
FROM orders
WHERE ship_city LIKE '%burg';

-- 2. order_id, customer_id, freight, ship_country.
--    Отгружено в страны, начинающиеся на 'P'.
--    Сортировка по весу по убыванию, первые 10 записей.
SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country LIKE 'P%'
ORDER BY freight DESC
LIMIT 10;

-- 3. Имя, фамилия и телефон сотрудников, у которых отсутствует регион
SELECT first_name, last_name, home_phone
FROM employees
WHERE region IS NULL;

-- 4. Количество поставщиков в каждой стране.
--    По убыванию количества.
SELECT country, COUNT(*)
FROM suppliers
GROUP BY country
ORDER BY COUNT(*) DESC;

-- 5. Суммарный вес заказов (где известен регион) по странам,
--    только страны с суммарным весом > 2750.
--    По убыванию суммарного веса.
SELECT ship_country, SUM(freight)
FROM orders
WHERE ship_region IS NOT NULL
GROUP BY ship_country
HAVING SUM(freight) > 2750
ORDER BY SUM(freight) DESC;

-- 6. Страны, в которых зарегистрированы и заказчики, и поставщики, и работники
SELECT country FROM customers
INTERSECT
SELECT country FROM suppliers
INTERSECT
SELECT country FROM employees;

-- 7. Страны, в которых зарегистрированы и заказчики, и поставщики,
--    но НЕ зарегистрированы работники
(SELECT country FROM customers
 INTERSECT
 SELECT country FROM suppliers)
EXCEPT
SELECT country FROM employees;
