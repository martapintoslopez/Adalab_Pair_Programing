USE Northwind;

SELECT customer_id, company_name
FROM customers;

WITH clientes AS (SELECT customer_id, company_name, country
				FROM customers)
SELECT customer_id, company_name, country
	FROM clientes
    WHERE country = 'Germany';

-- Necesitamos tabla orders y tabla customers

SELECT c.customer_id, company_name, order_id, order_date 
	FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;


WITH facturas AS (SELECT c.customer_id, company_name, order_id, order_date 
						FROM customers AS c
					INNER JOIN orders AS o
					ON c.customer_id = o.customer_id)

SELECT customer_id, company_name, COUNT(customer_id) AS numero_facturas
FROM facturas
GROUP BY customer_id;

-- Tenemos que sacar la suma de cantidad por producto
-- media de cantidad pedida por producto

WITH media AS (SELECT product_id, AVG (quantity) AS media_producto
				FROM order_details
				GROUP BY product_id)

SELECT product_name, media_producto
	FROM products AS p
 INNER JOIN media AS m
 ON p.product_id = m.product_id;

