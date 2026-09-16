
# Aplicación de los códigos en Compostec

La utilización de estos códigos permite analizar e interpretar los datos obtenidos durante el funcionamiento de **Compostec**. Mediante herramientas estadísticas y modelos como la **regresión lineal y los árboles de decisión**, se pueden estudiar las relaciones entre las variables monitoreadas durante el proceso de compostaje.

Estos códigos permiten generar gráficos, analizar correlaciones e identificar qué variables presentan una mayor influencia en los resultados. De esta manera, los datos recolectados pueden convertirse en información útil para comprender y controlar mejor el proceso.

En **Compostec**, este análisis complementa la información obtenida mediante los sensores y facilita la toma de decisiones basada en datos. Por ejemplo, permite evaluar el comportamiento de variables como la temperatura y la humedad, detectar condiciones inadecuadas y orientar las acciones necesarias para mantener un proceso de compostaje más eficiente y controlado.

## Importancia para Compostec

- Analizar los datos obtenidos durante el compostaje.
- Identificar relaciones entre las variables estudiadas.
- Visualizar los resultados mediante gráficos.
- Determinar qué variables tienen mayor importancia mediante modelos como los árboles de decisión.
- Utilizar los datos obtenidos para mejorar el seguimiento y control del proceso de compostaje.
## Árbol de decisión

Una de las partes del código que más me llamó la atención fue la creación y entrenamiento del **árbol de decisión**. Este modelo permite aprender patrones a partir de un conjunto de datos y posteriormente utilizarlos para realizar predicciones.

![Resultado del modelo](Captura%20de%20pantalla%202026-09-15%20203541.png)

En esta parte del código se dividen los datos en entrenamiento y prueba, se crea el modelo `DecisionTreeRegressor` y posteriormente se entrena utilizando los datos disponibles. Me llamó la atención porque permite observar cómo, a partir de información previamente registrada, el modelo puede generar predicciones sobre nuevos datos.

![Código del árbol de decisión](Captura%20de%20pantalla%202026-09-15%20203531.png)

### Importancia para Compostec

Considero que este modelo puede ser importante para **Compostec**, ya que los datos recolectados por los sensores pueden ser analizados para identificar patrones en variables como la temperatura y la humedad. Esto permitiría aprovechar los datos obtenidos durante el compostaje para apoyar el monitoreo del sistema y facilitar la toma de decisiones.

De esta manera, el código no solo permite analizar información, sino también explorar cómo los datos obtenidos por **Compostec** podrían utilizarse para desarrollar herramientas de predicción y mejorar progresivamente el control del proceso de compostaje.
