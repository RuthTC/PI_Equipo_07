 # Exploración de Datos y Análisis de Consumo de Energía 
      (Análisis de Regresión y Machine Learning)

En esta sesión trabajé con el conjunto de datos `Data_PI_regresion.csv`. El objetivo principal fue realizar un Análisis Exploratorio de Datos (EDA) utilizando Python en Google Colab / Jupyter Notebooks.

Nos enfocamos en cargar la información, verificar que no tuviéramos datos faltantes, calcular las estadísticas cuantitativas clave y graficar las variables para analizar cómo se relacionan la Temperatura, las Horas de Operación, la Carga y la Humedad con el Consumo de Energía.

---

### 1. Análisis Gráfico de Relaciones Cruzadas

![Relacion_Variables](https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Ruth_Turpo/imagenes/Relacion_Variables.png)

* **Lo que muestra la imagen:**  
  Una matriz de dispersión cruzada (*Pairplot*) de $5 \times 5$ con histogramas en la diagonal principal que compara todas las variables entre sí.

* **Lo que me llamó la atención:**  
  Me pareció genial porque me permitió observar de un solo vistazo cómo se relaciona cada variable con las demás. En la diagonal pude analizar la distribución de cada dato (histogramas), y en las celdas noté claramente cómo algunas variables muestran un patrón lineal supermarcado frente al Consumo de Energía, mientras que otras están totalmente dispersas.

* **¿Por qué es importante?**  
  Nos ofrece una forma visual muy rápida e intuitiva para detectar linealidad, patrones grupales o comportamientos atípicos en el dataset antes de construir cualquier modelo.

---

### 2. Análisis Visual de Variables Predictoras

![Variables Predictoras](https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Ruth_Turpo/imagenes/VariablesPredictorias.png)

* **Lo que muestra la imagen:**  
  Una cuadrícula de 4 gráficos de dispersión (*Scatter Plots*) individuales que evalúan las variables de entrada frente a la variable objetivo (*Consumo de Energía*).

* **Lo que me llamó la atención:**  
  Aquí pude confirmar visualmente lo que sospechaba desde el inicio: variables como las **Horas de Operación** forman una línea diagonal ascendente muy clara (demostrando una fuerte relación directa con el consumo), mientras que las variables climáticas (Temperatura y Humedad) se observan como una "nube" de puntos sin una tendencia definida.

* **¿Por qué es importante?**  
  Nos ayuda a confirmar de manera gráfica qué variables guardan una relación lineal real con la variable que queremos predecir y cuáles solo aportan ruido al análisis.

---

### 3. Importancia de Variables mediante Árbol de Decisión

![Árbol de Decisión](https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Ruth_Turpo/imagenes/ArbolDecision.png)

* **Lo que muestra la imagen:**  
  Un gráfico de barras horizontales que mide la importancia de cada característica (*Feature Importance*) calculada por un algoritmo de Árbol de Decisión.

* **Lo que me llamó la atención:**  
  La barra correspondiente a **Horas de Operación** destaca por completo en comparación con las demás, seguida por la **Carga Promedio**. Por el contrario, las variables climáticas muestran barras casi imperceptibles.

* **¿Por qué es importante?**  
  Es fundamental para la selección de variables (*Feature Selection*). Nos demuestra cuantitativamente que el modelo le otorga casi todo el peso a los factores operativos, permitiéndonos descartar las variables climáticas sin perder precisión.

---

### 4. Evaluación Estadística del Modelo (Mínimos Cuadrados Ordinarios - MCO)

![Resultados de la regresión MCO](https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/seman5_colab/Ruth_Turpo/imagenes/Resultados%20de%20la%20regresi%C3%B3n%20MCO.png)

* **Lo que muestra la imagen:**  
  La tabla con el resumen de resultados del modelo de regresión lineal (`OLS Regression Results` de la librería `statsmodels`).

* **Lo que me llamó la atención:**  
  Nos entrega las métricas formales del modelo: el coeficiente de determinación ($R^2$), que nos indica qué tan bien explica el modelo la variabilidad del consumo, junto a los coeficientes ($\beta$), errores estándar y los p-values de cada variable.

* **¿Por qué es importante?**  
  Es la validación estadística final de nuestro trabajo. Nos permite confirmar formalmente si el modelo es significativo en su conjunto y validar si cada variable aporta información valiosa de manera estadísticamente significativa.
