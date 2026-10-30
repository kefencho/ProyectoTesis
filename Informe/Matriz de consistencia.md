# Matriz de consistencia

Oct 30, 2026 · @kenny Asto

La matriz alinea problema, objetivo, hipótesis, variables e indicadores en cuatro líneas específicas más la general, y cada objetivo lleva una meta medible que puede no cumplirse.

## Matriz de consistencia

| Nivel | Problema | Objetivo | Hipótesis | Variable independiente | Variable dependiente | Indicadores (meta) |
| --- | --- | --- | --- | --- | --- | --- |
| General | ¿En qué medida alguna estrategia de recuperación de evidencia, definida por una representación textual y un método de recuperación, alcanza un desempeño pertinente para verificar afirmaciones sobre los resultados de las Elecciones Generales del Perú 2026 mediante modelos de lenguaje? | Lograr que al menos una de las estrategias de recuperación evaluadas alcance un Recall@5 ≥ 0,90 y un MRR ≥ 0,80 en la recuperación de evidencia para la verificación de afirmaciones sobre las Elecciones Generales del Perú 2026. | Al menos una de las nueve configuraciones (3 representaciones × 3 métodos) alcanza un Recall@5 ≥ 0,90 y un MRR ≥ 0,80 sobre el conjunto de afirmaciones. | Representación textual de los datos electorales; método de recuperación de evidencia | Desempeño de la recuperación de evidencia | Recall@5 ≥ 0,90; MRR ≥ 0,80 (escala 0 a 1) |
| Específico 1 | ¿En qué medida la representación textual de los datos de la ONPE (directa, normalizada conservadoramente o enriquecida con contexto) mejora el Recall@5 en la recuperación de evidencia electoral? | Lograr que alguna representación textual (normalizada o enriquecida) supere a la representación directa en al menos 10 puntos porcentuales de Recall@5. | Alguna representación (normalizada o enriquecida) supera a la directa en al menos 10 puntos porcentuales de Recall@5. | Representación textual (directa, normalizada, enriquecida) | Desempeño de la recuperación (Recall@5) | Recall@5 por representación; diferencia en puntos porcentuales frente a la directa (≥ 10) |
| Específico 2 | ¿En qué medida los métodos semántico e híbrido mejoran el MRR respecto de BM25, y con qué latencia lo hacen? | Lograr que algún método (semántico o híbrido) supere a BM25 en al menos 0,05 de MRR, con una latencia promedio menor a 500 ms por consulta. | Algún método (semántico o híbrido) supera a BM25 en al menos 0,05 de MRR, con latencia promedio menor a 500 ms por consulta. | Método de recuperación (BM25, semántico, híbrido) | Desempeño de la recuperación (MRR); latencia de recuperación | MRR por método; diferencia frente a BM25 (≥ 0,05); latencia promedio en ms (< 500) |
| Específico 3 | ¿Cómo varía el Recall@5 de la mejor configuración según el tipo de afirmación (organización política, comparación entre organizaciones, participación ciudadana y actas contabilizadas)? | Lograr que la mejor configuración alcance un Recall@5 ≥ 0,80 en cada uno de los cuatro tipos de afirmación. | La mejor configuración alcanza un Recall@5 ≥ 0,80 en cada uno de los cuatro tipos de afirmación. | Tipo de afirmación electoral | Desempeño de la recuperación (Recall@5 por tipo) | Recall@5 por tipo de afirmación (≥ 0,80 en cada uno) |
| Específico 4 | ¿En qué medida la evidencia recuperada por la mejor configuración permite que un modelo de lenguaje clasifique correctamente las afirmaciones como respaldadas, refutadas o con evidencia insuficiente? | Lograr que el modelo de lenguaje, con la evidencia recuperada por la mejor configuración, alcance un F1 macro ≥ 0,80 en la clasificación de las afirmaciones. | El modelo de lenguaje, con la evidencia recuperada por la mejor configuración, alcanza un F1 macro ≥ 0,80 en la clasificación de las afirmaciones. | Evidencia recuperada por la mejor configuración | Desempeño de la verificación automática | F1 macro (≥ 0,80); exactitud; precisión y exhaustividad por clase |

## Variables intervinientes

Se mantienen constantes en las nueve configuraciones para que la comparación sea válida; no entran a la matriz principal.

| Variable interviniente | Indicador | Valor o control |
| --- | --- | --- |
| Valor de k | k de Recall@k | Fijo en 5 en todos los objetivos |
| Calidad y estructura de los datos | % de registros completos, campos requeridos presentes | Se documenta el porcentaje de registros completos antes de los experimentos |
| Cobertura del corpus | N.º de registros, ámbitos geográficos e indicadores | Mismo corpus y mismas afirmaciones en todas las configuraciones |
| Configuración del método de recuperación | Parámetros de indexación y búsqueda | Registrados por método |
| Configuración del modelo de lenguaje | Modelo, versión, instrucciones, parámetros de generación | Registrados; mismo modelo para todo OE4 |
| Condiciones de ejecución | Entorno y recursos computacionales | Mismo equipo para medir la latencia |

## Ajustes que se desprenden en el resto del plan

Al pasar a objetivos con meta, estas secciones quedan desalineadas y conviene corregirlas.

| Sección del plan | Cambio |
| --- | --- |
| Introducción y 3.1.6 | Quitar o matizar "sin presuponer la superioridad de una estrategia": ahora hay metas explícitas. Basta decir que las metas se contrastan experimentalmente. |
| 1.1.3 Problema general y específicos | Reemplazar por las preguntas de la matriz; los verbos pasan de "cómo varía" a "en qué medida mejora o alcanza". |
| 2.1 y 2.2 Objetivos | Reemplazar por los cuatro objetivos medibles; el prototipo deja de ser objetivo propio y queda dentro del OE4. |
| 3.3.1 Hipótesis | Reemplazar "presenta diferencias" por las cinco hipótesis con dirección y magnitud. |
| Tabla 3.1 Variables | Fijar k = 5 en el indicador de Recall@k; agregar F1 macro como indicador de la verificación; añadir el tipo de afirmación como independiente del OE3. |
| 4.3 Método estadístico | Indicar cómo se contrastan las metas: comparación de medias o prueba no paramétrica sobre las 9 configuraciones; si las metas se cumplen o no es lo que determina la conclusión. |
| 4.4.2 Muestra | Justificar el tamaño de muestra: con Recall@5 ≥ 0,80 por tipo, hacen falta afirmaciones suficientes en cada uno de los cuatro tipos. |
| 4.5 y 4.8 | El paso de evaluar el LLM ya no es "complementario": es la base del OE4. |

Los umbrales (0,90, 0,80, 10 puntos porcentuales, 0,05 de MRR, 500 ms) son provisionales; conviene calibrarlos con una prueba piloto antes de fijarlos en el plan.
