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
