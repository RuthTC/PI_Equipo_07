# IInforme: Análisis mediante Regresión Lineal — Concentración de CO (Salt Lake City, 2023)

## Introducción

En este informe se presenta el desarrollo y evaluación de modelos de **Inteligencia Artificial (IA) y Machine Learning (Aprendizaje Automático Supervisado)** aplicados al análisis de datos de calidad del aire. El objetivo principal de implementar estas técnicas de Machine Learning es permitir que un modelo algorítmico "aprenda" la relación entre la presencia de contaminantes atmosféricos y el Índice de Calidad del Aire (AQI), prediciendo de manera automática el nivel de riesgo ambiental a partir de mediciones físicas.

Para llevar a cabo este proceso, se utilizó un conjunto de datos real correspondiente al **Monóxido de Carbono (CO)**, recopilado en el Condado de Jefferson, Alabama (área de Birmingham-Hoover) durante los años **2023, 2024 y 2025**, el cual contiene **2,603 registros y 28 variables**.

El trabajo práctico abarcó todo el ciclo de vida de un proyecto de Machine Learning: la exploración de datos con `pandas`, el análisis gráfico de relaciones con `seaborn`, la preparación e ingeniería de variables ($X$ e $y$), la división de la muestra en conjuntos de entrenamiento (**70 %**) y prueba (**30 %**), el entrenamiento del algoritmo de aprendizaje supervisado de Regresión Lineal (`LinearRegression()`), la evaluación de sus predicciones y el diagnóstico de residuos.

Adicionalmente, como pruebas complementarias de IA, se generó un conjunto de datos sintéticos con `make_regression()`, se entrenó un algoritmo de árbol de decisión (`DecisionTreeRegressor`) para evaluar la importancia de las características y el Error Cuadrático Medio (MSE), y se realizó un ajuste analítico por Mínimos Cuadrados Ordinarios (OLS) con `statsmodels` [1], [2].

---

## Metodología

### 1. Exploración del conjunto de datos

Se utilizó un conjunto de datos de calidad del aire correspondiente a la estación **Copper View** (Salt Lake City, Utah), que contiene **365 registros y 21 variables**, uno por cada día del año 2022. Entre las variables disponibles se encuentran la **concentración máxima diaria de CO en 8 horas** (variable objetivo), el **valor diario del AQI**, la **cantidad de observaciones diarias**, el **porcentaje de datos completos** y distintos campos identificativos de la estación (ubicación, códigos de método y de parámetro, coordenadas), que son constantes para todo el dataset al provenir de un único sitio de monitoreo.

Para conocer la estructura de los datos se utilizaron funciones básicas de `pandas`, principalmente `head()`, `info()` y `describe()`.

```python
df1 = pd.read_csv(file)
df1.head()
df1.info(verbose=True)
df1.describe().round(1)
```

La función `head()` permitió observar los primeros registros (por ejemplo, el 01/01/2022 se registró una concentración de 0.4 ppm de CO con un AQI de 5). La función `info()` confirmó que las 365 filas no tienen valores nulos y que las variables numéricas relevantes son de tipo `float64` e `int64`. Finalmente, `describe()` mostró que la concentración de CO oscila entre **0.0 y 1.0 ppm**, con una media de **0.284 ppm**, mientras que el AQI diario varía entre **0 y 11**, con una media de **3.15**.

**Imagen 1 – Exploración inicial del conjunto de datos**

![Figura 1](./Imagenes/imagen%201.png) 

---

![Figura 1](./Imagenes/imagen%202.png)

*Figura 1. Primeros registros del conjunto de datos.*

---
### 1.2. Análisis exploratorio y correlación

Se realizó un análisis exploratorio para observar visualmente las relaciones entre las variables utilizando un gráfico de pares (`pairplot`). Este análisis se enfocó en las cinco variables numéricas del DataFrame `df` que presentan variabilidad real: **Daily Max CO Concentration**, **Daily AQI Value**, **Daily Obs Count**, **Percent Complete** y **Probe Height (m)**. 

Se excluyeron del análisis gráfico las demás columnas numéricas (como coordenadas geográficas, elevación, códigos AQS o de método), ya que mantienen valores constantes o no aportan información sobre la dinámica del monóxido de carbono en la estación. Asimismo, se descartaron temporalmente los registros con valores faltantes en la altura de la sonda (`Probe Height (m)`) para asegurar la correcta generación de las distribuciones y diagramas de dispersión.

```python
sns.pairplot(df1)
```

**Imagen 2 – Relaciones entre variables**
![Figura 1](./Imagenes/imagen%203.png)
*Figura 2. Relaciones entre las variables del conjunto de datos.*

**Interpretación:** el panel más relevante es el que relaciona `Daily Max CO Concentration` con `Daily AQI Value`: los puntos se alinean casi perfectamente sobre una recta creciente, lo que anticipa una correlación lineal casi perfecta entre ambas variables (el AQI de CO se calcula directamente a partir de la concentración de CO, por lo que esta relación es, en la práctica, una transformación matemática y no una asociación empírica). En cambio, `Daily Obs Count` y `Percent Complete` se concentran mayoritariamente en un único valor (24 observaciones y 100 % de datos completos), con un grupo reducido de días con menos observaciones y menor porcentaje de completitud; estos puntos corresponden a días con fallas o interrupciones en el equipo de medición y no muestran una relación clara con la concentración de CO. Por su parte, `Probe Height (m)` se distribuye en valores discretos fijos para el monitoreo de la estación, sin presentar ninguna relación funcional con las variaciones en los niveles de CO.


### Distribución de la variable objetivo

```
pythondf["Daily Max CO Concentration"].plot.hist(bins=25, figsize=(8,4))
df['Daily Max CO Concentration'].plot.density()
```
**Imagen 3 – Histograma de la variable objetivo**
<table>
  <tr>
    <td align="center">
      <strong>Imagen 4</strong><br>
      <img src="./Imagenes/imagen%204.png" width="400">
    </td>
    <td align="center">
      <strong>Imagen 5</strong><br>
      <img src="./Imagenes/imagen%205.png" width="400">
    </td>
  </tr>
</table>
