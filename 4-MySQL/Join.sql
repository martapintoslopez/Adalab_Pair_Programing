USE `Northwind`;

SELECT * 
	FROM `orders`;
    
SELECT * 
	FROM `customers`;

-- 1.
-- Numero de pedidos y id de cliente --> tabla orders
-- Nombre cliente --> tabla customers

SELECT `c`.`company_name` AS `NombreEmpresa`, `c`.`customer_id` AS `Identificador`, `c`.`country`, COUNT(`o`.`customer_id`) AS `NumeroPedidos`
	FROM `customers` AS `c`
    INNER JOIN `orders` AS `o`
	ON `c`.`customer_id`= `o`.`customer_id`
	GROUP BY `o`.`customer_id`
    HAVING `c`.`country` = "UK";

-- 2.
SELECT * 
	FROM `order_details`;
    
-- Tablas usadas: customers AS c y orders AS o
SELECT `c`.`company_name`, YEAR(`o`.`order_date`) AS `año`, SUM(`od`.`quantity`) AS `NumObjetos`
	FROM `customers` AS `c`
	INNER JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id` AND `c`.`country` = "UK"
    -- Tabla a usar: order_details AS od
    INNER JOIN `order_details` AS `od`
    ON `o`.`order_id` = `od`.`order_id`
    GROUP BY `c`.`company_name`, YEAR(`o`.`order_date`);
    
/* 3. Adición de la cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos
 salen en porcentajes, 15% nos sale como 0.15.*/
SELECT `c`.`company_name`, YEAR(`o`.`order_date`) AS `año`, SUM(`od`.`quantity`) AS `NumObjetos`, SUM(`od`.`unit_price`*`od`.`quantity` - `od`.`unit_price`*`od`.`quantity`*`od`.`discount`) AS  `DineroTotal`
	FROM `customers` AS `c`
	INNER JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id` AND `c`.`country` = "UK"
    -- Tabla a usar: order_details
    INNER JOIN `order_details` AS `od`
    ON `o`.`order_id` = `od`.`order_id`
    GROUP BY `c`.`company_name`, YEAR(`o`.`order_date`);
    

/* 4. BONUS: Pedidos que han realizado cada compañía y su fecha: Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que 
se han obtenido, desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado
y su fecha.*/
SELECT `o`.`order_id` AS `OrderID`,`c`.`company_name` AS `CompanyName`, `o`.`order_date`
	FROM `customers` AS `c`
	INNER JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id`;
    

/* 5. BONUS: Tipos de producto vendidos:Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la 
categoría y el nombre del producto, y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).*/
 SELECT * FROM northwind.categories; -- category_id, category_name
 SELECT * FROM northwind.products; -- product_id, product_name, category_id, unit_price, quantity, discount
 SELECT * FROM northwind.order_details; -- order_id,product_id,unit_price,quantity,discount
 
 SELECT `ca`.`category_id`, `ca`.`category_name`, `p`.`product_name`, SUM(`od`.`unit_price` * `od`.`quantity` - `od`.`unit_price` * `od`.`quantity` * `od`.`discount`) AS `ProductSales`
	FROM `products` AS `p`
	INNER JOIN `categories` AS `ca`
    ON `ca`.`category_id` = `p`.`category_id`
    INNER JOIN `order_details` AS `od`
    ON `od`.`product_id` = `p`.`product_id`
    GROUP BY `ca`.`category_id`, `ca`.`category_name`, `p`.`product_name`
    ORDER BY `ca`.`category_id`;
 
 /* 6. Qué empresas tenemos en la BBDD Northwind: Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las 
 empresas cliente, los ID de sus pedidos y las fechas.*/
 SELECT * FROM northwind.customers; -- company_name, customer_id
 SELECT * FROM northwind.orders; -- customer_id, order_id, order_date
 
SELECT `o`.`order_id`, `c`.`company_name`, `o`.`order_date`
	FROM `customers` AS `c`
    INNER JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id`;

/* 7. Pedidos por cliente de UK: Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada 
cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía 
cliente junto con el número de pedidos.*/
SELECT * FROM northwind.customers; -- company_name, customer_id, country
SELECT * FROM northwind.orders; -- customer_id, order_id

SELECT `c`.`company_name`, COUNT(`o`.`order_id`)
	FROM `customers` AS `c`
    INNER JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id`
    WHERE `c`.`country` = "UK"
    GROUP BY `c`.`country`, `c`.`company_name`;


/* 8. Empresas de UK y sus pedidos: También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o
no) junto con los ID de todos los pedidos que han realizado y la fecha del pedido.*/
SELECT `o`.`order_id`, `c`.`company_name`, `o`.`order_date`
	FROM `customers` AS `c`
    INNER JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id`
    WHERE `c`.`country` = "UK";


/* 9. Empleadas que sean de la misma ciudad: Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla
los datos de todas las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las 
jefas. Investiga el resultado, ¿sabes decir quién es el director?*/
SELECT * FROM northwind.employees; -- city, first_name, last_name -> Empleadas -- city, first_name, last_name -> Jefas

SELECT `e1`.`city`, `e1`.`first_name` AS `NombreEmpleado`, `e1`.`last_name` AS `ApellidoEmpleado`, `e2`.`city`, `e2`.`first_name` AS `NombreJefe`, `e2`.`last_name` AS `ApellidoJefe`
	FROM `employees` AS `e1`, `employees` AS `e2`
	WHERE `e1`.`employee_id` <> `e2`.`employee_id`
	AND `e1`.`reports_to` = `e2`.`employee_id`
    GROUP BY `e1`.`city`, `e1`.`first_name`, `e1`.`last_name`, `e2`.`city`, `e2`.`first_name`, `e2`.`last_name`
    ORDER BY `e1`.`city`;  


/* 10. BONUS: FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no: Selecciona todos los pedidos, tengan empresa asociada o no, y todas las
empresas tengan pedidos asociados o no. Muestra el ID del pedido, el nombre de la empresa y la fecha del pedido (si existe).*/
SELECT * FROM northwind.customers; -- company_name, customer_id 
SELECT * FROM northwind.orders; -- customer_id, order_id

SELECT `o`.`order_id`, `c`.`company_name` AS `NombreEmpresa`, `o`.`order_date` AS `FechaDelPedido`
	FROM `customers` AS `c`
    LEFT JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id`
    UNION
    SELECT `o`.`order_id`, `c`.`company_name` AS `NombreEmpresa`, `o`.`order_date` AS `FechaDelPedido`
	FROM `customers` AS `c`
    RIGHT JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id`;


