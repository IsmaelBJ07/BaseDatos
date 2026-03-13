--Ejercicio01
SELECT jugador.codigo, jugador.nombre, jugador.procedencia, jugador.altura, jugador.peso
FROM jugador
WHERE jugador.altura > (
    SELECT AVG(altura)
    FROM jugador
);

--Ejercicio02
SELECT DISTINCT jugador.nombre, equipo.nombre, jugador_equipo.temporada
FROM jugador
INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
WHERE jugador_equipo.temporada = '2020-21'
AND equipo.nombre != 'Raptors'
AND (
    equipo.codigo IN (
        SELECT equipo_local
        FROM partido
        WHERE equipo_visitante = (
            SELECT codigo
            FROM equipo
            WHERE nombre = 'Raptors'
        )
        AND temporada = '2020-21'
    )
    OR
    equipo.codigo IN (
        SELECT equipo_visitante
        FROM partido
        WHERE equipo_local = (
            SELECT codigo
            FROM equipo
            WHERE nombre = 'Raptors'
        )
        AND temporada = '2020-21'
    )
);

--Ejercicio03
SELECT jugador.nombre
FROM jugador
WHERE jugador.codigo NOT IN (
    SELECT id_jugador
    FROM estadistica_jugador_temporada
    WHERE temporada = '2018-19'
    AND promedio_puntos_partido_temporada > 15
)
AND jugador.codigo IN (
    SELECT id_jugador
    FROM estadistica_jugador_temporada
    WHERE temporada = '2018-19'
);

--Ejercicio04
SELECT DISTINCT jugador.nombre
FROM jugador
INNER JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
WHERE equipo.conferencia = 'Este'
AND estadistica_jugador_temporada.temporada = '2017-18'
AND estadistica_jugador_temporada.promedio_puntos_partido_temporada > 700
ORDER BY jugador.nombre;

--Ejercicio05
SELECT jugador.nombre
FROM jugador
INNER JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
WHERE estadistica_jugador_temporada.temporada = '2012-13'
AND estadistica_jugador_temporada.promedio_tapones_temporada > 80;

--Ejercicio06
SELECT jugador.nombre, jugador.altura
FROM jugador
WHERE jugador.altura > (
    SELECT AVG(jugador.altura)
    FROM jugador
    INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
    INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
    WHERE equipo.nombre = 'Timberwolves'
    AND jugador_equipo.temporada = '2021-22'
);

--Ejercicio07
SELECT DISTINCT equipo.nombre
FROM equipo
INNER JOIN jugador_equipo ON equipo.codigo = jugador_equipo.codigo_equipo
INNER JOIN jugador ON jugador.codigo = jugador_equipo.codigo_jugador
WHERE equipo.nombre LIKE 'C%'
AND jugador_equipo.temporada = '2024-25'
AND jugador.peso > 100;

--Ejercicio08
SELECT jugador.nombre, estadistica_jugador_temporada.temporada, estadistica_jugador_temporada.promedio_puntos_partido_temporada
FROM jugador
INNER JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
WHERE estadistica_jugador_temporada.temporada = '2017-18'
AND estadistica_jugador_temporada.promedio_puntos_partido_temporada > (
    SELECT AVG(promedio_puntos_partido_temporada)
    FROM estadistica_jugador_temporada
    WHERE temporada = '2017-18'
);

--Ejercicio09
SELECT estadistica_jugador_temporada.temporada, jugador.nombre, equipo.nombre, estadistica_jugador_temporada.promedio_tiros_libres_temporada
FROM estadistica_jugador_temporada
INNER JOIN jugador ON jugador.codigo = estadistica_jugador_temporada.id_jugador
INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
WHERE estadistica_jugador_temporada.promedio_tiros_libres_temporada = (
    SELECT MAX(promedio_tiros_libres_temporada)
    FROM estadistica_jugador_temporada estadistica2
    WHERE estadistica2.temporada = estadistica_jugador_temporada.temporada
);

--Ejercicio10
SELECT jugador.nombre, equipo.nombre
FROM jugador
INNER JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
WHERE estadistica_jugador_temporada.temporada = '2019-20'
AND estadistica_jugador_temporada.total_partidos_jugados > 36;

--Ejercicio11
SELECT jugador.nombre, equipo.nombre
FROM jugador
INNER JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
WHERE estadistica_jugador_temporada.temporada = '2020-21'
AND estadistica_jugador_temporada.promedio_asistencia_temporadas < 3;

