USE gblasd_inventarios;

INSERT INTO estados(estado, nombre) 
VALUES ('MX', 'Edo. Mexico');

INSERT INTO clientes (num_cliente, nombre, apellidos, compania,
direccion1, direccion2, ciudad, estado, cp, telefono) 
VALUES (129, 'Gustavo', 'Blas', 'UNAM', 'Alcanfores San juan',
NULL, 'Mexico', 'MX', '53150', '55-56231643');

UPDATE inventarios
   SET precio_unitario = 45
 WHERE precio_unitario = 40;
  
COMMIT WORK;  -- save data

-- COMMAND -----------

BEGIN WORK;

DELETE FROM clientes WHERE num_cliente = 129;

SELECT num_cliente, nombre, apellidos
  FROM clientes;

ROLLBACK WORK;

-- COMMAND ------------

SELECT num_cliente, nombre, apellidos
  FROM clientes;


-- Command HAVING

SELECT num_orden, sum(precio_total)
  FROM articulos
 GROUP BY num_orden  
HAVING sum(precio_total) > 250;

