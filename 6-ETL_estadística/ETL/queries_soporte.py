query_creacion_bbdd = "CREATE SCHEMA IF NOT EXISTS `tienda_italia`;"

query_tabla_tienda = """CREATE TABLE IF NOT EXISTS `tienda_italia`.`tienda_italia` (
                            `first_name` VARCHAR (45),
                            `last_name` VARCHAR (45),
                            `email` VARCHAR (100),
                            `gender` VARCHAR (45),
                            `city` VARCHAR (45),
                            `country` VARCHAR (45),
                            `address` VARCHAR (150),
                            `id_cliente` INT NOT NULL,
                            `id_producto` VARCHAR(45),
                            `fecha_venta` VARCHAR(45),
                            `cantida` INT,
                            `total` FLOAT,
                            `nombre_producto` VARCHAR(150),
                            `categoría` VARCHAR(250),
                            `precio`FLOAT,
                            `origen` VARCHAR(100),
                            `descripción` VARCHAR(250),
                            `descripción 2` VARCHAR(250),
                            PRIMARY KEY (`id_cliente`));"""

query_insert_table_tienda = """INSERT INTO `tienda_italia` (
                            `first_name`,
                            `last_name`,
                            `email`,
                            `gender`,
                            `city`,
                            `country`,
                            `address`,
                            `id_cliente`,
                            `id_producto`,
                            `fecha_venta`,
                            `cantida`,
                            `total`,
                            `nombre_producto`,
                            `categoría`,
                            `precio`,
                            `origen`,
                            `descripción`,
                            `descripción 2`)
                            VALUES (%s, %s, %s, %s, %s,%s, %s, %s,%s, %s, %s, %s, %s,%s, %s, %s, %s, %s);
                            """


