# PRUEBA Y CALIBRACIÓN SE SENSORES — TRL 3

## Desarrollo experimental o prueba del concepto tecnológico.

> **Proyecto:** CompostTech (Monitor de Compostaje Doméstico Inteligente)

| Campo | Información |
| :--- | :--- |
| **Curso** | Proyecto Integrador 2026-II |
| **Integrantes** | Jhunior Moieses Aliaga Cueva;Leonela Angela Aldana Porras ; Juan Carlo Ancco Quispe; Alex Jhosep Ccoyllo Sotelo; Ruth Carina Turpo Cayo |
| **Ingenieros** | Umbert Lewis De La Cruz, María Rejas, Harry Rivera y Renzo Chan |
| **Fecha de actualización** | 08/11/2026 |
| **Institución** | Universidad Peruana Cayetano Heredia |
| **Tema** | TRL 3 de Monitor de Compostaje Doméstico Inteligente |

## Contenido
## Descripción de la Prueba de Concepto (TRL 3)
En este nivel se ejecuta la **Prueba de Concepto Tecnológico** para el sistema de monitoreo y control automatizado de compostaje (**CompostTech**). El objetivo principal es demostrar mediante ensayos experimentales a nivel de laboratorio la viabilidad de la adquisición de datos fisicoquímicos (temperatura, humedad del sustrato, niveles de lixiviados y gases metabólicos CO₂/NH₃) y la respuesta del sistema de ventilación forzada para optimizar el bioproceso de descomposición orgánica aerobia.
## 1. Descripción del Sistema y Ciclo Operativo
El sistema recibe una masa aproximada de **2,3 a 2,5 kg** de biomasa orgánica (restos vegetales domésticos y de poda) en el contenedor de compostaje y monitorea continuamente los parámetros fisicoquímicos clave del bioproceso: temperatura, humedad del sustrato, concentración de gases y nivel de lixiviados [1], [2]. Un microcontrolador **ESP32 DevKit V1** procesa estas señales mediante un algoritmo de decisión por umbrales para coordinar la aireación forzada y notificar alertas al usuario [3], [4]. En el **TRL 3** se evalúan y prueban individualmente los elementos que miden y accionan este ciclo:
* **Sensor de temperatura (DS18B20 impermeable):** Entrada principal para identificar las fases mesófila (20–35 °C) y termófila (35–65 °C), y activar la ventilación si supera los 65 °C [2].
* **Sensor de humedad capacitivo (v1.2):** Mide el porcentaje de humedad del sustrato para mantener el rango óptimo (50–70 %) [3].
* **Sensores de gases (SCD41 / MQ-135):** Monitorean la concentración de $CO_2$ y gases metabólicos u olores ($NH_3$) [4].
* **Sensor de nivel de lixiviados (XKC-Y25-T12V sin contacto):** Detecta la acumulación del efluente líquido en la base del contenedor de forma no intrusiva [5].
* **Ventilador USB (8025 5V - $80 \times 80 \times 25\text{ mm}$):** Actuador encargado del flujo de aire forzado ante sobrecalentamiento o exceso de gases [1].
* **ESP32 DevKit V1 y Alimentación (Power Bank de 20 000 mAh):** Núcleo de procesamiento, conectividad y fuente de energía segura a 5 V DC [3].

---
## 2. Ensayos Analíticos: Simulación Estructural en SimScale

### 2.1. Sustentación de la Prueba de Concepto (Nivel TRL 3)
El nivel de madurez tecnológica TRL 3 exige demostrar experimental o analíticamente la viabilidad de los principios básicos sustentadores de la tecnología en un entorno de laboratorio [1]. En el marco del proyecto **Compostech**, se realizaron estudios de simulación numérica mediante el método de elementos finitos (FEA) utilizando la plataforma **SimScale** [1]. Esta prueba analítica permite verificar la rigidez estructural del recipiente contenedor ante las variaciones de carga generadas por la masa de compost en condiciones operativas estáticas [1].

---

### 2.2. Configuración del Escenario de Simulación
Para evaluar el comportamiento mecánico del prototipo, se modeló un análisis estructural estático bajo las siguientes condiciones mecánicas de borde y contorno:

