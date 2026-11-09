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
El análisis estructural se centró en evaluar la integridad del conjunto tambor-eje-chasis bajo la carga máxima de residuos orgánicos en proceso de compostaje.

**Parámetros de Entrada:**
*   **Carga:** Peso máximo estimado de residuos ($\approx$ 50 kg) + peso propio de la estructura, aplicado como gravedad y carga superficial interna en el tambor.
*   **Materiales:** Tambor de HDPE (Polietileno de Alta Densidad) y eje/chasis de Acero AISI 304.
*   **Condiciones de Contorno:** Soportes fijos en la base del chasis; restricciones de rodadura en los soportes del eje.

### 2.1. Visualización General de Esfuerzos (Von Mises)

La primera etapa del análisis evalúa la distribución de esfuerzos de Von Mises en todo el ensamblaje para identificar si algún componente supera el límite elástico del material.

![Distribución general de esfuerzos de Von Mises en la compostera bajo carga máxima operativa.] <img width="1017" height="726" alt="Captura de pantalla 2026-11-09 153124" src="https://github.com/user-attachments/assets/9d77239a-50fd-47f7-a1e9-055d7534d0f5" />
> **Cita de Imagen 2.1:** `
`. Esta figura muestra el mapa de calor de esfuerzos de Von Mises. El rango de colores indica la intensidad del esfuerzo en MPa. Se observa que la mayor parte de la estructura trabaja en rangos seguros (azul/verde), muy por debajo del límite de fluencia del HDPE y del acero.

### 2.2. Identificación de Puntos Críticos y Concentraciones de Esfuerzo

Para asegurar la durabilidad, es crucial analizar las zonas donde los esfuerzos se concentran, como uniones, esquinas y soportes de rodamientos.

![Detalle de las concentraciones de esfuerzo en la unión del eje principal y el soporte del rodamiento.](simscale_stress_concentrations.png)
> **Cita de Imagen 2.2:** `simscale_stress_concentrations.png`. Vista detallada (zoom) que resalta las zonas de máximo esfuerzo (hotspots). Identificar estas áreas ($\sigma_{max}$) permite validar el diseño de los componentes críticos como el eje de transmisión y sus soportes, asegurando un Factor de Seguridad adecuado.

### 2.3. Análisis de Desplazamiento y Deformación Estructural

Además de resistir los esfuerzos, la estructura no debe deformarse excesivamente para garantizar el correcto funcionamiento de los mecanismos de rotación y sellado.

![Mapa de desplazamiento total (deformación) de la estructura de la compostera.](simscale_displacement.png)
> **Cita de Imagen 2.3:** `simscale_displacement.png`. Esta imagen ilustra la deformación elástica de la estructura en mm. El desplazamiento máximo se localiza en el centro del tambor debido a la carga de los residuos, pero se mantiene dentro de límites aceptables ($<2$ mm) que no comprometen la operación mecánica.

### 2.4. Calidad de la Malla y Convergencia

Para garantizar la precisión de los resultados de SimScale, se realizó un estudio de la calidad de la malla (discretización), asegurando que los resultados numéricos sean independientes del tamaño de los elementos.

![Visualización de la malla de elementos finitos y gráfico de estudio de convergencia.](mesh_convergence_analysis.png)
> **Cita de Imagen 2.4:** `mesh_convergence_analysis.png`. A la izquierda, la malla final utilizada, mostrando mayor refinamiento en zonas críticas. A la derecha, la gráfica de convergencia que demuestra que aumentar la densidad de elementos no cambia significativamente el valor de esfuerzo máximo, validando la precisión de la simulación.

## 2.5. Despiece y Arquitectura del Sistema CAD

Como parte de la planificación de la fabricación (Indicador TRL 3), se presenta la arquitectura detallada del sistema en una vista explosionada.

![Vista explosionada (Exploded View) del diseño CAD 3D de la compostera inteligente.](cad_assembly_exploded.png)
> **Cita de Imagen 2.5:** `cad_assembly_exploded.png`. Esta vista permite visualizar la interacción y el orden de montaje de todos los subcomponentes principales: el tambor HDPE, el eje central, los rodamientos, el motorreductor, el chasis de soporte y el módulo de sensores inteligentes.

## 2.6. Conclusión de Viabilidad (TRL 3)

Los ensayos analíticos realizados en SimScale confirman que el diseño estructural de la compostera inteligente es viable. Los esfuerzos máximos calculados están significativamente por debajo del límite elástico de los materiales propuestos, y las deformaciones son mínimas. Este análisis proporciona la base necesaria para proceder con confianza a la fase de prototipado físico (TRL 4).

 ##  Referencias bibliograficas 
* [1] M. A. H. Abas, F. A. Chandler, and R. Ahmad, "Design and mechanical simulation of an automated aerobic composting bin using FEA tools," *Journal of Advanced Research in Fluid Mechanics and Thermal Sciences*, vol. 92, no. 1, pp. 110–122, 2022.
* [2] S. Sugiarto, L. A. Wibowo, and D. R. Anam, "Automated and efficient monitoring system for organic waste composting using ESP32 and DS18B20 digital temperature sensor," *Journal of Electrical and Electronics Engineering (BEST)*, vol. 6, no. 2, pp. 45–52, Oct. 2026.
* [3] S. Fouguira, A. Benzaouia, and M. Hajji, "Internet of Things and predictive artificial intelligence for monitoring and optimization of organic waste composting process," *MDPI Internet of Things*, vol. 97, no. 1, art. no. 16, Jun. 2025.
* [4] M. K. N. Mursalim and A. Purwanto, "Development of an IoT-based e-nose gas sensing system (MQ-135/SCD41) for monitoring organic decomposition kinetics," *IEEE Transactions on Instrumentation and Measurement*, vol. 73, pp. 1–10, 2024.
* [5] R. A. Prasetyo and T. Utomo, "Non-contact liquid level sensing using XKC-Y25-V for leachate and hydroponic reservoir control in microcontrollers," *Journal of Robotics and Control (JRC)*, vol. 5, no. 3, pp. 312–319, 2024.
