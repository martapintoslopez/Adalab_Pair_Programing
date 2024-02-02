SELECT  'Hola!'  AS `tipo_nombre`
FROM `customers`;

SELECT `city`, `company_name`, `contact_name`
	FROM `customers`
    WHERE city LIKE 'A%' OR city LIKE 'B%';

-- Necesitamos tabla customers y tabla orders (order_id)

SELECT `city`, `company_name`, `contact_name`, COUNT(`o.order_id`)
	FROM `customers` AS `c`
    INNER JOIN `orders` AS `o`
    ON `c`.`customer_id` = `o`.`customer_id`
    GROUP BY `city`, `company_name`, `contact_name`
    HAVING `city` LIKE 'L%';

SELECT `contact_name`, `contact_title`,  `company_name`
	FROM `customers`
    WHERE `contact_title` NOT LIKE '%Sales%';

SELECT `contact_name`
	FROM `customers`
    WHERE `contact_name` NOT LIKE '_A%';

SELECT `city`, `company_name`, `contact_name`, 'Customers' AS `Relationship`
    FROM `customers`
UNION
SELECT `city`, `company_name`, `contact_name`, 'Suppliers' AS `Relationship`
    FROM `suppliers`;

SELECT `category_name`
	FROM `categories`
    WHERE `description` LIKE '%Sweet%';

SELECT concat(`first_name`, `last_name`) AS `Nombre_completo`
	FROM `employees`
UNION
SELECT `contact_name`
	FROM `customers`;
    