# TinyML con XIAO ESP32S3 Sense — Edge Impulse

**Práctica de laboratorio:** clasificación de imágenes mediante TinyML, Edge Impulse y XIAO ESP32S3 Sense.  
**Clases del proyecto:** `Ruth` y `celular`.  
**Plataformas:** Arduino IDE, interfaz web de cámara ESP32, Edge Impulse; SenseCraft como etapa propuesta de visualización.  
**Guía seguida:** *Guía TinyML con Edge Impulse*, 29 páginas, proporcionada por el docente.

> **Alcance de las evidencias.** Las capturas permiten documentar la cámara operativa, la carga del dataset, el diseño del *impulse*, la generación de características, la validación, las pruebas en Edge Impulse y la exportación de la biblioteca. La compilación en Arduino IDE quedó en proceso por su duración; **no se acredita una ejecución final del modelo en la placa ni una prueba concluida en SenseCraft**.

## Objetivo

Desarrollar y evaluar un modelo básico de clasificación de imágenes de dos categorías (`Ruth` y `celular`) usando Edge Impulse y preparar su implementación en una placa XIAO ESP32S3 Sense con cámara.

## 1. Configuración inicial de Arduino IDE y XIAO ESP32S3 Sense (guía, pp. 2–5)

Siguiendo la guía, la configuración contempla instalar el soporte de placas ESP32 de Espressif, seleccionar la placa **XIAO ESP32S3**, elegir el puerto correspondiente y habilitar **OPI PSRAM** para disponer de memoria adicional durante el procesamiento de imágenes. La URL de tarjetas indicada por la guía es:

```text
https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_dev_index.json
```

En la evidencia de Arduino IDE se identifica la placa **XIAO_ESP32S3** y el puerto **COM6**. No se adjuntaron capturas individuales de todas las opciones de instalación y configuración, por lo que se documentan como procedimiento de referencia de la guía, no como comprobación visual de cada ajuste.

## 2. Preparación de la cámara y captura de imágenes (guía, pp. 6–12)

Se utilizó el ejemplo de servidor de cámara ESP32 para obtener imágenes a través de la red Wi-Fi. El Monitor Serie muestra conexión exitosa y el mensaje `Camera Ready!`, con la dirección local `http://172.20.10.2`. Esta dirección corresponde a la red usada durante la práctica y puede cambiar en otra sesión.

![Monitor Serie: conexión Wi-Fi y cámara lista](imagenes/01_monitor_serie_wifi_camara.png)

*Figura 1. El dispositivo se conecta a Wi-Fi y anuncia la disponibilidad de la cámara.*

Desde el navegador se abrió la interfaz **ESP32 OV3660**, con transmisión de imagen y ajustes de cámara. En las capturas se observa una resolución **QVGA (320 × 240)**.

![Interfaz web de cámara, primera captura](imagenes/02_stream_camara_ruth_y_celular_1.png)

*Figura 2. Interfaz web de la cámara y primera vista capturada.*

![Interfaz web de cámara, segunda captura](imagenes/03_stream_camara_ruth_y_celular_2.png)

*Figura 3. Segunda vista de la transmisión de la cámara.*

### 2.1. Clases utilizadas para el entrenamiento

Se trabajó con dos etiquetas: **`Ruth`**, correspondiente a imágenes de una compañera, y **`celular`**, correspondiente a imágenes de un teléfono. Las siguientes fotografías documentan la toma de imágenes durante la práctica; no sustituyen el dataset completo.

![Evidencia fotográfica de la clase Ruth](imagenes/04_foto_clase_ruth.png)

*Figura 4. Evidencia de adquisición de imágenes para la clase `Ruth`.*

![Evidencia fotográfica de la clase celular](imagenes/05_foto_clase_celular.png)

*Figura 5. Evidencia de adquisición de imágenes para la clase `celular`.*

## 3. Proyecto y dataset en Edge Impulse (guía, pp. 13–15)

Se cargaron imágenes de cada clase con sus etiquetas. La evidencia de carga de la clase `celular` confirma **25 archivos subidos correctamente y 0 fallidos**. Se seleccionó la partición automática entre entrenamiento y prueba.

![Carga de 25 imágenes de la clase celular](imagenes/06_carga_25_imagenes_celular.png)

*Figura 6. Carga satisfactoria de 25 imágenes etiquetadas `celular`.*

El panel **Dataset** registra **50 elementos**, distribuidos en **40 imágenes para entrenamiento (80 %) y 10 para prueba (20 %)**.

![Resumen del dataset con 50 elementos](imagenes/07_dataset_50_imagenes.png)

*Figura 7. Resumen del conjunto de datos y partición 80/20.*

| Parámetro | Resultado observado |
|---|---:|
| Clases | 2 (`Ruth`, `celular`) |
| Imágenes totales | 50 |
| Imágenes de entrenamiento | 40 |
| Imágenes de prueba | 10 |
| División | 80 % / 20 % |

