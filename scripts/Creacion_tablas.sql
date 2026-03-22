CREATE DATABASE inversion_publica_db;

-- CREAMOS LAS 3 TABLAS QUE VIENEN DE LA TABLA MAESTRA
-- 1. Geografía
CREATE TABLE geografia (
    ubigeo_id INT PRIMARY KEY,
    region VARCHAR(100),
    provincia VARCHAR(100),
    distrito VARCHAR(100)
);

-- 2. Sectores
CREATE TABLE sectores (
    sector_id INT PRIMARY KEY,
    nombre_sector VARCHAR(150)
);

-- 3. Hechos (Proyectos)
CREATE TABLE proyectos (
    proyecto_id INT PRIMARY KEY,
    nombre_proyecto TEXT,
    sector_id INT,
	fecha_registro VARCHAR(50),
    ubigeo_id INT,
    costo_inicial NUMERIC,
    costo_total NUMERIC,
    beneficiarios INT,
    estado VARCHAR(100),
    
    -- Definimos las relaciones (Llaves Foráneas)
    FOREIGN KEY (ubigeo_id) REFERENCES geografia(ubigeo_id),
    FOREIGN KEY (sector_id) REFERENCES sectores(sector_id)
);

-- VEMOS LAS TABLAS (no tienen información).
-- Ejecutar de nuevo después de ejecutar la parte 4 en Python: Carga a PostgreSQL
SELECT *
FROM Geografia

SELECT *
FROM Sectores

SELECT *
FROM Proyectos

-- TIP SI HAY ERRORES
-- Errores al crear tablas, las borramos:
DROP TABLE IF EXISTS geografia;
DROP TABLE IF EXISTS sectores;
DROP TABLE IF EXISTS proyectos;

-- Errores al llenar los datos, los borramos así:
TRUNCATE TABLE proyectos, sectores, geografia CASCADE;


-- SI CREAMOS LAS TABLAS CORRECTAMENTE, VAMOS AL PYTHON PARA LLENAR LOS DATOS
-- LAS CONSULTAS SQL TAMBIÉN LAS HAREMOS EN PYTHON