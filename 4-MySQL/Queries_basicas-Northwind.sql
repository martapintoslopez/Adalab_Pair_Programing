CREATE SCHEMA `northwind`;

USE `northwind`;

-- Conociendo a las empleadas:
SELECT `employee_id`, `last_name`, `first_name`
	FROM `employees`;
    
-- Conociendo los productos más baratos:
SELECT `product_name`, `unit_price`
	FROM `products`
    WHERE `unit_price` BETWEEN 0 AND 5; 
    
-- Conociendo los productos que no tienen precio:
SELECT `product_name`, `unit_price`
	FROM `products`
    WHERE `unit_price` = NULL;

-- Comparando productos:
SELECT `product_id`,`product_name`, `unit_price`
	FROM `products`
    WHERE `unit_price` <= 15 AND `product_id` < 10;

-- Cambiando de operadores:
SELECT `product_id`,`product_name`, `unit_price`
	FROM `products`
    WHERE NOT `unit_price`  <= 15 AND NOT `product_id` < 10;
    
-- Conociendo los paises a los que vendemos:
SELECT DISTINCT `ship_country`
	FROM `orders`;
    
-- Conociendo el tipo de productos que vendemos en Northwind:
SELECT `product_id`,`product_name`, `unit_price`
	FROM `products`
    LIMIT 10;

-- Ordenando los resultados:
SELECT `product_id`,`product_name`, `unit_price`
	FROM `products`
    ORDER BY `product_id` DESC
    LIMIT 10;

-- Que pedidos tenemos en nuestra BBDD:
SELECT DISTINCT `order_id`
	FROM `order_details`;

-- Qué pedidos han gastado más:
SELECT *, `quantity`*`unit_price` AS `ImporteTotal`
	FROM `order_details`
    ORDER BY `ImporteTotal` DESC
    LIMIT 3;

-- Los pedidos que están entre las posiciones 5 y 10 de nuestro ranking:
SELECT `order_ID`, `quantity`*`unit_price` AS `ImporteTotal`
	FROM `order_details`
    ORDER BY `ImporteTotal` DESC
    LIMIT 5
    OFFSET 5;
    
-- Qué categorías tenemos en nuestra BBDD:    
SELECT `category_name` as `NombreDeCategoria`
	FROM `categories`;

-- Selecciona envios con retraso:
SELECT `order_date`, `shipped_date`, DATE_ADD(`order_date`, INTERVAL 5 DAY) AS `FechaRetrasada`
	FROM `orders`;
    
-- Selecciona los productos más rentables:
SELECT `product_id`, `product_name`, `unit_price`
	FROM `products` 
    WHERE `unit_price` BETWEEN 15 AND 50;
    
-- Selecciona los productos con unos precios dados:
 SELECT `product_id`, `product_name`, `unit_price`
	FROM `products` 
    WHERE `unit_price` IN (18, 19 ,20);
 