> **Archivo de datos:** la entrega requiere `Data.zip` con las imágenes originales y sus etiquetas o carpetas por clase. **Ese ZIP no se ha incluido**, porque no se proporcionó el conjunto original de 50 imágenes. Las fotografías y capturas del presente README no reemplazan ese archivo.

## 4. Creación del *impulse*, procesamiento y entrenamiento (guía, pp. 16–19)

Se creó un *impulse* de clasificación de imágenes con entrada de **96 × 96 píxeles**, bloque de procesamiento **Image** y bloque de aprendizaje **Transfer Learning (Images)**, con dos clases de salida.

![Configuración del impulse](imagenes/08_creacion_impulse_96x96.png)

*Figura 8. Diseño del flujo de procesamiento y clasificación de imágenes.*

Posteriormente se inició la generación de características sobre las **40 imágenes de entrenamiento**.

![Pantalla previa a generar características](imagenes/09_generacion_caracteristicas_inicio.png)

*Figura 9. Preparación de la generación de características.*

![Registro de generación de características](imagenes/10_generacion_caracteristicas_log.png)

*Figura 10. El registro informa 40 ventanas generadas: 21 de `Ruth` y 19 de `celular`.*

En el explorador de características se observan dos agrupaciones diferenciadas, una por cada clase. Esta separación visual es favorable para el clasificador, aunque por sí sola no demuestra rendimiento sobre imágenes no vistas.

![Explorador de características](imagenes/11_explorador_caracteristicas.png)

*Figura 11. Representación de características por clase.*

### 4.1. Resultados de validación del entrenamiento

La captura de validación reporta **100 % de exactitud**, **pérdida (*loss*) de 0.04**, matriz de confusión sin errores visibles y puntuación **F1 = 1.00** para ambas clases. Se trata de resultados del conjunto de validación mostrado por la plataforma, no de una garantía de funcionamiento general.

![Resultados de validación y matriz de confusión](imagenes/12_validacion_matriz_confusion.png)

*Figura 12. Exactitud, pérdida, matriz de confusión y métricas de validación.*

## 5. Clasificación y pruebas estadísticas en Edge Impulse (guía, pp. 20–21)

### 5.1. Prueba de clasificación de una imagen

En la pantalla de clasificación individual se probó la muestra `Ruth_006`. La etiqueta esperada era `Ruth` y la salida mostrada fue **`Ruth = 1.00`** y **`celular = 0`**.

![Clasificación individual de Ruth_006](imagenes/13_clasificacion_imagen_ruth.png)

*Figura 13. Resultado de clasificación de la muestra `Ruth_006`.*

### 5.2. Prueba del conjunto reservado

Se ejecutó **Model testing** con las **10 imágenes de prueba**. La tabla visible contiene **4 muestras `Ruth` y 6 muestras `celular`**, todas clasificadas correctamente en esta ejecución.

![Vista conjunta de pruebas y resultados](imagenes/14_model_testing_resumen.png)

*Figura 14. Vista general de las muestras de prueba y del panel de resultados.*

![Detalle de las 10 muestras de prueba](imagenes/15_model_testing_10_muestras.png)

*Figura 15. Tabla de las diez muestras y sus etiquetas predichas.*

![Métricas del conjunto de prueba](imagenes/16_model_testing_metricas.png)

*Figura 16. Resultado del conjunto de prueba: exactitud de 100 %, precisión, exhaustividad y F1 ponderados de 1.00.*

### 5.3. Tres comprobaciones estadísticas solicitadas

A partir de las evidencias de la plataforma se documentan **tres comprobaciones de desempeño**, no tres experimentos independientes:

1. **Exactitud (*accuracy*):** la plataforma reporta **100 %** en el conjunto de prueba (10 de 10 muestras correctas).
2. **Matriz de confusión:** las muestras de `Ruth` y `celular` aparecen en la diagonal correcta; no se observan errores de clasificación en las diez muestras.
3. **Precisión, *recall* y F1:** los promedios ponderados reportados son **1.00**, consistentes con la clasificación correcta de ese conjunto pequeño.

La plataforma también muestra **ROC AUC = 1.00**; sin embargo, el registro de ejecución incluye una advertencia `UndefinedMetricWarning` que indica que el AUC no está definido cuando `y_true` contiene una sola clase en un cálculo. Por tanto, **no se debe usar el AUC como prueba concluyente** sin revisar cómo se generó esa métrica. Asimismo, el conjunto de prueba es reducido y puede no representar cambios de iluminación, distancia o entorno.

## 6. Exportación del modelo e implementación en Arduino IDE (guía, pp. 21–26)

En la sección de despliegue se compararon las versiones **Quantized (int8)** y **Unoptimized (float32)**. La estimación mostrada por Edge Impulse para un objetivo Cortex-M4F a 80 MHz fue:

