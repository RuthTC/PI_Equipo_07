#  Identificación Visual mediante  Redes Neuronales Artificiales
Las Redes Neuronales Artificiales (RNA) son modelos computacionales de aprendizaje automático inspirados en la estructura y el funcionamiento del cerebro biológico humano. Están diseñadas para reconocer patrones complejos, procesar información masiva y tomar decisiones de manera autónoma a partir de datos no estructurados, como imágenes, vídeos o texto.
Su importancia radica en su capacidad de aprendizaje no lineal y generalización. A diferencia de la programación tradicional basada en reglas rígidas, las redes neuronales pueden aprender directamente de los datos, ajustando sus parámetros internos (pesos y sesgos) para resolver problemas altamente complejos que antes requerían exclusivamente la intervención humana.

### Aplicación práctica en nuestro contexto (COMPOST-IoT)

Como estudiantes de ingeniería industrial estas herramientas permiten automatizar tareas críticas como la inspección visual, el control de calidad y la clasificación automatizada, reemplazando la segregación manual por sistemas inteligentes más precisos, seguros y eficientes.

Orientándonos específicamente al proyecto **COMPOST-IoT** (sistema automatizado de compostaje), la implementación de redes neuronales nos ayuda a resolver un problema operativo clave: la detección y separación oportuna de agentes contaminantes inorgánicos  mezclados en la materia orgánica. Ayudar en este contexto significa:

*   **Garantizar la calidad del sustrato:** Evita que elementos tóxicos o no biodegradables arruinen el proceso de descomposición aeróbica.
*   **Optimizar los parámetros biológicos:** Asegura un abono orgánico limpio y de alta calidad alineado con los Objetivos de Desarrollo Sostenible.
*   **Reducir pérdidas operativas:** Automatiza la pre-clasificación de residuos de manera rápida, minimizando errores humanos y maximizando la eficiencia de la planta de compostaje.

---
## 1. Método CNN (Convolutional Neural Networks)

Las Redes Neuronales Convolucionales (CNN) son arquitecturas avanzadas de aprendizaje profundo diseñadas específicamente para el procesamiento y análisis de datos con estructura de cuadrícula, como las imágenes. Su funcionamiento se basa en la aplicación de filtros locales (*kernels*) que se desplazan sobre la matriz de píxeles, permitiendo capturar patrones espaciales y relaciones de vecindad independientemente de la posición del objeto dentro del encuadre visual.

A diferencia de las redes neuronales densas o tradicionales, las CNN preservan la correlación espacial bidimensional y reducen notablemente el número de parámetros computacionales mediante el uso de pesos compartidos.

### 1.1 Componentes y etapas principales del método

El método comprende una secuencia estructurada de procesamiento dividida en los siguientes bloques:

*   **Convolución (Conv2D):** Aplica operaciones de filtrado para generar mapas de características que identifican desde bordes o texturas simples hasta figuras geométricas complejas.
*   **Activación no lineal (ReLU):** Introduce no linealidad transformando valores negativos a cero y manteniendo los positivos, permitiendo modelar dinámicas complejas.
*   **Submuestreo (MaxPool2D):** Reduce las dimensiones espaciales de los mapas de características, minimizando la carga computacional y aportando invarianza frente a traslaciones leves.
*   **Capas Densas (Fully-Connected):** Integran los vectores de características aplanados para computar la probabilidad de pertenencia a cada clase.
*   **Técnicas de optimización:** Incorpora *Data Augmentation* para robustecer la generalización y *Transfer Learning* (mediante modelos como ResNet18) para transferir representaciones  visuales preentrenadas   ante conjuntos de datos acotados.
  
### 1.2. Resultados y resumen del taller

Antes de entrenar cualquier modelo, primero se preparó el entorno de trabajo. Para este taller se utilizó PyTorch, ya que es un framework que permite construir y entrenar redes neuronales con amplio control sobre cada capa y sobre los gradientes automáticos:

