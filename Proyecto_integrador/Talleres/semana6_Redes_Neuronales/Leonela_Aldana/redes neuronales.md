
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

![Código CNN](images/Captura%20de%20pantalla%202026-09-22%20190540.png)

## Importancia y función del código

Este código permite seleccionar una imagen del conjunto de prueba y analizar la predicción realizada por la **CNN mediante Grad-CAM**.

La línea más importante es:

`cam, pred_class = grad_cam(resnet, x)`

Esta línea aplica **Grad-CAM al modelo ResNet**. `cam` genera el mapa de calor que muestra las zonas de la imagen que más influyeron en la decisión, mientras que `pred_class` indica la clase predicha por el modelo.

Este código es importante porque permite conocer la clasificación realizada por la CNN y también **visualizar qué partes de la imagen utilizó el modelo para tomar su decisión**.

## Resultado obtenido

![Resultado Grad-CAM](images/Captura%20de%20pantalla%202026-09-22%20183358.png)

## Interpretación

La primera imagen corresponde al residuo analizado y tiene una **etiqueta real igual a 0 (`label=0`)**.

La segunda imagen corresponde al **Grad-CAM**. Las zonas amarillas y verdes representan las regiones que tuvieron mayor influencia en la decisión de la CNN.

El modelo obtuvo una **predicción igual a 0 (`pred=0`)**, por lo que la predicción coincide con la etiqueta real.

La tercera imagen muestra la **superposición** del Grad-CAM sobre la imagen original. Se observa que el modelo concentra principalmente su atención en la zona central del objeto.

Esto permite identificar visualmente **qué partes de la imagen fueron importantes para que la CNN realizara su clasificación**.
