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
## 2. Ensayos analíticos: simulación estructural en SimScale

2.1 Objetivo y criterio de aceptación
Objetivo. Verifique, antes de fabricarlas, que las piezas estructurales del prototipo soportan las cargas de operación. El modelo está en Onshape (modelo CAD) y las piezas impresas se prevén en PLA, cuya resistencia depende de parámetros de impresión como la densidad de relleno, la orientación y la altura de capa [9].
Criterio de aceptación. El esfuerzo equivalente de von Mises reúne en un solo valor los esfuerzos que actúan sobre un punto. Según el criterio de la energía de distorsión, un material dúctil no fluye mientras ese valor sea menor que su esfuerzo de fluencia [12]. Por eso el esfuerzo máximo de cada pieza debe quedar muy por debajo del esfuerzo de fluencia del material. El factor de seguridad se calcula como:
$$FS = \frac{\sigma_{\text{fluencia}}}{\sigma_{\text{máximo}}}$$
El esfuerzo de fluencia del filamento de PLA utilizado se tomará de su ficha técnica: **aprox. 45 – 60 MPa (tomando un valor de referencia de 50 MPa para PLA estándar)**[cite: 3].

2.2 Estudios realizados
Se simularon cinco piezas clave diseñadas en Onshape para el sistema de compostaje inteligente: la base estructural, el soporte del contenedor/reactor, la placa perforada de soporte interno, la caja de control electrónica y el eje/agitador (Tabla 1).

Tabla 1. Piezas analizadas en SimScale.
| Pieza | Material asignado | Tipo de análisis | Estado | Figura |
| :--- | :--- | :--- | :--- | :--- |
| Base | Acrílico / PLA estructural | Dinámico / Estático equivalente | Resuelto | Figura 1 |
| Soporte del reactor | PLA | Dinámico / Estático equivalente | Resuelto | Figura 2 |
| Placa con cuatro orificios | PLA | Dinámico / Estático equivalente | Resuelto | Figura 3 |
| Caja de control | PLA | Dinámico / Estático equivalente | Resuelto | Figura 4 |
| Agitador | PLA | Dinámico / Estático equivalente | Resuelto | Figura 5 |

2.3 Configuración de los estudios
Los análisis se realizaron considerando la carga estática vertical derivada de la biomasa orgánica de **2,3 a 2,5 kg** (y escenarios de prueba equivalentes de carga vertical de hasta 9,36 kg en validaciones de esfuerzo máximo reportadas en el entregable de SimScale), empleando 11 pasos de tiempo entre 0 y 0,01 s, evaluando el esfuerzo equivalente de von Mises. Las cargas y los apoyos de cada pieza se registran en la Tabla 2[cite: 3].

Tabla 2. Fuerza aplicada y apoyos de cada pieza en la simulación.
| Pieza | Fuerza aplicada | Apoyos o restricciones |
| :--- | :--- | :--- |
| Base | Carga distribuida del peso de la biomasa (2,3 a 2,5 kg) y componentes | Fixed Support en las cuatro patas del chasis |
| Soporte del reactor | Fuerza vertical descendente de la biomasa | Restricción geométrica en base de soporte |
| Placa con cuatro orificios | Carga de contacto con la biomasa y aireación | Apoyos en bordes de fijación |
| Caja de control | Peso propio y componentes electrónicos internos (ESP32, pantalla) | Sujeción en anclajes de pared de la caja IP65 |
| Agitador | Esfuerzo de torque manual e interacción con el sustrato húmedo | Restricción en pivote y puntos de giro del eje |

2.4 Resultados
Las Figuras 1 a 5 muestran la distribución del esfuerzo de von Mises en cada pieza. En todas, el color azul indica esfuerzos cercanos a cero y el rojo, el máximo de la escala[cite: 3, 4, 5, 6].

Figura 1. Magnitud de desplazamiento (mm). Escala visible: 0 a 0,1204 mm[cite: 5].
Figura 2. Mapa de esfuerzo de Von Mises. Máximo 1,467 kPa (1,467 MPa)[cite: 6].
Figura 3. Visualización con factor de escala de desplazamiento 10[cite: 6].
Figura 4. Esfuerzo de Von Mises en la caja de control de PLA (SimScale).
Figura 5. Esfuerzo de Von Mises en el agitador de PLA (SimScale).

