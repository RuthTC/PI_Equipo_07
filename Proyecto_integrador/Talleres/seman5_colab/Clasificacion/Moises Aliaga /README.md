# Informe: Análisis y Modelo Predictivo — Concentración Diaria de Ozono (Alabama, 2023–2025)

## Introducción
En este informe se presenta el desarrollo y evaluación de modelos de Inteligencia Artificial (IA) y Machine Learning (Aprendizaje Automático Supervisado) aplicados al análisis de datos espaciales y de calidad del aire. El objetivo principal es que un modelo algorítmico aprenda la relación entre las características geográficas/operativas de las estaciones de medición y los niveles del contaminante, prediciendo de manera automática la concentración ambiental.

Para llevar a cabo este proceso, se utilizó un conjunto de datos real correspondiente al Ozono, recopilado en 22 estaciones de monitoreo del estado de Alabama (EE. UU.) durante los años 2023, 2024 y 2025, el cual contiene 14,557 registros y 28 variables.

El trabajo práctico abarcó todo el ciclo de vida de un proyecto de Machine Learning: la exploración de datos con pandas, el análisis gráfico de relaciones, la preparación e ingeniería de variables (X e y), la división de la muestra en conjuntos de entrenamiento (70 %) y prueba (30 %), el entrenamiento del algoritmo de aprendizaje supervisado (RandomForestRegressor / LinearRegression), la evaluación de sus predicciones y el diagnóstico de residuos. Adicionalmente, se generó un conjunto de datos sintéticos para evaluar métricas de árboles de decisión y ajustes analíticos por Mínimos Cuadrados Ordinarios (OLS).

---

## Metodología
### 1. Exploración del conjunto de datos
Se utilizó el conjunto de datos de calidad del aire que consolida 14,557 registros y 28 variables. Entre las variables disponibles destacan la concentración máxima diaria de Ozono (Daily Max Ozone Concentration - variable objetivo), el valor diario del AQI (Daily AQI Value), la cantidad de observaciones diarias (Daily Obs Count), el porcentaje de datos completos (Percent Complete), así como datos geográficos fijos (Site Latitude, Site Longitude, Elevation (m)).
Para conocer la estructura de los datos se utilizaron funciones básicas de pandas:

```python
df = pd.read_csv(ruta)
df.head()
df.info(verbose=True)
df.describe().round(2)
```
La función info() confirmó que los 14,557 registros de las variables seleccionadas no presentan valores nulos. La función describe() mostró que la concentración máxima diaria de Ozono oscila entre 0.00 y 0.082 ppm, con una media de 0.041 ppm, mientras que el AQI diario varía entre 0 y 140, con una media de 38.89.

**Imagen 1 – Exploración inicial del conjunto de datos**
<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/Info(1).jpeg">

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/describe(1.1).jpeg">

---

*Figura 1. Primeros registros y estadísticas descriptivas del conjunto de datos.*

---

### 1.2. Análisis exploratorio y correlación
Se realizó un análisis exploratorio para observar visualmente las relaciones entre las variables utilizando un gráfico de pares (pairplot). Este análisis se enfocó en las variables continuas y espaciales frente a la concentración de Ozono.
```python
sns.pairplot(df1)
```
**Imagen 2 – Relaciones entre variables**
<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/Relaci%C3%B3n(2).jpeg">
*Figura 2. Matriz de dispersión cruzada entre las variables.*


**Interpretación:** El panel que relaciona Daily Max Ozone Concentration con Daily AQI Value muestra una alineación casi perfecta, confirmando que el índice AQI se deriva matemáticamente de la concentración de gas. Por otro lado, las variables espaciales (Elevation, Latitude, Longitude) muestran agrupaciones discretas (líneas verticales o bloques), ya que corresponden a las ubicaciones fijas de los 22 sensores. Las variables operativas (Percent Complete y Daily Obs Count) se agrupan casi en su totalidad en el 100% y en 17 observaciones, demostrando escasa variabilidad frente a los picos de ozono.
### Distribución de la variable objetivo
```
df['Daily Max Ozone Concentration'].plot.hist(bins=25, figsize=(8,4))
df['Daily Max Ozone Concentration'].plot.density()
```
**Imagen 3 – Histogramas de la variable objetivo**
<table>
  <tr>
    <td align="center">
      <strong>Imagen 4</strong><br>
      <img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/Distribucion(3).jpeg" width="400">
    </td>
    <td align="center">
      <strong>Imagen 5</strong><br>
      <img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/Distribucion(3.1).jpeg" width="400">
    </td>
  </tr>
</table>

*Figura 4 y 5. Distribución de frecuencias de la concentración máxima diaria de OZONO.*
**Interpretación:** La distribución de la concentración máxima diaria de ozono se aproxima a una forma de campana (distribución normal) con una ligera asimetría, centrando la mayor parte de las observaciones entre 0.034 ppm y 0.048 ppm. Los valores extremos por encima de 0.070 ppm son raros y representan episodios críticos de mala calidad del aire.

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
      <img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/correlacion(4).jpeg" width="500">
    </td>
    <td align="center">
      <strong>Imagen 5</strong><br>
      <img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/correlacion(4.1).jpeg" width="500">
    </td>
  </tr>
