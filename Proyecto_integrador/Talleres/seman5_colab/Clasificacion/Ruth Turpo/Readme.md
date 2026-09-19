# Informe: Análisis mediante Regresión Lineal — Concentración de CO (North Birmingham, 2023–2025)

## Introducción

En este informe se presenta el desarrollo y evaluación de modelos de **Inteligencia Artificial (IA) y Machine Learning (Aprendizaje Automático Supervisado)** aplicados al análisis de datos de calidad del aire. El objetivo principal de implementar estas técnicas de Machine Learning es permitir que un modelo algorítmico "aprenda" la relación entre la presencia de contaminantes atmosféricos y el Índice de Calidad del Aire (AQI), prediciendo de manera automática el nivel de riesgo ambiental a partir de mediciones físicas.

Para llevar a cabo este proceso, se utilizó un conjunto de datos real correspondiente al **Monóxido de Carbono (CO)**, recopilado en el Condado de Jefferson, Alabama (área de Birmingham-Hoover) durante los años **2023, 2024 y 2025**, el cual contiene **2,603 registros y 28 variables**.

El trabajo práctico abarcó todo el ciclo de vida de un proyecto de Machine Learning: la exploración de datos con `pandas`, el análisis gráfico de relaciones con `seaborn`, la preparación e ingeniería de variables ($X$ e $y$), la división de la muestra en conjuntos de entrenamiento (**70 %**) y prueba (**30 %**), el entrenamiento del algoritmo de aprendizaje supervisado de Regresión Lineal (`LinearRegression()`), la evaluación de sus predicciones y el diagnóstico de residuos.

Adicionalmente, como pruebas complementarias de IA, se generó un conjunto de datos sintéticos con `make_regression()`, se entrenó un algoritmo de árbol de decisión (`DecisionTreeRegressor`) para evaluar la importancia de las características y el Error Cuadrático Medio (MSE), y se realizó un ajuste analítico por Mínimos Cuadrados Ordinarios (OLS) con `statsmodels` [1], [2].

---

## Metodología

### 1. Exploración del conjunto de datos

Se utilizó un conjunto de datos de calidad del aire correspondiente a la estación **North Birmingham** (Jefferson, Alabama), que contiene **2,603 registros y 28 variables**, abarcando el periodo del **2023 al 2025**. Entre las variables disponibles se encuentran la **concentración máxima diaria de CO en 8 horas** (variable objetivo), el **valor diario del AQI** (`Daily AQI Value`), la **cantidad de observaciones diarias** (`Daily Obs Count`), el **porcentaje de datos completos** (`Percent Complete`) y distintos campos identificativos de la estación (como el código AQS: 01-073-0023, ubicación, coordenadas y códigos de método), los cuales se mantienen constantes al provenir de un único sitio de monitoreo.

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
**Imagen 3 – Histogramas de la variable objetivo**
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
*Figura 4 y 5. Distribución de frecuencias de la concentración máxima diaria de CO.*

**Interpretación:**

La distribución de la concentración máxima diaria de monóxido de carbono (`Daily Max CO Concentration`) presenta una clara **asimetría positiva (sesgo a la derecha)**. 

* **Valores concentrados:** La mayor parte de las observaciones diarias se agrupan en el rango bajo de la escala, manteniéndose predominantemente entre **0.2 y 0.4 ppm** (con una media de **0.3 ppm** y un AQI promedio de **3.5**).
* **Valores extremos:** Solo un número pequeño de días muestra concentraciones elevadas, alcanzando valores máximos puntuales cercanos a **0.9 - 1.0 ppm**.
* **Observación sobre el sensor:** Se aprecian algunos valores atípicos con signo negativo (hasta **-0.3 ppm**), los cuales reflejan ruidos de calibración en la estación de monitoreo de *North Birmingham*.

Esta estructura es típica en el análisis de contaminantes del aire: las concentraciones se mantienen en niveles mínimos en días habituales y solo registran picos en presencia de tráfico denso o fenómenos meteorológicos puntuales que limitan la dispersión del aire.