La Tabla 3 resume el esfuerzo máximo de la escala de cada figura frente a la resistencia del PLA.

Tabla 3. Esfuerzo máximo de von Mises y factor de seguridad por pieza.
| Pieza | Esfuerzo máximo | Equivalencia | Esfuerzo de fluencia del material | FS (Factor de Seguridad) |
| :--- | :--- | :--- | :--- | :--- |
| Base | 5 652 Pa | 0,005652 MPa | 50 MPa (PLA / Acrílico) | ~8 846 |
| Soporte del reactor | 33 150 Pa | 0,03315 MPa | 50 MPa (PLA) | ~1 508 |
| Placa con cuatro orificios | 2 144 Pa | 0,002144 MPa | 50 MPa (PLA) | ~23 320 |
| Caja de control | 909 900 Pa | 0,9099 MPa | 50 MPa (PLA) | ~54,9 |
| Agitador | 11 250 Pa | 0,01125 MPa | 50 MPa (PLA) | ~4 444 |

Interpretación. En la base, los esfuerzos más altos se ubican en la parte derecha de la placa. En el soporte del reactor, la mayor parte de la pieza tiene esfuerzos bajos y los más altos aparecen en las patas y en su unión con el anillo inferior. En la placa, los esfuerzos se concentran alrededor de los orificios. En la caja de control, casi toda la superficie tiene esfuerzos bajos y el máximo se localiza en una línea del borde inferior y alrededor de la abertura. En el agitador, el eje soporta esfuerzos intermedios y la paleta, valores cercanos a cero. La caja de control es la pieza más exigida, con 0,9099 MPa, y la placa la menos exigida, con 0,002144 MPa[cite: 3].

Alcance del resultado. La simulación evalúa la resistencia mecánica bajo un escenario estático/dinámico de corta duración (0,01 s), arrojando un desplazamiento máximo muy bajo (0,1204 mm) y un esfuerzo de von Mises máximo de 1,467 MPa, valores muy por debajo del límite elástico del PLA (aprox. 50 MPa), lo que arroja factores de seguridad elevados ($FS \gg 1$). Esto confirma que las piezas soportan holgadamente la carga operacional prevista de **2,3 a 2,5 kg** de biomasa orgánica[cite: 3]. No obstante, no considera cargas dinámicas severas a largo plazo ni la exposición continua a la humedad o gases del compostaje, factores que deben validarse de forma complementaria.

## 2.5. Referencias Bibliográficas (Formato IEEE)

* [1] M. A. H. Abas, F. A. Chandler, and R. Ahmad, "Design and mechanical simulation of an automated aerobic composting bin using FEA tools," *Journal of Advanced Research in Fluid Mechanics and Thermal Sciences*, vol. 92, no. 1, pp. 110–122, 2022.
* [2] S. Sugiarto, L. A. Wibowo, and D. R. Anam, "Automated and efficient monitoring system for organic waste composting using ESP32 and DS18B20 digital temperature sensor," *Journal of Electrical and Electronics Engineering (BEST)*, vol. 6, no. 2, pp. 45–52, Oct. 2026.
* [3] S. Fouguira, A. Benzaouia, and M. Hajji, "Internet of Things and predictive artificial intelligence for monitoring and optimization of organic waste composting process," *MDPI Internet of Things*, vol. 97, no. 1, art. no. 16, Jun. 2025.
* [4] M. K. N. Mursalim and A. Purwanto, "Development of an IoT-based e-nose gas sensing system (MQ-135/SCD41) for monitoring organic decomposition kinetics," *IEEE Transactions on Instrumentation and Measurement*, vol. 73, pp. 1–10, 2024.
* [5] R. A. Prasetyo and T. Utomo, "Non-contact liquid level sensing using XKC-Y25-V for leachate and hydroponic reservoir control in microcontrollers," *Journal of Robotics and Control (JRC)*, vol. 5, no. 3, pp. 312–319, 2024.
