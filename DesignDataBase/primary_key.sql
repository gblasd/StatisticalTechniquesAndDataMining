use gblasd_inventarios;

SET @@SESSION.sql_mode='ALLOW_INVALID_DATES';

-- Add primary key in tables

ALTER TABLE estados 
ADD CONSTRAINT pk_estado
PRIMARY KEY (estado);

ALTER TABLE clientes
ADD CONSTRAINT pk_clientes
PRIMARY KEY (num_cliente);

ALTER TABLE ordenes
ADD CONSTRAINT pk_ordenes
PRIMARY KEY (num_orden);

ALTER TABLE articulos 
ADD CONSTRAINT pk_articulos
PRIMARY KEY (num_articulo, num_orden);

SELECT num_orden FROM articulos WHERE num_orden NOT IN 
(SELECT num_orden FROM ordenes);

DELETE FROM articulos WHERE num_orden NOT IN
(SELECT num_orden FROM ordenes);

ALTER TABLE inventarios
ADD CONSTRAINT pk_inventarios
PRIMARY KEY (num_inventario, codigo_proveedor);

ALTER TABLE proveedores
ADD CONSTRAINT pk_proveedores
PRIMARY KEY (codigo_proveedor);


-- SET FOREIGN KEY

ALTER TABLE clientes
ADD CONSTRAINT fk_clientes
FOREIGN KEY (estado)
REFERENCES estados(estado);

ALTER TABLE ordenes
ADD CONSTRAINT fk_ordenes
FOREIGN KEY (num_cliente)
REFERENCES clientes(num_cliente);

ALTER TABLE articulos
ADD CONSTRAINT fk_items1
FOREIGN KEY (num_orden)
REFERENCES ordenes(num_orden);

ALTER TABLE articulos
ADD CONSTRAINT fk_items2
FOREIGN KEY (num_inventario, codigo_proveedor)
REFERENCES inventarios(num_inventario, codigo_proveedor);

ALTER TABLE inventarios
ADD CONSTRAINT fk_inventario
FOREIGN KEY (codigo_proveedor)
REFERENCES proveedores(codigo_proveedor);

