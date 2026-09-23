# REDES NEURONALES 

## 1. Fundamentos e Infraestructura

Las **Redes Neuronales Convolucionales (CNN)** permiten realizar el análisis de imágenes evaluando píxeles cercanos mediante patrones pequeños. Frente a una red densa tradicional, una CNN presenta dos ventajas principales:

* **Compartición de filtros:** Reduce drásticamente la cantidad de parámetros.
* **Preservación espacial:** Respeta la estructura y topología espacial de la imagen.

Para construir y entrenar nuestros modelos, utilizaremos **PyTorch** como entorno principal.

### 1.1: Componentes Clave Aplicados en el Código

1. **`Conv2D`:** Aplica kernels (por ejemplo, de $3 \times 3$) que recorren la imagen para extraer características fundamentales como bordes, texturas y formas.
2. **`MaxPooling2D`:** Realiza una reducción de escala espacial (por ejemplo, $2 \times 2$), disminuyendo las dimensiones de los mapas de características para optimizar el costo computacional y mitigar el sobreajuste (*overfitting*).
3. **`Flatten` y `Dense`:** Transforma el mapa de características multidimensional a un vector 1D que ingresa a capas densamente conectadas para la clasificación final.

---
![img 1](rutas/a/tu/img1.png)

## 1.2: Preparación de Datos y Clasificación Binaria

Aborda un problema de **clasificación binaria**:

* `0 = glass` (Vidrio)
* `1 = plastic` (Plástico)

El conjunto de datos `TrashDataset` realiza una partición automática de los datos:

* **Entrenamiento (Train):** 70%
* **Validación (Validation):** 15%
* **Prueba (Test):** 15%

> **Nota de Implementación:** La transformación `T.ToTensor()` convierte los valores numéricos originales de la imagen ($0 - 255$) en tensores normalizados con valores continuos dentro del intervalo $[0, 1]$.

Al confirmar que el conjunto contiene únicamente las clases `['glass', 'plastic']`, se establece la naturaleza supervisada del problema. Esto condiciona de forma directa el diseño de la capa final de salida y la selección de la función de pérdida.

---

## 1.3: Visualización y Análisis Exploratorio

A continuación se muestran los ejemplos visuales generados:

| Código de Visualización (img 2) | Resultados Visuales (img 3) |
| :---: | :---: |
| ![Código de visualización](rutas/a/tu/img2.png) | ![Resultados visuales](rutas/a/tu/img3.png) |

### 1.4: Aspectos Técnicos Destacados

1. **Configuración del Modelo:** Al verificar `DataClass.classes` y obtener `['glass', 'plastic']`, se valida el problema binario. La capa final del modelo contendrá 2 salidas y se optimizará mediante la función de pérdida `BCELoss`.
2. **Manejo de Tensores:** La instrucción `x.squeeze(0)` elimina la dimensión de canal para transformar las dimensiones de `(1, H, W)` a `(H, W)`, permitiendo que `matplotlib` represente adecuadamente la imagen en escala de grises.

> ⚠️ **Observación Visual:**
> El vidrio y el plástico presentan una gran similitud visual (formas análogas, transparencias y ausencia de información de color). Este factor representa un desafío alto para la CNN, la cual deberá aprender a extraer patrones muy finos de textura y bordes para discriminar ambas clases.

---

## 1.5: Modelo 1: CNN Desde Cero

![Modelo 1 Architecture](rutas/a/tu/img4.png)

Este código define la arquitectura completa de la CNN desde cero, separando el proceso en dos etapas:
* **`features`:** Extrae bordes y texturas mediante capas convolucionales.
* **`classifier`:** Decide si la imagen pertenece a la clase vidrio o plástico.

### 1.6: Métricas de Evaluación

* **Accuracy:** Mide el porcentaje general de aciertos.
* **ROC-AUC:** Mide la capacidad del modelo para separar ambas clases.
* **Matriz de Confusión, Precision, Recall y F1-Score:** Permiten evaluar la precisión real del modelo frente a posibles desbalances de datos entre vidrio y plástico.

