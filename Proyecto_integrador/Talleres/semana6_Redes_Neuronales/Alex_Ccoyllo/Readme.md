# Redes neuronales - Resumen de lo aprendido

## ¿Qué aprendí?

En esta clase aprendí diferentes formas de usar redes neuronales para resolver problemas de clasificación.

Primero vimos las **CNN (Convolutional Neural Networks)**, que sirven principalmente para trabajar con imágenes. Estas redes utilizan filtros llamados *kernels* que recorren una imagen para encontrar patrones como bordes, texturas o formas.

También vimos algunos de sus componentes principales:

- **Conv2D:** aplica filtros sobre la imagen para encontrar características.
- **ReLU:** convierte los valores negativos en 0 y mantiene los positivos.
- **Pooling:** reduce el tamaño de la información manteniendo las características más importantes.
- **Capas densas:** utilizan lo aprendido por las capas anteriores para realizar la clasificación.

En el ejemplo trabajado se utilizó un dataset de residuos para clasificar imágenes entre **vidrio y plástico**. Primero se entrenó una CNN desde cero y luego se probaron técnicas como **data augmentation**, **transfer learning** y **fine-tuning**.

También aprendí que no basta con ver solamente el accuracy del modelo. Se pueden utilizar otras métricas como:

- Accuracy
- ROC-AUC
- Matriz de confusión
- Precision
- Recall
- F1-score

Otra herramienta que vimos fue **Grad-CAM**, que permite observar mediante un mapa de calor qué zonas de una imagen fueron más importantes para que la red realizara una predicción.

---

## Algo característico que aprendí

Algo que me quedó bastante claro de esta clase es que una red neuronal no ve una imagen como nosotros, sino como un conjunto de valores numéricos correspondientes a sus píxeles.

A partir de esos valores, las CNN van aprendiendo características poco a poco. Primero pueden encontrar cosas más simples como bordes y después, en capas más profundas, patrones más complejos.

También aprendí que **tener un modelo más complejo no significa automáticamente obtener mejores resultados**, ya que el modelo puede terminar memorizando los datos de entrenamiento y presentar sobreajuste.

---

## Clasificación binaria con Keras

También vimos cómo crear una red neuronal con Keras para clasificar reseñas de películas como positivas o negativas.

En este caso se trabajó con datos de texto y estos tuvieron que transformarse a valores numéricos para que la red pudiera procesarlos.

Se creó una red con:

- 2 capas ocultas de 16 neuronas.
- 1 capa final de una neurona.

Algo importante fue observar el **sobreajuste**. Esto sucede cuando el modelo aprende muy bien los datos de entrenamiento, pero cuando recibe datos nuevos su rendimiento disminuye.

Para reducir este problema vimos algunas técnicas como:

- utilizar modelos más pequeños;
- regularización;
- dropout.

El **dropout** me pareció interesante porque durante el entrenamiento desactiva de forma aleatoria algunas neuronas. Esto ayuda a que la red no dependa demasiado de neuronas específicas.

---

## Perceptrón

También vimos el **perceptrón**, que es una de las formas más sencillas de una red neuronal.

El perceptrón recibe diferentes entradas, las multiplica por pesos, agrega un bias y después aplica una función de activación para producir una salida.

Vimos que puede representar operaciones como:

- AND
- OR

Sin embargo, un solo perceptrón no puede resolver correctamente XOR porque este problema no se puede separar utilizando solamente una línea.

Para resolver XOR se necesitan varios perceptrones trabajando juntos. Esto me ayudó a entender mejor por qué las redes neuronales utilizan varias neuronas y capas.

---

# Parte que considero importante

Una parte del código que me pareció importante fue el **Data Augmentation**:

```python
transform_aug = T.Compose([
    T.RandomRotation(degrees=10),
    T.RandomAffine(degrees=0, translate=(0.05, 0.05)),
    T.ToTensor()
])


train_dataset_aug = DataClass(
    root=DATA_DIR,
    split="train",
    transform=transform_aug
)


train_loader_aug = DataLoader(
    train_dataset_aug,
    batch_size=batch_size,
    shuffle=True,
    num_workers=2,
    pin_memory=True
)
```

---

# Mi interpretación

Lo que entendí es que una red neuronal aprende encontrando patrones dentro de los datos.

Dependiendo del tipo de información que tengamos podemos utilizar diferentes tipos de modelos. Por ejemplo, las CNN funcionan muy bien para imágenes, mientras que otros modelos pueden trabajar con texto o datos numéricos.

También entendí que no basta con entrenar un modelo y observar solamente su accuracy. Es necesario analizar diferentes métricas y comprobar si realmente funciona correctamente con datos que nunca ha visto.

Para mí, la idea principal de esta clase fue entender que **debemos escoger el modelo según el problema que queremos resolver y no solamente utilizar el modelo más complejo**.

---

# Aplicación a nuestro proyecto Compostech

En nuestro proyecto **Compostech** considero que no sería necesario utilizar Deep Learning, porque los datos que vamos a obtener no serán principalmente imágenes, audio o texto, sino valores numéricos provenientes de sensores.

Algunos de los datos que tendremos serán:

- Temperatura del compost.
- Humedad.
- Variaciones de gases detectadas por el MQ-135.
- Nivel de lixiviados.
- Tiempo desde el último riego.
- Tiempo desde la última remoción del compost.
- Fecha y hora de las mediciones.

Por esta razón, para Compostech utilizaría **Machine Learning clásico**.

Una alternativa que considero adecuada es **Random Forest**, porque puede analizar varias variables al mismo tiempo y encontrar patrones que permitan clasificar el estado del compost.

Por ejemplo, podríamos tener:

- Temperatura de 50 °C.
- Humedad alta.
- Lectura elevada del MQ-135.
- Nivel de lixiviados normal.

A partir de varias mediciones similares, el modelo podría aprender que esta combinación está relacionada con algún problema como exceso de humedad o poca aireación.

Después de identificar el estado, el sistema podría mostrar una recomendación al usuario, por ejemplo:

**Estado:** Posible exceso de humedad.

**Recomendación:** Remover el compost y no agregar agua por el momento.

---

## ¿Por qué no usar Deep Learning?

Por lo que entendí durante la clase, Deep Learning es muy útil para problemas más complejos, especialmente cuando se trabaja con imágenes, audio o una gran cantidad de información.

En nuestro proyecto tendremos pocas variables y principalmente datos numéricos de sensores, por lo que utilizar una red neuronal profunda sería hacer el sistema más complicado de lo necesario.

Además, para entrenar correctamente un modelo de Deep Learning normalmente se necesita una gran cantidad de datos.

Por eso considero que para Compostech sería mejor trabajar inicialmente de la siguiente manera:

**Sensores → Reglas y rangos → PostgreSQL → Datos históricos → Random Forest → Estado del compost → Recomendaciones**

Primero utilizaríamos reglas y rangos conocidos para poder hacer funcionar el sistema.

Mientras Compostech se encuentre funcionando, las mediciones se irían almacenando en PostgreSQL.

Cuando tengamos suficientes datos históricos y estos estén correctamente clasificados, podremos utilizarlos para entrenar el modelo de Random Forest.

En una versión futura sí podría ser útil Deep Learning si agregáramos, por ejemplo, una cámara que analice imágenes del compost o identifique diferentes tipos de residuos.