</table>

**Interpretación (Figura 6 y 7):**
Interpretación:

* **Ozono y AQI:** Mantienen una correlación casi perfecta (0.955), indicando una codependencia directa por cálculo normativo.

* **Variables espaciales y operativas:** Características como Daily Obs Count (0.151) y Elevation (0.076) muestran correlaciones muy débiles con la concentración de Ozono. Esto anticipa que la ubicación geográfica y la cantidad de mediciones, por sí solas, no determinan linealmente los niveles del gas (faltando componentes meteorológicos dinámicos).

*
### 1.4. Preparación de los datos
Para aislar el problema predictivo geoespacial y operativo, se separaron las variables independientes (Daily Obs Count, Percent Complete, Site Latitude, Site Longitude, Elevation (m)) de la variable objetivo (Daily Max Ozone Concentration). Se excluyó deliberadamente el AQI para evitar predecir la variable basándose en su propio cálculo derivado.
```python
features = ['Daily Obs Count', 'Percent Complete', 'Site Latitude', 'Site Longitude', 'Elevation (m)']
target = 'Daily Max Ozone Concentration'
X = df[features]
y = df[target]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=123)
from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.3, random_state=123)
```
La división reservó el 70% de datos para entrenamiento y el 30% para evaluación ciega.
### 1.5. Entrenamiento del Modelo
```python
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor

# Ajuste del modelo de Regresión Lineal Clásica
lm = LinearRegression()
lm.fit(X_train, y_train)

# Ajuste del modelo de Bosque Aleatorio (Árboles de Decisión Múltiples)
rf_model = RandomForestRegressor(max_depth=5, random_state=10)
rf_model.fit(X_train, y_train)
```
**Resultados obtenidos:**
<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/Regresion(5).jpeg">
**Interpretación de los coeficientes:**
En el análisis por OLS y Árboles, las características geográficas (Site Longitude, Elevation (m)) muestran un mayor peso estadístico ($p < 0.05$) frente a variables operativas como el porcentaje de completitud. Sin embargo, los coeficientes mantienen magnitudes marginales debido a que las coordenadas fijas no explican las oscilaciones diarias del ozono causadas por factores climáticos (radiación solar, viento, temperatura).
* **R cuadrado del ajuste del modelo:** El modelo arroja un coeficiente de determinación (R^2) sumamente bajo (entre 0.03 y 0.05). Esto indica que solo un 5% de la variabilidad de la contaminación por ozono en Alabama puede ser explicada usando exclusivamente coordenadas geográficas y recuentos de observación.
 ---
### 1.6 Evaluación del modelo con datos de prueba

```python
plt.figure(figsize=(10, 7))
plt.scatter(Y_test, predictions, alpha=0.3, color='blue', edgecolors='k')

# Línea de referencia ideal de 45°
min_val = min(Y_test.min(), predictions.min())
max_val = max(Y_test.max(), predictions.max())
plt.plot([min_val, max_val], [min_val, max_val], color='red', linestyle='--', linewidth=2)

plt.title("Concentración de Ozono real vs. predicha", fontsize=20)
plt.xlabel("Concentración de Ozono real", fontsize=14)
plt.ylabel("Concentración de Ozono predicha", fontsize=14)
plt.grid(True, linestyle=':', alpha=0.6)
plt.show()
```
```python
l = list(cdf.index)
target = 'Daily Max Ozone Concentration'

from matplotlib import gridspec
fig = plt.figure(figsize=(18, 12))
gs = gridspec.GridSpec(2, 3)

for i, var in enumerate(l):
    ax = plt.subplot(gs[i])
    ax.scatter(df[var], df[target], alpha=0.3)
    ax.set_title(f"{var}\nvs. Ozone Concentration", fontdict={'fontsize': 14})
    ax.set_xlabel(var)
    ax.set_ylabel("Ozone Concentration")

plt.tight_layout()
plt.show()
```
**Figura 9 (Variables predictoras vs. Target)**
<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/imagen(6).jpeg">
*Figura 9 Variables predictoras vs. Target*
* **Interpretación**: En los paneles espaciales (Site Latitude, Site Longitude, Elevation), los datos se visualizan como densas franjas verticales discretas. Esto ocurre lógicamente porque los registros provienen de ubicaciones geográficas fijas (estaciones de monitoreo), pero no revelan ninguna tendencia ascendente o descendente que indique una correlación directa. Por su parte, las variables operativas (Daily Obs Count y Percent Complete) muestran una altísima concentración de puntos en sus valores máximos (17 observaciones diarias y 100% de completitud), confirmando que las variaciones en los niveles de ozono ocurren de manera totalmente independiente a la calidad del muestreo del sensor. Todo esto anticipa el bajo poder predictivo de estas variables.
 ---
 ### Entrenamiento del Modelo