```python
packages = [
    "torch", "torchvision", "numpy",
    "matplotlib", "scikit-learn", "tqdm", "pillow"
]
```
Para implementar el flujo de trabajo, se importaron las librerías necesarias: torch y torchvision para el modelado neuronal y las transformaciones de tensores; numpy para el cálculo numérico; matplotlib.pyplot para la visualización gráfica de imágenes y curvas de rendimiento; tqdm para el seguimiento del progreso de cómputo por época; y scikit-learn junto con pillow para el soporte en la carga de imágenes y el análisis de métricas.

Para trabajar con imágenes se utilizó el dataset TrashNet, que contiene fotografías de distintos tipos de residuos. Para este ejercicio solo se usaron dos clases: vidrio (etiqueta 0) y plástico (etiqueta 1). A través del módulo trash_dataset.py, las muestras se dividieron en conjuntos de entrenamiento (70%), validación (15%) y prueba (15%) utilizando una semilla aleatoria (seed=42) para mantener la estratificación de los datos. Además, las imágenes se convirtieron a escala de grises para adaptarse a la entrada monocanal de la CNN y se transformaron a tensores numéricos para que PyTorch pudiera procesar la información:
```python
transform_basic = T.Compose([
    T.ToTensor()  # Convierte la imagen en un tensor
])
```
También se configuraron los DataLoaders para organizar las imágenes en lotes (batches) y mezclarlas aleatoriamente, definiendo la ejecución sobre la GPU para procesar las operaciones matriciales en paralelo y reducir los tiempos de entrenamiento. Con el entorno y los datos listos, se inició la etapa de entrenamiento y evaluación.

* **1.2.1. Inspección y validación visual de las muestras**

Previo a inicializar el entrenamiento, se ejecutó una inspección visual sobre el conjunto de datos para validar la integridad de las imágenes, el preprocesamiento a un solo canal en escala de grises y la correspondencia binaria de las etiquetas de desecho.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RN_1.png">*Figura 2. Muestreo representativo de residuos de vidrio (etiqueta 0) y plástico (etiqueta 1) procedentes del repositorio TrashNet.*

Interpretación: La exploración gráfica confirma disparidades notables en la dispersión lumínica, los perfiles geométricos y la densidad de bordes entre ambos tipos de desecho. Las 983 muestras efectivas (687 en entrenamiento, 147 en validación y 149 en prueba) estructuradas en lotes de tamaño $[128, 1, 384, 512]$ evidencian que la reducción a un único canal monocromático conserva los gradientes morfológicos requeridos para alimentar los mapas convolucionales sin depender de información cromática.

* **1.2.2. Entrenamiento de la arquitectura CNN base desde cero**

Se estructuró una red convolucional directa apilando secuencialmente bloques de 1 a 16, 32 y 64 canales con filtros $3\times3$, rectificación no lineal (ReLU), MaxPool2d y AdaptiveAvgPool2d, finalizando en un clasificador lineal de dos salidas. El proceso formativo se ejecutó a lo largo de 8 épocas, monitoreando el coste de entrenamiento (`train_loss`), la exactitud de validación (`val_acc`) y la capacidad de discriminación (`val_auc`).

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RN_2.png">*Figura 3. Pérdida de entrenamiento y métricas de validación (Accuracy y ROC-AUC) de la CNN entrenada desde cero.*

Interpretación: Durante las primeras cuatro épocas, el modelo exhibe una convergencia lenta e inestable, iniciando con una pérdida de 0.6925 y fluctuaciones notables en la exactitud (0.5102 en la época 1 frente a 0.4830 en la época 4). A partir del quinto ciclo, el descenso del error se hace más evidente hasta alcanzar en la época 8 su mejor rendimiento en validación con una pérdida de 0.6593, exactitud de 63.95 % (0.6395) y un área bajo la curva ROC de 0.6689. Este comportamiento confirma que, aunque existe aprendizaje, el ajuste de pesos sin conocimiento previo sobre un volumen muestral restringido condiciona y ralentiza la extracción de características determinantes.

