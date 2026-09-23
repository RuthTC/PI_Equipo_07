# Aprendiendo Deep Learning con CNN

## Introducción

En esta práctica aprendí los conceptos básicos de Deep Learning utilizando una Red Neuronal Convolucional (CNN) para la clasificación de imágenes.

El objetivo fue entender cómo una red neuronal aprende patrones, cómo se evalúa su desempeño y qué técnicas existen para mejorar su capacidad de predicción.

Durante el desarrollo revisé:

- La pérdida durante el entrenamiento.
- Las métricas de evaluación.
- La matriz de confusión.
- La regularización del modelo.

---

## Pérdida durante el entrenamiento

![Pérdida](images/perdida.png)

La función de pérdida permite observar cómo va aprendiendo el modelo durante el entrenamiento.

Al inicio el error es mayor, pero conforme pasan las épocas la pérdida disminuye, lo que indica que la red está ajustando sus parámetros y mejorando sus predicciones.

---

## Métricas del modelo

![Métricas](images/metricas.png)

Para conocer el rendimiento del modelo se utilizaron métricas como:

- **Accuracy:** indica qué porcentaje de predicciones fueron correctas.
- **ROC-AUC:** permite evaluar qué tan bien el modelo separa las diferentes clases.

Estas métricas ayudan a entender si el modelo realmente está aprendiendo y no solamente memorizando los datos.

---

## Matriz de confusión

<img width="507" height="532" alt="Captura de pantalla 2026-09-22 185214" src="https://github.com/user-attachments/assets/75df63d4-6da6-4990-84fd-c9378ba0969b" />


La matriz de confusión permite observar dónde el modelo acertó y dónde tuvo errores.

Gracias a esta herramienta se puede identificar qué clases son más difíciles de reconocer y qué aspectos podrían mejorarse, como aumentar los datos de entrenamiento o ajustar el modelo.

---

## Regularización



<img width="826" height="756" alt="Captura de pantalla 2026-09-22 185259" src="https://github.com/user-attachments/assets/c4c16c8f-f81d-4251-98ec-e1edb6974857" />


La regularización ayuda a evitar el overfitting, que ocurre cuando un modelo aprende demasiado los datos de entrenamiento pero falla con datos nuevos.

Esta técnica permite que el modelo tenga una mejor capacidad de generalización.

---

# Relación con mi proyecto Compostec

Después de revisar Deep Learning, analicé si era la mejor opción para mi proyecto Compostec.

Aunque las CNN son muy útiles para trabajar con imágenes, actualmente Compostec utiliza información obtenida mediante sensores:

- Temperatura.
- Humedad.
- Gases.
- Nivel de lixiviados.

Por esta razón, considero que **Machine Learning es una mejor alternativa para la primera versión del proyecto**.

Modelos como:

- Random Forest.
- Gradient Boosting.
- XGBoost.

pueden aprender la relación entre las variables de los sensores y determinar el estado del compost.

---

# ¿Por qué no Deep Learning?

Deep Learning sería una buena opción si en el futuro se agrega una cámara para analizar imágenes del compost.

Por ejemplo:



Pero para la versión actual se necesitarían más imágenes, más datos y mayor capacidad computacional.

---

# Conclusión

Esta práctica me permitió comprender cómo funcionan las redes neuronales convolucionales y cómo evaluar un modelo de Deep Learning.

Para Compostec se utilizará principalmente Machine Learning porque los datos vienen de sensores y son variables numéricas, por lo que estos modelos se adaptan mejor al problema actual.

Deep Learning queda como una posible mejora futura mediante visión artificial.
