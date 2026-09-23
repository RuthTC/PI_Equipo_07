
# Redes Neuronales: CNN, Keras y Perceptrón

## CNN (Red Neuronal Convolucional)

Una **CNN** es un tipo de red neuronal diseñada principalmente para trabajar con **imágenes**. Aprende automáticamente características como bordes, formas y texturas.

**¿Para qué sirve?**

Se utiliza principalmente para **reconocer y clasificar imágenes**, detectar objetos o identificar patrones visuales. En este trabajo se aplica para diferenciar imágenes de **vidrio y plástico**.

## Keras

**Keras** es una herramienta que permite **crear, entrenar y evaluar redes neuronales** de una manera más sencilla.

**¿Para qué sirve?**

Facilita la construcción de modelos de aprendizaje profundo, permitiendo agregar capas, funciones de activación y métodos para mejorar el entrenamiento. En este trabajo se utiliza para realizar **clasificación de reseñas**.

## Perceptrón

El **perceptrón** es uno de los modelos más básicos de una red neuronal. Recibe diferentes datos de entrada, les asigna pesos y genera una salida.

**¿Para qué sirve?**

Se utiliza principalmente para realizar **clasificaciones o decisiones sencillas**. En este trabajo se aplica a un ejemplo de **detección de sobrecalentamiento mediante temperatura y vibración**.

# CNN

## Código importante

![Código CNN](Captura%20de%20pantalla%202026-09-22%20213736.png)

## Importancia y función del código

Este código permite seleccionar una imagen del conjunto de prueba y analizar la predicción realizada por la CNN mediante **Grad-CAM**.

La línea más importante es:

`cam, pred_class = grad_cam(resnet, x)`

Esta línea aplica Grad-CAM al modelo ResNet. `cam` genera un mapa de calor que muestra las zonas de la imagen que más influyeron en la decisión, mientras que `pred_class` indica la clase predicha por el modelo.

Su importancia está en que permite conocer la predicción de la CNN y visualizar qué partes de la imagen fueron más importantes para tomar esa decisión.

## Resultado obtenido

![Resultado Grad-CAM](Captura%20de%20pantalla%202026-09-22%20213751.png)

## Interpretación

La imagen presenta tres resultados: la **imagen original**, el **mapa Grad-CAM** y la **superposición**.

La primera corresponde a la imagen que se proporciona al modelo y tiene una etiqueta real igual a `0`.

La segunda corresponde al mapa **Grad-CAM**. Las zonas amarillas y verdes muestran las regiones que tuvieron mayor influencia en la decisión de la CNN. En este caso, el modelo obtuvo una predicción igual a `0`, por lo que coincide con la etiqueta real.

La tercera imagen corresponde a la **superposición** del mapa Grad-CAM sobre la imagen original. Se observa que el modelo concentra principalmente su atención en la zona central del objeto.

Esto permite identificar visualmente qué partes de la imagen fueron más importantes para que la CNN realizara su clasificación.

# Keras

## Código importante

![Código Keras](Captura%20de%20pantalla%202026-09-22%20215545.png)

## Importancia y función del código

Este código permite comparar el comportamiento del modelo durante el entrenamiento y la validación mediante los valores de pérdida (`loss`).

Las líneas más importantes son:

`loss_values = modelb_dict['loss']`

`val_loss_values3 = modelb3.history['val_loss']`

Estas líneas obtienen la pérdida durante el entrenamiento y la pérdida durante la validación. Posteriormente, estos valores se representan en una gráfica para observar cómo cambia el error a medida que avanzan las épocas.

La importancia de este código está en que permite identificar si el modelo está aprendiendo correctamente o si presenta **sobreajuste (overfitting)**. También permite comparar el comportamiento del modelo original con el modelo al que se aplicó regularización.

## Resultado obtenido

![Resultado Keras](Captura%20de%20pantalla%202026-09-22%20215633.png)

## Interpretación