* **1.2.3. Evaluación cuantitativa sobre el conjunto de prueba independiente**

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RN_3.png">*Figura 4. Matriz de confusión de la CNN entrenada desde cero sobre el conjunto de prueba.*

Interpretación: Al confrontar la arquitectura base con las 149 instancias no observadas de prueba, la exactitud cayó a 57.05 % (0.5705) con un ROC-AUC de 0.6143. La matriz de confusión resultante:

$$\begin{pmatrix} 44 & 32 \\ 32 & 41 \end{pmatrix}$$

evidencia un desempeño simétrico pero deficiente: de 76 muestras de vidrio se acertaron 44 y de 73 de plástico se predijeron 41, acumulando 32 falsos positivos y 32 falsos negativos. Con métricas homogéneas (F1-score de 0.5789 para vidrio y 0.5616 para plástico), el modelo evidencia dificultades para generalizar, mostrando un comportamiento cercano a un clasificador aleatorio ante variaciones espaciales no vistas en el entrenamiento.

* **1.2.4. Aumento sintético de datos y transferencia de aprendizaje**

Para mitigar la rigidez del modelo base, se incorporó una etapa de *Data Augmentation* aplicando rotaciones aleatorias de hasta 10° y traslaciones afines del 5 % durante 6 épocas. 

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RN_4.png">*Figura 5. Curvas de pérdida y métricas de desempeño incorporando Data Augmentation.*

Interpretación: Pese a que la exactitud rígida por umbral en prueba descendió a 51.01 % (0.5101), la métrica ROC-AUC ascendió a 0.6483 frente a los 0.6143 del modelo base. Esta discrepancia indica que la perturbación sintética enriqueció la separación probabilística global entre clases, reduciendo la memorización posicional a costa de exigir un ajuste más fino en la frontera de decisión.

Posteriormente, se adoptó la estrategia de *Transfer Learning* sobre ResNet18 redimensionando las entradas a $224\times224$ píxeles y triplicando el canal para sincronizar con los tensores de ImageNet. En la fase de extracción de características (4 épocas con solo la capa `fc` descongelada), el modelo progresó de un error de 0.7082 a 0.5546, alcanzando una exactitud de validación de 70.75 % y un ROC-AUC de 0.8193. Con el posterior ajuste fino (*fine-tuning*) liberando el bloque terminal `layer4` junto con `fc` a tasa de aprendizaje reducida ($lr=10^{-4}$), el entrenamiento se consolidó rápidamente, reduciendo la pérdida a 0.0874 con un ROC-AUC de 0.9576 en validación.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RN_5.png">*Figura 6. Métricas de validación y evaluación en prueba del modelo con transfer learning y fine-tuning (ResNet18).*

Interpretación: Al testear la ResNet18 optimizada sobre el conjunto de prueba, el rendimiento alcanzó una exactitud de 87.92 % (0.8792) y un ROC-AUC de 0.9584. La matriz de confusión confirma la solidez de la inferencia:

$$\begin{pmatrix} 71 & 5 \\ 13 & 60 \end{pmatrix}$$

El modelo clasificó adecuadamente 71 de 76 vidrios (sensibilidad del 93.42 % y F1 de 0.8875) y 60 de 73 plásticos (precisión del 92.31 % y F1 de 0.8696), reduciendo drásticamente los falsos positivos a solo 5 casos y alcanzando un F1 ponderado global de 0.8834. La comparativa final en test valida la brecha de desempeño:

* **CNN desde cero (sin aumentación):** Exactitud = 57.05 % | ROC-AUC = 0.6143
* **CNN desde cero (con aumentación):** Exactitud = 51.01 % | ROC-AUC = 0.6483
* **Transfer Learning + Fine-tuning (ResNet18):** Exactitud = 87.92 % | ROC-AUC = 0.9584