| Característica | INT8 cuantizado | Float32 sin optimizar |
|---|---:|---:|
| Latencia total estimada | 766 ms | 1,564 ms |
| RAM estimada | 250.7 KB | 669.3 KB |
| Exactitud reportada | 100 % | 100 % |

Estas cifras son **estimaciones de Edge Impulse para el objetivo de referencia mostrado**, no mediciones directas en el XIAO ESP32S3.

![Comparación de modelos cuantizado y sin optimizar](imagenes/17_optimizacion_int8_vs_float32.png)

*Figura 17. Comparación de rendimiento y memoria; selección de la versión INT8.*

Se generó una **biblioteca de Arduino** desde Edge Impulse. La plataforma indicó la ruta de instalación `Sketch > Include Library > Add .ZIP Library...` y el ejemplo del proyecto.

![Biblioteca de Arduino generada](imagenes/18_biblioteca_arduino_generada.png)

*Figura 18. Confirmación de generación de biblioteca para Arduino IDE.*

### 6.1. Limitación: compilación prolongada

Durante la implementación se intentó compilar el proyecto en **Arduino IDE**, con la placa **XIAO ESP32S3** conectada al puerto **COM6**. El proceso permaneció durante un tiempo prolongado en el estado **«Compilando proyecto...»**, sin completarse dentro del tiempo disponible para la práctica.

![Compilación prolongada en Arduino IDE](imagenes/19_compilacion_arduino_pendiente.png)

*Figura 19. Evidencia de Arduino IDE durante la compilación del proyecto.*

**Justificación de la etapa pendiente:** debido al tiempo requerido por la compilación, no se alcanzó a finalizar la verificación, carga y prueba del modelo en el dispositivo durante la sesión. La captura demuestra que el proceso de compilación estaba en ejecución, **pero no acredita un error específico del código ni permite afirmar que la compilación falló**. Las fases previas de entrenamiento, evaluación y generación de biblioteca sí tienen evidencia. Esta limitación se documenta siguiendo la indicación del docente.

> **Aclaración sobre `Modelo.zip`:** el ZIP adjunto contiene un archivo de modelo **TensorFlow Lite INT8** (`.lite`). No es necesariamente el mismo ZIP de la biblioteca de Arduino generado en la Figura 18. Si la entrega requiere la biblioteca Arduino completa, es necesario adjuntar también el ZIP exportado desde la opción *Arduino library* de Edge Impulse.

## 7. Visualización y pruebas en SenseCraft (guía, pp. 27–29)

La guía propone volver al proyecto de Edge Impulse, elegir el modelo **TensorFlow Lite (int8 quantized)** y subirlo desde **SenseCraft > Workspace / Espacio de trabajo > Upload Model / Subir modelo**.

**Estado de la práctica:** no se proporcionó captura de una carga o inferencia concluida en SenseCraft. Por ello, esta sección queda **pendiente de evidencia** y no se reporta como una prueba realizada. Se indicó una dificultad para seleccionar el archivo del modelo en el cuadro *Model File*, cuya compatibilidad con el dispositivo debe verificarse antes de continuar.

## 8. Resultados y conclusiones

- Se documentó el funcionamiento de la cámara del XIAO ESP32S3 Sense y la adquisición de imágenes para dos clases.
- Edge Impulse registró **50 imágenes** y una división **40/10** entre entrenamiento y prueba.
- El clasificador de dos clases obtuvo **100 % de exactitud en las diez imágenes de prueba mostradas**. Por el tamaño reducido del dataset, el resultado debe interpretarse con cautela.
- Se obtuvo un modelo cuantizado INT8 y se generó la biblioteca para Arduino, según la evidencia de despliegue.
- La compilación en Arduino IDE **no pudo finalizarse durante el tiempo de laboratorio**; no se dispone de prueba final de inferencia ejecutada en la placa.
- La prueba en SenseCraft permanece **pendiente** por falta de evidencia de una carga y ejecución completadas.

## 9. Archivos de la entrega

```text
TinyML_Edge_Impulse_Entrega/
├── README.md
├── Modelo.zip              # Modelo TFLite INT8 exportado desde Edge Impulse
├── Data.zip                # PENDIENTE: adjuntar dataset original (NO incluido)
└── imagenes/
    ├── 01_monitor_serie_wifi_camara.png
    ├── ...
    └── 19_compilacion_arduino_pendiente.png
```

**Pendiente antes de entregar:** incorporar `Data.zip` con las imágenes originales y sus etiquetas; si el profesor exige el ZIP de la biblioteca de Arduino, añadirlo también. Verificar si se requiere una evidencia adicional de SenseCraft.

## 10. Referencia

- Docente del curso. *Guía TinyML con Edge Impulse: laboratorio con XIAO ESP32S3 Sense*, material de práctica proporcionado al grupo, 29 páginas.
