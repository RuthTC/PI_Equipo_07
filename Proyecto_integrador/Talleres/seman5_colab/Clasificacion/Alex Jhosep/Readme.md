# Regresión lineal aplicada a datos diarios de NO₂

## Descripción

En esta práctica trabajé con un conjunto de datos que contiene mediciones diarias de **NO₂** y valores relacionados con la calidad del aire mediante el **AQI**.

Primero revisé la información general del dataset utilizando funciones como `head()`, `info()` y `describe()` para conocer la estructura de los datos, las variables disponibles y sus principales estadísticas.

Después se analizó gráficamente la relación entre la **concentración máxima diaria de NO₂** y el **AQI diario**, utilizando un gráfico de dispersión.

## Modelo utilizado

Para este análisis se utilizó un modelo de **Regresión Lineal**.

Se definieron las variables de la siguiente manera:

- **Variable predictora (X):** `Daily Max NO2 Concentration`
- **Variable objetivo (y):** `Daily AQI Value`

Luego los datos fueron divididos en datos de entrenamiento y prueba utilizando `train_test_split`.

Se utilizó:

- **70% de los datos para entrenamiento**
- **30% de los datos para prueba**

Posteriormente se creó el modelo utilizando `LinearRegression()` y se entrenó con los datos de entrenamiento mediante `fit()`.

Finalmente, se realizaron las predicciones utilizando `predict()`.

## Evaluación

Para evaluar el funcionamiento del modelo se utilizaron las siguientes métricas:

- MAE
- MSE
- RMSE
- R²

También se realizó una comparación gráfica entre los valores reales del AQI y los valores predichos por el modelo.

Además, se representó la línea de regresión para observar la relación entre la concentración máxima diaria de NO₂ y el AQI.

## Análisis de residuos

También se realizó un análisis de los residuos del modelo.

Los residuos representan la diferencia entre los valores reales y los valores predichos:

`residuo = valor real - valor predicho`

Se utilizó un histograma para observar cómo se distribuyen estos errores y analizar el comportamiento de las predicciones realizadas por el modelo.

## Validación cruzada

Para comprobar el rendimiento del modelo también se utilizó **validación cruzada**.

Se aplicó `KFold` con 5 divisiones y se calculó el valor de **R²** en cada una de ellas utilizando `cross_val_score`.

Finalmente, se obtuvo:

- R² de cada división
- R² promedio
- Desviación estándar

También se realizó un gráfico de caja para observar la distribución de los valores de R² obtenidos durante la validación cruzada.

## ¿Qué aprendí?

Con esta práctica pude entender mejor cómo se aplica una regresión lineal utilizando datos reales de calidad del aire.

Aprendí a identificar una variable predictora y una variable que se desea predecir, además de dividir los datos en entrenamiento y prueba antes de crear el modelo.

También pude practicar el uso de `LinearRegression`, realizar predicciones y evaluar el modelo utilizando métricas como MAE, MSE, RMSE y R².

Finalmente, reforcé la importancia de utilizar gráficos, análisis de residuos y validación cruzada para revisar si el modelo está representando correctamente la relación entre los datos.