---

### 1.3. Matriz de correlación

Se realizó un análisis de correlación con el objetivo de identificar relaciones lineales entre las variables y determinar cuáles podrían ser utilizadas para el modelo de regresión.

```python
numeric_df = df.select_dtypes(include=[np.number])
numeric_df.corr().round(4)
plt.figure(figsize=(10,7))
sns.heatmap(numeric_df.corr(), annot=True, linewidths=2)
```

**Imagen 4 – Matriz de correlación**
<table>
  <tr>
    <td align="center">
      <strong>Imagen 4</strong><br>
      <img src="./Imagenes/imagen%206.png" width="500">
    </td>
    <td align="center">
      <strong>Imagen 5</strong><br>
      <img src="./Imagenes/imagen%207.png" width="500">
    </td>
  </tr>
</table>

**Interpretación (Figura 6 y 7):**

La matriz de correlación confirma las relaciones observadas en los análisis previos sobre el conjunto de datos de la estación de *North Birmingham*:

* **Relación directa entre concentración y AQI:** La variable `Daily Max 8-hour CO Concentration` y `Daily AQI Value` presentan una correlación de **1.00** (perfecta). Esto ocurre por construcción metodológica, ya que el valor del índice AQI para el monóxido de carbono se deriva directamente de la concentración máxima del gas.
* **Métricas de completitud:** Las variables `Daily Obs Count` y `Percent Complete` están correlacionadas entre sí de forma perfecta (**1.00**), puesto que ambas cuantifican la cobertura de datos diarios desde enfoques equivalentes.
* **Efecto de la cobertura en las mediciones:** La completitud mantiene una correlación **débil y negativa (-0.13)** con la concentración de CO. Esto indica que en días con un menor número de observaciones registradas la concentración tiende a ser ligeramente menor (un sesgo marginal por muestreo incompleto que no altera el comportamiento general del contaminante).

* 
### 1.4. Preparación de los datos

Para construir el modelo de regresión, se separaron las variables independientes o predictores, representadas por **X** (`Daily AQI Value`, `Daily Obs Count`, `Percent Complete`), de la variable objetivo, representada por **y** (`Daily Max 8-hour CO Concentration`). Se excluyeron del conjunto de predictores las columnas de texto, identificadores, metadatos y códigos geográficos que no aportan a la regresión (`Date`, `Source`, `Site ID`, `POC`, `Units`, `Local Site Name`, códigos AQS/CBSA/FIPS, `State`, `County`, coordenadas, etc.).

```python
# Código 11: Definición de variable objetivo y selección de predictores
variable_objetivo = 'Daily Max 8-hour CO Concentration'

# Matriz de variables independientes (X) y vector de la variable objetivo (y)
X = df[['Daily AQI Value', 'Daily Obs Count', 'Percent Complete']]
y = df[variable_objetivo]

```
Posteriormente, los datos de la estación de monitoreo (*North Birmingham*) fueron divididos en:

* **70 % para entrenamiento** (~1,822 registros), utilizado para ajustar el modelo de regresión.
* **30 % para prueba** (~781 registros), utilizado para evaluar las predicciones con datos no vistos.

La división se realizó mediante la función `train_test_split()` definiendo `test_size=0.3` y utilizando `random_state=123` para mantener la reproducibilidad exacta de los resultados.

```python
# Código 12: División de los datos en Train y Test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=123)
```
### 1.5. Regresión lineal

Se utilizó `LinearRegression()` para construir el modelo de regresión lineal múltiple con los datos de la estación de *North Birmingham*.

```python
# Código 13: Ajuste del modelo de regresión lineal
lm = LinearRegression()
lm.fit(X_train, y_train)
```
**Resultados obtenidos:**
![Figura 1](./Imagenes/imagen%208.png)

**Interpretación de los coeficientes:**

