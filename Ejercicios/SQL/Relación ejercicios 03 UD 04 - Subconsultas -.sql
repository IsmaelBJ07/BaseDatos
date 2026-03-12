--Ejercicio01
SELECT jugador.codigo, jugador.nombre, jugador.procedencia, jugador.altura, jugador.peso
FROM jugador
WHERE jugador.altura > (
	SELECT AVG(altura)
	FROM jugador
);

--Ejercicio02
SELECT DISTINCT jugador.nombre AS jugador, equipo.nombre AS equipo, jugador_equipo.temporada
FROM jugador
INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
WHERE jugador_equipo.temporada = '2020-21'
	AND equipo.nombre != 'Raptors'
	AND (
		equipo.codigo IN (SELECT equipo_local FROM partido WHERE equipo_visitante = (SELECT codigo FROM equipo WHERE nombre = 'Raptors') AND temporada = '2020-21')
		OR
		equipo.codigo IN (SELECT equipo_visitante FROM partido WHERE equipo_local = (SELECT codigo FROM equipo WHERE nombre = 'Raptors') AND temporada = '2020-21')
	);

--Ejercicio03
SELECT jugador.nombre
FROM jugador
WHERE jugador.codigo NOT IN (
	SELECT id_jugador
	FROM estadistica_jugador_temporada
	WHERE temporada = '2018-19' AND promedio_puntos_partido_temporada > 15
)
AND jugador.codigo IN (
	SELECT id_jugador
	FROM estadistica_jugador_temporada
	WHERE temporada = '2018-19'
);

--Ejercicio04
SELECT DISTINCT jugador.nombre
FROM jugador
INNER JOIN estadistica_jugador_temporada ejt ON jugador.codigo = ejt.id_jugador
INNER JOIN equipo ON equipo.codigo = ejt.id_equipo
WHERE equipo.conferencia = 'Este'
	AND ejt.temporada = '2017-18'
	AND ejt.promedio_puntos_partido_temporada > 700;

--Ejercicio05
SELECT jugador.nombre
FROM jugador
INNER JOIN estadistica_jugador_temporada ejt ON jugador.codigo = ejt.id_jugador
WHERE ejt.temporada = '2012-13'
	AND ejt.promedio_tapones_temporada > 80;

--Ejercicio06
SELECT jugador.nombre AS jugador, jugador.altura
FROM jugador
WHERE jugador.altura > (
	SELECT AVG(j.altura)
	FROM jugador j
	INNER JOIN jugador_equipo je ON j.codigo = je.codigo_jugador
	INNER JOIN equipo e ON e.codigo = je.codigo_equipo
	WHERE e.nombre = 'Timberwolves' AND je.temporada = '2021-22'
);

--Ejercicio07
SELECT DISTINCT equipo.nombre AS Nombre_Equipo
FROM equipo
INNER JOIN jugador_equipo je ON equipo.codigo = je.codigo_equipo
INNER JOIN jugador j ON j.codigo = je.codigo_jugador
WHERE equipo.nombre LIKE 'C%'
	AND je.temporada = '2024-25'
	AND j.peso > 100;

--Ejercicio08
SELECT j.nombre AS Nombre_Jugador, ejt.temporada, ejt.promedio_puntos_partido_temporada
FROM jugador j
INNER JOIN estadistica_jugador_temporada ejt ON j.codigo = ejt.id_jugador
WHERE ejt.temporada = '2017-18'
	AND ejt.promedio_puntos_partido_temporada > (
		SELECT AVG(promedio_puntos_partido_temporada)
		FROM estadistica_jugador_temporada
		WHERE temporada = '2017-18'
	);

--Ejercicio09
SELECT ejt1.temporada, j.nombre AS nombre_jugador, e.nombre AS nombre_equipo, ejt1.promedio_tiros_libres_temporada
FROM estadistica_jugador_temporada ejt1
INNER JOIN jugador j ON j.codigo = ejt1.id_jugador
INNER JOIN equipo e ON e.codigo = ejt1.id_equipo
WHERE ejt1.promedio_tiros_libres_temporada = (
	SELECT MAX(promedio_tiros_libres_temporada)
	FROM estadistica_jugador_temporada ejt2
	WHERE ejt2.temporada = ejt1.temporada
);

--Ejercicio10
SELECT j.nombre AS jugador, e.nombre AS equipo
FROM jugador j
INNER JOIN estadistica_jugador_temporada ejt ON j.codigo = ejt.id_jugador
INNER JOIN equipo e ON e.codigo = ejt.id_equipo
WHERE ejt.temporada = '2019-20'
	AND ejt.total_partidos_jugados > 36;

--Ejercicio11
SELECT j.nombre AS jugador, e.nombre AS equipo
FROM jugador j
INNER JOIN estadistica_jugador_temporada ejt ON j.codigo = ejt.id_jugador
INNER JOIN equipo e ON e.codigo = ejt.id_equipo
WHERE ejt.temporada = '2020-21'
	AND ejt.promedio_asistencia_temporadas < 3;

