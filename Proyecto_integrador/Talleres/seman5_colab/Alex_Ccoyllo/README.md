# Aplicación e importancia de los códigos utilizados

Durante esta práctica se utilizaron diferentes códigos de Python para realizar el análisis de una base de datos, observar el comportamiento de las variables y posteriormente trabajar con modelos de predicción. Para esto se emplearon librerías como **Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn y Statsmodels**, las cuales permiten organizar, analizar y representar los datos de una manera más sencilla.

Primero se realizó una exploración de los datos utilizando funciones que permitieron conocer mejor la información disponible, revisar las variables y observar algunos valores estadísticos. Después se utilizaron diferentes gráficos, como histogramas, gráficos de dispersión y mapas de calor, con el objetivo de identificar patrones y relaciones entre las variables.

También se trabajó con modelos como la **regresión lineal** y el **árbol de decisión**, utilizando una parte de los datos para entrenar los modelos y otra parte para evaluar sus resultados. Esto permitió comprender mejor cómo se pueden utilizar datos anteriores para realizar predicciones sobre nuevos datos.

## Código que más me llamó la atención

Una de las partes que más me llamó la atención fue el siguiente código:

```python
plt.figure(figsize=(10,7))

plt.title("Histograma de residuos para verificar la normalidad", fontsize=25)

plt.xlabel("Residuos", fontsize=18)

plt.ylabel("Densidad del kernel", fontsize=18)

sns.distplot([y_test-predictions])
```

Este código permite generar un **histograma de los residuos obtenidos en el modelo de regresión**.

Los residuos representan la diferencia entre los valores reales y los valores que fueron predichos por el modelo. En este caso, se calculan mediante:

```python
y_test - predictions
```

Me pareció interesante porque antes pensaba que al realizar una predicción solamente era necesario observar el resultado obtenido, pero aprendí que también es importante analizar los errores que comete el modelo.

El histograma permite observar cómo se distribuyen estos residuos y verificar visualmente si presentan un comportamiento aproximadamente normal. Si una gran cantidad de residuos se encuentra cerca de cero, quiere decir que muchas de las predicciones realizadas por el modelo estuvieron relativamente próximas a los valores reales.

Por otro lado, si aparecen residuos muy alejados de cero, significa que en esos casos hubo una mayor diferencia entre lo que realmente ocurrió y lo que el modelo había estimado.

También entendí que este tipo de gráfico sirve para evaluar mejor el comportamiento de un modelo de regresión, ya que permite observar los errores de una manera visual y no solamente mediante valores numéricos.

## Lo que aprendí

Durante esta práctica aprendí que antes de crear un modelo es importante conocer y analizar correctamente los datos con los que se va a trabajar.

También entendí la importancia de separar los datos en **datos de entrenamiento y datos de prueba**. Los datos de entrenamiento se utilizan para que el modelo aprenda los patrones existentes, mientras que los datos de prueba permiten comprobar cómo funciona el modelo con información que no utilizó directamente durante su entrenamiento.

Otro concepto que aprendí fue el de las **predicciones**, que representan los valores que el modelo estima después de haber sido entrenado.

Además, aprendí que los **residuos** permiten conocer la diferencia entre el resultado real y el resultado predicho. Esto ayuda a identificar qué tan cerca o lejos estuvieron las predicciones realizadas por el modelo.

Los gráficos también me ayudaron a entender mejor la información, ya que permiten visualizar cosas que pueden ser más difíciles de identificar observando únicamente los valores dentro de una tabla.

## Importancia de los códigos utilizados

Los códigos utilizados durante esta práctica son importantes porque permiten realizar diferentes etapas dentro de un análisis de datos.

Primero permiten explorar y conocer la información disponible, después ayudan a representar los datos mediante gráficos y finalmente permiten construir modelos capaces de realizar predicciones.

También aprendí que no es suficiente con obtener una predicción, sino que es necesario evaluar los resultados para conocer qué tan bien está funcionando el modelo. Para esto se pueden utilizar diferentes métricas y gráficos, como el histograma de residuos.

Este tipo de herramientas permite comprender mejor el comportamiento de los datos y encontrar relaciones que pueden ser útiles para resolver diferentes problemas.

## Posible aplicación en Compostec

Lo aprendido durante esta práctica también podría ser útil para el proyecto **Compostec**, ya que los sensores utilizados en el sistema generarán diferentes datos relacionados con el proceso de compostaje.

Por ejemplo, se podrían registrar datos de **temperatura, humedad y cambios en los gases presentes durante el compostaje**. Con una cantidad suficiente de información se podrían analizar estos datos mediante gráficos para observar su comportamiento a lo largo del tiempo.

Posteriormente, estos datos también podrían utilizarse para entrenar modelos que ayuden a identificar patrones relacionados con el estado del compost.

Además, mediante el análisis de errores y residuos se podría evaluar qué tan precisas son las predicciones realizadas por estos modelos.

De esta manera, las herramientas aprendidas durante la práctica podrían servir para que los datos obtenidos por los sensores no solamente sean mostrados, sino que también puedan ser analizados para apoyar el monitoreo y la toma de decisiones dentro del proyecto.
