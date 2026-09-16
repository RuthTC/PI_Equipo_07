 # Exploración de Datos y Análisis de Consumo de Energía

En esta clase trabajamos con un conjunto de datos en un archivo llamado Data_PI_regresion.csv. La idea de la sesión fue aprender a hacer un análisis exploratorio de datos (EDA) usando Python en Jupyter / Google Colab.

Nos enfocamos en cargar la información, revisar que no tuvieramos datos faltantes, calcular algunas estadísticas básicas y graficar las variables para ver cómo se relacionan la Temperatura, las Horas de Operación, la Carga y la Humedad con el Consumo de Energía.

## 1. Análisis Gráfico de Relaciones Cruzadas
![Relacion_Variables](https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Ruth_Turpo/imagenes/Relacion_Variables.png)

## Lo que muestra la imagen:Una matriz de dispersión cruzada (Pairplot) de $5 \times 5$ con histogramas en la diagonal principal que compara todas las variables entre sí.
## Lo que me llamó la atención:
## Permite ver de un solo vistazo cómo se relaciona cada variable con las demás. En la diagonal vemos la forma de la distribución de cada dato (histograma), y en las celdas se aprecia claramente cómo algunas variables muestran un patrón lineal muy marcado frente al Consumo de Energía, mientras que otras están completamente dispersas.
## ¿Por qué es importante?Es una forma visual rápida de detectar linealidad, patrones grupales o distribuciones raras entre todas las variables del dataset antes de modelar.

## 2. Análisis Visual de Variables Predictoras
![Variables Predictoras](https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Ruth_Turpo/imagenes/VariablesPredictorias.png)
## Lo que muestra la imagen:
Una cuadrícula de 4 gráficos de dispersión (Scatter Plots) individuales que evalúan las variables de entrada frente a la variable objetivo (Consumo de Energía).
## Lo que me llamó la atención:
Aquí se confirma visualmente lo que sospechábamos: variables como las Horas de Operación forman una línea diagonal ascendente muy clara (fuerte relación directa con el consumo), mientras que las variables climáticas (Temperatura y Humedad) se ven como una "nube" de puntos sin una tendencia definida.
## ¿Por me importa?
Nos ayuda a confirmar visualmente qué variables tienen una relación lineal real con la variable que queremos predecir y cuáles solo representan ruido.

## 3. Importancia de Variables mediante Árbol de Decisión
![Árbol de Decisión](https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Ruth_Turpo/imagenes/ArbolDecision.png)
## Lo que muestra la imagen:
Un gráfico de barras horizontales que mide la importancia de cada característica (Feature Importance) calculada por un algoritmo de Árbol de Decisión.
## Lo que me llamó la atención:
La barra de Horas de Operación es sobresaliente en comparación con el resto, seguida por la Carga Promedio. Las variables climáticas tienen barras casi imperceptibles.
## ¿Por qué es importante?
Sirve para la selección de variables (feature selection). Nos demuestra cuantitativamente que el modelo le da casi todo el peso a los factores operativos y que podemos descartar el clima sin perder precisión.

## 4. Evaluación Estadística del Modelo (Mínimos Cuadrados Ordinarios - MCO)
![Resultados de la regresión MCO](https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Ruth_Turpo/imagenes/Resultados%20de%20la%20regresi%C3%B3n%20MCO.png)
## Lo que muestra la imagen:
La tabla de salida del resumen del modelo de regresión lineal (OLS Regression Results de statsmodels).
## Lo que me llamó la atención:
Nos entrega las métricas formales del modelo: el coeficiente de determinación ($R^2$), que nos indica qué tan bien explica el modelo la variabilidad del consumo, junto con los coeficientes ($\beta$), errores estándar y los p-values de cada variable.
## ¿Por qué es importante?
Es la validación estadística final del modelo. Nos permite saber formalmente si el modelo es significativo en su conjunto y si cada variable aporta de manera estadísticamente significativa.
Es la validación estadística final del modelo. Nos permite saber formalmente si el modelo es significativo en su conjunto y si cada variable aporta de manera estadísticamente significativa.
