# Aplicación y aprendizaje de los códigos utilizados

Durante esta práctica se utilizaron diferentes herramientas de Python para trabajar con una base de datos y comprender mejor la información que contiene. A través de librerías como **Pandas, NumPy, Matplotlib, Seaborn y Scikit-learn**, se pudieron organizar los datos, realizar gráficos y posteriormente utilizarlos para crear modelos de predicción.

Una parte importante del trabajo fue primero observar y analizar los datos antes de crear algún modelo. Para esto se utilizaron gráficos como histogramas, gráficos de dispersión y mapas de calor. Estos gráficos ayudaron a identificar cómo se distribuyen los datos y si existe alguna relación entre las diferentes variables.

Después de realizar el análisis inicial, se trabajó con modelos como la **regresión lineal** y el **árbol de decisión**, los cuales permiten utilizar información existente para intentar predecir nuevos valores.

## Parte que más me llamó la atención

Una de las partes que más me llamó la atención fue la separación de los datos utilizando:

```python
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42)
```

Al inicio no tenía muy claro para qué era necesario dividir los datos, pero entendí que se hace para evitar utilizar toda la información directamente en el entrenamiento del modelo.

Una parte de los datos, llamada **datos de entrenamiento**, se utiliza para que el modelo pueda aprender las relaciones o patrones presentes en la información. La otra parte, llamada **datos de prueba**, se guarda para comprobar posteriormente si el modelo puede realizar buenas predicciones con información que no utilizó durante su entrenamiento.

Me pareció interesante porque permite evaluar el modelo de una forma más realista. Si se utilizara toda la información para entrenarlo y después se evaluara con los mismos datos, podría parecer que el modelo funciona correctamente aunque solamente esté reconociendo los datos que ya había visto.

## Lo que aprendí durante la práctica

También aprendí que antes de crear un modelo es importante conocer los datos con los que se está trabajando. Funciones como:

```python
df.head()
df.info()
df.describe()
```

permiten observar las primeras filas de la base de datos, identificar los tipos de variables y obtener algunos valores estadísticos importantes.

Otra parte que me ayudó a comprender mejor los datos fue el uso de la **matriz de correlación** y el mapa de calor. Con estos gráficos se puede observar qué variables presentan una relación mayor o menor entre ellas.

Posteriormente, al utilizar los modelos, aprendí que no basta solamente con generar una predicción. También es necesario comparar los resultados obtenidos con los valores reales para saber qué tan diferente fue lo que predijo el modelo.

En el caso del árbol de decisión, por ejemplo, se pueden realizar predicciones utilizando:

```python
test_pred = tree_model.predict(x_test)
```

y después comparar estas predicciones con los valores reales mediante gráficos y métricas de error.

## Importancia de lo aprendido

Considero que estos códigos son importantes porque permiten realizar diferentes etapas dentro de un análisis de datos. Primero se puede conocer y visualizar la información, después preparar los datos y finalmente construir modelos que intenten realizar predicciones.

Lo que más entendí durante esta práctica es que crear un modelo no consiste solamente en colocar los datos dentro de un código y obtener un resultado. También se necesita revisar los datos, dividirlos correctamente, entrenar el modelo y comprobar si las predicciones tienen sentido.

Este tipo de análisis también podría aplicarse en **Compostec**, ya que los sensores del proyecto generarían diferentes datos, como temperatura, humedad o cambios relacionados con los gases producidos durante el compostaje. Con una cantidad suficiente de registros, estos datos podrían analizarse para encontrar patrones y conocer mejor cómo cambia el estado del compost durante el tiempo.

De esta manera, los datos obtenidos por los sensores no solamente servirían para mostrar valores, sino que también podrían utilizarse posteriormente para apoyar el monitoreo y la toma de decisiones dentro del proyecto.