---

## 1.7: Curvas de Entrenamiento y Diagnóstico

![Curvas de entrenamiento](rutas/a/tu/img5.png)

### Análisis del Código de Graficación

```
plt.plot(history_scratch["train_loss"]) # Grafica el error que comete la red durante el entrenamiento
plt.plot(history_scratch["val_acc"])    # Rendimiento sobre datos nuevos de validación (Accuracy)
plt.plot(history_scratch["val_auc"])    # Rendimiento sobre datos nuevos de validación (ROC-AUC)
## 5. Curvas de Entrenamiento

| Gráfica 1: Pérdida (img 6) | Gráfica 2: Métricas (img 7) |
| :---: | :---: |
| ![img 6](rutas/a/tu/img6.png) | ![img 7](rutas/a/tu/img7.png) |

```
### Gráfica 1: Pérdida de Entrenamiento
* **¿Qué significa?** La "pérdida" mide cuántos errores comete el modelo.
* **Resultado:** La línea va hacia abajo en cada época (de ~0.697 a ~0.672).
* **Conclusión:** Es una buena señal; indica que la red está aprendiendo y ajustando sus parámetros paso a paso.

### Gráfica 2: Métricas de Validación (Accuracy y ROC-AUC)
* **Accuracy (Azul - Aciertos):** Al inicio es baja y plana (~50%, equivalente a adivinar al azar). A partir de la época 4 sube y alcanza un 63.27%.
* **ROC-AUC (Naranja - Capacidad de separar clases):** Se mantiene estable entre 0.67 y 0.70. Significa que la red diferencia razonablemente bien entre vidrio y plástico.

---

## 1.8: Matriz de confusion

![img 8](rutas/a/tu/img8.png)

* `plt.imshow(cm)`: Muestra la matriz de confusión como una gráfica de colores para comparar las predicciones del modelo frente a los datos reales.
* `plt.title(...)`, `plt.xlabel(...)`, `plt.ylabel(...)`: Añaden el título "Matriz de confusión (CNN desde cero)" y etiquetan los ejes horizontal (lo que predijo el modelo) y vertical (lo que era en realidad).
* `plt.colorbar()`: Agrega la barra lateral de color que indica qué número representa cada tono (amarillo para valores altos y morado para valores bajos).
* `plt.show()`: Renderiza el gráfico en pantalla.

![img 9](rutas/a/tu/img9.png)

#### Aciertos (Diagonal Principal):
* **68 en Vidrio (0,0):** De las imágenes que eran vidrio, predijo correctamente 68.
* **14 en Plástico (1,1):** De las imágenes que eran plástico, predijo correctamente solo 14.

#### Errores (Fuera de la Diagonal):
* **8 (0,1):** Eran vidrio pero la red dijo que eran plástico.
* **59 (1,0):** Eran plástico pero la red se equivocó diciendo que eran vidrio.

El modelo tiene un fuerte sesgo hacia la clase Vidrio (0). Clasifica muy bien el vidrio (68 de 76 acertados), pero falla gravemente con el plástico, confundiendo la mayoría (59 de 73) como si fuera vidrio. Esto explica por qué el rendimiento general es bajo y demuestra que la red necesita ajustes o más muestras para aprender a distinguir el plástico.
## 1.9: Aumento de Datos y Aprendizaje por Transferencia

Para solucionar los problemas observados en el modelo base (como el sesgo en la matriz de confusión y la alta similitud entre clases), implementamos dos técnicas clave de mejora:

* **Data Augmentation:** Modifica ligeramente las imágenes durante el entrenamiento para enseñarle a la red a reconocer el objeto sin importar su inclinación o posición. Por ejemplo, `T.RandomRotation(degrees=10)` rota aleatoriamente la imagen hasta 10 grados para que el modelo no se memorice una sola postura.
* **Transfer Learning:** Consiste en no empezar desde cero, sino "heredar" el conocimiento de **ResNet-18**, una red preentrenada con millones de imágenes:

