# 🛡️ Verificación de afirmaciones electorales mediante LLM y recuperación de evidencia

Proyecto de investigación de la Maestría en Inteligencia Artificial de la Universidad Nacional de Ingeniería (UNI), orientado a evaluar estrategias de recuperación de evidencia para la verificación automática de afirmaciones sobre los resultados de las Elecciones Generales del Perú 2026.

El proyecto utiliza los resultados electorales oficiales publicados por la Oficina Nacional de Procesos Electorales (ONPE), transformados en unidades textuales que servirán como fuente de evidencia para los experimentos con modelos de lenguaje (LLM).


---

## 👥 Autores

* **Kenny S. Asto Hinostroza** – [@kefencho](https://github.com/kefencho)
---

## 📊 Dataset

- **Fuente:** [ONPE – Resultados históricos de las Elecciones Generales del Perú 2026.](https://resultadohistorico-eg2026.onpe.gob.pe/main/resumen)
- **Registros de origen:** aproximadamente 90,223 mesas de sufragio.
- **Formato original:** archivos JSON con los resultados electorales por mesa y los votos obtenidos por cada candidato.
- **Datos procesados:** unidades textuales generadas a partir de los resultados oficiales para facilitar la recuperación de evidencia.
- **Dataset de evaluación:** conjunto de afirmaciones verdaderas y falsas relacionadas con los resultados electorales, pendiente de construcción y validación.
Los archivos JSON originales constituyen la fuente de datos, mientras que las unidades textuales representan la información procesada que utilizará el sistema de recuperación.
---

## 🗂️️ Estructura del Repositorio

```text
├── data/
│   ├── raw/                  
│   │   └── ONPE_2026/
│   │       └── Peru/                           # JSON originales descargados de ONPE
|   ├── processed/              
│   │   └── unidades_textuales/                 # Unidades textuales generadas
│   └── evaluation/                             # Afirmaciones y etiquetas de referencia
├── notebooks/         
│   ├── 01_exploracion_datos.ipynb              # Análisis exploratorio inicial
│   └── 02_validacion_unidades_textuales.ipynb  # Validación de unidades textuales
├── scripts/
│   └── descargar_onpe.sh                       # Descarga de datos oficiales de ONPE
├── src/               
│   ├── data/
│   │   └── generar_unidades.py                 # Conversión de JSON a texto
│   ├── retrieval/
│   │   ├── bm25.py                             # Recuperación léxica
│   │   ├── semantic.py                         # Recuperación semántica
│   │   └── hybrid.py                           # Recuperación híbrida
│   ├── verification/
│   │   └── llm_verifier.py                     # Verificación mediante LLM
│   └── evaluation/
│       └── metrics.py                          # Métricas de evaluación         
├── logs/                                       # Archivos de logging
├── results/                                    # Predicciones y métricas
├── slides/                                     # Presentaciones de resultados
├── .gitignore
├── README.md
└── requirements.txt
```
---

## ⚙️ Requisitos

El proyecto utilizará Python y las bibliotecas necesarias para procesar los datos, implementar las estrategias de recuperación y evaluar los resultados.

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

3. **Generación de unidades textuales**

    Transformación de los resultados electorales en unidades textuales que conserven la información necesaria para identificar candidatos, votos y ámbitos geográficos.

5. **Indexación y recuperación de evidencia**

    Construcción de los índices para comparar las estrategias de recuperación léxica mediante BM25, búsqueda semántica mediante embeddings y recuperación híbrida.

7. **Verificación mediante LLM**

    Envío de la afirmación y de la evidencia recuperada al modelo de lenguaje para obtener un veredicto sustentado en la información disponible.

9. **Evaluación experimental**

    Comparación de los resultados obtenidos por cada estrategia mediante las métricas definidas en el diseño metodológico.

Los comandos específicos de ejecución se documentarán cuando los módulos correspondientes estén implementados.

---

## 📈 Resultados Esperados (Semana 3)

* Datos originales de ONPE organizados y documentados.
* Unidades textuales generadas y validadas.
* Diseño inicial del conjunto de afirmaciones para la evaluación.
* Primera implementación de una estrategia de recuperación de evidencia.
* Definición del protocolo experimental para comparar las estrategias de recuperación.
* Registro de las configuraciones y los resultados de cada experimento.
---

## 📌 Roadmap

- [x] Descarga de los resultados electorales oficiales en formato JSON.
- [x] Generación inicial de unidades textuales.
- [ ] Validación de las unidades textuales.
- [ ] Construcción del dataset de afirmaciones y sus etiquetas de referencia.
- [ ] Implementación de recuperación léxica mediante BM25.
- [ ] Implementación de recuperación semántica mediante embeddings.
- [ ] Implementación de recuperación híbrida.
- [ ] Integración del modelo de lenguaje para la verificación.
- [ ] Ejecución de experimentos comparativos.
- [ ] Evaluación de métricas y análisis de errores.
- [ ] Documentación de resultados y conclusiones.

---

## 📜 Licencia

Proyecto de carácter académico desarrollado en el marco de la Maestría en Inteligencia Artificial de la Universidad Nacional de Ingeniería (UNI).
