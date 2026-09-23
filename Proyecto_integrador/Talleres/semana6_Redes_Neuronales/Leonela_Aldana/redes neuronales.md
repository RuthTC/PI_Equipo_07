# Redes Neuronales: CNN, Keras y Perceptrón

## 🧠 CNN (Red Neuronal Convolucional)

Una **CNN** es un tipo de red neuronal diseñada principalmente para trabajar con **imágenes**. Aprende automáticamente características como bordes, formas y texturas.

**¿Para qué sirve?**  
Se utiliza principalmente para **reconocer y clasificar imágenes**, detectar objetos o identificar patrones visuales. En este trabajo se aplica para diferenciar imágenes de **vidrio y plástico**.

---

## ⚙️ Keras

**Keras** es una herramienta que permite **crear, entrenar y evaluar redes neuronales** de una manera más sencilla.

**¿Para qué sirve?**  
Facilita la construcción de modelos de aprendizaje profundo, permitiendo agregar capas, funciones de activación y métodos para mejorar el entrenamiento. En este trabajo se utiliza para realizar **clasificación de reseñas**.

---

## 🔵 Perceptrón

El **perceptrón** es uno de los modelos más básicos de una red neuronal. Recibe diferentes datos de entrada, les asigna pesos y genera una salida.

**¿Para qué sirve?**  
Se utiliza principalmente para realizar **clasificaciones o decisiones sencillas**, especialmente cuando los datos pueden separarse linealmente. En este trabajo se aplica a un ejemplo de **detección de sobrecalentamiento mediante temperatura y vibración**.


## 🧠 CNN — Red Neuronal Convolucional

### 💻 Código importante

![Código CNN](images/Captura%20de%20pantalla%202026-09-22%20190540.png)

### Importancia y función del código

Este código permite seleccionar una imagen del conjunto de prueba y analizar la predicción realizada por la **CNN mediante Grad-CAM**.

La línea más importante es:

`cam, pred_class = grad_cam(resnet, x)`

Esta línea aplica **Grad-CAM al modelo ResNet** para obtener dos resultados:

- `cam`: genera un mapa de calor que indica qué zonas de la imagen tuvieron mayor influencia en la decisión del modelo.
- `pred_class`: indica la clase que la red neuronal predijo.

Su importancia radica en que permite no solo conocer la clasificación realizada por la CNN, sino también **interpretar qué partes de la imagen utilizó el modelo para tomar esa decisión**.

---

### 📊 Resultado obtenido

![Resultado Grad-CAM](images/Captura%20de%20pantalla%202026-09-22%20183358.png)

### Interpretación

La primera imagen corresponde al residuo que se proporciona al modelo y presenta una **etiqueta real igual a 0 (`label=0`)**.

En la segunda imagen, **Grad-CAM** representa mediante un mapa de calor las regiones que tuvieron mayor influencia en la predicción. Las zonas más claras, especialmente las amarillas y verdes, indican una mayor importancia para la decisión de la CNN.

El modelo obtuvo una **predicción igual a 0 (`pred=0`)**, por lo que en este ejemplo la predicción coincide con la etiqueta real.

Finalmente, la **superposición** combina la imagen original con el mapa Grad-CAM. Se observa que la red concentra principalmente su atención en la **zona central del objeto**, indicando que las características presentes en esta región fueron relevantes para realizar la clasificación.

Por lo tanto, Grad-CAM permite comprender visualmente **en qué partes de la imagen se basó la CNN para realizar su predicción**.
