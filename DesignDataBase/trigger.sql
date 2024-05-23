use gblasd_inventarios;

-- check table structure
SELECT * 
  FROM ordenes 
 WHERE num_orden = 1002;
 

-- add new column to table 
ALTER TABLE ordenes ADD COLUMN total DECIMAL(12, 2);


-- check table structure
select sum(precio_total) 
  from articulos
 where num_orden = 1002 ;


-- create trigger: sum of orders
DELIMITER //
CREATE TRIGGER ordenes_actualizaTotal AFTER INSERT ON articulos
	FOR EACH ROW
    BEGIN
		UPDATE ordenes 
           SET total = (SELECT SUM(precio_total) 
                          FROM articulos a
						 WHERE a.num_orden = new.num_orden)
		 WHERE num_orden = new.num_orden;
	END;//
DELIMITER ;


-- Row of the order  
SELECT * 
  FROM articulos
 WHERE num_orden = 1002; 
 
--  Add new row in table
INSERT INTO articulos VALUES (3, 1002, 4, 'HSK', 2, 1920);

-- query about the num_order
SELECT * FROM ordenes WHERE num_orden = 1002;


