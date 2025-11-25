CREATE DATABASE Pubs;
USE Pubs;

CREATE TABLE LOCALIDAD (
    codigo_localidad INT IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_localidad PRIMARY KEY (codigo_localidad)
);

CREATE TABLE TITULAR (
    DNI_titular VARCHAR(9),
    nombre VARCHAR(100) NOT NULL,
    domicilio VARCHAR(200),
    codigo_PUB VARCHAR(10),
    CONSTRAINT pk_titular PRIMARY KEY (DNI_titular)
);

CREATE TABLE EMPLEADO (
    DNI_empleado VARCHAR(9),
    nombre VARCHAR(100) NOT NULL,
    domicilio VARCHAR(200),
    CONSTRAINT pk_empleado PRIMARY KEY (DNI_empleado)
);

CREATE TABLE PUB (

CREATE TABLE ARTICULO (
    codigo_articulo VARCHAR(10),
    nombre VARCHAR(100) NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    codigo_PUB VARCHAR(10) NOT NULL,
    CONSTRAINT pk_articulo PRIMARY KEY (codigo_articulo),
    CONSTRAINT ch_precio_articulo CHECK (precio > 0),
    CONSTRAINT fk_articulo_pub FOREIGN KEY (codigo_PUB) REFERENCES PUB(codigo)
);

CREATE TABLE PUB_EMPLEADO (
    codigo_PUB VARCHAR(10),
    DNI_empleado VARCHAR(9),
    funcion VARCHAR(20) NOT NULL,
    CONSTRAINT pk_pub_empleado PRIMARY KEY (codigo_PUB, DNI_empleado),
    CONSTRAINT ch_funcion_empleado CHECK (funcion IN ('CAMARERO', 'SEGURIDAD', 'LIMPIEZA')),
    CONSTRAINT fk_pub_empleado_pub FOREIGN KEY (codigo_PUB) REFERENCES PUB(codigo),
    CONSTRAINT fk_pub_empleado_empleado FOREIGN KEY (DNI_empleado) REFERENCES EMPLEADO(DNI_empleado)
);

CREATE LOGIN administradorPubs
WITH PASSWORD = 'AdminPubs2025!';

CREATE USER administradorPubs
FOR LOGIN administradorPubs;

CREATE USER lectorDatos WITHOUT LOGIN;

GRANT SELECT ON Pubs.LOCALIDAD TO lectorDatos;
GRANT SELECT ON Pubs.PUB TO lectorDatos;
GRANT SELECT ON Pubs.ARTICULO TO lectorDatos;

CREATE LOGIN gestorArticulos
WITH PASSWORD = 'GestorArt2025!';

CREATE USER gestorArticulos
FOR LOGIN gestorArticulos;

GRANT SELECT, INSERT, UPDATE ON Pubs.ARTICULO TO gestorArticulos;

CREATE LOGIN gestorEmpleados
WITH PASSWORD = 'GestorEmp2025!';

CREATE USER gestorEmpleados
FOR LOGIN gestorEmpleados;

GRANT INSERT, UPDATE, DELETE ON Pubs.EMPLEADO TO gestorEmpleados;
GRANT INSERT, UPDATE, DELETE ON Pubs.PUB_EMPLEADO TO gestorEmpleados;

GRANT INSERT, UPDATE, DELETE ON Pubs.PUB TO administradorPubs WITH GRANT OPTION;

REVOKE UPDATE ON Pubs.ARTICULO FROM gestorArticulos;

DENY SELECT ON Pubs.TITULAR TO lectorDatos;

ALTER USER gestorEmpleados WITH NAME = encargadoPersonal;

GRANT ALL ON Pubs.TITULAR TO administradorPubs;

DROP USER lectorDatos;