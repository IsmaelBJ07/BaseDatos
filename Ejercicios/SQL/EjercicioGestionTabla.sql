CREATE DATABASE Pruebas;

USE Pruebas;

--Ejercicio1
CREATE TABLE Pais (
	idPais INT IDENTITY (1,1),
	nombrePais NVARCHAR(100) NOT NULL,

	CONSTRAINT pl_pais_idPaais PRIMARY KEY (idPais)
);

--Ejercicio2
CREATE TABLE Region (
	idRegion INT IDENTITY (1,1),
	nombreRegion NVARCHAR (300),
	hemisferioRegion NVARCHAR NOT NULL ,

	CONSTRAINT pk_region_idRegion PRIMARY KEY (idRegion),
	CONSTRAINT ck_region_hemisferioregion CHECK (hemisferioRegion IN('NORTE', 'SUR'))
);



--Ejercicio3
ALTER TABLE Pais
ADD Region INT;

ALTER TABLE Pais
ADD CONSTRAINT fk_region_pais FOREIGN KEY (idPais) REFERENCES Region(idRegion);

--Ejercicio4
ALTER TABLE Pais
ADD CONSTRAINT nombrePais CHECK (nombrePais IN('Italia', 'China', 'India')

);

--Ejercicio5
CREATE TABLE Trabajo (
	idTrabajo NVARCHAR (10),
	nombreTrabajo NVARCHAR (35) NOT NULL,
	salarioMin DECIMAL (7,2),
	salarioMax DECIMAL (7,2) CHECK (salarioMax < 25000),

	CONSTRAINT pk_trabajo_idtrabajo PRIMARY KEY (idTrabajo)
);

--Ejercicio6
CREATE TABLE Trabajador (
	idTrabajador NVARCHAR (9),
	nombreTrabajador NVARCHAR (200) NOT NULL,
	apellido1Trabajador NVARCHAR (200) NOT NULL,
	apellido2Trabajador NVARCHAR (200) NOT NULL,
	fechaNacTrabajador DATE NOT NULL,

	CONSTRAINT pk_trabajador_idtrabajador PRIMARY KEY (idTrabajador)
);

--Ejercicio7
CREATE TABLE Historial_Trabajo (
	idTrabajador NVARCHAR (9),
	idTrabajo NVARCHAR (10),
	fecha_comienzo DATE NOT NULL,
	fecha_finalizacion DATE NOT NULL,

	CONSTRAINT fk_trabajo_historial FOREIGN KEY (idTrabajo) REFERENCES Trabajo(idTrabajo)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT fk_trabajador_historial FOREIGN KEY (idTrabajador) REFERENCES Trabajador(idTrabajador)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT pk_historial_trabajo PRIMARY KEY (idTrabajador, idTrabajo)

);

--Ejercicio8
ALTER TABLE Pais
ADD CONSTRAINT uq_pais_nombrepais UNIQUE (nombrePais);

--Ejercicio9
ALTER TABLE Trabajo
ADD CONSTRAINT df_trabajosalariomin DEFAULT 1500 for salarioMin;