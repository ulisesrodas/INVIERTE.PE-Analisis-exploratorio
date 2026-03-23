# Auditoría de la Inversión Pública en el Perú (2020-2024)

Este proyecto realiza un análisis multidimensional de la ejecución presupuestal del Estado Peruano utilizando el dataset oficial de **Invierte.pe**. El objetivo es identificar ineficiencias, sobrecostos y disparidades territoriales mediante el uso de **SQL (PostgreSQL)** y **Python**.

## 👀 Dataset

**Elección del Dataset:**
Para el presente proyecto se ha seleccionado el dataset "Public Investments in Peru", el cual consolida información del Sistema Nacional de Programación Multianual y Gestión de Inversiones del 2020-2024. La relevancia de este conjunto de datos radica en que permite auditar y comprender la distribución territorial y sectorial de los recursos del Estado. Analizar esta información es clave para identificar disparidades regionales, prioridades reales de política pública y posibles ineficiencias (sobrecostos) en la ejecución de proyectos de inversión.

**Link:** [Dataset: Public Investments in Peru](https://www.kaggle.com/datasets/jenifergrategarro/dataset-public-investments-in-peru/data)

## ❓ Pregunta de Investigación / Problemática:
* **¿Cuáles son las principales distorsiones en la ejecución de la inversión pública peruana y cómo afectan estas fallas de planificación a la rentabilidad social y la equidad territorial en el periodo analizado?**

El modelo es el siguiente:

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/f484002a-1430-447d-8966-0c0bd9b4e57a" />

* **Tabla de Hechos:** `proyectos` (Métricas financieras y de impacto).
* **Dimensiones:** `geografia`, `sectores`.

## 📊 Hallazgos Principales
* **Sobrecostos Críticos:** El sector Educación presenta una desviación presupuestal promedio del **462.6%**.
<img width="915" height="536" alt="image" src="https://github.com/user-attachments/assets/5a08e314-1288-49a1-9982-ae577671c0b5" />


* **Efecto Callao:** Se identificó una alta concentración de inversión en megaproyectos en el puerto, contrastando con la **atomización del gasto** en regiones como Áncash.
<img width="917" height="601" alt="image" src="https://github.com/user-attachments/assets/512bd936-538f-469f-90a1-39e7b5a45b88" />


* **Atomización de las obras en Municipios Locales:** Al haber tantas obras, necesitan mano de obra calificada. Hay un déficit de profesionales en provincias.
<img width="916" height="532" alt="image" src="https://github.com/user-attachments/assets/b3ed4cd2-7eee-41af-ae19-091c82ea38ff" />

## 🏁 Conclusiones
**1. Crisis de Planificación y Sobrecostos:** Existe una deficiencia estructural en la elaboración de expedientes técnicos, especialmente en sectores críticos como Educación. El hallazgo de un sobrecosto promedio del 462.6% en este sector revela que el Estado no solo gasta mal, sino que es incapaz de prever contingencias, lo que deriva en una "hemorragia" de recursos que podrían destinarse a cerrar otras brechas sociales.

**2. La Trampa de la Atomización frente a la Concentración:** El análisis del "Efecto Callao" vs. la realidad de Áncash demuestra una gestión territorial esquizofrénica. Mientras algunas regiones fragmentan su presupuesto en miles de micro-obras de bajo impacto (visibilidad política de corto plazo), otras concentran su "riqueza" en un solo megaproyecto, generando una vulnerabilidad financiera extrema donde el desarrollo regional depende del éxito o fracaso de una única obra.

**3. Inequidad en la Rentabilidad Social:** El indicador de Costo por Beneficiario desmitifica la eficiencia del gasto. Se evidencia que sectores estratégicos para el capital humano (Salud y Educación) tienen una rentabilidad social mucho más alta (menor costo por persona) que los sectores de infraestructura pesada. Sin embargo, la centralización en Lima y Callao (casi el 50% de la inversión) demuestra que el Estado sigue priorizando los nodos logísticos de la capital sobre la integración y el bienestar de las periferias fronterizas y amazónicas.

## 🛠️ Stack Tecnológico
* **Base de Datos:** PostgreSQL (Modelo Relacional en Estrella).
* **Lenguaje:** Python 3.x.
* **Librerías Principales:** `Pandas`, `SQLAlchemy`, `Matplotlib`, `Seaborn`.
* **Entorno:** Jupyter Notebook / VS Code.

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
   DB_PASSWORD=tu variable de entorno local