* **`Daily AQI Value`:** Presenta el valor de coeficiente/t-estadístico significativamente más alto dentro del modelo econométrico de OLS (`statsmodels`). Esto confirma que es la variable con mayor poder explicativo sobre la concentración máxima diaria de CO, manteniendo una relación directamente proporcional (un mayor índice AQI equivale directamente a una mayor concentración de CO, coincidiendo con la correlación de 1.00 detectada en la matriz).
* **`Daily Obs Count`:** Presenta un coeficiente positivo de magnitud reducida. Esto indica que a mayor número de mediciones tomadas durante el día por los sensores de la estación de *North Birmingham*, la estimación de la concentración tiende a ser levemente mayor.
* **`Percent Complete`:** Muestra un coeficiente negativo de valor pequeño. Esto implica que un mayor porcentaje de completitud en los registros diarios está asociado, en el margen del modelo, a niveles ligeramente menores de concentración de CO, lo cual guarda coherencia con la relación negativa débil identificada en la etapa exploratoria.

### Significancia estadística de los coeficientes (t-statistic)

```python
# Cálculo del t-statistic para evaluar la significancia de cada variable
n = X_train.shape[0]; k = X_train.shape[1]; dfN = n - k
train_error = np.square(train_pred - y_train)
sigma_sq = train_error.sum() / dfN
var_b = sigma_sq * (np.linalg.inv(np.dot(X_train.T, X_train)).diagonal())
sd_b = np.sqrt(var_b)
ts_b = lm.coef_ / sd_b
```
### Relación de las variables más importantes con la variable objetivo

```python
# Gráficos de dispersión para analizar las variables más importantes vs. Target
fig = plt.figure(figsize=(18, 10))
gs = gridspec.GridSpec(2, 2)

ax0 = plt.subplot(gs[0])
ax0.scatter(df[l[0]], df[variable_objetivo])
ax0.set_title(l[0] + ' vs. Target', fontdict={'fontsize': 20})

ax1 = plt.subplot(gs[1])
ax1.scatter(df[l[1]], df[variable_objetivo])
ax1.set_title(l[1] + ' vs. Target', fontdict={'fontsize': 20})

ax2 = plt.subplot(gs[2])
ax2.scatter(df[l[2]], df[variable_objetivo])
ax2.set_title(l[2] + ' vs. Target', fontdict={'fontsize': 20})

# Si solo se grafican las 3 variables principales del dataset, el cuarto panel queda vacío o libre
plt.tight_layout()
plt.show()
```

**Imagen 9 – Variables más importantes vs. variable objetivo**
![Figura 1](./Imagenes/imagen%209.png)

*Figura 5. Relación de las tres variables predictoras con la concentración de CO.*
*Figura 5. Relación de las tres variables predictoras con la concentración de CO.*

**Interpretación:** el panel de `Daily AQI Value` muestra la relación lineal casi perfecta ya descrita. Los paneles de `Daily Obs Count` y `Percent Complete` muestran una nube de puntos altamente concentrada en los valores máximos del sensor de *North Birmingham* (24 observaciones diarias y 100 % de completitud de registros), cubriendo prácticamente todo el rango de concentración de CO. Asimismo, se observa un grupo reducido de puntos con valores menores en estas dos métricas asociados a concentraciones diversas —evidencia visual directa de que su aporte predictivo real es marginal frente al peso dominante de `Daily AQI Value` en la regresión.

### R cuadrado del ajuste del modelo (entrenamiento)

```python
# Evaluación del R² en el conjunto de entrenamiento
metrics.r2_score(y_train, train_pred)

```
**Resultado:** R² de entrenamiento = **0.993**, es decir, el modelo explica el 99.3 % de la variabilidad de la concentración de CO en el conjunto de entrenamiento de la estación de *North Birmingham*.

---
### 1.6. Evaluación del modelo con datos de prueba

```python
# Generación de predicciones sobre el conjunto de prueba
predictions = lm.predict(X_test)

```
### Valores reales vs. predichos

