--Ejercicio1
SELECT *
FROM jugador
WHERE altura > 
	(
	SELECT AVG(altura)
	FROM jugador
	);

--Ejercicio2
SELECT *
FROM jugador
WHERE codigo IN
	(
	SELECT codigo_jugador
	FROM jugador_equipo
	WHERE temporada = '2020-21' AND codigo_equipo =
	(
	SELECT partido.equipo_local, partido.equipo_visitante
	FROM equipo
	INNER JOIN partido ON equipo.codigo = partido.equipo_local
	INNER JOIN partido ON equipo.codigo = partido.equipo_visitante
	WHERE nombre = 'Raptors'
	)
);

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
SELECT DISTINCT nombre
FROM jugador
WHERE codigo IN 
	(
	SELECT id_jugador
	FROM estadistica_jugador_temporada
	WHERE temporada = '2018-19' AND promedio_puntos_partido_temporada>700 AND id_jugador in
	(
	SELECT codigo
	FROM equipo
	WHERE conferencia = 'Este'

	)
	);

