# Semana 5 - Machine Learning

## ¿Qué aprendí?

En esta semana trabajé con modelos de Machine Learning usando Python. 
Primero revisé los datos y después probé diferentes modelos para hacer predicciones.

## 1. Trabajando con los datos

Primero importé las librerías que necesitaba:

- NumPy
- Pandas
- Matplotlib
- Seaborn

Después cargué el archivo CSV y revisé la información de los datos.

También aprendí a usar:

- `head()` para ver los primeros datos.
- `info()` para revisar las columnas y tipos de datos.
- `describe()` para obtener un resumen de los datos.
- `columns` para conocer las columnas del conjunto de datos.

## 2. Análisis de los datos

Realicé algunos gráficos para entender mejor los datos.

Trabajé con:

- Histogramas.
- Gráficos de densidad.
- Gráficos de dispersión.
- Matriz de correlación.
- Heatmap.

También revisé la relación entre las variables y el consumo de energía.

## 3. Separar los datos

Separé las variables en:

- `X`: variables que utilizo para hacer la predicción.
- `y`: variable que quiero predecir.

Después dividí los datos en entrenamiento y prueba usando:

`train_test_split`

Utilicé un 70% para entrenamiento y 30% para prueba.

## 4. Regresión lineal

Trabajé con el modelo `LinearRegression`.

Primero creé el modelo y después lo entrené con los datos de entrenamiento.

También revisé:

- Intercepto.
- Coeficientes.
- Error de las predicciones.
- Standard Error.
- t-statistic.

Los coeficientes me permiten conocer cómo participa cada variable en la predicción.

## 5. Predicciones

Después de entrenar el modelo hice predicciones con los datos de prueba.

Comparé:

- Valor real.
- Valor predicho.

También revisé los residuos para ver qué tan alejadas estaban las predicciones de los valores reales.

## 6. Árbol de decisión

Después probé otro modelo:

`DecisionTreeRegressor`

En este caso utilicé una profundidad máxima de 5.

Luego:

1. Separé los datos.
2. Entrené el árbol.
3. Hice las predicciones.
4. Comparé los valores reales con los predichos.
5. Calculé el MSE.

## 7. Error MSE

Aprendí a utilizar el error cuadrático medio (MSE).

El error se eleva al cuadrado para evitar que los errores positivos y negativos se cancelen y para darle mayor importancia a los errores grandes.

## 8. Importancia de las variables

También revisé la importancia de las características del árbol.

Esto permite saber qué variables tuvieron mayor importancia para realizar las predicciones.

## 9. Regresión con Statsmodels

Finalmente utilicé `statsmodels` para crear un modelo OLS.

Esto me permitió obtener un resumen estadístico del modelo y revisar diferentes valores relacionados con la regresión.

## Lo que me llevo de esta semana

Aprendí que antes de entrenar un modelo es importante conocer los datos.

También aprendí el proceso básico:

Datos → análisis → entrenamiento → predicción → evaluación

Probé regresión lineal y árbol de decisión para comparar diferentes formas de realizar predicciones.