```python
# Visualización de valores reales vs. predichos en el conjunto de prueba
plt.figure(figsize=(10, 7))
plt.title('Valores reales vs. predichos de CO', fontsize=25)
plt.xlabel('Conjunto real de concentración de CO', fontsize=18)
plt.ylabel('Valores predichos de concentración de CO', fontsize=18)
plt.scatter(x=y_test, y=predictions, alpha=0.7)

plt.plot(
    [y_test.min(), y_test.max()],
    [y_test.min(), y_test.max()],
    color='red',
    linestyle='--',
    lw=2,
)
plt.show()
```
**Imagen 10 – Valores reales vs. valores predichos**
![Figura 1](./Imagenes/imagen%2010.png)

*Figura 10. Comparación entre los valores reales y los valores predichos por el modelo.*
*Figura 6. Gráfico de dispersión de valores reales frente a predichos de concentración de CO.*

**Interpretación:** los puntos pertenecientes al conjunto de evaluación de la estación de *North Birmingham* se ajustan de manera prácticamente impecable a la línea diagonal discontinua de predicción perfecta (línea roja), abarcando todo el rango operativo medido por los sensores de la EPA (desde cerca de 0.0 hasta valores superiores a 1.5 ppm). Se aprecian únicamente desviaciones mínimas en ciertos puntos intermedios, donde el modelo llega a subestimar o sobreestimar levemente algunas lecturas individuales. En términos generales, la alineación casi perfecta ratifica que la capacidad de generalización del modelo es sumamente sólida y totalmente consistente con el $R^2$ de 0.993 obtenido en el entrenamiento.

### Análisis de residuos

```python
# Gráfico de distribución de residuos (Histograma + KDE)
residuos = y_test - predictions
sns.histplot(residuos, kde=True, color='blue', bins=30)
plt.title('Distribución de Residuos', fontsize=18)
plt.xlabel('Error de predicción (Residuo)', fontsize=14)
plt.ylabel('Frecuencia', fontsize=14)
plt.show()
```
**Imagen 11 – Análisis de residuos**
![Figura 1](./Imagenes/imagen%2011.png)
*Figura 11. Distribución de los residuos del modelo.*

**Interpretación:** el histograma de residuos muestra una forma aproximadamente centrada en cero, con la mayor parte de los errores concentrados en un rango estrecho[cite: 1]. Esto respalda el supuesto de normalidad de los residuos, aunque el gráfico revela una marcada bimodalidad con un pico secundario en los valores más altos de error[cite: 1]. Por su parte, en el análisis de residuos vs. predichos no se observa un patrón sistemático (curvatura o embudo) alrededor de la línea de referencia en cero, lo que sugiere una **homoscedasticidad razonable**: la varianza del error se mantiene relativamente estable a lo largo del rango de valores predichos, indicando que el modelo conserva su comportamiento de manera constante a lo largo de las distintas concentraciones.

negativa, y con la mayor parte de los errores concentrados en un rango muy estrecho, entre -0.05 y +0.06 ppm. Esto es coherente con los indicadores de error obtenidos (ver sección 1.8) y respalda el supuesto de normalidad de los residuos, aunque con algunas colas discretas. En el gráfico de residuos vs. predichos no se observa un patrón sistemático (curvatura o embudo) alrededor de la línea de referencia en cero, lo que sugiere una **homoscedasticidad razonable**: la varianza del error se mantiene relativamente estable a lo largo del rango de valores predichos, sin evidencia fuerte de que el modelo funcione peor para concentraciones altas que para concentraciones bajas.

---

### 1.7. Análisis complementario con datos artificiales

Como complemento del análisis, se generó un conjunto de datos artificiales utilizando `make_regression()`, con el fin de probar otros algoritmos de forma controlada (con relaciones conocidas de antemano).

Se utilizaron **100 muestras, 6 características y 3 características informativas**, además de un nivel de ruido de 20 y una semilla aleatoria (`random_state=20`) para mantener la reproducibilidad.