--Ejercicio12
SELECT j.nombre AS jugador, e.nombre AS equipo
FROM jugador j
INNER JOIN estadistica_jugador_temporada ejt ON j.codigo = ejt.id_jugador
INNER JOIN equipo e ON e.codigo = ejt.id_equipo
WHERE ejt.temporada = '2021-22'
	AND ejt.promedio_puntos_partido_temporada > (
		SELECT AVG(promedio_puntos_partido_temporada)
		FROM estadistica_jugador_temporada
		WHERE temporada = '2021-22'
	);

--Ejercicio13
SELECT DISTINCT j.nombre
FROM jugador j
INNER JOIN estadistica_jugador_temporada ejt ON j.codigo = ejt.id_jugador
INNER JOIN equipo e ON e.codigo = ejt.id_equipo
WHERE ejt.temporada = '2023-24'
	AND e.conferencia = 'Este'
	AND ejt.promedio_puntos_partido_temporada >= 375
	AND e.codigo IN (
		SELECT equipo_visitante
		FROM partido
		WHERE temporada = '2023-24'
	);

--Ejercicio14
SELECT j.codigo AS codigo_jugador, j.nombre AS nombre_jugador, e.nombre AS nombre_equipo, ejt.promedio_robos_temporada
FROM jugador j
INNER JOIN estadistica_jugador_temporada ejt ON j.codigo = ejt.id_jugador
INNER JOIN equipo e ON e.codigo = ejt.id_equipo
WHERE ejt.temporada = '2023-24'
	AND ejt.promedio_robos_temporada > (
		SELECT AVG(promedio_robos_temporada)
		FROM estadistica_jugador_temporada ejt2
		INNER JOIN equipo e2 ON e2.codigo = ejt2.id_equipo
		WHERE ejt2.temporada = '2023-24' AND e2.nombre = 'Heat'
	);

--Ejercicio15
SELECT jugador.nombre AS nombre, equipo.nombre AS equipo, ejt_cp.temporada 
FROM estadistica_jugador_temporada ejt_cp
INNER JOIN jugador_equipo ON jugador_equipo.codigo_jugador = ejt_cp.id_jugador 
	AND jugador_equipo.codigo_equipo = ejt_cp.id_equipo 
	AND jugador_equipo.temporada = ejt_cp.temporada
INNER JOIN jugador ON jugador.codigo = jugador_equipo.codigo_jugador
INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
WHERE ejt_cp.promedio_puntos_partido_temporada >
	(
	SELECT AVG(promedio_puntos_partido_temporada)
	FROM estadistica_jugador_temporada
	WHERE estadistica_jugador_temporada.temporada = ejt_cp.temporada
		AND estadistica_jugador_temporada.id_equipo = ejt_cp.id_equipo
	)
ORDER BY jugador.nombre, equipo.nombre;

--Ejercicio16
SELECT e.nombre,
	(SELECT COUNT(*) FROM partido p1 WHERE p1.equipo_local = e.codigo AND p1.temporada = '2023-24' AND p1.puntos_local > p1.puntos_visitante) AS partidos_ganados_como_local,
	(SELECT COUNT(*) FROM partido p2 WHERE p2.equipo_visitante = e.codigo AND p2.temporada = '2023-24' AND p2.puntos_visitante > p2.puntos_local) AS partidos_ganados_como_visitante
FROM equipo e
WHERE (SELECT COUNT(*) FROM partido p1 WHERE p1.equipo_local = e.codigo AND p1.temporada = '2023-24' AND p1.puntos_local > p1.puntos_visitante) > 
	  (SELECT COUNT(*) FROM partido p2 WHERE p2.equipo_visitante = e.codigo AND p2.temporada = '2023-24' AND p2.puntos_visitante > p2.puntos_local)
ORDER BY e.nombre;

--Ejercicio17
SELECT e.nombre, p_local.temporada,
	AVG(p_local.porcentaje_triples_anotados_local) AS media_triples_local,
	(SELECT AVG(p_visitante.porcentaje_triples_anotados_visitante) 
	 FROM partido p_visitante 
	 WHERE p_visitante.equipo_visitante = e.codigo 
	 AND p_visitante.temporada = p_local.temporada) AS media_triples_visitante
FROM equipo e
INNER JOIN partido p_local ON e.codigo = p_local.equipo_local
GROUP BY e.codigo, e.nombre, p_local.temporada
HAVING AVG(p_local.porcentaje_triples_anotados_local) > (
	 SELECT AVG(p_visitante.porcentaje_triples_anotados_visitante) 
	 FROM partido p_visitante 
	 WHERE p_visitante.equipo_visitante = e.codigo 
	 AND p_visitante.temporada = p_local.temporada
)
ORDER BY e.nombre, p_local.temporada;
