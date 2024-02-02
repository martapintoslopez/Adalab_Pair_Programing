USE `northwind`;

SELECT MIN(unit_price) AS `LowestPrice`, MAX(unit_price) AS `highestPrice`
	FROM products;

SELECT COUNT(product_id) AS `numero_producto`, AVG(unit_price) AS `precio_medio`
	FROM products;

SELECT MAX(freight) AS `carga_max`, MIN(freight) AS `carga_min`
	FROM orders
    WHERE ship_country = "UK";

SELECT AVG(unit_price) AS `precio_medio`
	FROM products;
    -- precio medio 28.866363636363637

SELECT product_id AS `id_producto_caros`
	FROM products
    WHERE `unit_price`> 28.866363636363637
    ORDER BY `unit_price` DESC;

SELECT product_id, discontinued
	FROM products
    WHERE `discontinued` = 1;

SELECT product_id, discontinued, product_name
	FROM products
    WHERE `discontinued` = 0
    ORDER BY product_id DESC
    LIMIT 10;

SELECT employee_id, COUNT(order_id) AS `numero_pedidos_trabajador`, MAX(freight) AS `carga_maxima_trabajador`
	FROM orders
    GROUP BY employee_id;

SELECT employee_id, COUNT(order_id) AS `numero_pedidos_trabajador`, MAX(freight) AS `carga_maxima_trabajador`
	FROM orders
    WHERE shipped_date IS NOT NULL -- lo mismo que en la anterior porque solo saca los NULL
    GROUP BY employee_id
    ORDER BY employee_id DESC;

SELECT  COUNT(order_number) AS `numero_pedidos`, DAY(order_date) AS `dia`, MONTH(order_date) AS `mes`, YEAR(ORDER_date) AS `año` -- numero de pedidos por dia, mes y año
	FROM orders
    GROUP BY `dia`, `mes`, `año`
    ORDER BY `año`, `mes`, `dia`;

SELECT  COUNT(order_number) AS `numero_pedidos`, MONTH(order_date) AS `mes`, YEAR(ORDER_date) AS `año` -- numero de pedidos por mes y año
	FROM orders
    GROUP BY `mes`, `año`
    ORDER BY `año`, `mes`;

SELECT city AS `ciudad`, COUNT(employee_id) AS `empleadas`
	FROM employees
	GROUP BY city
	HAVING empleadas >= 4;

SELECT check_number AS `pedido`, amount AS `cantidad_pagada`, -- Añadimos una tag de alto o bajo en función de lo pagado
       CASE
           WHEN amount > 2000 THEN "Alto"
           ELSE "Bajo"
       END AS Categoria
FROM payments;
