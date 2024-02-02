 CREATE SCHEMA `tienda_zapatillas`;
 USE `tienda_zapatillas`;
 CREATE TABLE zapatillas(
	 id_zapatilla INT AUTO_INCREMENT NOT NULL, 
	 modelo VARCHAR(45) NOT NULL, 
	 color VARCHAR(45) NOT NULL,
     PRIMARY KEY(id_zapatilla));
     
CREATE TABLE clientes(
	id_cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    telefono INT NOT NULL,
    email VARCHAR(45) NOT NULL,
    direccion  VARCHAR(45) NOT NULL,
    ciudad  VARCHAR(45),
    provincia  VARCHAR(45) NOT NULL,
    codigo_postal VARCHAR(45) NOT NULL
    );
    
CREATE TABLE empleados(
	id_empleado INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    tienda VARCHAR(45) NOT NULL,
    salario INT,
    fecha_incorporacion DATE NOT NULL
    );
    
CREATE TABLE facturas(
	id_factura INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    numero_factura VARCHAR(45) NOT NULL,
    fecha DATE NOT NULL,
    id_zapatilla INT NOT NULL,
    CONSTRAINT fk_idzapas_idzapas
		FOREIGN KEY (id_zapatilla)
        REFERENCES zapatillas (id_zapatilla),
	id_empleado INT NOT NULL,
     CONSTRAINT fk_idempleado_idempleado
		 FOREIGN KEY (id_empleado)
		 REFERENCES empleados(id_empleado),
	id_cliente INT NOT NULL,
    CONSTRAINT fk_cliente_cliente
		FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

ALTER TABLE zapatillas
ADD COLUMN marca VARCHAR (45) NOT NULL,
ADD COLUMN talla INT NOT NULL;

ALTER TABLE empleados
MODIFY COLUMN salario FLOAT NOT NULL;

ALTER TABLE facturas
ADD COLUMN TOTAL FLOAT;

INSERT INTO zapatillas(modelo,color,marca,talla)
VALUES ("XQYUN", "Negro", "Nike", 42), ("UOPMN", "Rosas", "Nike", 39), ("OPNYT", "Verdes", "Adidas", 35);

INSERT INTO empleados (nombre, tienda, salario, fecha_incorporacion)
VALUES ("Laura", "Alcobendas", 25987, '2010-09-03'), ("Maria", "Sevilla", 0, '2001-04-11'), ("Ester", "Oviedo", 30165.98, '2000-11-29');

INSERT INTO clientes(nombre, telefono, email, direccion, ciudad, provincia, codigo_postal)
VALUES ("Monica", 123456789, "monica@email.com", "calle felicidad", "Mostoles", "Madrid", "28176"), ("Lorena", 289345678, "lorena@email.com", "calle alegria", "Barcelona", "Barcelona", "12346"), ("Carmen", 298463759, "carmen@email.com", "calle del color", "Vigo", "Pontevedra", "23456");

INSERT INTO facturas (numero_factura, fecha, id_zapatilla, id_empleado, id_cliente, TOTAL)
VALUES ("123",'2001-12-11', 1, 2, 1, 54.98), ("1234", '2005-05-23', 1, 1, 3, 89.91), ("12345", '2015-09-18', 2,3, 3, 76.23);

UPDATE zapatillas
SET color = "amarillas"
WHERE color = "Rosas";

/*Tabla empleados: Laura se ha cambiado de ciudad y ya no vive en Alcobendas, se fue cerquita del mar, 
ahora vive en A Coruña.*/
UPDATE empleados
SET tienda = "A Coruña"
WHERE tienda = "Alcobendas";

/*Tabla clientes: El Numero de telefono de Monica esta mal!!! Metimos un digito de más. En realidad su 
número es: 123456728*/
UPDATE clientes
SET telefono = "123456728"
WHERE nombre = "Monica";

/*Tabla facturas:El total de la factura de la zapatilla cuyo id es 2 es incorrecto.En realidad es: 89,91.*/
UPDATE facturas
SET TOTAL = 89.91
WHERE id_factura = 2;