```python
# Generación del conjunto de datos sintéticos
x, y, coef = make_regression(
    n_samples=100,
    n_features=6,
    n_informative=3,
    random_state=20,
    shuffle=False,
    noise=20,
    coef=True
)
```

---

### 1.8. Árbol de decisión

Sobre los datos artificiales se entrenó un `DecisionTreeRegressor` con una profundidad máxima de 5.

```python
tree_model = tree.DecisionTreeRegressor(max_depth=5, random_state=10)
```
El modelo realizó predicciones sobre el conjunto de prueba, obteniéndose un **MSE de 7,931.6** (un valor elevado en términos absolutos, pero esperable dado que los datos artificiales se generaron con `noise=20` y valores de la variable objetivo en una escala mucho más amplia que la del CO real).

**Imagen 12 – Real vs. predicho (árbol de decisión)**
![Figura 1](./Imagenes/imagen%2012.png)

*Figura 12. Comparación entre valores reales y predichos del árbol de decisión sobre datos artificiales.*

Además, se obtuvo la importancia relativa de cada característica utilizada por el árbol.

**Imagen 13 – Importancia de las características**
![Figura 1](./Imagenes/imagen%2013.png)

*Figura 13. Importancia relativa de las características en el árbol de decisión.*
*Figura 8. Estructura e importancia de variables del Árbol de Decisión sobre datos sintéticos.*

**Interpretación:** el árbol identifica correctamente que las variables **x1, x2 y x3** son las más relevantes (con importancias de 0.269, 0.537 y 0.111 respectivamente, sumando ≈ 92 % de la importancia total), mientras que **x4, x5 y x6** —que no fueron marcadas como informativas al generar los datos— reciben una importancia mucho menor (todas por debajo de 0.04). Esto valida que el modelo de árbol es capaz de distinguir automáticamente las variables realmente predictivas de las que solo aportan ruido, tal como se diseñó el experimento (`n_informative=3` de 6 características totales).

---
### 1.9. Mínimos cuadrados

Finalmente, se utilizó `statsmodels` para ajustar un modelo mediante el método de mínimos cuadrados ordinarios (OLS) sobre los mismos datos artificiales.

```python
xs = sm.add_constant(x)
stat_model = sm.OLS(y, xs)
stat_result = stat_model.fit()
print(stat_result.summary())
```
**Interpretación:** el resumen del modelo OLS arrojó un **R² de 0.976** (R² ajustado 0.974), con un estadístico F de 628.6 y una probabilidad asociada prácticamente nula (p ≈ 6×10⁻⁷³), lo que indica que el modelo en conjunto es altamente significativo. A nivel individual, los coeficientes de **x1, x2 y x3** son estadísticamente significativos (p < 0.001 en los tres casos), con valores muy cercanos a los coeficientes reales usados para generar los datos, mientras que **x4, x5 y x6** no resultan significativos (p > 0.05 en los tres casos), confirmando nuevamente —desde un enfoque estadístico formal— el mismo hallazgo que entregó la importancia de características del árbol de decisión: solo tres de las seis variables generadas influyen realmente sobre la variable objetivo.

---
## 2. Resultados

### **Resumen del Dataset y Análisis Exploratorio**
* **Volumen de datos:** Un conjunto de **2,603 registros y 21 columnas** correspondientes a mediciones diarias de monóxido de carbono (CO) en la estación de *North Birmingham* (AQS: 01-073-0023) durante el periodo **2023–2025**.
* **Comportamiento de variables:** La concentración máxima diaria de CO en 8 horas presentó valores entre **0.0 y 1.6 ppm** (media de 0.285 ppm), mientras que el índice de calidad del aire (`Daily AQI Value`) varió entre **0 y 18** (media de 3.23).
* **Correlaciones principales:** Se identificó una relación lineal casi perfecta ($r = 0.996$) entre el CO diario y el `Daily AQI Value`. Por el contrario, las variables operativas (`Daily Obs Count` y `Percent Complete`) mostraron correlaciones prácticamente nulas con la variable objetivo.
  