```
resnet = models.resnet18(weights=models.ResNet18_Weights.DEFAULT)

```
* **Resize((224, 224)):** Redimensiona las imágenes a $224 \times 224$ píxeles, que es el tamaño estándar obligatorio que exige ResNet-18.
* **RandomRotation y RandomAffine:** Aplican rotaciones y pequeños desplazamientos (5% horizontal y vertical) solo al conjunto de entrenamiento para evitar el sobreajuste.
* **Lambda(lambda x: x.repeat(3, 1, 1)):** Punto clave. Como nuestras imágenes están en escala de grises (1 canal), duplicamos ese canal 3 veces para simular una imagen RGB (3 canales), ya que ResNet-18 fue diseñada para procesar color.
* **transform_tl_eval:** Para validación y prueba no aplicamos transformaciones aleatorias; solo ajustamos el tamaño, convertimos a tensor y adaptamos a 3 canales para medir el rendimiento real.

```
train_dataset_tl = DataClass(root=DATA_DIR, split="train", transform=transform_tl_train)
val_dataset_tl = DataClass(root=DATA_DIR, split="val", transform=transform_tl_eval)
test_dataset_tl = DataClass(root=DATA_DIR, split="test", transform=transform_tl_eval)

train_loader_tl = DataLoader(train_dataset_tl, batch_size=64, shuffle=True, num_workers=2, pin_memory=True)
val_loader_tl = DataLoader(val_dataset_tl, batch_size=64, shuffle=False, num_workers=2, pin_memory=True)
test_loader_tl = DataLoader(test_dataset_tl, batch_size=64, shuffle=False, num_workers=2, pin_memory=True)
```
* **¿Qué hace?** Toma el primer lote de imágenes del cargador de entrenamiento y revisa su forma (shape).
* **Resultado esperado:** Retorna un tensor de dimensión `[64, 3, 224, 224]`, confirmando que tenemos 64 imágenes por lote, con 3 canales de color y una resolución de $224 \times 224$, listas para entrar a ResNet-18.

 ## 2. Clasificación binaria con Keras

### Introducción y Carga de Datos

```
from keras.datasets import imdb
from keras import models, layers, optimizers

(train_data, train_labels), (test_data, test_labels) = imdb.load_data(num_words=10000, index_from=3)
```
Aquí pasamos de clasificar imágenes a clasificar texto (reseñas de películas de IMDB para saber si son positivas o negativas). Con `num_words=10000` nos quedamos solo con las 10,000 palabras más frecuentes, ignorando las muy raras para simplificar el análisis.

* **Tipo de Problema:** Clasificación binaria de texto ($N = 2$ clases: 0 = negativa, 1 = positiva).
* **Filtrado de Vocabulario:** Limitar a 10,000 palabras reduce la dimensionalidad del problema y evita trabajar con tensores gigantes e innecesarios.

### 2.2: Vectorización (One-Hot Encoding)

```
def vectorizar(sequences, dim=10000):
    results = np.zeros((len(sequences), dim))
    for i, sequence in enumerate(sequences):
        results[i, sequence] = 1.
    return results
```
Las redes neuronales no entienden palabras directas ni listas de números enteros. Esta función transforma cada reseña en una lista fija de 10,000 ceros y unos: marca un 1 si la palabra aparece en la reseña y un 0 si no está.

* **Preprocesamiento:** Convierte secuencias de enteros de longitud variable en tensores de entrada bidimensionales de tamaño fijo (muestras, 10000).
* **Representación:** Crea una matriz dispersa (bag of words) lista para ser consumida por capas totalmente conectadas (Dense Layers).

### 2.3: Creación del Modelo (Sequential)

