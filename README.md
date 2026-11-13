# 🗳️ Sistema Text-to-SQL para el análisis de los resultados electorales del Perú 2026

Proyecto de investigación de la Maestría en Inteligencia Artificial de la Universidad Nacional de Ingeniería (UNI), orientado al desarrollo de un sistema basado en modelos de lenguaje de gran tamaño (LLM) que permita responder consultas analíticas sobre los resultados de la elección presidencial de las Elecciones Generales del Perú 2026.

El sistema permitirá que los usuarios formulen preguntas en lenguaje natural, las cuales serán transformadas en consultas SQL, ejecutadas sobre una base de datos relacional y presentadas mediante una respuesta en lenguaje natural junto con la consulta SQL generada.

La investigación busca facilitar el análisis de los resultados electorales sin requerir que los usuarios conozcan SQL, permitiendo realizar consultas que involucren filtros, agrupaciones, agregaciones, comparaciones entre organizaciones políticas y análisis de diferentes ámbitos geográficos.


---

## 👥 Autores

* **Kenny S. Asto Hinostroza** – [@kefencho](https://github.com/kefencho)
---

## 📊 Dataset

- **Fuente:** [ONPE – Resultados históricos de las Elecciones Generales del Perú 2026.](https://resultadohistorico-eg2026.onpe.gob.pe/main/resumen)
- **Fecha de descarga:** 16 de agosto de 2026.
- **Cobertura geográfica:** 25 departamentos, 196 provincias y 1,892 distritos.
- **Organizaciones políticas:** 36 organizaciones políticas identificadas.
- **Formato original:** archivos JSON con información de participantes y totales de los resultados electorales.
- **Datos procesados:** registros electorales organizados por ámbito geográfico y organización política, que serán almacenados en una base de datos relacional.
Los archivos JSON originales constituyen la fuente de datos, mientras que la información procesada será utilizada para construir la base de datos que permitirá realizar consultas analíticas sobre los resultados electorales.
---

## 🗂️️ Estructura del Repositorio

```text
├── data/
│   ├── raw/                  
│   │   └── ONPE_2026/
│   │       └── Peru/                           # JSON originales descargados de ONPE
|   ├── processed/              
│   │   └── datos_electorales/                  # Datos procesados y validados
│   └── evaluation/                             # Preguntas y resultados de referencia
├── notebooks/         
│   ├── 01_exploracion_datos.ipynb              # Análisis exploratorio inicial
│   └── 02_validacion_unidades_textuales.ipynb  # Validación de unidades textuales
├── scripts/
│   └── descargar_onpe.sh                       # Descarga de datos oficiales de ONPE
├── src/               
│   ├── data/
│   │   └── generar_datos.py                    # Procesamiento de archivos JSON
│   ├── text_to_sql/
│   │   ├── llm_client.py                       # Integración con el modelo de lenguaje
│   │   ├── prompt_builder.py                   # Construcción de instrucciones para el LLM
│   │   └── sql_generator.py                    # Generación de consultas SQL
│   ├── verification/
│   │   └── sql_validator.py                    # Validación de consultas SQL
│   └── evaluation/
│       └── metrics.py                          # Métricas de evaluación         
├── logs/                                       # Archivos de logging
├── results/                                    # Resultados y métricas de evaluación
├── slides/                                     # Presentaciones de resultados
├── .gitignore
├── README.md
└── requirements.txt
```
---

## ⚙️ Requisitos

El proyecto utilizará Python y las bibliotecas necesarias para procesar los datos electorales, integrar modelos de lenguaje, interactuar con la base de datos y evaluar las consultas generadas.

**1. Verificar Python**

```bash
python --version
```

**2. Crear el entorno virtual**

```bash
python -m venv .venv
```

**3. Activar el entorno virtual en Windows PowerShell**

```powershell
.\.venv\Scripts\Activate.ps1
```

Si utilizas **Git Bash**, activa el entorno con:

```bash
source .venv/Scripts/activate
```

**4. Actualizar pip (opcional, recomendado)**

```bash
python -m pip install --upgrade pip
```

**5. Instalar las dependencias del proyecto**
```bash
python -m pip install -r requirements.txt
```

La lista definitiva de dependencias y las versiones compatibles se documentarán en requirements.txt.

---

## 🚀 Cómo Ejecutar el Pipeline
El flujo de ejecución previsto consta de las siguientes etapas:
1. **Ingesta de datos**

   Lectura de los archivos JSON originales de ONPE almacenados en data/raw/.

2. **Procesamiento y almacenamiento de datos**

   Limpieza, transformación y organización de los resultados electorales para su incorporación en una base de datos relacional.

3. **Generación de consultas SQL**

    Recepción de preguntas en lenguaje natural y utilización de un modelo de lenguaje de gran tamaño para generar las consultas SQL correspondientes, considerando el esquema de la base de datos.

4. **Validación y ejecución de consultas**

    Validación de las consultas SQL generadas y ejecución sobre la base de datos relacional para obtener los resultados solicitados.

7. **Generación de respuestas y evaluación**

    Presentación de los resultados en lenguaje natural junto con la consulta SQL generada. Evaluación del sistema mediante un conjunto de 100 preguntas analíticas y las métricas definidas en el diseño metodológico.

Los comandos específicos de ejecución se documentarán cuando los módulos correspondientes estén implementados.

---

## 📈 Resultados Esperados (Semana 3)

* Datos originales de ONPE organizados y documentados.
* Base de datos relacional construida a partir de los resultados electorales.
* Sistema Text-to-SQL integrado con un modelo de lenguaje de gran tamaño.
* Generación y ejecución de consultas SQL a partir de preguntas en lenguaje natural.
* Conjunto de 100 preguntas analíticas con sus respectivas consultas SQL y resultados de referencia.
* Evaluación del sistema mediante métricas de validez SQL, exactitud de ejecución y tiempo de respuesta.
---

## 📌 Roadmap

- [x] Descarga de los resultados electorales oficiales en formato JSON.
- [x] Exploración inicial de la estructura de los archivos JSON.
- [ ] Procesamiento y validación de los datos electorales.
- [ ] Diseño e implementación de la base de datos relacional.
- [ ] Construcción del conjunto de 100 preguntas de evaluación.
- [ ] Elaboración y validación de las consultas SQL de referencia.
- [ ] Integración del modelo de lenguaje de gran tamaño (LLM).
- [ ] Implementación del generador y validador de consultas SQL.
- [ ] Implementación de la ejecución de consultas y generación de respuestas.
- [ ] Evaluación de métricas y análisis de resultados.

---

## 📜 Licencia

Proyecto de carácter académico desarrollado en el marco de la Maestría en Inteligencia Artificial de la Universidad Nacional de Ingeniería (UNI).
