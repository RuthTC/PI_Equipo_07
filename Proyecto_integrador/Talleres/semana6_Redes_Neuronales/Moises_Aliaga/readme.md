# 🚩 Redes Neuronales Convolucionales (CNN)

## ¿Qué es una CNN y para qué sirve?

Una **CNN (Red Neuronal Convolucional)** es una red diseñada para procesar imágenes. En lugar de ver la imagen como una lista plana de píxeles, entiende que los píxeles vecinos están relacionados y que los patrones (bordes, formas, texturas) pueden aparecer en cualquier parte de la imagen.

**Cómo "ve" una CNN:**

1. **Bordes** → contornos de la botella.
2. **Formas** → cuello, cuerpo, tapa.
3. **Texturas** → transparencia, brillo.
4. **Decisión** → "esto es vidrio" o "esto es plástico".

**Componentes clave:**

| Componente | Función |
|---|---|
| **Conv2D** | Aplica filtros que detectan patrones locales. |
| **ReLU** | Introduce no linealidad: `max(0, x)`. |
| **MaxPool** | Reduce resolución manteniendo lo importante. |
| **Dense/Linear** | Decide la clase final. |

**Ventaja frente a una red densa:** comparte filtros (menos parámetros) y respeta la estructura espacial.

---

## 1. Preparación del entorno

Se instalan las dependencias necesarias: `torch` y `torchvision` (construcción del modelo), `numpy` y `matplotlib` (cálculo y gráficas), `scikit-learn` (métricas), `tqdm` (barras de progreso) y `pillow` (carga de imágenes). También se monta Google Drive para acceder a datos y guardar resultados.

---

## 2. Carga del dataset (TrashNet)

Se trabaja con **clasificación binaria**:

- `0 = glass`
- `1 = plastic`

El `TrashDataset` divide automáticamente las imágenes en **train (70%)**, **validation (15%)** y **test (15%)**. La conversión a tensor con `T.ToTensor()` transforma los valores de la imagen (0–255) a tensores con valores entre 0 y 1.

---

## 3. Visualización de ejemplos

```python
def show_glass_plastic(dataset):
    glass, plastic = [], []
    for i in range(len(dataset)):
        x, y = dataset[i]
        label = int(y.item())
        if label == 0 and len(glass) < 6:
            glass.append((x, label))
        elif label == 1 and len(plastic) < 6:
            plastic.append((x, label))
        if len(glass) == 6 and len(plastic) == 6:
            break

    for i, (x, label) in enumerate(glass + plastic):
        plt.subplot(3, 4, i + 1)
        plt.imshow(x.squeeze(0), cmap="gray")
        plt.title(DataClass.classes[label])
        plt.axis("off")
    plt.show()

show_glass_plastic(train_dataset)
```
* **Interpretación**: el x.squeeze(0) elimina la dimensión del canal para poder graficar con imshow. Esta visualización sirve para verificar que los datos se cargan correctamente y notar algo clave: las botellas de vidrio y de plástico se parecen mucho (ambas transparentes). Esto anticipa que una CNN entrenada desde cero tendrá dificultades.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/semana6_Redes_Neuronales/Moises_Aliaga/image/RN_1.png">

## 4. DataLoaders y device 
Se define device para usar GPU (CUDA) si está disponible. Los DataLoader dividen el dataset en batches (128 imágenes) y, en el caso de train, mezclan el orden con shuffle=True para que la red no memorice el orden de las imágenes. Los workers cargan datos en paralelo mientras la GPU entrena.

## 5. Modelo: CNN desde cero.
```python
class SimpleCNN(nn.Module):
    def __init__(self, num_classes):
        super().__init__()
        self.features = nn.Sequential(
            nn.Conv2d(1, 16, 3, padding=1), nn.ReLU(), nn.MaxPool2d(2),
            nn.Conv2d(16, 32, 3, padding=1), nn.ReLU(), nn.MaxPool2d(2),
            nn.Conv2d(32, 64, 3, padding=1), nn.ReLU(),
            nn.AdaptiveAvgPool2d((1, 1))
        )
        self.classifier = nn.Sequential(nn.Flatten(), nn.Linear(64, num_classes))

    def forward(self, x):
        return self.classifier(self.features(x))
```
* **Arquitectura explicada:**

1. Conv1 → 16 filtros detectan bordes simples.

2. MaxPool → reduce tamaño.

3. Conv2 → combina bordes en formas más complejas.

4. Conv3 → detecta partes concretas (cuello, tapa).

5. AdaptiveAvgPool → resume todo en un vector de 64 números.

6. Linear(64, 2) → decide entre las 2 clases.
   
 padding=1 con kernel 3 mantiene el tamaño espacial. ReLU introduce no linealidad (sin ella, toda la red sería equivalente a una sola capa lineal).

---
* **Funciones de entrenamiento y evaluación**
La función train_one_epoch ejecuta el ciclo clásico de PyTorch en cada batch: limpiar gradientes, hacer forward, calcular la pérdida con CrossEntropyLoss, retropropagar (backward) y actualizar pesos (step). Devuelve el promedio de pérdida de la época.

La función evaluate desactiva gradientes (@torch.no_grad()) y pone el modelo en modo evaluación (eval()), lo que desactiva dropout y batchnorm en modo entrenamiento. Calcula accuracy y ROC-AUC sobre todo el set. ROC-AUC es importante porque mide la capacidad de separar clases independientemente del umbral de decisión.
```python
criterion = nn.CrossEntropyLoss()
optimizer = torch.optim.Adam(model_scratch.parameters(), lr=1e-3)
```

for epoch in range(1, epochs + 1):
    train_loss = train_one_epoch(model_scratch, train_loader, optimizer, criterion)
    val_acc, val_auc, _, _, _ = evaluate(model_scratch, val_loader)
    print(f"Epoch {epoch:02d} | loss={train_loss:.4f} | val_acc={val_acc:.4f}")
```
