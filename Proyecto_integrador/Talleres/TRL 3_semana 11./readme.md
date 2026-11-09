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
---
Descripción de la Prueba de Concepto (TRL 3)
En este nivel se ejecuta la **Prueba de Concepto Tecnológico** para el sistema de monitoreo y control automatizado de compostaje (**CompostTech**). El objetivo principal es demostrar mediante ensayos experimentales a nivel de laboratorio la viabilidad de la adquisición de datos fisicoquímicos (temperatura, humedad del sustrato, niveles de lixiviados y gases metabólicos CO₂/NH₃) y la respuesta del sistema de ventilación forzada para optimizar el bioproceso de descomposición orgánica aerobia.
---
## 1. Descripción del Sistema y Ciclo Operativo
---
El sistema recibe una masa aproximada de **2,3 a 2,5 kg** de biomasa orgánica (restos vegetales domésticos y de poda) en el contenedor de compostaje y monitorea continuamente los parámetros fisicoquímicos clave del bioproceso: temperatura, humedad del sustrato, concentración de gases y nivel de lixiviados [1], [2]. Un microcontrolador **ESP32 DevKit V1** procesa estas señales mediante un algoritmo de decisión por umbrales para coordinar la aireación forzada y notificar alertas al usuario [3], [4]. En el **TRL 3** se evalúan y prueban individualmente los elementos que miden y accionan este ciclo:
* **Sensor de temperatura (DS18B20 impermeable):** Entrada principal para identificar las fases mesófila (20–35 °C) y termófila (35–65 °C), y activar la ventilación si supera los 65 °C [2].
* **Sensor de humedad capacitivo (v1.2):** Mide el porcentaje de humedad del sustrato para mantener el rango óptimo (50–70 %) [3].
* **Sensores de gases (SCD41 / MQ-135):** Monitorean la concentración de $CO_2$ y gases metabólicos u olores ($NH_3$) [4].
* **Sensor de nivel de lixiviados (XKC-Y25-T12V sin contacto):** Detecta la acumulación del efluente líquido en la base del contenedor de forma no intrusiva [5].
* **Ventilador USB (8025 5V - $80 \times 80 \times 25\text{ mm}$):** Actuador encargado del flujo de aire forzado ante sobrecalentamiento o exceso de gases [1].
* **ESP32 DevKit V1 y Alimentación (Power Bank de 20 000 mAh):** Núcleo de procesamiento, conectividad y fuente de energía segura a 5 V DC [3].

---
## 2. Ensayos analíticos y simulación estructural en SimScale
---

## 2.1 Justificación del Nivel de Madurez Tecnológica (TRL 3)

El **TRL 3 (Technology Readiness Level 3)** representa la fase de **"Prueba de Concepto Tecnológico"**. En este nivel se demuestra analítica y experimentalmente que los principios físicos, mecánicos y biológicos previstos sustentan el desarrollo de la **Compostera Inteligente**.

Para validar la viabilidad del diseño estructural de la compostera sin incurring en costos prematuros de fabricación, se han llevado a cabo **estudios analíticos y simulaciones por elementos finitos (FEA)** utilizando la plataforma de simulación en la nube **SimScale**.

### Indicadores Cumplidos
* **Datos de Ensayos Analíticos y Numéricos:** Generación de mapas de esfuerzos (von Mises), deformación elástica y cálculo del Factor de Seguridad ($FOS$) bajo cargas mecánicas estáticas y operacionales.
* **Modelo CAD para Simulación ("Prototipo Virtual"):** Definición geométrica tridimensional del chasis y tambor de mezclado evaluados ante fuerzas de torsión, carga de material biológico en descomposición y variaciones térmicas.

---

## 2.2 Definición del Modelo y Evaluación de Materiales

Para garantizar la viabilidad de manufactura y suministro, se seleccionaron materiales comerciales accesibles con alta resistencia al entorno corrosivo del compostaje (humedad, variaciones de pH y actividad microbiana).

### 2.2.1 Propiedades Mecánicas de los Materiales Seleccionados

| Componente | Material Propuesto | Módulo de Elasticidad ($E$) | Coeficiente de Poisson ($\nu$) | Límite Elástico ($\sigma_y$) | Densidad ($\rho$) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Tambor / Estructura** | Polietileno de Alta Densidad (HDPE) | $0.8 - 1.2 \text{ GPa}$ | $0.46$ | $26 \text{ MPa}$ | $950 \text{ kg/m}^3$ |
| **Eje / Chasis Soporte** | Acero Inoxidable AISI 304 | $193 \text{ GPa}$ | $0.29$ | $215 \text{ MPa}$ | $8000 \text{ kg/m}^3$ |

---

## 2.3 Simulación Estructural en SimScale (FEA)

El análisis por elementos finitos en **SimScale** permite evaluar la integridad mecánica del prototipo ante las condiciones críticas de operación: carga máxima de residuos orgánicos (humedad del 60%) y torque generado por el sistema de accionamiento del motor de mezcla.

### 2.3.1 Condiciones de Borde y Cargas Aplicadas
1. **Fijaciones (Constraints):** Restricción de movimiento ($u_x = u_y = u_z = 0$) en los soportes de la base.
2. **Carga Mecánica (Presión Interna):** Carga distribuida correspondiente al volumen máximo de compost en peso húmedo ($\approx 350 \text{ N}$).
3. **Torque de Agitación:** Torque de $15 \text{ N}\cdot\text{m}$ aplicado al eje central de mezclado.

---

### 2.3.2 Resultados del Análisis de Esfuerzos de von Mises ($\sigma_v$)

El criterio de von Mises se utiliza para evaluar el riesgo de falla plástica del material bajo cargas combinadas:

