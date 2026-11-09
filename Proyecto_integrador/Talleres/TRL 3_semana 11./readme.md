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
## Contenido

En este nivel se ejecuta la Prueba de Concepto Tecnológico para el sistema de monitoreo y control automatizado de compostaje (**CompostTech**). El objetivo principal es demostrar mediante ensayos experimentales a nivel de laboratorio la viabilidad de la adquisición de datos fisicoquímicos (temperatura, humedad del sustrato, niveles de lixiviados y gases metabólicos $\text{CO}_2/\text{NH}_3$) y la respuesta del sistema de ventilación forzada para optimizar el bioproceso de descomposición orgánica aerobia.

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
El análisis estructural se centró en evaluar la integridad del prototipo **Compostech** (conjunto recipiente-eje-chasis) bajo la carga estática asociada al peso estimado de la materia orgánica en proceso de compostaje.

**Parámetros de Entrada y Configuración del Escenario Simulado:**
*   **Plataforma de Simulación:** SimScale (Análisis estructural estático).
*   **Carga Aplicada:** Fuerza vertical de $91.8\text{ N}$ aplicada sobre la cara interna inferior del recipiente. Esto equivale a una masa aproximada de $9.36\text{ kg}$ ($\approx 91.8\text{ N} / 9.81\text{ m/s}^2$).
*   **Materiales Asignados:** Recipiente principal en HDPE (Polietileno de Alta Densidad), eje central/chasis en Acero AISI 304 y componentes impresos en PLA.
*   **Condiciones de Contorno (Apoyos):** *Fixed Support* (apoyos fijos) en las cuatro patas del recipiente estructural y restricciones de rodadura en los soportes del eje.

---

### 2.1. Visualización General de Esfuerzos (Von Mises)

La primera etapa del análisis evalúa la distribución del esfuerzo equivalente de Von Mises en todo el ensamblaje bajo el escenario estático reportado, verificando que la respuesta mecánica trabaje en rangos seguros.

