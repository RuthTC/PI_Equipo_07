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
## 1. Descripción de la Prueba de Concepto (TRL 3)
En este nivel se ejecuta la **Prueba de Concepto Tecnológico** para el sistema de monitoreo y control automatizado de compostaje (**CompostTech**). El objetivo principal es demostrar mediante ensayos experimentales a nivel de laboratorio la viabilidad de la adquisición de datos fisicoquímicos (temperatura, humedad del sustrato, niveles de lixiviados y gases metabólicos CO₂/NH₃) y la respuesta del sistema de ventilación forzada para optimizar el bioproceso de descomposición orgánica aerobia.

## 2. Enfoque Aplicado y Componentes Evaluados
## 2.1. Descripción del Sistema y Ciclo Operativo
El sistema recibe una masa aproximada de **2,3 a 2,5 kg** de biomasa orgánica (restos vegetales domésticos y de poda) en el contenedor de compostaje y monitorea continuamente los parámetros fisicoquímicos clave del bioproceso: temperatura, humedad del sustrato, concentración de gases y nivel de lixiviados [1], [2]. Un microcontrolador **ESP32 DevKit V1** procesa estas señales mediante un algoritmo de decisión por umbrales para coordinar la aireación forzada y notificar alertas al usuario [3], [4]. En el **TRL 3** se evalúan y prueban individualmente los elementos que miden y accionan este ciclo:
* **Sensor de temperatura (DS18B20 impermeable):** Entrada principal para identificar las fases mesófila (20–35 °C) y termófila (35–65 °C), y activar la ventilación si supera los 65 °C [2].
* **Sensor de humedad capacitivo (v1.2):** Mide el porcentaje de humedad del sustrato para mantener el rango óptimo (50–70 %) [3].
* **Sensores de gases (SCD41 / MQ-135):** Monitorean la concentración de $CO_2$ y gases metabólicos u olores ($NH_3$) [4].
* **Sensor de nivel de lixiviados (XKC-Y25-T12V sin contacto):** Detecta la acumulación del efluente líquido en la base del contenedor de forma no intrusiva [5].
* **Ventilador USB (8025 5V - $80 \times 80 \times 25\text{ mm}$):** Actuador encargado del flujo de aire forzado ante sobrecalentamiento o exceso de gases [1].
* **ESP32 DevKit V1 y Alimentación (Power Bank de 20 000 mAh):** Núcleo de procesamiento, conectividad y fuente de energía segura a 5 V DC [3].

---

## 2.2. Ensayo Analítico (Sección 2)
* **Simulación estructural y térmica:** Análisis mediante herramientas CAE (*SimScale* / Elementos Finitos) de las cinco piezas principales del prototipo (tapa del contenedor, soporte estanco de sensores, conducto del ventilador, chasis estructural y caja protectora IP65 del ESP32) para verificar la resistencia a esfuerzos mecánicos por la biomasa y deformaciones térmicas hasta 65 °C [1].

---

## 2.3. Ensayos Experimentales (Sección 3)
* **Acondicionamiento y conversión de señales:** Calibración del conversor analógico-digital (ADC) del ESP32 para transformar las señales eléctricas de los sensores en variables físicas reales (°C, % de humedad, ppm de $CO_2$/$NH_3$ y estados discretos HIGH/LOW para lixiviados) [3], [4].
* **Pruebas unitarias de sensores y actuadores:**
  * Curvas de respuesta temporal del sensor DS18B20 y del sensor capacitivo en sustrato con humedad controlada.
  * Verificación de la conmutación del sensor capacitivo de lixiviados XKC-Y25 a través de la pared del contenedor.
  * Medición de consumo de corriente, caudal y efectividad del ventilador USB de 5V accionado mediante la señal digital del microcontrolador [1].

---

## 2.4. Demo del Prototipo (Sección 4)
* **Banco de pruebas y prototipo físico:** Ensamble completo del circuito electrónico en protoboard y sobre la estructura física preliminar (ESP32, pantalla OLED 1.3", módulos sensores y etapa de potencia del ventilador), ejecutando el firmware de adquisición de datos y despliegue local de estados [3].

---

## 2.5. Referencias Bibliográficas (Formato IEEE)

* [1] M. A. H. Abas, F. A. Chandler, and R. Ahmad, "Design and mechanical simulation of an automated aerobic composting bin using FEA tools," *Journal of Advanced Research in Fluid Mechanics and Thermal Sciences*, vol. 92, no. 1, pp. 110–122, 2022.
* [2] S. Sugiarto, L. A. Wibowo, and D. R. Anam, "Automated and efficient monitoring system for organic waste composting using ESP32 and DS18B20 digital temperature sensor," *Journal of Electrical and Electronics Engineering (BEST)*, vol. 6, no. 2, pp. 45–52, Oct. 2026.
* [3] S. Fouguira, A. Benzaouia, and M. Hajji, "Internet of Things and predictive artificial intelligence for monitoring and optimization of organic waste composting process," *MDPI Internet of Things*, vol. 97, no. 1, art. no. 16, Jun. 2025.
* [4] M. K. N. Mursalim and A. Purwanto, "Development of an IoT-based e-nose gas sensing system (MQ-135/SCD41) for monitoring organic decomposition kinetics," *IEEE Transactions on Instrumentation and Measurement*, vol. 73, pp. 1–10, 2024.
* [5] R. A. Prasetyo and T. Utomo, "Non-contact liquid level sensing using XKC-Y25-V for leachate and hydroponic reservoir control in microcontrollers," *Journal of Robotics and Control (JRC)*, vol. 5, no. 3, pp. 312–319, 2024.
