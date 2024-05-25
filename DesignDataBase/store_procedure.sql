-- Create database
DROP DATABASE IF EXISTS tareas;
CREATE DATABASE IF NOT EXISTS tareas;
USE tareas;

-- create table 
DROP TABLE IF EXISTS mobiliario;
CREATE TABLE IF NOT EXISTS mobiliario (
	idArticulo int,
    descripcion char(50),
    existencia int
);

-- create store procedure
DROP PROCEDURE IF EXISTS insertaMobiliario;
delimiter //
CREATE PROCEDURE insertaMobiliario (p_id int, p_descripcion char(50), p_existencia int)
	INSERT INTO mobiliario VALUES (p_id, p_descripcion, p_existencia);
//
delimiter ;

-- call store procedure
CALL insertaMobiliario(1, 'descripcion1', 10);
SELECT * FROM mobiliario;

-- create store procedure
DROP PROCEDURE IF EXISTS actualizaMobiliario;
delimiter //
CREATE PROCEDURE actualizamobiliario(p_id int, p_descripcion char(50), p_existencia int)
	UPDATE mobiliario 
       SET descripcion = p_descripcion, existencia = p_existencia
     WHERE idArticulo = p_id;     
//
delimiter ;

-- call store procedure
CALL actualizaMobiliario(1, 'descripcion2', 20);
SELECT * FROM mobiliario;

-- create store procedure
DROP PROCEDURE IF EXISTS selectMobiliario;
delimiter //
	CREATE PROCEDURE selectMobiliario(p_id int)
    SELECT * FROM mobiliario WHERE idArticulo = p_id;
// 
delimiter ;

-- command call store procedure
CALL selectMobiliario(1);

-- create store procedure
DROP PROCEDURE IF EXISTS borraMobiliario;
delimiter //
CREATE PROCEDURE borraMobiliario(p_id int)
	DELETE FROM mobiliario WHERE idArticulo = p_id;
//
delimiter ;

-- command call store procedure
CALL borraMobiliario(1);
SELECT * FROM mobiliario;


