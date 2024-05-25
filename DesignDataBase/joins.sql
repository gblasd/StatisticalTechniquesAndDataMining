use gblasd_inventarios;

select c.num_cliente, c.compania, o.num_orden 
  from clientes c join ordenes o
    on c.num_cliente = o.num_cliente;
    
select a.num_articulo, a.num_orden, i.descripcion
  from articulos a 
  join inventarios i on a.num_inventario = i.num_inventario
 where a.num_orden = 1004
 group by a.num_articulo, i.num_inventario, i.descripcion;

select concat(c.nombre, ' ', c.apellidos) as nom_completo, 
	   o.num_orden, 
       a .num_articulo
  from ordenes o
  join clientes c on o.num_cliente = c.num_cliente
  join articulos a on o.num_orden = a.num_orden
 where o.num_orden = 1007;

select o.fecha_orden, avg(a.precio_total)
  from articulos a
  join ordenes o on a.num_orden = o.num_orden
 group by o.fecha_orden 
 order by avg(o.total) desc;   

select i.*, a.num_orden
  from inventarios i left outer join articulos a
    on i.num_inventario = a.num_inventario
   and i.codigo_proveedor = a.codigo_proveedor
 order by num_orden;
 
select e.nombre, c.num_cliente, c.apellidos, telefono
  from clientes c right outer join estados e 
    on c.estado = e.estado
 order by 1;
