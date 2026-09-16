 # Exploración de Datos y Análisis de Consumo de Energía

**Estudiante:** Ruth Turpo  
**Ubicación:** `ruth turpo/README.md`  

---

## 📌 ¿De qué trató la clase de hoy?

En la clase de hoy trabajamos con un archivo llamado `Data_PI_regresion.csv`, el cual contiene 5,000 registros sobre el funcionamiento de ciertos equipos y su consumo energético. 

El objetivo principal fue aprender a hacer una **exploración inicial de datos (EDA)** usando Python en Jupyter Notebook / Google Colab. Aprendimos a cargar el archivo, revisar que la información esté completa, sacar estadísticas básicas y generar gráficos para ver cómo se relacionan las variables entre sí.

---

## 💻 Paso a paso del código trabajado en clase

A continuación explico cada parte del código que ejecutamos en la clase y lo que entendí de cada paso:

### 1️⃣ Carga de librerías y datos

Lo primero que hicimos fue importar las librerías necesarias. Usamos `pandas` y `numpy` para manejar las tablas y números, y `matplotlib` junto con `seaborn` para crear los gráficos.

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

# Cargamos el dataset desde nuestra ruta en Colab
df = pd.read_csv("/content/Data_PI_regresion.csv")
df.head()