* **1.2.5. Análisis de interpretabilidad mediante mapas Grad-CAM**

A fin de auditar la confiabilidad espacial de la red y descartar sesgos inducidos por el fondo de captura, se generaron mapas de activación Grad-CAM sobre la capa `model.layer4` de la arquitectura ResNet18.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RN_6.png">*Figura 7. Mapa de calor generado mediante Grad-CAM sobre una imagen de prueba, superpuesto a la imagen original.*

Interpretación: Los gradientes térmicos de mayor excitación (tonalidades amarillas y luminosas) se concentran focalizadamente sobre la silueta central, el relieve estructural y las aristas perimetrales de los recipientes. Este diagnóstico certifica que la red basa su discriminación en la morfología intrínseca del material y no en artefactos periféricos de la superficie de soporte, validando técnica y espacialmente el 87.92 % de acierto obtenido.
---
* **2. Método Keras**

**Keras** es una interfaz o *framework* de alto nivel desarrollada en Python, diseñada para simplificar la creación, compilación y entrenamiento de redes neuronales. 

A diferencia de trabajar con bibliotecas de bajo nivel (como PyTorch o TensorFlow puro), Keras actúa como una capa de abstracción que permite construir modelos de aprendizaje profundo de manera modular, intuitiva y con pocas líneas de código, evitando la manipulación compleja de matrices y tensores a mano.

#### Características principales:
* **Prototipado rápido:** Facilita diseñar y probar diferentes arquitecturas neuronales (como redes densas o convolucionales) en muy poco tiempo.
* **Modularidad:** Sus componentes —tales como las capas (*Layers*), funciones de activación, optimizadores y funciones de pérdida— funcionan como bloques de construcción totalmente independientes y combinables.
* **Facilidad de uso:** Está enfocado en ofrecer una experiencia de desarrollo limpia y accesible, lo que reduce significativamente la curva de aprendizaje en proyectos de Inteligencia Artificial.

* **2.1. Preparación y Vectorización del Corpus (Dataset IMDB)**

El proceso inició con la carga estructurada del repositorio IMDB limitando el espacio de características léxicas a las 10,000 palabras más habituales (`num_words=10000`), omitiendo los tres índices de control iniciales (`index_from=3`). Debido a que las redes neuronales operan exclusivamente con estructuras numéricas fijas, las secuencias de texto de longitud variable se transformaron mediante codificación binaria directa (*One-Hot Encoding*), dimensionando vectores densos de 10,000 posiciones donde cada columna refleja la presencia (1) o ausencia (0) de un término en el vocabulario. Para el monitoreo durante el entrenamiento, los datos se particionaron configurando un subconjunto de validación con los primeros 10,000 registros y un segmento de entrenamiento parcial a partir del índice 10,000 en adelante.

* **2.2. Implementación del Modelo Base y Detección de Sobreajuste**

Se estructuró una red densa (*Multi-Layer Perceptron*) compuesta por una capa inicial de entrada con 16 neuronas y activación ReLU (configurada para recibir vectores de 10,000 dimensiones), una capa oculta intermedia idéntica de 16 neuronas con activación ReLU, y una capa terminal de salida con una sola neurona y función de activación sigmoide para acotar la probabilidad de predicción entre 0 y 1[cite: 1]. El entrenamiento se configuró a lo largo de 20 épocas con un tamaño de lote (*batch size*) de 512, empleando el optimizador RMSprop y la función de pérdida de entropía cruzada binaria (`binary_crossentropy`)[cite: 1].

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNK_2.png">*Figura 8. Curva de pérdida del conjunto de entrenamiento y del conjunto de validación del modelo base de Keras.*

