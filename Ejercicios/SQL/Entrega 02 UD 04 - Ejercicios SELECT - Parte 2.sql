--Ejercicio1
SELECT ciudad,telefono,pais
FROM oficina
WHERE pais = 'España';

--Ejercicio2
SELECT nombre,apellido1,apellido2,puesto
FROM empleado
WHERE puesto != 'Representante Ventas';

--Ejercicio3
SELECT codigo_pedido,codigo_cliente,fecha_esperada,fecha_entrega
FROM pedido
WHERE DATEDIFF (day, fecha_entrega, fecha_esperada)>=2;

--Ejercicio4
SELECT codigo_pedido, codigo_cliente, fecha_pedido, estado
FROM pedido
WHERE estado = 'Rechazado' AND (fecha_pedido>'2025-01-01' AND fecha_pedido<'2025-12-31');

--Ejercicio5
SELECT codigo_producto, nombre, gama, cantidad_en_stock, precio_venta
FROM producto
WHERE gama='Ornamentales' AND cantidad_en_stock>100
ORDER BY precio_venta DESC;

--Ejercicio6
SELECT codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas
FROM cliente
WHERE ciudad = 'Madrid' AND (codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas=30);

--Ejercicio7 
SELECT nombre_cliente, CONCAT(empleado.nombre, ' ', empleado.apellido1, ' ', empleado.apellido2) AS nombre_completo_empleado, oficina.ciudad AS ciudad_oficina
FROM empleado
INNER JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina;

--Ejercicio8
SELECT cliente.nombre_cliente, pedido.fecha_entrega, pedido.fecha_esperada
FROM cliente
INNER JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
WHERE fecha_entrega > fecha_esperada;

--Ejercicio9
SELECT oficina.linea_direccion1, oficina.linea_direccion2, oficina.ciudad
FROM empleado
INNER JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina
WHERE cliente.ciudad ='Fuenlabrada';

--Ejercicio10
SELECT DISTINCT cliente.nombre_cliente, producto.gama
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
INNER JOIN linea_pedido ON pedido.codigo_pedido = linea_pedido.codigo_pedido
INNER JOIN producto ON linea_pedido.codigo_producto = producto.codigo_producto
ORDER BY gama;
;

--Ejercicio11
SELECT DISTINCT oficina.codigo_oficina, oficina.ciudad, oficina.pais
FROM oficina
INNER JOIN empleado ON oficina.codigo_oficina = empleado.codigo_oficina
INNER JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
INNER JOIN linea_pedido ON pedido.codigo_pedido = linea_pedido.codigo_pedido
INNER JOIN producto ON linea_pedido.codigo_producto = producto.codigo_producto
WHERE producto.gama = 'Frutales';

--Ejercicio12
SELECT *
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_empleado_rep_ventas IS NULL
ORDER BY codigo_empleado;

--Ejercicio13
SELECT CONCAT(e1.nombre, ', ', e1.apellido1, ', ', e1.apellido2) AS nombre_empleado,
    CONCAT(e2.nombre, ', ', e2.apellido1, ', ', e2.apellido2) AS nombre_jefe,
    CONCAT(e3.nombre, ', ', e3.apellido1, ', ', e3.apellido2) AS nombre_jefe_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;
