# Aprendiendo Deep Learning con CNN

## Introducción

En esta práctica realicé una introducción al uso de Deep Learning mediante una Red Neuronal Convolucional (CNN) utilizando Keras.

El objetivo fue comprender cómo una red neuronal aprende patrones a partir de imágenes, cómo se puede evaluar su rendimiento y qué técnicas ayudan a mejorar la capacidad de generalización del modelo.

Durante el desarrollo revisé principalmente:

- Entrenamiento de una CNN.
- Función de pérdida (Loss).
- Métricas de evaluación.
- Matriz de confusión.
- Regularización para evitar sobreajuste.

---

# Entrenamiento del modelo CNN

Durante el entrenamiento se observa cómo el modelo modifica sus parámetros para reducir el error y mejorar sus predicciones.

La función de pérdida permite conocer si el modelo está aprendiendo correctamente durante las épocas de entrenamiento.

<img src="imagenes/perdida_metricas.png">

En la gráfica se observa la evolución de la pérdida y las métricas de validación del modelo.

La pérdida disminuye progresivamente durante el entrenamiento, mientras que las métricas permiten analizar el comportamiento del modelo con datos que no fueron utilizados directamente para entrenarlo.

---

# Evaluación mediante métricas

Para evaluar el rendimiento del modelo se utilizaron las siguientes métricas:

### Accuracy

Indica la cantidad de predicciones correctas realizadas por el modelo respecto al total de muestras evaluadas.

### ROC-AUC

Permite observar la capacidad del modelo para diferenciar entre las clases.

Estas métricas ayudan a comprobar si el modelo realmente está aprendiendo patrones y no solamente memorizando los datos de entrenamiento.

---

# Matriz de confusión

<img src="imagenes/matriz_confusion.png">

La matriz de confusión permite observar los aciertos y errores del modelo durante la clasificación.

Los valores muestran:

- Predicciones correctas.
- Predicciones incorrectas.
- Clases donde el modelo presenta mayor dificultad.

Esta herramienta es importante porque permite analizar qué aspectos pueden mejorarse, por ejemplo aumentando la cantidad de datos o ajustando la arquitectura del modelo.

---

# Regularización

<img src="imagenes/regularizacion.png">

Durante el entrenamiento también se revisó el concepto de regularización.

Esta técnica busca reducir el overfitting, que ocurre cuando un modelo aprende demasiado los datos de entrenamiento y tiene un peor desempeño con datos nuevos.

La comparación entre entrenamiento y validación permite observar si el modelo logra generalizar correctamente.

---

# Keras y Perceptrón

## Keras

Keras es una biblioteca utilizada para construir modelos de Deep Learning de manera más sencilla.

En esta práctica fue utilizada para crear la CNN, definir sus capas, entrenar el modelo y evaluar sus resultados.

## Perceptrón

El perceptrón es uno de los modelos más básicos dentro de las redes neuronales artificiales.

Su funcionamiento se basa en recibir entradas, aplicar pesos y generar una salida.

Aunque es un modelo simple, representa la base de modelos neuronales más complejos utilizados actualmente.

---

# Aplicación en el proyecto Compostec

Después de revisar el funcionamiento de CNN, Keras y redes neuronales, se evaluó si este enfoque era adecuado para el proyecto Compostec.

Actualmente Compostec obtiene información mediante sensores:

- Temperatura.
- Humedad.
- Gases.
- Nivel de lixiviados.

Estos datos son valores numéricos obtenidos mediante un sistema IoT, por lo que el problema no está enfocado en imágenes.

Por esta razón, para la primera versión del proyecto se considera más adecuado utilizar modelos de Machine Learning como:

- Random Forest.
- Gradient Boosting.
- XGBoost.

Estos modelos pueden aprender la relación entre las variables de los sensores y ayudar a determinar el estado del compost.

---

# ¿Por qué no utilizar CNN actualmente?

Las CNN tienen un gran rendimiento en problemas donde existen imágenes, por ejemplo:

- Reconocimiento de objetos.
- Clasificación visual.
- Análisis de fotografías.

Sin embargo, Compostec actualmente no cuenta con una cámara ni un conjunto de imágenes del compost para entrenar este tipo de modelo.

En una versión futura se podría agregar visión artificial para analizar características visuales del compost y complementar la información obtenida por los sensores.

---

# Conclusión

Esta práctica permitió comprender cómo funcionan las redes neuronales convolucionales, cómo se evalúa un modelo y cómo técnicas como la regularización ayudan a mejorar los resultados.

Para Compostec se considera utilizar principalmente Machine Learning debido a que la información obtenida proviene de sensores y corresponde a datos numéricos.

El uso de Deep Learning queda como una posible mejora futura si se incorporan imágenes y un sistema de visión artificial.
