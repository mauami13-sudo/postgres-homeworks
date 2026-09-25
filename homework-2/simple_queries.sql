-- 1. "имя контакта" и "город" из таблицы customers
SELECT contact_name, city
FROM customers;

-- 2. идентификатор заказа и разница между датами формирования (order_date)
--    заказа и его отгрузкой (shipped_date)
SELECT order_id, shipped_date - order_date
FROM orders;

-- 3. все города без повторов, в которых зарегистрированы заказчики
--    (вариант без DISTINCT — через GROUP BY, раз DISTINCT под вопросом)
SELECT city
FROM customers
GROUP BY city;

-- 4. количество заказов (таблица orders)
SELECT COUNT(*)
FROM orders;

-- 5. количество стран, в которые отгружался товар
--    (вариант без DISTINCT — через GROUP BY в подзапросе)
SELECT COUNT(DISTINCT ship_country)
FROM orders;