![Distribución general de esfuerzos de Von Mises en la compostera bajo carga máxima operativa.](https://github.com/user-attachments/assets/9d77239a-50fd-47f7-a1e9-055d7534d0f5)
> **Cita de Imagen 2.1:** `simscale_von_mises.png`. Esta figura muestra el mapa de calor de esfuerzos de Von Mises. El rango de colores indica la intensidad del esfuerzo en MPa. Se observa que la mayor parte de la estructura trabaja en rangos seguros (azul/verde), con un esfuerzo máximo localizado significativamente por debajo del límite de fluencia del HDPE y del acero.

---

### 2.2. Identificación de Puntos Críticos y Concentraciones de Esfuerzo

Para asegurar la durabilidad del sistema, se analizaron las zonas donde los esfuerzos se concentran (*hotspots*), tales como uniones, filamentos de esquina, soportes de rodamientos y bordes inferiores del recipiente.

![Detalle de las concentraciones de esfuerzo en la unión del eje principal y el soporte del rodamiento.](https://github.com/user-attachments/assets/f6e71a71-86b6-4a2e-8b41-740af1d30d4b)
> **Cita de Imagen 2.2:** `simscale_stress_concentrations.png`. Vista detallada (zoom) que resalta las zonas de máximo esfuerzo ($\sigma_{max}$). Identificar estas áreas permite validar el diseño de componentes críticos como el eje de transmisión y sus soportes de rodamiento, asegurando un Factor de Seguridad ($FS$) adecuado.

---

### 2.3. Análisis de Desplazamiento y Deformación Estructural

Además de la resistencia a la fluencia, la estructura no debe deformarse excesivamente para garantizar la correcta alineación del eje de rotación y el sellado del recipiente.

![Mapa de desplazamiento total (deformación) de la estructura de la compostera.](https://github.com/user-attachments/assets/449b0d67-0ed5-4791-8271-76f4166b902f)
> **Cita de Imagen 2.3:** `simscale_displacement.png`. Mapa de desplazamiento total de la estructura. Se observa un desplazamiento máximo calculado de **$0.1204\text{ mm}$** localizado en la cara inferior del recipiente por efecto de la carga estática. Esta deformación es insignificante respecto a las dimensiones del contenedor y se mantiene dentro de los límites operativos ($<2\text{ mm}$).

---

### 2.4. Calidad de la Malla y Convergencia

Para garantizar la precisión numérica en SimScale, se realizó un estudio de discretización y convergencia de malla, validando que el esfuerzo calculado sea independiente de la densidad de elementos.

![Visualización de la malla de elementos finitos y gráfico de estudio de convergencia.](https://github.com/user-attachments/assets/58d67385-0424-4c2e-a222-c2ca44169df6)
> **Cita de Imagen 2.4:** `mesh_convergence_analysis.png`. A la izquierda, la malla refinada empleada en zonas de alta concentración de esfuerzo. A la derecha, la gráfica de convergencia que confirma la estabilidad del valor numérico de $\sigma_{max}$ al incrementar la densidad de la malla.

---

### 2.5. Resumen de Esfuerzos y Evaluación del Factor de Seguridad

La **Tabla 3** resume los esfuerzos máximos de Von Mises arrojados por la simulación estática para cada componente evaluado en el prototipo Compostech, comparándolos con su respectivo límite de fluencia para determinar la viabilidad estructural.

#### Tabla 3. Esfuerzo máximo de Von Mises y Factor de Seguridad (FS) por componente

| Componente / Pieza | Material Asignado | Esfuerzo Máximo ($\sigma_{max}$) | Equivalencia en MPa | Esfuerzo de Fluencia ($\sigma_{fluencia}$) | Factor de Seguridad ($FS = \frac{\sigma_{fluencia}}{\sigma_{max}}$) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Recipiente Base (Contenedor)** | HDPE | $1,467,000\text{ Pa}$ | $1.467\text{ MPa}$ | $25.0\text{ MPa}$ | **$17.04$** |
| **Eje Principal y Soportes** | Acero AISI 304 | $2,144,000\text{ Pa}$ | $2.144\text{ MPa}$ | $205.0\text{ MPa}$ | **$95.61$** |
| **Abrazadera / Soporte de Rodamiento** | PLA (Impresión 3D) | $909,900\text{ Pa}$ | $0.9099\text{ MPa}$ | $49.5\text{ MPa}$ | **$54.40$** |
| **Pala / Agitador Interno** | PLA (Impresión 3D) | $33,150\text{ Pa}$ | $0.03315\text{ MPa}$ | $49.5\text{ MPa}$ | **$1493.21$** |
| **Placa de Anclaje de Sensores** | PLA (Impresión 3D) | $5,652\text{ Pa}$ | $0.005652\text{ MPa}$ | $49.5\text{ MPa}$ | **$8757.96$** |

---

### 2.6. Despiece y Arquitectura del Sistema CAD

Como parte de la planificación de la fabricación (Indicador TRL 3), se presenta la arquitectura detallada del sistema en una vista explosionada.

<p align="center">
  <img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Recursos%20_Im%C3%A1genes/3D_compostech.png" alt="Vista explosionada (Exploded View) del diseño CAD 3D de la compostera inteligente.">
</p>
> **Cita de Imagen 2.5:** `cad_assembly_exploded.png`. Esta vista permite visualizar la interacción y el orden de montaje de todos los subcomponentes principales: el recipiente HDPE, el eje central, los soportes de rodamiento, el motorreductor, la manivela de accionamiento y el módulo de sensores inteligentes.

---

### 2.7. Conclusión de Viabilidad (TRL 3) y Alcance del Resultado

Los ensayos analíticos realizados en SimScale confirman la **viabilidad estructural (TRL 3)** del prototipo Compostech:

1. **Margen de Seguridad:** El esfuerzo equivalente máximo registrado ($1.467\text{ MPa}$ en el recipiente y $0.9099\text{ MPa}$ en componentes auxiliares) se encuentra muy por debajo de los límites de fluencia del HDPE ($25\text{ MPa}$), Acero AISI 304 ($205\text{ MPa}$) y PLA ($49.5\text{ MPa}$), garantizando factores de seguridad holgados ($FS > 15$).
2. **Deformaciones Controladas:** El desplazamiento máximo calculado es de apenas **$0.1204\text{ mm}$**, lo que confirma que el contenedor no sufrirá deformaciones plásticas ni desalineaciones en sus acoples mecánicos bajo la carga estática evaluada ($91.8\text{ N} \approx 9.36\text{ kg}$).
3. **Alcance y Trabajo Futuro:** El análisis evalúa únicamente la resistencia mecánica bajo condiciones estáticas directas. Para la fase TRL 4 (prototipo físico), se recomienda realizar pruebas empíricas complementarias que evalúen la resistencia del material PLA frente a factores ambientales reales, humedad y la degradación por ácidos orgánicos resultantes del proceso de compostaje.

 ##  Referencias bibliograficas 
* [1] M. A. H. Abas, F. A. Chandler, and R. Ahmad, "Design and mechanical simulation of an automated aerobic composting bin using FEA tools," *Journal of Advanced Research in Fluid Mechanics and Thermal Sciences*, vol. 92, no. 1, pp. 110–122, 2022.
* [2] S. Sugiarto, L. A. Wibowo, and D. R. Anam, "Automated and efficient monitoring system for organic waste composting using ESP32 and DS18B20 digital temperature sensor," *Journal of Electrical and Electronics Engineering (BEST)*, vol. 6, no. 2, pp. 45–52, Oct. 2026.
* [3] S. Fouguira, A. Benzaouia, and M. Hajji, "Internet of Things and predictive artificial intelligence for monitoring and optimization of organic waste composting process," *MDPI Internet of Things*, vol. 97, no. 1, art. no. 16, Jun. 2025.
* [4] M. K. N. Mursalim and A. Purwanto, "Development of an IoT-based e-nose gas sensing system (MQ-135/SCD41) for monitoring organic decomposition kinetics," *IEEE Transactions on Instrumentation and Measurement*, vol. 73, pp. 1–10, 2024.
* [5] R. A. Prasetyo and T. Utomo, "Non-contact liquid level sensing using XKC-Y25-V for leachate and hydroponic reservoir control in microcontrollers," *Journal of Robotics and Control (JRC)*, vol. 5, no. 3, pp. 312–319, 2024.