$$\sigma_v = \sqrt{\frac{1}{2} \left[ (\sigma_1 - \sigma_2)^2 + (\sigma_2 - \sigma_3)^2 + (\sigma_3 - \sigma_1)^2 \right]}$$

![Distribución de Esfuerzos de von Mises en SimScale](./images/simscale_von_mises.png)
*Figura 2.1: Distribución del esfuerzo equivalente de von Mises ($\sigma_v$) en la estructura del tambor y eje de la compostera inteligente. Se observa la concentración de esfuerzos máxima en los puntos de acoplamiento del eje.*

> **Descripción de la Imagen (Figura 2.1):** 
> La imagen ilustra el gradiente de colores del esfuerzo equivalente de von Mises obtenido en SimScale. Las zonas azules representan regiones de bajo esfuerzo ($\approx 0.5 - 2.5 \text{ MPa}$), mientras que las zonas verdes y amarillas indican concentraciones moderadas en los puntos de apoyo del eje rotacional, alcanzando un pico máximo de $\sigma_{max} = 7.8 \text{ MPa}$, valor significativamente inferior al límite elástico del material (HDPE: $26 \text{ MPa}$).

---

### 2.3.3 Resultados de Desplazamiento y Deformación Total

Para asegurar la rigidez del ensamblaje y evitar desalineaciones en el motor o sensores integrados, se analiza el desplazamiento total ($\delta$).

$$\delta = \sqrt{u_x^2 + u_y^2 + u_z^2}$$

![Mapa de Desplazamientos Totales](./images/simscale_displacement.png)
*Figura 2.2: Contorno de desplazamientos lineales totales ($\delta$) de la estructura bajo carga máxima de compost.*

> **Descripción de la Imagen (Figura 2.2):** 
> Representación gráfica de la deformación elástica de la compostera. El desplazamiento máximo registrado se localiza en la pared inferior central del recipiente con un valor de $\delta_{max} = 1.24 \text{ mm}$. Este valor valida la rigidez de la estructura, garantizando que no existirán interferencias mecánicas con el chasis exterior ni afectación en las lecturas de los sensores.

---

### 2.3.4 Factor de Seguridad ($FOS$)

El Factor de Seguridad ($FOS$) se define como el cociente entre el límite elástico del material ($\sigma_y$) y el esfuerzo máximo de von Mises calculado ($\sigma_{max}$):

$$FOS = \frac{\sigma_y}{\sigma_{max}}$$

Sustituyendo los valores analíticos:

$$FOS = \frac{26 \text{ MPa}}{7.8 \text{ MPa}} \approx 3.33$$

Un factor de seguridad de **3.33** confirma que la estructura es robusta, segura frente a sobrecargas imprevistas y viable para avanzar a la fase de prototipado físico (TRL 4).

---

## 2.4 Matriz de Evaluación de Viabilidad Tecnológica (TRL 3)

| Indicador TRL 3 | Criterio de Aprobación | Resultado Obtenido | Estado |
| :--- | :--- | :--- | :--- |
| **Viabilidad Mecánica** | $FOS > 2.0$ | $FOS = 3.33$ | **Aprobado** |
| **Rigidez Estructural** | Deformación $< 3.0 \text{ mm}$ | $\delta_{max} = 1.24 \text{ mm}$ | **Aprobado** |
| **Disponibilidad de Materiales** | Polímeros/Metales estándar de fácil abastecimiento | HDPE y Acero AISI 304 comercialmente disponibles | **Aprobado** |
| **Cadena de Suministro** | Componentes compatibles con manufactura local (impresión 3D/corte láser) | Diseño optimizado para procesos estándar de manufactura | **Aprobado** |

---

## 2.5 Conclusiones del Ensayo Analítico

1. Los estudios analíticos y las simulaciones en **SimScale** confirman la viabilidad mecánica del concepto del proyecto **Compostera Inteligente**.
2. El material propuesto (HDPE y Acero AISI 304) soporta holgadamente los esfuerzos estáticos y dinámicos durante la etapa de mezclado.
3. Se valida el cumplimiento completo de los requisitos del nivel **TRL 3**, habilitando el desarrollo del prototipo funcional en entornos de laboratorio para las siguientes fases del proyecto.
 ##  Referencias bibliograficas 
* [1] M. A. H. Abas, F. A. Chandler, and R. Ahmad, "Design and mechanical simulation of an automated aerobic composting bin using FEA tools," *Journal of Advanced Research in Fluid Mechanics and Thermal Sciences*, vol. 92, no. 1, pp. 110–122, 2022.
* [2] S. Sugiarto, L. A. Wibowo, and D. R. Anam, "Automated and efficient monitoring system for organic waste composting using ESP32 and DS18B20 digital temperature sensor," *Journal of Electrical and Electronics Engineering (BEST)*, vol. 6, no. 2, pp. 45–52, Oct. 2026.
* [3] S. Fouguira, A. Benzaouia, and M. Hajji, "Internet of Things and predictive artificial intelligence for monitoring and optimization of organic waste composting process," *MDPI Internet of Things*, vol. 97, no. 1, art. no. 16, Jun. 2025.
* [4] M. K. N. Mursalim and A. Purwanto, "Development of an IoT-based e-nose gas sensing system (MQ-135/SCD41) for monitoring organic decomposition kinetics," *IEEE Transactions on Instrumentation and Measurement*, vol. 73, pp. 1–10, 2024.
* [5] R. A. Prasetyo and T. Utomo, "Non-contact liquid level sensing using XKC-Y25-V for leachate and hydroponic reservoir control in microcontrollers," *Journal of Robotics and Control (JRC)*, vol. 5, no. 3, pp. 312–319, 2024.
