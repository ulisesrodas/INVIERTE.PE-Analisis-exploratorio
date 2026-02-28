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

-- VEMOS LAS TABLAS (no tienen información)
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


-- SI CREAMOS LAS TABLAS CORRECTAMENTE, VAMOS AL PYTHON PARA LLENAR LOS DATOS. 
-- DESPUÉS DE LLENAR (Y COMPROBAR) LOS DATOS EN LAS TABLAS CORRESPONDIENTE, SEGUIMOS

-- 2.4. CONSULTAS Y ANÁLISIS EN SQL
-- A. CONSULTAS BÁSICAS: USO DE SELECT Y WHERE
-- Proyectos activos que superen los 2000 millones de soles en costo actualizado
SELECT 
    proyecto_id, 
    nombre_proyecto, 
    costo_total, 
    estado 
FROM proyectos 
WHERE estado = 'ACTIVO' 
  AND costo_total > 2000000000;


-- B. FILTROS CONDICIONALES: USO DEL CASE WHEN
-- Analizar el sobrecosto de las obras de "Mejoramiento" y crear una alerta presupuestal
SELECT 
    nombre_proyecto,
    fecha_registro, 
    costo_inicial,
    costo_total,
    (costo_total - costo_inicial) AS sobrecosto, -- Operador matemático
    CASE  -- Cláusula CASE WHEN
        WHEN (costo_total - costo_inicial) > 5000000 THEN 'Alerta Roja: Sobrecosto Crítico' -- 5 Millones de soles
        WHEN (costo_total - costo_inicial) > 0 THEN 'Alerta Amarilla: Sobrecosto Moderado'
        ELSE 'Verde: Dentro del Presupuesto'
    END AS alerta_presupuestal
FROM Proyectos
WHERE nombre_proyecto LIKE '%MEJORAMIENTO%' -- Operador de texto
  AND costo_total > 0
  AND TO_DATE(fecha_registro, 'DD/MM/YYYY') >= '2022-01-01'; -- Operador de fecha: Convierte el texto a fecha y filtra desde el 1 de enero de 2022


-- C. INTEGRACIÓN DE JOINS Y SUBCONSULTAS
-- TOP NACIONAL:
-- Top 10 de los proyectos más caros a nivel nacional
SELECT 
    p.proyecto_id,
    p.nombre_proyecto,
    s.nombre_sector AS sector,
    g.region AS departamento,
    p.costo_total
FROM proyectos p
INNER JOIN geografia g ON p.ubigeo_id = g.ubigeo_id
INNER JOIN sectores s ON p.sector_id = s.sector_id
WHERE p.costo_total > 0 
  AND p.estado = 'ACTIVO' -- Opcional, pero metodológicamente ideal para evaluar obras vigentes
ORDER BY p.costo_total DESC
LIMIT 10;


-- D.1. FUNCIONES DE AGREGACIÓN Y AGRUPAMIENTO:
-- Resumen macroeconómico de obras activas por departamento
SELECT 
    g.region AS departamento,
    COUNT(p.proyecto_id) AS total_proyectos_activos, -- Cuenta cuántos proyectos hay
    SUM(p.costo_total) AS inversion_total_region, -- Suma todo el dinero
    ROUND(AVG(p.costo_total), 2) AS costo_promedio, -- Saca el promedio por obra
    MAX(p.costo_total) AS obra_mas_cara, -- Encuentra el mayor costo
    MIN(p.costo_total) AS obra_mas_barata -- Encuentra el menor costo
FROM proyectos p
INNER JOIN geografia g ON p.ubigeo_id = g.ubigeo_id
WHERE p.estado = 'ACTIVO'
GROUP BY g.region -- Agrupado por departamento
HAVING COUNT(p.proyecto_id) > 100 -- Condición HAVING sobre la agregación
ORDER BY inversion_total_region DESC; -- Ordenamos por el que invierte más

-- D.2 FUNCIONES DE VENTANA (OVER):
-- Top 3 de los proyectos más caros por cada departamento (Ranking Regional)
-- Usamos un CTE (WITH) para poder filtrar el top 3 cómodamente
WITH RankingRegional AS (
    SELECT 
        g.region AS departamento,
        p.nombre_proyecto,
        p.costo_total,
        -- La función de ventana (OVER):
        -- PARTITION BY crea "bloques" por región. 
        -- ORDER BY ordena de mayor a menor dentro de cada bloque.
        RANK() OVER (PARTITION BY g.region ORDER BY p.costo_total DESC) AS puesto_regional
    FROM proyectos p
    INNER JOIN geografia g ON p.ubigeo_id = g.ubigeo_id
    WHERE p.estado = 'ACTIVO' AND p.costo_total > 0
)
-- Llamamos a nuestra tabla temporal y le pedimos solo las "medallas de oro, plata y bronce" 
SELECT * FROM RankingRegional 
WHERE puesto_regional <= 3;