**Figura 10 Evaluación del modelo: Real vs. Predicho**
<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/imagen(6.1).jpeg">
*Figura 9 Variables Real vs. Predicho*
* **Interpretación**:La nube de puntos azules muestra un claro comportamiento anómalo al no alinearse sobre la línea diagonal de predicción ideal. En lugar de ello, el modelo predice casi exclusivamente valores concentrados en una franja horizontal estrecha (alrededor de 0.040 – 0.042 ppm, que es la media del conjunto de datos). Esto es la evidencia gráfica de un underfitting (subajuste) severo: al carecer de variables independientes dinámicas (como viento, temperatura o radiación) que expliquen las fluctuaciones del ozono, el algoritmo es incapaz de capturar la varianza y opta matemáticamente por predecir siempre un valor cercano al promedio para no penalizar excesivamente su error.

### 1.7 Mínimos cuadrados (MCO/OLS)
```python
import statsmodels.api as sm

# Agregamos la constante a tus predictoras X
Xs = sm.add_constant(X)

# Usamos Y en mayúscula para que coincida exactamente con el tamaño de X
stat_model = sm.OLS(Y, Xs)
stat_result = stat_model.fit()

# Mostramos el resumen estadístico completo
print(stat_result.summary())
```
**Figura 11 OLS Regression**
<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Clasificacion/Moises%20Aliaga%20/Imagenes/Regresion.jpeg">
*Figura 9. Resumen estadístico del modelo OLS.*
* **Interpretación**: El modelo sintético arrojó un $R^2$ de 0.976. Los p-values confirman formalmente que solo los coeficientes de las variables informativas son estadísticamente significativos ($p < 0.001$), demostrando que la metodología implementada filtra eficientemente el ruido cuando la correlación subyacente existe en los datos.

 ---
 ## 2. Resultados
* **Volumen de datos:** 14,557 registros correspondientes a 22 estaciones de monitoreo de ozono durante 2023–2025.
* **Comportamiento de variables:** El ozono ambiental mantuvo una media de 0.041 ppm. Las variables predictoras seleccionadas abarcaron dimensiones puramente espaciales (Latitud, Longitud, Altitud) y operativas (Conteo de observaciones diarias).
* **Desempeño del modelo:** El modelo entrenado sobre las 5 características arrojó un R^2 de prueba bajo (aproximadamente 0.05), demostrando una nula correlación lineal entre la coordenada estática del sensor y los picos de contaminación dinámica.
  
---
## 3. Discusión
A diferencia de modelos de referencia que incluyen el índice de calidad del aire (AQI) y logran un ajuste casi perfecto ($R^2=0.99$), este experimento excluyó variables autocorrelacionadas o matemáticamente derivadas para probar el verdadero poder predictivo de los metadatos operativos y de ubicación (Latitude, Longitude, Elevation).Los resultados demuestran una premisa fundamental en la ingeniería ambiental: la contaminación atmosférica no puede predecirse basándose únicamente en la ubicación estática de la estación de monitoreo. Dado que variables operativas como el Percent Complete o la latitud se mantienen inmutables día tras día en un mismo sitio, el algoritmo no cuenta con variabilidad suficiente para predecir si un día específico tendrá una alta o baja concentración de ozono. El bajo coeficiente de determinación obtenido ratifica matemáticamente la necesidad de incorporar variables independientes de carácter meteorológico (dirección del viento, radiación ultravioleta, temperatura) y de emisiones antropogénicas (volumen de tráfico en el día) para construir un modelo de Machine Learning que generalice con precisión.

---
## 4. Conclusiones
-Se procesó exitosamente el dataset de calidad del aire (2023–2025) con 14,557 registros continuos y sin valores nulos en las características objetivo.
-El análisis mediante pairplot y matrices de correlación reveló que el Ozono mantiene una codependencia algorítmica con el AQI ($r=0.955$), pero carece de asociación lineal fuerte con los parámetros espaciales u operativos (correlaciones inferiores a 0.15).
-a regresión basada en coordenadas y cantidad de observaciones evidenció un claro subajuste ($R^2$ inferior al 10%), confirmando que el monitoreo de contaminantes dinámicos requiere características predictoras dinámicas (meteorología).
-El ensayo paralelo con datos artificiales (make_regression) validó que el código implementado, tanto para Árboles de Decisión como para MCO, identifica correctamente características útiles y suprime el ruido de fondo, asegurando la confiabilidad del flujo de trabajo en Python.
- Como recomendación técnica para futuras iteraciones del proyecto, se sugiere integrar datasets climáticos correspondientes a los mismos sitios y fechas, lo que dotará al modelo del marco conceptual físico necesario para predecir eficazmente la generación de ozono troposférico.
---
## 5. Referencias
[1] Notebook de trabajo: *CO_Regresion.ipynb*, 2026.

[2] Conjunto de datos: Ozone_daily_aqs_data_downloaded_2026-09-17 19_54_38.csv — Concentración máxima diaria de Ozono, agencias de monitoreo en Alabama, 2023–2025 (US EPA AirData).
