# Auditoría de la Inversión Pública en el Perú (2020-2024)

Este proyecto realiza un análisis multidimensional de la ejecución presupuestal del Estado Peruano utilizando el dataset oficial de **Invierte.pe**. El objetivo es identificar ineficiencias, sobrecostos y disparidades territoriales mediante el uso de **SQL (PostgreSQL)** y **Python**.

##  Descripción del dataset

El análisis se fundamenta en el dataset "Public Investments in Peru", el cual consolida información del Sistema Nacional de Programación Multianual y Gestión de Inversiones del 2020-2024. La relevancia de este conjunto de datos radica en que permite auditar y comprender la distribución territorial y sectorial de los recursos del Estado. Analizar esta información es clave para identificar disparidades regionales, prioridades reales de política pública y posibles ineficiencias (sobrecostos) en la ejecución de proyectos de inversión.

* **Periodo de información:** El dataset abarca los proyectos de inversión pública registrados y actualizados en el periodo **2020 - 2024**.
* **Volumen de datos:** Consta de aproximadamente 381,273 registros consolidados, a partir de 25 archivos de Excel unificados.
* **Estructura:** La base de datos se ha modelado en un esquema de estrella, contando con:
  * **Tabla de hechos (`proyectos`):** Contiene las métricas cuantitativas clave como el costo de inversión inicial, el costo actualizado, costo total y el estado de la obra.
  * **Dimensión geográfica (`geografia`):** Permite granular el análisis a nivel de región, provincia y distrito.
  * **Dimensión sectorial (`sectores`):** Categoriza la inversión según la función del Estado.
<p align="center"><img width="675" height="300" alt="image" src="https://github.com/user-attachments/assets/f484002a-1430-447d-8966-0c0bd9b4e57a" /></p>

Si bien el dataset proporciona una visión estrictamente financiera y de ejecución presupuestal, no incluye indicadores demográficos, por lo que el análisis se centra en la eficiencia del gasto y su distribución territorial.

**Link:** [Dataset: Public Investments in Peru](https://www.kaggle.com/datasets/jenifergrategarro/dataset-public-investments-in-peru/data)

## ❓ Pregunta de Investigación / Problemática:
* **¿Cuáles son las principales distorsiones en la ejecución de la inversión pública peruana y cómo afectan estas fallas de planificación a la rentabilidad social y la equidad territorial en el periodo analizado?**



## 📊 Hallazgos Principales
* **Sobrecostos Críticos:** El sector Educación presenta una desviación presupuestal promedio del **462.6%**. Más información en [Gestión](https://gestion.pe/economia/ahora-casi-14-mil-obras-publicas-en-peru-son-mas-caras-que-lo-previsto-al-inicio-noticia/)
<p align="center"><img width="800" height="450" alt="image" src="https://github.com/user-attachments/assets/5a08e314-1288-49a1-9982-ae577671c0b5" /></p>


* **Atomización de las obras en Municipios Locales:** Al haber tantas obras, necesitan mano de obra calificada. Hay un déficit de profesionales en provincias. Más información en [ComexPerú](https://www.comexperu.org.pe/articulo/gestion-municipal-en-2025-el-967-requiere-asistencia-tecnica-o-capacitacion) y [La República](https://especial.larepublica.pe/metro-cuadrado/vivienda-y-construccion/2026/02/03/municipios-con-millones-sin-gastar-por-que-tantas-obras-publicas-siguen-paralizadas-en-el-peru-265410)
<p align="center"><p align="center"><img width="805" height="390" alt="image" src="https://github.com/user-attachments/assets/a489185c-3ab4-4132-8b6c-d20561a5df85" /></p>


* **Efecto Callao:** Se identificó una alta concentración de inversión en megaproyectos en el puerto, contrastando con la **atomización del gasto** en regiones como Áncash.
<p align="center"><img width="917" height="601" alt="image" src="https://github.com/user-attachments/assets/512bd936-538f-469f-90a1-39e7b5a45b88" /></p>



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
* `analysis/`: Contiene el informe final `Final_Analysis.ipynb` con las visualizaciones, análisis y conclusiones.
* `inputs/`: Contiene los archivos xlsx de Kaggle, pero igual son generados en `load_data.ipynb`.
* `queries/`: Contiene `script_queries.py` con las funciones SQL a usar por el informe final.
* `scripts/`: Contiene `load_data.ipynb` que extrae la información de Kaggle y crea las laves primarias y foráneas de las tablas a usar.

## 🚀 Cómo ejecutarlo
Si se quiere ver al detalle el proyecto, ver el informe `Final_Analysis.ipynb`. Para ejecutarlo, tener en cuenta a `script_queries.py` y `load_data.ipynb`. El procedimiento es el siguiente:

1. Clona el repositorio en tu computadora/laptop.
2. Ten claro cuál es tu variable de entorno en PostgreSQL. Más información aquí: [Link](https://www.youtube.com/watch?v=SBEtF7EfY6w)
3. Configura tu base de datos en PostgreSQL como  `inversion_publica_db`.
4. Ejecuta `load_data.ipynb` cambiando antes tu variable de entorno `os.getenv()` donde sea necesario.
5. En `script_queies.py` están todas las consultas. No es necesario modificarlo. 
6. Ejecutar `Final_Analysis.ipynb`. Jalará información de `load_data.ipynb` y `script_queries.py`.