Interpretación: Durante los ciclos iniciales, la red experimenta una optimización acelerada: en la época 1 la pérdida de entrenamiento se sitúa en 0.5603 (exactitud de 77.27 %) frente a una pérdida de validación de 0.4426 (exactitud de 84.55 %); hacia la época 3 el error de entrenamiento disminuye a 0.2735 y la validación alcanza su cúspide de precisión con 88.31 %. Sin embargo, a partir de la época 4-5 se manifiesta un fenómeno crítico de sobreajuste (*overfitting*): la pérdida de entrenamiento sigue descendiendo de forma continua hasta alcanzar un valor marginal de 0.0140 (99.93 % de acierto) en la época 20, mientras que la pérdida de validación repunta severamente hasta 0.5444. En la evaluación definitiva sobre el conjunto de prueba independiente, el modelo obtuvo una pérdida de 0.5801 y una exactitud general de 86.14 %[cite: 10], demostrando que una capacidad de parametrización excesiva deteriora la generalización al memorizar los datos de entrenamiento.

* **2.3. Control de Capacidad con un Modelo Reducido**

Para examinar el impacto del dimensionamiento de la red sobre la memorización de datos, se estructuró una arquitectura simplificada reduciendo la capacidad de las capas ocultas a únicamente 4 neuronas con activación ReLU y manteniendo la salida sigmoidea.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNK_2.1.png">*Figura 9. Comparación de la pérdida de validación entre el modelo original y un modelo con menos neuronas.*

Interpretación: Al restringir el espacio de representación interna, la divergencia ascendente en la curva de pérdida de validación se aplaca notablemente. Aunque el sobreajuste no se anula por completo debido a la naturaleza estocástica del texto, el punto óptimo de error se mantiene contenido durante un mayor número de épocas. Esto evidencia que un modelo sobredimensionado frente a la complejidad intrínseca del problema tiende a sobreaprender los detalles particulares del corpus de origen.

* **2.4. Aplicación de Regularización L2 y Dropout**

Con el propósito de frenar el sobreajuste sin comprometer la capacidad estructural de la red original de 16 neuronas, se evaluaron dos estrategias de regularización independientes: la penalización de pesos L2 y la técnica de abandono estocástico (*Dropout*).

Para el modelo con regularización L2, se integró una penalización matemática (`kernel_regularizer=regularizers.l2(0.001)`) sobre los pesos de las capas densas. Durante su ejecución, el registro de entrenamiento avanzó desde una pérdida inicial de 0.5835 (exactitud de 76.95 %) en la época 1 hasta una pérdida de 0.1420 (exactitud de 97.71 %) en la época 20, registrando en paralelo una pérdida de validación de 0.4280 (87.41 % de acierto).

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNK_2.2.png">*Figura 10. Curvas de pérdida de entrenamiento y validación aplicando regularización L2, comparadas con el modelo original.*

Interpretación: La penalización L2 restringe el crecimiento desmedido de los parámetros sinápticos. Si bien esto genera pequeñas oscilaciones en la ruta de validación, frena eficazmente la sobreestimación de pesos específicos logrando que el error posterior se mantenga controlado.

Por otro lado, la incorporación de capas de *Dropout* con una tasa de desactivación del 50 % (`layers.Dropout(0.5)`) tras cada capa oculta modificó sustancialmente la dinámica de aprendizaje: la época 1 inició con un error de 0.6366 y una exactitud de 62.85 %, estabilizándose en la época 5 con una pérdida de entrenamiento de 0.3037 y una validación óptima con un error de 0.2786 y una exactitud de 88.86 %. Al concluir la vigésima época, la red registró una pérdida de 0.0669 y un acierto general en validación de 88.28 %.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNK_2.3.png">*Figura 11. Curva de pérdida de validación aplicando Dropout, comparada con el modelo original.*

Interpretación: El uso de *Dropout* interrumpe de forma aleatoria las coadaptaciones neuronales durante los ciclos de propagación, forzando a la red a generar representaciones redundantes y robustas. Esto retrasó de manera drástica la aparición del sobreajuste y estabilizó la métrica de validación por encima del 88 %.

* **2.5. Inferencia y Predicción de Ejemplos**