```
model = models.Sequential()
model.add(layers.Dense(16, activation='relu', input_shape=(10000,)))
model.add(layers.Dense(16, activation='relu'))
model.add(layers.Dense(1, activation='sigmoid'))

model.compile(optimizer='rmsprop',
              loss='binary_crossentropy',
              metrics=['accuracy'])
```
Construimos la red capa por capa: dos capas ocultas de 16 neuronas para aprender los patrones del texto, y una capa final de 1 sola neurona con activación sigmoid para que nos dé una probabilidad entre 0 y 1 (cerca de 1 es positiva, cerca de 0 es negativa).

* **Arquitectura:** Red Densa Multicapa (MLP). Usa ReLU en las capas ocultas para introducir no-linealidad.
* **Capa de Salida:** Una única neurona con sigmoid ideal para estimar la probabilidad $P(Y=1\vert{}X)$.
* **Compilación:** Usa la función de pérdida `binary_crossentropy` (la norma para clasificación binaria) y el optimizador `rmsprop`.

### 2.4: Análisis de las Curvas de Entrenamiento

```
plt.plot(epoch, loss_values, '.-', label='training')
plt.plot(epoch, val_loss_values, '--', label='val')
plt.legend()
plt.show()
```
Graficamos la pérdida del entrenamiento frente a la de validación para ver si la red está aprendiendo bien o si se está "memorizando" los datos.
Diagnóstico de Sobreajuste (Overfitting): Si la línea de entrenamiento (training) sigue bajando pero la de validación (val) empieza a subir a partir de ciertas épocas, indica que el modelo memorizó las reseñas de entrenamiento y perdió capacidad de generalizar sobre datos nuevos.
Toma de Decisiones: Ayuda a determinar la época exacta para aplicar Early Stopping (detener el entrenamiento antes de que empiece a sobreajustar).
![img 10](rutas/a/tu/img10.png)

Azul: error del modelo en entrenamiento.
Anaranjado: error sobre datos de validación.
La curva anaranjada no cae al final → sobreajuste: la red aprende demasiado bien los datos de entrenamiento y pierde capacidad de generalización.
Resultado en test: nivel de error 0.6, exactitud 86.1%.
Comparación con un Modelo Más Pequeño (model2)
codigo:
```
model2 = models.Sequential()
model2.add(layers.Dense(4, activation='relu', input_shape=(10000,)))
model2.add(layers.Dense(1, activation='sigmoid'))

```
Aquí reducimos drásticamente la capacidad de la red: pasamos de 2 capas ocultas de 16 neuronas a 1 sola capa oculta de solo 4 neuronas. La idea es ver si un modelo más simple es suficiente para aprender las palabras clave o si se queda demasiado "corto" para entender el texto.

*(subida como img 11)*

![img 11](rutas/a/tu/img11.png)

* Con la muestra original hubo sobreajuste.
* Con el modelo más chico, el mínimo de pérdida se mantiene más épocas y el incremento posterior es menor. Sigue habiendo sobreajuste, pero menos pronunciado.

### Regularización

```
from keras import regularizers

model3.add(layers.Dense(16, activation='relu', kernel_regularizer=regularizers.l2(0.001)))
```
Aquí le ponemos un "freno" a la red. La regularización L2 castiga a la neurona si sus pesos se vuelven demasiado grandes o exagerados al memorizar palabras específicas. El valor 0.001 es la fuerza de esa penalización: obliga a la red a mantener sus pesos pequeños y distribuidos de forma más pareja.

![img 12](rutas/a/tu/img12.png)

Durante el entrenamiento se apagan aleatoriamente el 50% de las neuronas. Esto obliga a la red a aprender de diferentes combinaciones de neuronas, para reducir el sobreajuste.
### 2.5: Predicciones

```
predictions = model.predict(x_test)
```
La predicción del índice 10 dio **99.4%**: reseña positiva con un 99.4% de probabilidad.

* **Qué se aprendió:** cómo armar una red densa simple con Keras y, sobre todo, cómo detectar y reducir el sobreajuste con distintas técnicas (modelo más chico, regularización, dropout).


  ## 3. PERCEPTRÓN

Modelo sencillo de IA que recibe datos, los combina con pesos y produce una salida (predicción).

