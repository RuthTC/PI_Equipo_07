# Informe de Análisis Metodológico y Proyecto COMPOSTEC

---

## 1. Redes Neuronales Convolucionales (CNN)

Las **Redes Neuronales Convolucionales (CNN)** nos permiten realizar el análisis de datos mediante píxeles cercanos, reconociendo imágenes a través de pequeños patrones espaciales. Frente a una red densa tradicional, una CNN comparte filtros (lo que reduce drásticamente el número de parámetros) y respeta la estructura espacial bidimensional de la imagen.

Para construir y entrenar estos modelos, se utiliza la librería **PyTorch**.

### Componentes Clave Aplicados en el Código

* **`Conv2D`:** Aplica filtros/kernels (por ejemplo, de $3 \times 3$) que recorren la imagen extrayendo características de bajo y alto nivel (bordes, texturas, formas).
* **`MaxPooling2D`:** Aplica una reducción de escala (por ejemplo, $2 \times 2$), disminuyendo las dimensiones espaciales de los mapas de características. Esto reduce el costo computacional y ayuda a prevenir el sobreajuste (*overfitting*).
* **`Flatten` y `Dense`:** Al finalizar las capas convolucionales, el mapa de características multidimensional se aplana a un vector 1D y entra a capas densas (*fully connected*) para realizar la clasificación final.

![Entorno y Arquitectura CNN](img1.png)

---

### Clasificación Binaria y Preparación del Dataset

El problema está configurado como una **clasificación binaria**:
* `0 = glass` (Vidrio)
* `1 = plastic` (Plástico)

La clase `TrashDataset` divide automáticamente los datos en tres conjuntos:
* **Entrenamiento (Train):** 70%
* **Validación (Validation):** 15%
* **Prueba (Test):** 15%

La conversión a tensor mediante `T.ToTensor()` escala los valores de los píxeles del rango $[0, 255]$ al rango $[0.0, 1.0]$. 

> Al confirmar que las clases son `['glass', 'plastic']`, se establece la naturaleza de aprendizaje supervisado del problema. Esto condiciona directamente el diseño de la última capa del modelo (2 salidas o 1 salida sigmoide) y la elección de la función de pérdida (`BCELoss` o `CrossEntropyLoss`).

---

### Visualización de Ejemplos de Datos

| Código de Muestreo | Resultados Visuales |
| :---: | :---: |
| ![Código de Muestreo](img2.png) | ![Resultados Visuales](img3.png) |

#### Manejo de Tensores en la Visualización
La instrucción `x.squeeze(0)` elimina la dimensión del canal para transformar el tensor de forma `(1, H, W)` a `(H, W)`, permitiendo que `matplotlib` grafique la imagen correctamente en escala de grises.

#### Análisis de los Datos Visuales
Se puede observar que las muestras de vidrio y plástico son visualmente muy similares en este dataset (presentan formas parecidas, transparencias y ausencia de color). Esto anticipa que la CNN enfrentará un reto complejo y requerirá aprender texturas y bordes muy finos para evitar confusiones entre ambas clases.

---

### Modelo 1: CNN Desde Cero

Este código define la arquitectura completa de la CNN desde cero, separando el proceso en dos etapas principales:
1. **`features`:** Extrae bordes, esquinas y texturas mediante capas convolucionales.
2. **`classifier`:** Toma el vector de características y decide si la imagen corresponde a vidrio o plástico.

![Código CNN desde Cero](img4.png)

#### Métricas de Evaluación
Para validar el desempeño de esta estructura, la red se evalúa mediante:
* **Accuracy:** Mide el porcentaje general de aciertos.
* **ROC-AUC:** Evalúa la capacidad del modelo para separar correctamente ambas clases a través de distintos umbrales.
* **Matriz de Confusión, Precision, Recall y F1-Score:** Permiten evaluar el desempeño real ante posibles desbalances entre las clases.

---

### Curvas de Entrenamiento

El progreso de la red se monitorea mediante las siguientes funciones en Matplotlib:
* `plt.plot(history_scratch["train_loss"])`: Grafica el error cometido durante el entrenamiento.
* `plt.plot(history_scratch["val_acc"])` y `plt.plot(history_scratch["val_auc"])`: Muestran el rendimiento sobre datos no vistos previamente (validación).

![Curvas de Entrenamiento](img5.png)

* **Gráfica de Pérdida de Entrenamiento:** Mide el error del modelo. La curva desciende en cada época (de $\approx 0.697$ a $\approx 0.672$), indicando que la red está ajustando sus parámetros correctamente.
* **Gráfica de Métricas de Validación:**
  * **Accuracy (Azul):** Inicialmente plana ($\approx 50\%$, equivalente a azar). A partir de la época 4 incrementa hasta alcanzar un **63.27%**.
  * **ROC-AUC (Naranja):** Se mantiene estable entre **0.67** y **0.70**, lo que demuestra que la red logra diferenciar razonablemente entre vidrio y plástico.

---

### Matriz de Confusión (CNN desde Cero)

| Código de la Matriz | Imagen de la Matriz de Confusión |
| :---: | :---: |
| ![Código Matriz de Confusión](img6.png) | ![Matriz de Confusión Resultante](img7.png) |

#### Interpretación de Resultados

* **Aciertos (Diagonal Principal):**
  * **68 en Vidrio `(0,0)`:** De las imágenes pertenecientes a la clase vidrio, predijo correctamente 68.
  * **14 en Plástico `(1,1)`:** De las imágenes pertenecientes a plástico, predijo correctamente solo 14.
* **Errores (Fuera de la Diagonal):**
  * **8 `(0,1)`:** Eran vidrio pero el modelo las clasificó como plástico.
  * **59 `(1,0)`:** Eran plástico pero el modelo las clasificó incorrectamente como vidrio.

> **Conclusión del Modelo Base:** El modelo presenta un fuerte **sesgo hacia la clase Vidrio (0)**. Clasifica bien el vidrio (68/76), pero falla gravemente en la clase plástico, confundiendo la mayoría (59/73). Esto demuestra la necesidad de aplicar técnicas de mejora como aumento de datos y transferencia de aprendizaje.

---

### Aumento de Datos y Aprendizaje por Transferencia (*Transfer Learning*)

Para solucionar el sesgo y mejorar la generalización, se implementan dos técnicas:

1. **Data Augmentation:** Modifica ligeramente las imágenes durante el entrenamiento (rotaciones aleatorias con `T.RandomRotation(degrees=10)`) para evitar que el modelo memorice posiciones fijas.
2. **Transfer Learning (ResNet-18):** Reutiliza una red preentrenada en millones de imágenes para aprovechar detectores de bordes y texturas complejos.

```python
import torchvision.models as models

# Carga de ResNet-18 con pesos preentrenados
resnet = models.resnet18(weights=models.ResNet18_Weights.DEFAULT)

# Transformaciones para entrenamiento
transform_tl_train = T.Compose([
    T.Resize((224, 224)),
    T.RandomRotation(degrees=10),
    T.RandomAffine(degrees=0, translate=(0.05, 0.05)),
    T.ToTensor(),
    T.Lambda(lambda x: x.repeat(3, 1, 1)) # Duplica canal gris a 3 canales RGB
])

# Transformaciones para evaluación
transform_tl_eval = T.Compose([
    T.Resize((224, 224)),
    T.ToTensor(),
    T.Lambda(lambda x: x.repeat(3, 1, 1))
])
