
-- 1 create database
DROP DATABASE IF EXISTS blasGustavo_FINAL;
CREATE DATABASE IF NOT EXISTS blasGustavo_FINAL;

-- 2 move to database
USE blasGustavo_FINAL;

-- 3 create table
CREATE TABLE IF NOT EXISTS asociados(
	clave int,
    nombre char(50),
    calle_num int,
    colonia char(50),
    cp char(6),
    delegacion char(50),
    telefono1 char(20),
    telefono2 char(20),
    paginaweb char(80)
);

-- 4 create table backup
CREATE TABLE IF NOT EXISTS asociados_backup(
	clave int,
    nombre char(50),
    calle_num int,
    colonia char(50),
    cp char(6),
    delegacion char(50),
    telefono1 char(20),
    telefono2 char(20),
    paginaweb char(80)
);

-- 5 Create store procedure to insert data
DROP PROCEDURE IF EXISTS insertaAsociados;
delimiter //
CREATE PROCEDURE insertaAsociados(
	p_clave int,
    p_nombre char(50),
    p_calle_num int,
    p_colonia char(50),
    p_cp char(6),
    p_delegacion char(50),
    p_telefono1 char(20),
    p_telefono2 char(20),
    p_paginaweb char(80))
BEGIN
	INSERT INTO asociados_backup VALUES (
		p_clave, p_nombre,
		p_calle_num, p_colonia, 
        p_cp, p_delegacion, 
        p_telefono1, p_telefono2,
		p_paginaweb);
END//
delimiter ;

-- 6 create store procedure to update rows
DROP PROCEDURE IF EXISTS actualizaAsociados;
delimiter //
CREATE PROCEDURE actualizaAsociados(
	p_clave int,
    p_nombre char(50),
    p_calle_num int,
    p_colonia char(50),
    p_cp char(6),
    p_delegacion char(50),
    p_telefono1 char(20),
    p_telefono2 char(20),
    p_paginaweb char(80))
BEGIN
	UPDATE asociados_backup 
	   SET nombre = p_nombre,
		   calle_num = p_calle_num,
           colonia = p_colonia, 
           cp = p_cp, 
           delegacion = p_delegacion, 
		   telefono1 = p_telefono1,
           telefono2 = p_telefono2,
		   paginaweb = p_paginaweb
     WHERE clave = p_clave;
END//
delimiter ;

-- 7 store procedure for delete row by id
DROP PROCEDURE IF EXISTS borraAsociados;
delimiter //
CREATE PROCEDURE borraAsociados( p_clave int)
BEGIN
	DELETE FROM asociados_backup WHERE clave = p_clave;
END//
delimiter ;


-- 8 Trigger for delete 
DELIMITER //
CREATE TRIGGER inserta_BI_asociados BEFORE INSERT ON asociados
	FOR EACH ROW
    BEGIN
		CALL insertaAsociados(
			NEW.clave,
			NEW.nombre,
			NEW.calle_num,
			NEW.colonia,
			NEW.cp,
			NEW.delegacion,
			NEW.telefono1,
			NEW.telefono2,
			NEW.paginaweb
        );
	END;//
DELIMITER ;

-- test trigger inserta_BI_asociados
INSERT INTO asociados VALUES (2,'Gustavo',239,'insurgentes','03230','Benito Juarez','5571423068','5554323455','holamundo.com');
SELECT * FROM asociados;
SELECT * FROM asociados_backup;

-- 9 Trigger to update rows
DELIMITER //
CREATE TRIGGER actualiza_BU_asociados BEFORE UPDATE ON asociados
	FOR EACH ROW
    BEGIN
		CALL actualizaAsociados (
            NEW.clave,
			NEW.nombre,
			NEW.calle_num,
			NEW.colonia,
			NEW.cp,
			NEW.delegacion,
			NEW.telefono1,
			NEW.telefono2,
			NEW.paginaweb
        );
	END;//
DELIMITER ;

-- test trigger actualiza_BU_asociados
UPDATE asociados SET nombre = "GUSTAVO BLAS" WHERE clave = 2;
SELECT * FROM asociados;
SELECT * FROM asociados_backup;


-- 10 Trigger to delete
DELIMITER //
CREATE TRIGGER borra_BD_asociados AFTER DELETE ON asociados
	FOR EACH ROW
    BEGIN
		CALL borraAsociados (OLD.clave);
	END;//
DELIMITER ;

-- test trigger borra_BD_asociados
DELETE FROM asociados WHERE clave = 2;
SELECT * FROM asociados;
SELECT * FROM asociados_backup;












