<img width="916" height="532" alt="image" src="https://github.com/user-attachments/assets/67c0cbe7-592a-43ad-b72d-19cb7fcdb245" /><img width="917" height="601" alt="image" src="https://github.com/user-attachments/assets/d75b425f-0267-4769-912d-54ff5602a0cf" /># 🇵🇪 Auditoría de la Inversión Pública en el Perú (2020-2024)

Este proyecto realiza un análisis multidimensional de la ejecución presupuestal del Estado Peruano utilizando el dataset oficial de **Invierte.pe**. El objetivo es identificar ineficiencias, sobrecostos y disparidades territoriales mediante el uso de **SQL (PostgreSQL)** y **Python**.

El modelo es el siguiente:
<img width="987" height="402" alt="image" src="https://github.com/user-attachments/assets/f484002a-1430-447d-8966-0c0bd9b4e57a" />


## 📊 Hallazgos Principales
* **Sobrecostos Críticos:** El sector Educación presenta una desviación presupuestal promedio del **462.6%**.
<img width="915" height="536" alt="image" src="https://github.com/user-attachments/assets/5a08e314-1288-49a1-9982-ae577671c0b5" />

* **Efecto Callao:** Se identificó una alta concentración de inversión en megaproyectos en el puerto, contrastando con la **atomización del gasto** en regiones como Áncash.
<img width="917" height="601" alt="image" src="https://github.com/user-attachments/assets/512bd936-538f-469f-90a1-39e7b5a45b88" />

* **Atomización de las obras en Municipios Locales:** Al haber tantas obras, necesitan mano de obra calificada. Hay un déficit de profesionales en provincias.
<img width="916" height="532" alt="image" src="https://github.com/user-attachments/assets/b3ed4cd2-7eee-41af-ae19-091c82ea38ff" />


## 🛠️ Stack Tecnológico
* **Base de Datos:** PostgreSQL (Modelo Relacional en Estrella).
* **Lenguaje:** Python 3.x.
* **Librerías Principales:** `Pandas`, `SQLAlchemy`, `Matplotlib`, `Seaborn`.
* **Entorno:** Jupyter Notebook / VS Code.

## 📐 Arquitectura de Datos
El proyecto implementa un **Star Schema** (Modelo en Estrella) optimizado para analítica (OLAP).
* **Tabla de Hechos:** `proyectos` (Métricas financieras y de impacto).
* **Dimensiones:** `geografia`, `sectores`, `ejecutores`.

## 📂 Estructura del Repositorio
* `analysis/`: Notebooks principales (`Final_Analysis.ipynb`) con las visualizaciones.
* `queries/`: Módulo de Python (`script_queries.py`) con todas las funciones SQL.
* `images/`: Gráficos generados y diagramas del modelo.
* `data/`: (Opcional) Diccionario de datos o scripts de carga.

## 🚀 Cómo ejecutarlo
1. Clona el repositorio.
2. Configura tu base de datos PostgreSQL con el archivo `.sql` provisto.
3. Crea un archivo `.env` con tus credenciales de base de datos:
   ```env
   DB_PASSWORD=tu_contraseña