## 3. Discusión

Los resultados obtenidos muestran que el modelo de regresión lineal ajusta prácticamente a la perfección los datos de la estación de North Birmingham ($R^2 = 0.992$). Sin embargo, al analizar estos hallazgos con más detenimiento, es importante destacar que la altísima correlación ($r = 0.996$) con la variable `Daily AQI Value` no necesariamente refleja un descubrimiento complejo sobre la calidad del aire, sino más bien la propia definición matemática del AQI. Como el índice de calidad del aire se calcula directamente a partir de la concentración del contaminante (en este caso, el CO), el modelo está utilizando una variable que es esencialmente un reflejo de la variable objetivo.

Por otro lado, variables operativas como `Daily Obs Count` o `Percent Complete` demostraron no aportar información relevante al modelo, lo cual era de esperarse, ya que la cantidad de lecturas tomadas en un día no cambia la cantidad de monóxido de carbono que hay en el ambiente. 

Respecto a los supuestos del modelo, los residuos se comportan de manera bastante homogénea (homocedasticidad), aunque se observa una pequeña bimodalidad en la distribución. Esto puede deberse a la presencia de días atípicos o eventos puntuales en los que las concentraciones de CO subieron más de lo normal en la zona industrial de North Birmingham durante el periodo 2023–2025.

Finalmente, la prueba con los datos sintéticos creados con `make_regression()` fue un ejercicio muy útil para poner a prueba los algoritmos en un entorno controlado. Tanto el modelo de regresión lineal como el Árbol de Decisión demostraron ser capaces de identificar correctamente las verdaderas variables predictivas ($x_1, x_2, x_3$) y descartar las variables con ruido. Esto confirma que el flujo de trabajo programado en Colab es metodológicamente correcto y confiable para distinguir señales reales en los datos.

---
  
## 4. Conclusiones

* Revisamos el conjunto de datos de la estación de North Birmingham (2018–2024) usando `head()`, `info()` y `describe()`, logrando confirmar un total de 2,603 registros listos para analizar.
* Analizamos cómo se relacionaban las variables con `pairplot()` y la matriz de correlación, encontrando que el CO y el AQI tienen una relación casi perfecta ($r = 0.996$), mientras que las variables de control de datos no influyen casi nada.
* Armamos un modelo de regresión lineal múltiple separando los datos en 70 % para entrenamiento y 30 % para prueba (`random_state=123`).
* El modelo funcionó súper bien y logró un **R² de 0.992 en la prueba**, con errores muy pequeños (MAE de 0.0152 ppm y RMSE de 0.0219 ppm), lo cual se debe principalmente a lo directo que se conecta el CO con el AQI.
* Revisamos los residuos y vimos que no tienen un patrón raro, por lo que se cumple bastante bien la homocedasticidad y la normalidad de los errores, salvo por unos pocos datos altos que forman dos pequeños picos.
* Creamos datos artificiales con `make_regression()` (100 muestras, 6 características y 3 informativas) para probar los modelos en un caso controlado.
* El árbol de decisión y el modelo OLS lograron reconocer exactamente cuáles eran las 3 variables que sí importaban ($x_1, x_2, x_3$) de las 6 que creamos, demostrando que ambos métodos funcionan bien para ignorar el ruido.
* Como recomendación para un trabajo futuro, sería bueno probar el modelo quitando la variable `Daily AQI Value`, para ver qué tanto pueden predecir las demás variables por sí solas.

---
## 5. Referencias

[1] Notebook de trabajo: *CO_Regresion.ipynb*, 2026.

[2] Conjunto de datos: *ad_viz_plotval_data.csv* — Concentración máxima diaria de CO (8 horas), estación North Birmingham, Jefferson, AL, **2023–2025** (AQS/EPA AirData).