--Ejercicio12
SELECT jugador.nombre, equipo.nombre
FROM jugador
INNER JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
WHERE estadistica_jugador_temporada.temporada = '2021-22'
AND estadistica_jugador_temporada.promedio_puntos_partido_temporada > (
    SELECT AVG(promedio_puntos_partido_temporada)
    FROM estadistica_jugador_temporada
    WHERE temporada = '2021-22'
);

--Ejercicio13
SELECT DISTINCT jugador.nombre
FROM jugador
INNER JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
WHERE estadistica_jugador_temporada.temporada = '2023-24'
AND equipo.conferencia = 'Este'
AND estadistica_jugador_temporada.promedio_puntos_partido_temporada >= 375
AND equipo.codigo IN (
    SELECT equipo_visitante
    FROM partido
    WHERE temporada = '2023-24'
);

--Ejercicio14
SELECT jugador.codigo, jugador.nombre, equipo.nombre, estadistica_jugador_temporada.promedio_robos_temporada
FROM jugador
INNER JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
WHERE estadistica_jugador_temporada.temporada = '2023-24'
AND estadistica_jugador_temporada.promedio_robos_temporada > (
    SELECT AVG(estadistica_jugador_temporada.promedio_robos_temporada)
    FROM estadistica_jugador_temporada
    INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
    WHERE estadistica_jugador_temporada.temporada = '2023-24'
    AND equipo.nombre = 'Heat'
);

--Ejercicio15
SELECT jugador.nombre, equipo.nombre, estadistica_jugador_temporada.temporada
FROM estadistica_jugador_temporada
INNER JOIN jugador_equipo ON jugador_equipo.codigo_jugador = estadistica_jugador_temporada.id_jugador 
AND jugador_equipo.codigo_equipo = estadistica_jugador_temporada.id_equipo 
AND jugador_equipo.temporada = estadistica_jugador_temporada.temporada
INNER JOIN jugador ON jugador.codigo = jugador_equipo.codigo_jugador
INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
WHERE estadistica_jugador_temporada.promedio_puntos_partido_temporada > (
    SELECT AVG(promedio_puntos_partido_temporada)
    FROM estadistica_jugador_temporada estadistica2
    WHERE estadistica2.temporada = estadistica_jugador_temporada.temporada
    AND estadistica2.id_equipo = estadistica_jugador_temporada.id_equipo
)
ORDER BY jugador.nombre, equipo.nombre;

--Ejercicio16
SELECT equipo.nombre,
(
    SELECT COUNT(*)
    FROM partido
    WHERE partido.equipo_local = equipo.codigo
    AND partido.temporada = '2023-24'
    AND partido.puntos_local > partido.puntos_visitante
) AS partidos_ganados_como_local,
(
    SELECT COUNT(*)
    FROM partido
    WHERE partido.equipo_visitante = equipo.codigo
    AND partido.temporada = '2023-24'
    AND partido.puntos_visitante > partido.puntos_local
) AS partidos_ganados_como_visitante
FROM equipo
WHERE
(
    SELECT COUNT(*)
    FROM partido
    WHERE partido.equipo_local = equipo.codigo
    AND partido.temporada = '2023-24'
    AND partido.puntos_local > partido.puntos_visitante
)
>
(
    SELECT COUNT(*)
    FROM partido
    WHERE partido.equipo_visitante = equipo.codigo
    AND partido.temporada = '2023-24'
    AND partido.puntos_visitante > partido.puntos_local
) 
ORDER BY equipo.nombre;

--Ejercicio17
SELECT equipo.nombre, partido.temporada,
AVG(partido.porcentaje_triples_anotados_local) AS media_triples_local,
(
    SELECT AVG(partido_visitante.porcentaje_triples_anotados_visitante) 
    FROM partido partido_visitante
    WHERE partido_visitante.equipo_visitante = equipo.codigo
    AND partido_visitante.temporada = partido.temporada
) AS media_triples_visitantes
FROM equipo
INNER JOIN partido ON equipo.codigo = partido.equipo_local
GROUP BY equipo.codigo, equipo.nombre, partido.temporada
HAVING AVG(partido.porcentaje_triples_anotados_local) >
(
    SELECT AVG(partido_visitante.porcentaje_triples_anotados_visitante)
    FROM partido partido_visitante
    WHERE partido_visitante.equipo_visitante = equipo.codigo
    AND partido_visitante.temporada = partido.temporada
)
ORDER BY equipo.nombre, partido.temporada;