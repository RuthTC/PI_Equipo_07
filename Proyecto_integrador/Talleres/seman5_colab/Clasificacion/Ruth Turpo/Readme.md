# Informe: Análisis mediante Regresión Lineal y Machine Learning

## Introducción

En este informe se presenta el desarrollo y evaluación de modelos de **Inteligencia Artificial (IA) y Machine Learning (Aprendizaje Automático Supervisado)** aplicados al análisis de datos de calidad del aire. El objetivo principal de implementar estas técnicas de Machine Learning es permitir que un modelo algorítmico "aprenda" la relación entre la presencia de contaminantes atmosféricos y el Índice de Calidad del Aire (AQI), prediciendo de manera automática el nivel de riesgo ambiental a partir de mediciones físicas.

Para llevar a cabo este proceso, se utilizó un conjunto de datos real correspondiente al **Monóxido de Carbono (CO)**, recopilado en el Condado de Jefferson, Alabama (área de Birmingham-Hoover) durante los años **2023, 2024 y 2025**, el cual contiene **2,603 registros y 28 variables**.

El trabajo práctico abarcó todo el ciclo de vida de un proyecto de Machine Learning: la exploración de datos con `pandas`, el análisis gráfico de relaciones con `seaborn`, la preparación e ingeniería de variables ($X$ e $y$), la división de la muestra en conjuntos de entrenamiento (**70 %**) y prueba (**30 %**), el entrenamiento del algoritmo de aprendizaje supervisado de Regresión Lineal (`LinearRegression()`), la evaluación de sus predicciones y el diagnóstico de residuos.

Adicionalmente, como pruebas complementarias de IA, se generó un conjunto de datos sintéticos con `make_regression()`, se entrenó un algoritmo de árbol de decisión (`DecisionTreeRegressor`) para evaluar la importancia de las características y el Error Cuadrático Medio (MSE), y se realizó un ajuste analítico por Mínimos Cuadrados Ordinarios (OLS) con `statsmodels` [1], [2].

---

## Metodología

### 1. Exploración del conjunto de datos

Se importó el archivo de datos con **2,603 registros y 28 variables** correspondientes al período **2023–2025**. Para realizar una exploración inicial del conjunto de datos, se utilizaron las funciones de `pandas`: `head()`, `info()` y `describe()`.

```python
df.head()
df.info()
df.describe().round(1)
