
 # Aplicación e importancia de los códigos utilizados

Durante el desarrollo de este trabajo se utilizaron diferentes códigos de Python para realizar el análisis de datos, desde la exploración y visualización de la información hasta la creación de modelos capaces de realizar predicciones. Se emplearon herramientas como **Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn y Statsmodels**, que permitieron trabajar con los datos de una manera más ordenada y comprender mejor su comportamiento.

Entre los códigos utilizados se realizaron histogramas y gráficos de densidad para observar la distribución de los datos, matrices de correlación y mapas de calor para identificar relaciones entre las variables, y gráficos de dispersión para visualizar su comportamiento. También se trabajó con **regresión lineal** y **árboles de decisión**, utilizando una parte de los datos para entrenar los modelos y otra para comprobar su capacidad de predicción.

## Código que más me llamó la atención

Una de las líneas que más me llamó la atención fue:

```python
test_pred = tree_model.predict(x_test)
```

Esta línea permite que el **árbol de decisión realice predicciones utilizando datos que no fueron empleados directamente para entrenar el modelo**. Me llamó la atención porque muestra de una manera sencilla cómo un modelo puede aprender a partir de datos anteriores y posteriormente utilizar lo aprendido para estimar nuevos resultados.

![Código del árbol de decisión](Captura%20de%20pantalla%202026-09-15%20203531.png)

Después de realizar las predicciones, el código compara los **valores reales con los valores predichos** mediante un gráfico de dispersión. Esto permite observar visualmente qué tan próximas son las predicciones del modelo a los valores reales.

![Valores reales vs predichos](Captura%20de%20pantalla%202026-09-15%20203541.png)

También se calcula el **error cuadrático medio (MSE)**, que permite cuantificar la diferencia entre los valores reales y los valores estimados por el modelo. En el ejercicio se obtuvo un MSE de aproximadamente **7931.57**. Este valor debe interpretarse considerando la escala y los datos utilizados; por sí solo no indica si el modelo es bueno o malo.

## Importancia de los códigos utilizados

En conjunto, los códigos utilizados son importantes porque permiten pasar de tener solamente una base de datos a **explorarla, visualizarla, identificar relaciones entre variables y construir modelos de predicción**. La regresión lineal permite estudiar relaciones entre las variables, mientras que el árbol de decisión permite aprender patrones y realizar predicciones. Los gráficos y las métricas permiten posteriormente evaluar e interpretar los resultados obtenidos.

Estos conocimientos también pueden ser útiles para **Compostec**, ya que un sistema que recopila información mediante sensores genera datos que necesitan ser analizados. Aplicando este tipo de herramientas se podrían estudiar variables monitoreadas durante el compostaje, identificar patrones y, con datos adecuados, desarrollar modelos que apoyen la predicción y la toma de decisiones para mejorar el seguimiento y control del proceso.
