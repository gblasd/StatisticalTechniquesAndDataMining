DROP DATABASE IF EXISTS gblasd_inventarios;

-- my database
CREATE DATABASE gblasd_inventarios;

-- move the database
USE gblasd_inventarios;


-- create table for test 
CREATE TABLE estados(
	estado CHAR(2),
	nombre CHAR(15)
);

-- create table

CREATE TABLE clientes(
	Num_cliente INT,
	Nombre CHAR(15),
	apellidos CHAR(15),
	compania CHAR(20),
	direccion1 CHAR(20),
	direccion2 CHAR(20),
	ciudad CHAR(15),
	estado CHAR(2),
	cp CHAR(5),
	telefono CHAR(16)
);

CREATE TABLE inventarios(
	num_inventario SMALLINT,
	codigo_proveedor CHAR(3),
	descripcion CHAR(15),
	precio_unitario DECIMAL(6,2),
	unidad CHAR(4),
	descripcion_unidad CHAR(15)
);

CREATE TABLE proveedores(
	codigo_proveedor CHAR(3),
	nombre_proveedor CHAR(20)
);

CREATE TABLE ordenes(
	num_orden INT,
	fecha_orden DATE,
	num_cliente INT,
	instrucciones CHAR(40),
	disponible CHAR(1),
	num_pedido CHAR(10),
	fecha_envio DATE,
	peso_envio DECIMAL(8,2),
	cargo_envio DECIMAL(6,2),
	fecha_pago DATE
);

CREATE TABLE articulos(
	num_articulo SMALLINT,
	num_orden INT,
	num_inventario SMALLINT,
	codigo_proveedor CHAR(3),
	cantidad SMALLINT,
	precio_total DECIMAL(8,2)
);



SHOW VARIABLES LIKE 'secure_file_priv';

DROP DATABASE IF EXISTS PRUEBA_gblasd;
CREATE DATABASE PRUEBA_gblasd;
USE PRUEBA_gblasd;

DROP TABLE IF EXISTS pruebaCargaDescarga;
CREATE TABLE pruebaCargaDescarga(col1 int, col2 int);
INSERT INTO pruebaCargaDescarga VALUES
(1, curdate()),
(2, curdate()),
(3, curdate()),
(4, curdate()),
(5, curdate());



SELECT * INTO OUTFILE '/Users/gblasd/pruebaCargaDescarga.csv'
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
FROM pruebaCargaDescarga;

SHOW VARIABLES LIKE 'secure_file_priv';

SHOW FULL TABLES FROM gblasd_inventarios;

USE gblasd_inventarios;

DESC estados;

LOAD DATA INFILE '/Users/gblasd/estados.txt'
INTO TABLE estados
FIELDS TERMINATED BY '|' 
(estado, nombre);

SELECT COUNT(*) 
  FROM estados;

LOAD DATA INFILE '/Users/gblasd/articulos.txt'
INTO TABLE articulos
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';

SELECT COUNT(*)
  FROM articulos;

LOAD DATA INFILE '/Users/gblasd/clientes.txt'
INTO TABLE clientes
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';

SELECT COUNT(*)
  FROM clientes;
    
LOAD DATA INFILE '/Users/gblasd/inventarios.txt'
INTO TABLE inventarios
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';

SELECT COUNT(*)
  FROM inventarios;
  
-- Script para configuracion de fechas
SET @@SESSION.sql_mode='ALLOW_INVALID_DATES';

LOAD DATA INFILE '/Users/gblasd/ordenes.txt'
INTO TABLE ordenes
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
(num_orden, @fecha_orden, num_cliente, instrucciones, disponible,
num_pedido, @fecha_envio, peso_envio, cargo_envio, @fecha_pago)
SET fecha_orden=STR_TO_DATE(@fecha_orden, '%d/%m/%Y'),
    fecha_envio=STR_TO_DATE(@fecha_envio, '%d/%m/%Y'),
    fecha_pago=STR_TO_DATE(@fecha_pago, '%d/%m/%Y');
    
SELECT count(*)
  FROM ordenes;
  
LOAD DATA INFILE '/Users/gblasd/proveedores.txt'
INTO TABLE proveedores
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';

SELECT count(*)
  FROM proveedores;
  


drop table articulos;