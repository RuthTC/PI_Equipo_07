# Análisis de la concentración diaria de SO₂

## Análisis realizado

En este cuaderno se analizaron datos diarios de dióxido de azufre (SO₂). Primero se revisaron las variables y sus estadísticas descriptivas. Luego se eliminaron los registros con datos faltantes y se elaboraron histogramas, gráficos de dispersión y una matriz de correlación para explorar los datos.

Después se entrenó un modelo de regresión lineal para estimar la concentración máxima diaria de SO₂. Se compararon los valores predichos con los reales, se revisaron los residuos y se calculó el error cuadrático medio (MSE).

## Imagen del código

![División de los datos y entrenamiento del modelo](Captura%20de%20pantalla%202026-09-18%20172741.png)

## Importancia del código

```python
x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.3, random_state=124
)

lm = LinearRegression()
lm.fit(x_train, y_train)
```

La función `train_test_split` separa el 70 % de los datos para entrenar el modelo y el 30 % para evaluarlo. Esto permite comprobar sus predicciones con datos que no utilizó durante el entrenamiento. `random_state=124` hace que la división sea la misma cada vez que se ejecute el cuaderno.

Luego, `LinearRegression()` crea el modelo y `lm.fit(x_train, y_train)` lo entrena para encontrar la relación entre las variables seleccionadas y la concentración de SO₂.