El gráfico muestra el comportamiento de la pérdida durante 20 épocas.

La línea azul (`regularization - train`) representa la pérdida durante el entrenamiento. Esta disminuye progresivamente, lo que indica que el modelo aprende cada vez mejor los datos utilizados para entrenarlo.

La línea naranja (`regularization - validation`) representa la pérdida de validación del modelo con regularización. Inicialmente disminuye, pero después comienza a aumentar.

La línea verde discontinua (`original`) corresponde a la pérdida de validación del modelo original. También disminuye al inicio y posteriormente aumenta de manera más pronunciada.

Esto indica la presencia de **sobreajuste**, porque mientras el error de entrenamiento continúa disminuyendo, el error de validación comienza a aumentar. La gráfica también permite comparar cómo la regularización modifica el comportamiento del modelo frente a datos que no fueron utilizados directamente para entrenarlo.

# Perceptrón

## Código importante

![Resultado Perceptrón](Captura%20de%20pantalla%202026-09-22%20220146.png)

## Importancia y función del código

Este código permite representar gráficamente las fronteras de decisión de las compuertas lógicas **AND y OR**, mostrando cómo un perceptrón puede separar diferentes grupos de datos.

Una de las líneas más importantes que aparece en el código es:

`plt.plot([0, 1.5], [1.5, 0], 'g-', linewidth=2)`

Esta línea dibuja la frontera de decisión correspondiente a la compuerta **AND**. Permite separar el punto `(1,1)` de los demás puntos.

También se utiliza:

`plt.plot([-0.3, 0.5], [0.5, -0.3], 'r-', linewidth=2)`

Esta línea representa la frontera de decisión de la compuerta **OR**, separando el punto `(0,0)` de los demás.

La importancia de este código está en que permite visualizar cómo un perceptrón puede utilizar una **frontera de decisión lineal** para clasificar datos.

## Resultado obtenido

![Código Perceptrón](Captura%20de%20pantalla%202026-09-22%20220052.png)

## Interpretación

El gráfico representa las cuatro combinaciones posibles de dos entradas binarias: `(0,0)`, `(0,1)`, `(1,0)` y `(1,1)`.

La línea verde representa la frontera de decisión de **AND**. Esta separa el punto `(1,1)` de los demás, ya que AND solamente tiene una salida igual a 1 cuando ambas entradas son 1.

La línea roja representa la frontera de decisión de **OR**. Esta separa el punto `(0,0)` de los demás, debido a que OR tiene una salida igual a 1 cuando al menos una de las entradas es 1.

El gráfico demuestra que los problemas **AND y OR son linealmente separables**, por lo que pueden ser resueltos mediante un perceptrón.
# Aplicación de Machine Learning en ComposTec

## Importancia del Machine Learning

El Machine Learning será importante en ComposTec porque permitirá utilizar los datos obtenidos por los sensores para conocer y predecir el estado del proceso de compostaje.

En lugar de limitarse a mostrar valores de temperatura, humedad y gases, el sistema podrá aprender de los datos registrados e identificar patrones que indiquen si el compostaje se está desarrollando adecuadamente o si necesita alguna intervención.

## ¿Cómo se utilizará en el proyecto?

Los sensores recopilarán continuamente datos como **temperatura, humedad y concentración de gases**. Estos datos serán almacenados y utilizados como variables de entrada para entrenar un modelo de Machine Learning.

El modelo podrá utilizarse para:

- Clasificar el estado del compostaje según las condiciones registradas.
- Detectar condiciones anormales durante el proceso.
- Predecir cuándo las condiciones podrían dejar de ser adecuadas.
- Generar alertas cuando sea necesaria una intervención.
- Apoyar decisiones como la activación del sistema de riego cuando las condiciones lo requieran.

De esta manera, Machine Learning permitirá que ComposTec evolucione de un sistema que únicamente **monitorea variables** a uno capaz de **analizar los datos y apoyar la toma de decisiones durante el proceso de compostaje**.