```
def step_function(x):
    return 1 if x >= 0 else 0

def tanh_activation(x):
    return np.tanh(x)

def perceptron(inputs, weights, bias, activation_func):
    weighted_sum = np.dot(inputs, weights) + bias
    return activation_func(weighted_sum)
```
### Ejemplo: Sobrecalentamiento de un equipo industrial

```
temperatura = 100
vibracion = 50
weights = np.array([0.5, -0.5])
bias = -30
inputs = np.array([temperatura, vibracion])

output_step = perceptron(inputs, weights, bias, step_function)
output_tanh = perceptron(inputs, weights, bias, tanh_activation)
```
Aquí va la salida impresa con los resultados de `output_step` y `output_tanh`:

* **Paso a paso del cálculo:** La suma ponderada es negativa $\rightarrow$ la función escalón da 0.
* **Comportamiento Tanh:** La función `tanh` transforma cualquier valor dejándolo en el rango $[-1, 1]$.
* **Conclusión:** La función de activación transforma la suma ponderada en la salida que usa la neurona para decidir.

### Perceptrón tipo AND, OR y XOR

```
def test_perceptron(inputs, weights, bias, activation_func):
    for p, q in [(0, 0), (0, 1), (1, 0), (1, 1)]:
        input_data = np.array([p, q])
        prediction = perceptron(input_data, weights, bias, activation_func)
        print(f'Entradas: ({p}, {q}), Predicción: {prediction}')
```
* **AND** (pesos `[0.4, 0.4]`, bias `-0.5`): da 1 solo cuando ambas entradas son 1.
* **OR** (pesos `[2, 1]`, bias `-0.5`): da 1 cuando al menos una entrada es 1.
* **XOR**: da 1 cuando las entradas son diferentes.

| AND | OR | XOR |
| :---: | :---: | :---: |
| ![img 13](rutas/a/tu/img13.png) | ![img 14](rutas/a/tu/img14.png) | ![img 15](rutas/a/tu/img15.png) |

### Lógica Booleana en el Perceptrón (AND, OR y XOR)

Es como trazar una línea recta en un plano. Con la puerta OR puedes dibujar una sola línea que deje el $(0,0)$ de un lado y los demás puntos del otro. Con el AND pasa lo mismo: una recta separa el $(1,1)$ del resto. Pero con XOR es imposible trazar una sola línea recta que separe los aciertos de los errores, porque los puntos están cruzados en diagonal. Por eso un solo perceptrón falla y necesitamos combinar varios en capas.
* **Separabilidad Lineal:** Un perceptrón simple actúa como un hiperplano de decisión ($w_1 x_1 + w_2 x_2 + b = 0$). Funciones como AND y OR son linealmente separables, por lo que un perceptrón basta para resolverlas.
* **El Problema del XOR:** El problema de XOR no es linealmente separable. Ninguna combinación de pesos $w$ y sesgo $b$ en una sola ecuación lineal puede separar las entradas $(0,1)$ y $(1,0)$ de $(0,0)$ y $(1,1)$.
* **Solución Multicapa (MLP):** Para resolver XOR se requiere proyectar los datos a un espacio de mayor dimensión donde sí sean separables. Esto se logra usando una capa oculta (mínimo 2 perceptrones que actúan como detectores de características) más una capa de salida que combina sus resultados.

### Cómo se aplicaría esto al proyecto Compostech

En esta etapa evaluamos las redes neuronales profundas y Keras, pero descartamos las CNN porque no vamos a trabajar con cámaras ni análisis visual. Compostech recolecta información directamente de sensores IoT que miden temperatura, humedad, gases y lixiviados, lo que genera una base de datos puramente numérica y tabular.

Viendo el tipo de datos que manejamos, resulta más adecuado aplicar algoritmos de Machine Learning como Random Forest, Gradient Boosting o XGBoost. Con estos modelos podemos predecir la calidad o la fase del compost a partir de las variaciones que detectan los sensores, sin complicar la arquitectura del sistema con redes neuronales que no se ajustan a nuestro tipo de entrada.

