
# Clasificación de imágenes con SenseCraft AI

## 1. Descripción

En esta práctica se implementó un modelo de inteligencia artificial utilizando **SenseCraft AI** y el dispositivo **XIAO ESP32S3 Sense**.

El objetivo fue entrenar un modelo de clasificación de imágenes para reconocer tres objetos diferentes mediante la cámara del dispositivo.

## 2. Herramientas utilizadas

- SenseCraft AI
- XIAO ESP32S3 Sense
- Cámara integrada
- Cable USB
- Computadora

## 3. Creación del modelo

Se ingresó a la plataforma [SenseCraft AI](https://sensecraft.seeed.cc/ai/training) para crear un modelo de clasificación de imágenes.

Se definieron tres categorías:

| Categoría | Cantidad de imágenes |
|---|---|
| Mouse | 26 |
| Lentes | 26 |
| Lentes Negro | 26 |
| **Total** | **78** |

### Evidencia 1: Recolección de imágenes

Se capturaron 26 imágenes para las categorías Mouse y Lentes utilizando la cámara del dispositivo.

<img width="1153" height="708" alt="Captura de pantalla 2026-10-13 183744" src="https://github.com/user-attachments/assets/c20a3699-e059-4f43-b0db-1e9ba5f6a52e" />




### Evidencia 2: Tercera categoría

Se agregó la categoría Lentes Negro con 26 imágenes para completar el conjunto de entrenamiento.


<img width="962" height="207" alt="Captura de pantalla 2026-10-13 190350" src="https://github.com/user-attachments/assets/0ccba202-56c7-4171-8cc6-76be52c8eda2" />



## 4. Entrenamiento del modelo

Después de recolectar las imágenes, se seleccionó el dispositivo XIAO ESP32S3 Sense y se inició el entrenamiento.

El modelo generado se encuentra en formato **TensorFlow Lite (.tflite)**, con un tamaño aproximado de **320.16 KB**.

## 5. Pruebas de reconocimiento

Se realizaron pruebas utilizando distintos objetos frente a la cámara para comprobar el funcionamiento del modelo.

### Evidencia 3: Reconocimiento de lentes

El modelo identificó la categoría **Lentes** con una confianza del 91 %.



<img width="320" height="492" alt="Captura de pantalla 2026-10-13 191151" src="https://github.com/user-attachments/assets/086111a5-2e22-4fd1-8917-c8ce7fea2f80" />




### Evidencia 4: Reconocimiento de mouse

Al colocar un mouse frente a la cámara, el modelo identificó la categoría **Mouse** con una confianza del 96 %.


<img width="378" height="582" alt="Captura de pantalla 2026-10-13 190713" src="https://github.com/user-attachments/assets/a976ddaa-b4a2-4328-9269-de7bb1f26a97" />



### Evidencia 5: Reconocimiento de lentes negros

Al colocar lentes negros frente a la cámara, se obtuvo el siguiente resultado:

- Mouse: 20 %
- Lentes: 7 %
- Lentes Negro: 71 %

El modelo identificó correctamente la categoría de mayor confianza.

<img width="245" height="360" alt="Captura de pantalla 2026-10-13 190818" src="https://github.com/user-attachments/assets/21936132-3579-4fc9-8c6c-56f313f992e1" />


## 6. Resultados

| Objeto evaluado | Clasificación | Confianza |
|---|---|---|
| Lentes | Lentes | 97 % |
| Mouse | Mouse | 96 % |
| Lentes negros | Lentes Negro | 71 % |

Los resultados muestran que el modelo logró reconocer los tres objetos utilizados durante la práctica.

## 7. Conclusión

Se logró crear y entrenar un modelo de clasificación de imágenes utilizando SenseCraft AI y XIAO ESP32S3 Sense.

Durante las pruebas, el modelo identificó correctamente las tres categorías, aunque con diferentes niveles de confianza.

Esta práctica permitió comprender el proceso de recolección de imágenes, entrenamiento e inferencia de un modelo de inteligencia artificial en un dispositivo IoT.
