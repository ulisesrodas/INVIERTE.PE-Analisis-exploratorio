# Análisis de la Inversión Pública en el Perú (Invierte.pe) - ETL y Modelado Relacional
## 📌 Descripción del Proyecto
Este proyecto analiza la cartera de proyectos de inversión pública en el Perú mediante la extracción, limpieza, modelado y análisis de datos del sistema Invierte.pe. El flujo de trabajo transforma una base de datos plana descentralizada (25 archivos regionales) en un modelo relacional robusto en PostgreSQL, permitiendo identificar patrones territoriales, sobrecostos y la priorización macroeconómica del Estado.

## 🛠️ Tecnologías Utilizadas
* Lenguajes: Python, SQL

* Librerías Python: pandas (manipulación de datos), sqlalchemy, os (conexión segura a base de datos)

* Base de Datos: PostgreSQL

* Entorno: Jupyter Notebook, pgAdmin 4

## ⚙️ Arquitectura y Metodología (Flujo ETL)
* Extracción y Unificación (Extract): Lectura automatizada de 25 archivos Excel departamentales desde Kaggle utilizando bucles en Python, consolidando la información en un archivo maestro de más de 380,000 registros (maestro_inversiones_peru.csv).

* Transformación y Modelado (Transform): Transición de un dataset plano a un modelo de esquema en estrella. Se crearon dos tablas dimensionales (geografia y sectores) y una tabla de hechos (proyectos), limpiando duplicados, normalizando tipos de datos y asignando llaves primarias (PRIMARY KEY) y foráneas (FOREIGN KEY).

* Carga de Datos (Load): Ingesta masiva hacia PostgreSQL utilizando la función to_sql de SQLAlchemy. Se implementaron buenas prácticas de ciberseguridad utilizando variables de entorno (os.getenv()) para proteger las credenciales de acceso locales.

* Análisis Estratégico (SQL Analytics): Consultas avanzadas en PostgreSQL empleando INNER JOIN, subconsultas, agrupamientos (GROUP BY, HAVING) y funciones de ventana (RANK() OVER) para generar rankings regionales y detectar disparidades presupuestales.

## 📊 Hallazgos Analíticos Clave
* Hegemonía del Cemento: El 80% del Top 10 de megaproyectos nacionales pertenece al sector Transportes y Comunicaciones (ej. Ferrocarriles interurbanos y Líneas del Metro de Lima), relegando a sectores de primera necesidad como Salud o Educación.

* El "Efecto Callao": A pesar de tener una baja cantidad de obras activas, la Provincia Constitucional del Callao concentra un costo promedio por proyecto de S/ 28.4 millones, quintuplicando la media nacional, lo que evidencia su rol como nodo exclusivo de mega-infraestructura logística.

* Disparidades Territoriales: Existe una clara marginación presupuestal hacia las zonas amazónicas y fronterizas (Madre de Dios, Ucayali, Tacna, Tumbes), las cuales ocupan la base del ranking nacional de inversión total frente a la concentración de capital en la costa central.

## 🚀 Instrucciones de Ejecución
Para replicar este proyecto en tu entorno local, sigue estos pasos:

* Clonar el repositorio:

* Bash
`git clone https://github.com/tu-usuario/tu-repositorio.git`

* Crear la Base de Datos:
Abre pgAdmin y ejecuta la primera parte del archivo TRABAJO FINAL - BD INVERSION PUBLICA.sql para crear la base de datos inversion_publica_db y las tablas vacías con sus restricciones.

* Configurar Variables de Entorno:
Asegúrate de configurar tu contraseña local de PostgreSQL como una variable de entorno en tu sistema. El script de Python buscará la variable configurada (puedes ajustar el nombre en el código).

* Ejecutar el pipeline ETL:
Abre y ejecuta las celdas de Preprocesamiento.ipynb. Esto procesará los archivos .xlsx de la carpeta /data y poblará las tablas en PostgreSQL.

* Realizar Consultas:
Vuelve al archivo .sql y ejecuta las consultas analíticas de la sección 2.4 para obtener los resúmenes financieros y operativos.
