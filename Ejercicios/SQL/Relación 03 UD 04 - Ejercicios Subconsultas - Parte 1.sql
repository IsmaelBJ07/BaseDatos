USE tienda_informatica;
--Ejercicio1
SELECT *
FROM producto
WHERE cod_fabricante IN
	(
	SELECT codigo=1
	FROM fabricante
	WHERE nombre = 'Sony'
	);

--Ejercicio2
SELECT *
FROM producto
WHERE precio = 
	(
    SELECT MAX(precio)
    FROM producto
    WHERE cod_fabricante = 
	(
        SELECT codigo
        FROM fabricante
        WHERE nombre = 'Samsung'
    )
);

--Ejercicio3
SELECT nombre
FROM producto
WHERE precio =
	(
	SELECT MAX(precio)
	FROM producto 
	WHERE cod_fabricante = 
	(
	SELECT codigo
	FROM fabricante
	WHERE nombre = 'Hewlett-Packard'
	)
);

--Ejercicio4
SELECT nombre
FROM producto
WHERE precio = 
	(
	SELECT MIN(precio)
	FROM producto
	WHERE cod_fabricante =
	(
	SELECT codigo
	FROM fabricante
    WHERE nombre = 'LG'
	)
);

--Ejercicio5
SELECT nombre
FROM producto
WHERE precio >=
	(
	SELECT MAX(precio)
	FROM producto
	WHERE cod_fabricante =
	(
	SELECT codigo
	FROM fabricante
	WHERE nombre = 'Asus'
	)
);

--Ejercicio6
SELECT *
FROM producto
WHERE precio >
	(
	SELECT AVG(precio)
	FROM producto
	WHERE cod_fabricante =
	(
	SELECT codigo
	FROM fabricante
	WHERE nombre = 'Asus'
	)
);

--MAL