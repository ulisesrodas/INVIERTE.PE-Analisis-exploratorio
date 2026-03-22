import pandas as pd
from sqlalchemy import text

def obtener_inversion_por_region(engine):
    """
    Calcula la inversión total y la cantidad de proyectos por departamento.
    Uso de funciones de Agregación y Agrupamiento (SUM, COUNT, GROUP BY).
    """
    query = text("""
    SELECT 
        g.region AS departamento,
        COUNT(p.proyecto_id) AS cantidad_proyectos,
        SUM(p.costo_total) AS inversion_total
    FROM proyectos p
    INNER JOIN geografia g ON p.ubigeo_id = g.ubigeo_id
    WHERE p.estado = 'ACTIVO'
    GROUP BY g.region
    ORDER BY inversion_total DESC;
    """)
    return pd.read_sql_query(query, engine)

def analizar_desviacion_sectorial(engine):
    """
    Calcula la desviación porcentual de presupuestos por sector (sobrecostos).
    Uso de funciones de JOINs, Funciones de Agregación.
    """
    query = text("""
    SELECT 
        s.nombre_sector,
        COUNT(p.proyecto_id) AS num_proyectos,
        ROUND(AVG(((p.costo_total - p.costo_inicial) / NULLIF(p.costo_inicial, 0)) * 100), 2) AS desviacion_promedio_pct
    FROM proyectos p
    INNER JOIN sectores s ON p.sector_id = s.sector_id
    WHERE p.costo_inicial > 0 AND p.estado = 'ACTIVO'
    GROUP BY s.nombre_sector
    ORDER BY desviacion_promedio_pct DESC;
    """)
    return pd.read_sql_query(query, engine)

def obtener_ranking_regional_top3(engine):
    """
    Extrae el Top 3 de los proyectos más caros por cada departamento.
    Uso de funciones de Funciones de Ventana y CTE (WITH, OVER, PARTITION BY, RANK).
    """
    query = text("""
    WITH RankingRegional AS (
        SELECT 
            g.region AS departamento,
            p.nombre_proyecto,
            p.costo_total,
            RANK() OVER (PARTITION BY g.region ORDER BY p.costo_total DESC) AS puesto_regional
        FROM proyectos p
        INNER JOIN geografia g ON p.ubigeo_id = g.ubigeo_id
        WHERE p.estado = 'ACTIVO' AND p.costo_total > 0
    )
    SELECT * FROM RankingRegional 
    WHERE puesto_regional <= 3;
    """)
    return pd.read_sql_query(query, engine)

def clasificar_magnitud_proyectos(engine):
    """
    Clasifica los proyectos según su costo total para identificar dónde se concentra la inversión.
    Uso de funciones de Agregación Condicional (CASE WHEN).
    """
    query = text("""
    SELECT 
        s.nombre_sector,
        SUM(CASE WHEN p.costo_total < 1000000 THEN 1 ELSE 0 END) AS proyectos_menores_1M,
        SUM(CASE WHEN p.costo_total BETWEEN 1000000 AND 10000000 THEN 1 ELSE 0 END) AS proyectos_1M_a_10M,
        SUM(CASE WHEN p.costo_total > 10000000 THEN 1 ELSE 0 END) AS megaproyectos_mas_10M
    FROM proyectos p
    INNER JOIN sectores s ON p.sector_id = s.sector_id
    WHERE p.estado = 'ACTIVO'
    GROUP BY s.nombre_sector
    ORDER BY megaproyectos_mas_10M DESC;
    """)
    return pd.read_sql_query(query, engine)

def analizar_rentabilidad_social(engine):
    """
    Calcula el costo promedio por ciudadano beneficiado a nivel sectorial.
    Uso de funciones de Funciones matemáticas y agrupación.
    """
    query = text("""
    SELECT 
        s.nombre_sector,
        SUM(p.costo_total) AS inversion_total,
        SUM(p.beneficiarios) AS total_beneficiarios,
        ROUND(SUM(p.costo_total) / NULLIF(SUM(p.beneficiarios), 0), 2) AS costo_por_beneficiario
    FROM proyectos p
    INNER JOIN sectores s ON p.sector_id = s.sector_id
    WHERE p.estado = 'ACTIVO' 
      AND p.beneficiarios > 0 
      AND p.costo_total > 0
    GROUP BY s.nombre_sector
    ORDER BY costo_por_beneficiario DESC;
    """)
    return pd.read_sql_query(query, engine)

def analizar_efecto_callao_atomizacion(engine):
    """
    Calcula el costo promedio por proyecto y la cantidad total de proyectos por región.
    Permite visualizar la dispersión: Alta atomización (muchos proyectos baratos) 
    vs Concentración (pocos proyectos caros).
    """
    query = text("""
    SELECT 
        g.region AS departamento,
        COUNT(p.proyecto_id) AS cantidad_proyectos,
        ROUND((AVG(p.costo_total))::numeric, 2) AS costo_promedio,
        SUM(p.costo_total) AS inversion_total
    FROM proyectos p
    INNER JOIN geografia g ON p.ubigeo_id = g.ubigeo_id
    WHERE p.costo_total > 0 AND p.estado = 'ACTIVO'
    GROUP BY g.region
    ORDER BY cantidad_proyectos DESC;
    """)
    return pd.read_sql_query(query, engine)

def analizar_brecha_centralizacion(engine):
    """
    Agrupa la inversión total comparando Lima y Callao frente al resto del país.
    Uso de funciones de CASE WHEN en el SELECT para recategorización.
    """
    query = text("""
    SELECT 
        CASE 
            WHEN g.region IN ('LIMA', 'CALLAO') THEN 'Lima y Callao (Capital y Puerto)'
            ELSE 'Resto del País (23 regiones)'
        END AS bloque_geografico,
        COUNT(p.proyecto_id) AS cantidad_proyectos,
        SUM(p.costo_total) AS inversion_total
    FROM proyectos p
    INNER JOIN geografia g ON p.ubigeo_id = g.ubigeo_id
    WHERE p.costo_total > 0 AND p.estado = 'ACTIVO'
    GROUP BY 
        CASE 
            WHEN g.region IN ('LIMA', 'CALLAO') THEN 'Lima y Callao (Capital y Puerto)'
            ELSE 'Resto del País (23 regiones)'
        END
    ORDER BY inversion_total DESC;
    """)
    return pd.read_sql_query(query, engine)

def obtener_top_10_proyectos_mas_caros(engine):
    """
    Extrae los 10 proyectos individuales con el mayor costo total a nivel nacional.
    Uso de funciones de JOINs múltiples, filtrado y ordenamiento (LIMIT).
    """
    query = text("""
    SELECT 
        p.nombre_proyecto AS "Nombre del Proyecto",
        s.nombre_sector AS "Sector",
        g.region AS "Departamento",
        p.costo_total AS "Costo Total (S/)"
    FROM proyectos p
    INNER JOIN sectores s ON p.sector_id = s.sector_id
    INNER JOIN geografia g ON p.ubigeo_id = g.ubigeo_id
    WHERE p.estado = 'ACTIVO' AND p.costo_total > 0
    ORDER BY p.costo_total DESC
    LIMIT 10;
    """)
    return pd.read_sql_query(query, engine)