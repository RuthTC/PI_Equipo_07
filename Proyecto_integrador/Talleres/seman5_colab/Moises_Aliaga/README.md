 # Análisis Exploratorio de Datos y Evaluación de Correlaciones en Python 
 En esta sesión se trabajo en Google Colab, se desarrolló la fase de Análisis Exploratorio de Datos (EDA) sobre un conjunto de registros operativos y climáticos con el fin de identificar las variables críticas que influyen en el consumo de energía. Utilizando librerías estándar de ciencia de datos como Pandas, Matplotlib y Seaborn, la ejecución abarcó la importación y auditoría estructural del dataset, la verificación de integridad de datos y cálculo de estadísticos descriptivos, culminando en la evaluación visual de relaciones bivariadas y matrices de correlación lineal. Esta etapa preliminar resulta clave para validar la calidad de la información, detectar patrones de comportamiento y seleccionar adecuadamente las variables predictoras antes del ajuste de un modelo formal de regresión.
## Implementación del Código

```python
plt.figure(figsize=(10, 7))
sns.heatmap(numeric_df.corr(), annot=True, linewidths=2)
# mapa de calor de correlaciones
```
# Lo que más me llamó la atención
El análisis evidencia que el consumo energético está determinado principalmente por factores operativos, destacando una fuerte correlación lineal positiva con las horas de operación (0.84) y la carga (0.34), en contraste con la temperatura (0.098) y la humedad (0.063), cuyo impacto resulta prácticamente nulo. Asimismo, la falta de relación entre las variables independientes (con valores entre -0.026 y 0.017) descarta problemas de multicolinealidad y asegura predictores ortogonales. Esto es clave para el modelado, ya que permite prescindir de factores irrelevantes que solo añadirían ruido, garantizando un modelo de regresión más parsimonioso, estable y matemáticamente confiable.


![mapa de calor de correlaciones](/Proyecto_integrador/Talleres/seman5_colab/Moises_Aliaga/correlacion1.png)

# ¿Por qué es importante?
Esta visualización es clave en cualquier proyecto de analítica porque transforma matrices numéricas complejas en una guía directa para la selección de variables (feature selection) y la validación de supuestos estadísticos. Al permitir identificar rápidamente qué factores influyen con fuerza en la variable objetivo y comprobar que no exista multicolinealidad entre las variables de entrada, facilita descartar datos redundantes o irrelevantes que solo añadirían ruido, logrando que el modelo final sea mucho más preciso, interpretable y eficiente antes de pasar a la etapa de entrenamiento
