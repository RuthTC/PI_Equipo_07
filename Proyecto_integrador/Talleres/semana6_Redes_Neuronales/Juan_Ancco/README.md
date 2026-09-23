# Aprendizaje de Deep Learning con CNN

## Introducción

En esta práctica se implementó una **Red Neuronal Convolucional (CNN)** para clasificación de imágenes con el objetivo de comprender el entrenamiento, evaluación y mejora de modelos de Deep Learning.

Se analizaron cuatro elementos principales:

- Pérdida del entrenamiento.
- Métricas de evaluación.
- Matriz de confusión.
- Regularización.

---

## 1. Pérdida durante el entrenamiento

![Pérdida](images/perdida.png)

La función de pérdida (**Loss**) permite conocer el error del modelo durante el entrenamiento.

Se observa que la pérdida disminuye con las épocas, indicando que la red aprende patrones de las imágenes y mejora sus predicciones.

---

## 2. Métricas de validación

![Métricas](images/metricas.png)

Se evaluó el modelo mediante:

- **Accuracy:** porcentaje de predicciones correctas.
- **ROC-AUC:** capacidad del modelo para diferenciar entre clases.

Estas métricas permiten conocer el rendimiento del modelo con datos de validación.

---

## 3. Matriz de confusión

![Matriz de confusión](images/matriz_confusion.png)

La matriz de confusión permite identificar los aciertos y errores del modelo.

Ayuda a observar qué clases son confundidas y qué aspectos pueden mejorarse mediante más datos o ajustes del modelo.

---

## 4. Regularización

![Regularización](images/regularizacion.png)

La regularización permite reducir el **overfitting**, evitando que el modelo memorice los datos de entrenamiento.

Su objetivo es mejorar la capacidad del modelo para trabajar con datos nuevos.

---

# Aplicación al proyecto Compostec

Para Compostec se evaluó el uso de Deep Learning y Machine Learning.

Aunque Deep Learning es útil para imágenes mediante CNN, nuestro proyecto trabaja principalmente con datos de sensores:

- Temperatura.
- Humedad.
- Gases.
- Nivel de lixiviados.

Por esta razón, se selecciona **Machine Learning** como modelo principal.

Los modelos recomendados serían:

- Random Forest.
- Gradient Boosting.
- XGBoost.

Estos modelos se adaptan mejor a datos tabulares, requieren menos datos y tienen menor costo computacional.

Deep Learning quedaría como una mejora futura si se incorpora una cámara para analizar imágenes del compost.

---

# Conclusión

La práctica permitió comprender el funcionamiento de una CNN y sus métricas de evaluación.

Para Compostec, Machine Learning es la alternativa más adecuada debido a que los datos provienen de sensores y no de imágenes.
