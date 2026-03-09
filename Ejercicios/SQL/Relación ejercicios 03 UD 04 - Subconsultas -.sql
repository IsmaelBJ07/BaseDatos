--Ejercicio1
SELECT *
FROM jugador
WHERE altura > 
	(
	SELECT AVG(altura)
	FROM jugador
	);

--Ejercicio2
SELECT jugador.nombre AS jugador, equipo.nombre AS equipo, jugador_equipo.temporada AS temporada
FROM jugador
INNER JOIN jugador_equipo ON jugador_equipo.codigo_jugador = jugador.codigo
INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
WHERE jugador_equipo.temporada = '2020-21' AND jugador.codigo IN
	(
	SELECT codigo_jugador
	FROM jugador_equipo
	WHERE temporada='2020-21'AND
	  (codigo_equipo IN
		(
		SELECT DISTINCT equipo_local
		FROM partido
		WHERE temporada='2020-21' AND equipo_visitante =
			(
			SELECT codigo
			FROM equipo
			WHERE nombre='Raptors'
			)
		 )
			 OR codigo_equipo IN
			(
			SELECT DISTINCT equipo_visitante
			FROM partido
			WHERE temporada='2020-21' AND equipo_local =
				(
				SELECT codigo
				FROM equipo
				WHERE nombre='Raptors'
				)
			)
		)
	)


--Ejercicio3
SELECT nombre
FROM jugador
WHERE codigo IN 
	(
	SELECT id_jugador
	FROM estadistica_jugador_temporada
	WHERE temporada = '2018-19' AND promedio_puntos_partido_temporada<15
	);

--Ejercicio4
SELECT DISTINCT jugador.nombre
FROM estadistica_jugador_temporada

INNER JOIN jugador_equipo ON jugador_equipo.codigo_jugador = estadistica_jugador_temporada.id_jugador 
	AND jugador_equipo.codigo_equipo = estadistica_jugador_temporada.id_equipo 
	AND jugador_equipo.temporada = estadistica_jugador_temporada.temporada
INNER JOIN jugador ON jugador.codigo = jugador_equipo.codigo_jugador

WHERE estadistica_jugador_temporada.temporada='2017-18' 
	AND estadistica_jugador_temporada.promedio_puntos_partido_temporada>700 
	AND jugador_equipo.codigo_equipo IN 
	(
	SELECT codigo
	FROM equipo
	WHERE conferencia ='Este'
	)
ORDER BY jugador.nombre ASC

--Ejercicio5
SELECT nombre
FROM jugador
WHERE jugador.codigo IN
	(
	SELECT estadistica_jugador_temporada.id_jugador
	FROM estadistica_jugador_temporada
	WHERE estadistica_jugador_temporada.temporada = '2012-13' 
		AND estadistica_jugador_temporada.promedio_tapones_temporada>80
	)

--Ejercicio6
SELECT jugador.nombre
FROM jugador
WHERE altura >
(
	SELECT AVG(altura)
	FROM jugador
	INNER JOIN jugador_equipo ON jugador_equipo.codigo_jugador = jugador.codigo
	WHERE temporada = '2021-22' AND jugador_equipo.codigo_equipo IN
	(
		SELECT codigo
		FROM equipo
		WHERE nombre = 'Timberwolves'
	)
)


