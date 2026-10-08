-- 1. Компания заказчика и ФИО сотрудника, когда и заказчик, и сотрудник в London,
--    а доставка — United Package.
--    Используем INNER JOIN (обычный JOIN = INNER JOIN).
SELECT c.company_name AS customer,
       CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.ship_via = s.shipper_id
WHERE c.city = 'London'
  AND e.city = 'London'
  AND s.company_name = 'United Package';


-- 2. Наименование продукта, остаток, имя и телефон поставщика
--    для неснятых с продажи, остаток < 25, категории Dairy Products и Condiments.
--    Сортировка по возрастанию остатка.
--    Здесь тоже INNER JOIN (products ↔ suppliers ↔ categories).
SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone
FROM products p
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
INNER JOIN categories cat ON p.category_id = cat.category_id
WHERE p.discontinued != 1
  AND p.units_in_stock < 25
  AND cat.category_name IN ('Dairy Products', 'Condiments')
ORDER BY p.units_in_stock;


-- 3. Компании заказчиков, не сделавших ни одного заказа.
--    Два варианта — LEFT JOIN и NOT EXISTS (оба дают одинаковый результат).
--    Оставляю оба, чтобы показать использование конструкций.
--    Вариант через LEFT JOIN:
SELECT c.company_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--    Вариант через NOT EXISTS:
SELECT c.company_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- 4. Уникальные названия продуктов, которых заказано ровно 10 единиц.
--    Именно через подзапрос + EXISTS.
SELECT DISTINCT p.product_name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM order_details od
    WHERE od.product_id = p.product_id
      AND od.quantity = 10
);
