```md
# Clasificación de datos de NO₂

## Descripción

En esta práctica trabajé con un dataset que contiene mediciones diarias de **NO₂** y datos relacionados con la calidad del aire.

Primero revisé la información del dataset usando funciones como `head()`, `info()` y `describe()` para conocer mejor los datos y ver qué variables podía utilizar.

Después seleccioné algunas columnas y creé una variable llamada `TARGET CLASS` para poder trabajar con modelos de clasificación.

## Modelos utilizados

Se probaron tres modelos vistos en clase:

- KNN
- Naive Bayes
- Regresión Logística

En KNN también se utilizó `StandardScaler` para escalar los datos y se probaron distintos valores de K para ver cómo cambiaba el error.

En Naive Bayes se realizaron predicciones usando `GaussianNB`.

Finalmente, con Regresión Logística se utilizó un `Pipeline` junto con `StandardScaler`.

## Evaluación

Para revisar qué tan bien funcionaban los modelos se usaron:

- Accuracy
- Precision
- Recall
- F1-score
- Matriz de confusión
- Cohen's Kappa
- Validación cruzada

## ¿Qué aprendí?

Con esta práctica entendí mejor cómo se trabaja un problema de clasificación desde el inicio.

Aprendí que primero se deben revisar y preparar los datos antes de entrenar un modelo. También entendí mejor cómo dividir los datos en entrenamiento y prueba.

Además, pude practicar con KNN, Naive Bayes y Regresión Logística y ver cómo se evalúan sus resultados.

Lo que más reforcé fue que no basta con ejecutar un modelo, sino que también hay que revisar sus métricas para saber si está clasificando correctamente los datos.
```