Finalmente, se validó la operatividad del clasificador texturizado realizando una predicción puntual sobre un vector de prueba seleccionado (específicamente la reseña correspondiente al índice 10).

Interpretación: El modelo procesó la secuencia y emitió un valor de salida continuo equivalente a un arreglo numérico de `[0.9932768]` (*dtype=float32*). Esta probabilidad cercana al 100% confirma una clasificación sumamente certera como reseña positiva, validando el funcionamiento integral del pipeline de vectorización e inferencia desarrollado en Keras.
---
# 🚩 Perceptrón

## ¿Qué es?

El **Perceptrón** es la unidad más básica de una red neuronal. Recibe entradas, las combina con **pesos** y un **sesgo (bias)**, y pasa el resultado por una **función de activación** que decide la salida.

**Cómo funciona:**
1. Multiplica cada entrada por su peso.
2. Suma los productos y agrega el sesgo.
3. Aplica la función de activación.
4. Devuelve la salida.

Es la versión más simple de una neurona artificial y la base de arquitecturas como las CNN.

---

## 1. Funciones de activación

| Función | Comportamiento | Rango |
|---|---|---|
| **Escalón** | `1` si la suma es `≥ 0`, `0` si es negativa. | `{0, 1}` |
| **tanh** | Transforma a un valor continuo con forma de S. | `[-1, 1]` |

La escalón da una decisión **binaria** (sí/no); `tanh` da una **intensidad** (qué tan cerca está del límite).

---

## 2. Caso práctico: sobrecalentamiento industrial

Se modeló una alerta de sobrecalentamiento usando dos sensores:

- **Temperatura:** 100 · **Vibración:** 50
- **Pesos:** `[0.5, -0.5]` · **Bias:** `-30`

$$
(100 \times 0.5) + (50 \times -0.5) - 30 = 50 - 25 - 30 = -5
$$

Como el resultado es **negativo**, la escalón devuelve `0` y `tanh` devuelve ≈ `-1`. En ambos casos: **no se activa la alerta**.

**Idea clave:** el perceptrón no depende solo de las entradas — los pesos y el bias determinan la decisión. Eso es lo que la red **aprende** durante el entrenamiento.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNP_1.png">

---

## 3. Compuertas lógicas: AND, OR y XOR

Se probaron las cuatro combinaciones posibles: `(0,0)`, `(0,1)`, `(1,0)` y `(1,1)`.

### 3.1. AND

Con pesos `[0.4, 0.4]` y bias `-0.5`, solo `(1,1)` supera el umbral:

$$
0.4 \times 1 + 0.4 \times 1 - 0.5 = 0.3 > 0 \;\Rightarrow\; 1
$$

El resto da `0`. Comportamiento **idéntico a AND**.

### 3.2. OR

Con pesos `[2, 1]` y bias `-0.5`, basta con que una entrada sea `1`:

- `(0,0)` → `0`
- `(0,1)` → `1`
- `(1,0)` → `1`
- `(1,1)` → `1`

Comportamiento **clásico de OR**.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNP_2.png">
<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNP_2.1.png">



**Interpretación geométrica:** AND y OR son **linealmente separables** — una sola línea recta divide el plano entre las salidas `0` y `1`.

### 3.3. XOR: donde falla

XOR da `1` solo cuando las entradas son **diferentes**:

- `(0,0)` → `0`
- `(0,1)` → `1`
- `(1,0)` → `1`
- `(1,1)` → `0`

Los puntos con salida `1` quedan en **diagonal** respecto a los de salida `0`. **No existe ninguna línea recta** que los separe.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNP_3.png">

**Conclusión:** un solo perceptrón **no puede resolver XOR**.

### 3.4. La solución: combinar perceptrones

Usando **dos perceptrones en paralelo** más una capa final, se trazan **dos fronteras de decisión** que juntas resuelven XOR.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RNP_4.png">

**¿Por qué importa?** Es la idea que da origen a las **redes multicapa** y, después, a arquitecturas como las CNN.

---