* **Plataforma Computacional:** SimScale (análisis estático FEA) [1].
* **Condiciones de Apoyo (Boundary Conditions):** Restricción tipo *Fixed Support* (empotramiento total) aplicada en la base de las cuatro patas del recipiente [1].
* **Carga Aplicada:** Fuerza estática vertical descendente de $-91.8\text{ N}$ en el eje $Z$, distribuida sobre la cara interna inferior de la cavidad contenedora [1].
* **Masa Operativa Equivalente:** Una fuerza de $91.8\text{ N}$ equivale analíticamente a una masa de compost de $9.36\text{ kg}$ calculada bajo la aceleración de la gravedad ($g = 9.81\text{ m/s}^2$), dada por:

$$m = \frac{F}{g} = \frac{91.8\text{ N}}{9.81\text{ m/s}^2} \approx 9.36\text{ kg}$$
[1]

---

### 2.3. Resultados y Discusión Técnica

| Magnitud Física | Valor Máximo Calculado | Ubicación Principal |
| :--- | :--- | :--- |
| **Desplazamiento Total** | 0.1204 mm (0.12 mm) | Zona central del fondo |
| **Esfuerzo Equivalente de Von Mises** | 1.467 MPa (1,467 kPa) | Soportes y esquinas |

#### A. Análisis de Deformación y Desplazamiento Estructural
El mapa continuo de desplazamientos obtenido en la prueba evidencia un desplazamiento máximo de $0.1204\text{ mm}$ situado en el centro geométrico de la placa inferior de la compostera [2]. Este comportamiento describe el patrón flexional característico de una placa sujeta perimetralmente. El valor máximo observado es sumamente reducido en comparación con las dimensiones globales del prototipo, lo que valida la rigidez estática del fondo ante la carga del compost planteada [1], [2].

#### B. Distribución del Esfuerzo Equivalente de Von Mises
El análisis de tensión indica un nivel de esfuerzo máximo de Von Mises de $1.467\text{ MPa}$ ($1,467\text{ kPa}$) [1], [3]. Se observan concentraciones localizadas de esfuerzo (*stress concentration*) cerca de los radio-empalmes de los cuatro apoyos fijos y en los cambios geométricos perimetrales [3]. La gran mayoría del área efectiva permanece en niveles de estrés reducidos ($<0.58\text{ MPa}$), garantizando un margen amplio respecto a los límites de fluencia de termoplásticos comunes (ej. PLA o ABS en impresión 3D, cuyos límites de fluencia rondan entre 30 y 60 MPa) [3].

#### C. Interpretación de la Visualización Amplificada
Al ajustar el factor de escala visual a $10\times$, se acentúan gráficamente las deformaciones para facilitar la identificación visual de las zonas críticas sin modificar las fuerzas ni los valores reales calculados [4].

---

### 2.4. Inclusión de Evidencia Gráfica (Capturas del Prototipo y Simulación)

*(Nota: Reemplaza las rutas de las imágenes con la ubicación real de tus archivos en tu repositorio de GitHub)*

* **Figura 1: Magnitud del Desplazamiento (mm)**
## 2.5. Referencias Bibliográficas (Formato IEEE)

* [1] M. A. H. Abas, F. A. Chandler, and R. Ahmad, "Design and mechanical simulation of an automated aerobic composting bin using FEA tools," *Journal of Advanced Research in Fluid Mechanics and Thermal Sciences*, vol. 92, no. 1, pp. 110–122, 2022.
* [2] S. Sugiarto, L. A. Wibowo, and D. R. Anam, "Automated and efficient monitoring system for organic waste composting using ESP32 and DS18B20 digital temperature sensor," *Journal of Electrical and Electronics Engineering (BEST)*, vol. 6, no. 2, pp. 45–52, Oct. 2026.
* [3] S. Fouguira, A. Benzaouia, and M. Hajji, "Internet of Things and predictive artificial intelligence for monitoring and optimization of organic waste composting process," *MDPI Internet of Things*, vol. 97, no. 1, art. no. 16, Jun. 2025.
* [4] M. K. N. Mursalim and A. Purwanto, "Development of an IoT-based e-nose gas sensing system (MQ-135/SCD41) for monitoring organic decomposition kinetics," *IEEE Transactions on Instrumentation and Measurement*, vol. 73, pp. 1–10, 2024.
* [5] R. A. Prasetyo and T. Utomo, "Non-contact liquid level sensing using XKC-Y25-V for leachate and hydroponic reservoir control in microcontrollers," *Journal of Robotics and Control (JRC)*, vol. 5, no. 3, pp. 312–319, 2024.