### Implementación de Machine Learning
#### Paso 1: Carga y Almacenamiento de Datos

* **En el ejemplo:** el archivo CSV se lee con `df_humedad = pd.read_csv('relative_humidity_daily_aqs_data.csv')`.
* **En nuestro proyecto:** Los 4 sensores enviarán lecturas periódicas a una base de datos (por ejemplo, Firebase, PostgreSQL o ThingSpeak), que luego exportarás o consumirás como un dataframe.

```
import pandas as pd

# Simulación de lectura de datos de tu compostera
# Columnas: Fecha, Temperatura (°C), Humedad (%), Gases (ppm), Lixiviados (pH)
df = pd.read_csv('datos_compostera.csv')
df.head()
```
#### Paso 2: Limpieza y Preprocesamiento (EDA)

* **En el ejemplo:** Usaste `df.info()` y `df.describe()` para ver valores nulos y promedios.
* **En tu proyecto real:** Sirve para detectar fallas en sensores (por ejemplo, si la humedad marca $0\%$ por un fallo eléctrico o valores atípicos fuera de rango).

```
# Verificación de datos nulos o errores de lectura
print(df.info())

# Estadísticas básicas para saber los rangos promedio de tus sensores
print(df.describe())
```
#### Paso 3: Análisis de Correlación y Patrones

* **En el ejemplo:** Generaste el gráfico `sns.pairplot(df)` para relacionar $AQI$ con la concentración de $Humedad$.
* **En tu proyecto real:** Te permite entender cómo interactúan los parámetros. Por ejemplo: ¿Cuando sube la temperatura, disminuye la humedad? ¿Aparecen gases si los lixiviados se acumulan?

```
import seaborn as sns

# Visualizar la relación entre Temperatura, Humedad, Gases y Lixiviados
sns.pairplot(df[['Temperatura', 'Humedad', 'Gases', 'Lixiviados']])
```
#### Paso 4: Entrenamiento del Modelo de Machine Learning

Usarás un modelo de Clasificación (ej. Random Forest) para predecir el Estado del Compost (Óptimo, Falta Aireación, Exceso de Agua, Crítico):

```
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

# Variables de entrada (X): Lecturas de los 4 sensores
X = df[['Temperatura', 'Humedad', 'Gases', 'Lixiviados']]

# Variable objetivo (y): Estado asignado por un experto o regla de calidad
y = df['Estado_Compost'] 

# División de datos de entrenamiento y prueba
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Entrenar el modelo
modelo = RandomForestClassifier()
modelo.fit(X_train, y_train)
```
### 3. Arquitectura de Salida: Pantalla LCD y Aplicación Móvil

Para hacer la compostera realmente "inteligente" e interactiva con el usuario, la información procesada por el modelo se mostrará en dos interfaces complementarias:

![img 16](rutas/a/tu/img16.png)

#### A. Pantalla LCD / OLED (Ubicada físicamente en la Compostera)
Muestra la información de primera necesidad en tiempo real mediante mensajes directos y notas simples:
* **Lecturas rápidas:** Temp: $55^\circ\text{C}$ | Hum: $50\%$.
* **Nota de Estado:** "Fase Termófila — Todo Correcto".
* **Alertas directas (Expresiones cortas):**
  * ⚠️ *"Mezclar compost: Alta concentración de gases."*
  * 💧 *"Agregar materia seca: Exceso de lixiviados/humedad."*

#### B. Aplicación Móvil (Vía Wi-Fi / Bluetooth)
Brinda un análisis profundo, gráfico e instruccional para el usuario:
* **Gráficos Históricos:** Evolución de la temperatura y humedad a lo largo de las semanas.
* **Predicción de Madurez:** "Su compost estará listo en 12 días con la calidad esperada".
* **Guía de Acciones y Asistente:** Pasos claros para mantener el compost (ej. *"Añadir 200g de hojas secas hoy"*).
* **Notificaciones Push:** Avisos al celular si un parámetro entra en nivel crítico.

