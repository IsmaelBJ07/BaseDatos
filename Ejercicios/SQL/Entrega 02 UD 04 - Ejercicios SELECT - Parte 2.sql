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
SELECT 