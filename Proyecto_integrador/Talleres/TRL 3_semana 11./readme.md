# PRUEBA Y CALIBRACIÓN DE SENSORES — TRL 3

## Desarrollo experimental o prueba del concepto tecnológico

> **Proyecto:** CompostTech (Monitor de Compostaje Doméstico Inteligente)

| Campo | Información |
| :--- | :--- |
| **Curso** | Proyecto Integrador 2026-II |
| **Integrantes** | Jhunior Moieses Aliaga Cueva; Leonela Angela Aldana Porras; Juan Carlo Ancco Quispe; Alex Jhosep Ccoyllo Sotelo; Ruth Carina Turpo Cayo |
| **Ingenieros** | Umbert Lewis De La Cruz, María Rejas, Harry Rivera y Renzo Chan |
| **Fecha de actualización** | 08/11/2026 |
| **Institución** | Universidad Peruana Cayetano Heredia |
| **Tema** | TRL 3 de Monitor de Compostaje Doméstico Inteligente |

## Contenido

En este nivel se ejecuta la Prueba de Concepto Tecnológico para el sistema de monitoreo y control automatizado de compostaje (**CompostTech**). El objetivo principal es demostrar mediante ensayos experimentales a nivel de laboratorio la viabilidad de la adquisición de datos fisicoquímicos (temperatura, humedad del sustrato, niveles de lixiviados y gases metabólicos $\text{CO}_2/\text{NH}_3$) y la respuesta del sistema de ventilación forzada para optimizar el bioproceso de descomposición orgánica aerobia.

## 1. Descripción del Sistema y Ciclo Operativo

El sistema recibe una masa aproximada de **2,3 a 2,5 kg** de biomasa orgánica (restos vegetales domésticos y de poda) en el contenedor de compostaje y monitorea continuamente los parámetros fisicoquímicos clave del bioproceso: temperatura, humedad del sustrato, concentración de gases y nivel de lixiviados[1,2]. Un microcontrolador **ESP32 DevKit V1** procesa estas señales mediante un algoritmo de decisión por umbrales para coordinar la aireación forzada y notificar alertas al usuario[3,4]. En el **TRL 3** se evalúan y prueban individualmente los elementos que miden y accionan este ciclo:
- **Sensor de temperatura (DS18B20 impermeable):** Entrada principal para identificar las fases mesófila (20–35 °C) y termófila (35–65 °C), y activar la ventilación si supera los 65 °C[2].
- **Sensor de humedad capacitivo (v1.2):** Mide el porcentaje de humedad del sustrato para mantener el rango óptimo (50–70 %)[3].
- **Sensores de gases (SCD41 / MQ-135):** Monitorean la concentración de $\text{CO}_2$ y gases metabólicos u olores ($\text{NH}_3$)[4].
- **Sensor de nivel de lixiviados (XKC-Y25-T12V sin contacto):** Detecta la acumulación del efluente líquido en la base del contenedor de forma no intrusiva[5].
- **Ventilador USB (8025 5V - $80 \times 80 \times 25\text{ mm}$):** Actuador encargado del flujo de aire forzado ante sobrecalentamiento o exceso de gases[1].
- **ESP32 DevKit V1 y Alimentación (Power Bank de 20 000 mAh):** Núcleo de procesamiento, conectividad y fuente de energía segura a 5 V DC[3].

## 2. Ensayos analíticos y simulación estructural en SimScale

El análisis estructural se centró en evaluar la integridad del prototipo **Compostech** (conjunto recipiente-eje-chasis) bajo la carga estática asociada al peso estimado de la materia orgánica en proceso de compostaje.

**Parámetros de Entrada y Configuración del Escenario Simulado:**
*   **Plataforma de Simulación:** SimScale (Análisis estructural estático).
*   **Carga Aplicada:** Fuerza vertical de $91.8\text{ N}$ aplicada sobre la cara interna inferior del recipiente. Esto equivale a una masa aproximada de $9.36\text{ kg}$ ($\approx 91.8\text{ N} / 9.81\text{ m/s}^2$).
*   **Materiales Asignados:** Recipiente principal en HDPE (Polietileno de Alta Densidad), eje central/chasis en Acero AISI 304 y componentes impresos en PLA.
*   **Condiciones de Contorno (Apoyos):** *Fixed Support* (apoyos fijos) en las cuatro patas del recipiente estructural y restricciones de rodadura en los soportes del eje.

---

### 2.1. Visualización General de Esfuerzos (Von Mises)

La primera etapa del análisis evalúa la distribución del esfuerzo equivalente de Von Mises en todo el ensamblaje bajo el escenario estático reportado, verificando que la respuesta mecánica trabaje en rangos seguros.

<p align="center">
  <img width="1017" height="726" alt="Distribución general de esfuerzos de Von Mises" src="https://github.com/user-attachments/assets/9d77239a-50fd-47f7-a1e9-055d7534d0f5">
</p>

> **Figura 2.1:** `simscale_von_mises.png`. Mapa de calor de esfuerzos de Von Mises. El rango cromático indica la intensidad del esfuerzo en MPa, evidenciando que la mayor parte de la estructura opera en rangos seguros (azul/verde), muy por debajo del límite de fluencia del HDPE y del acero.

---

### 2.2. Identificación de Puntos Críticos y Concentraciones de Esfuerzo

Para asegurar la durabilidad del sistema, se analizaron las zonas donde los esfuerzos se concentran (*hotspots*), tales como uniones, filamentos de esquina, soportes de rodamientos y bordes inferiores del recipiente.

<p align="center">
  <img width="765" height="456" alt="Detalle de concentraciones de esfuerzo" src="https://github.com/user-attachments/assets/f6e71a71-86b6-4a2e-8b41-740af1d30d4b">
> **Cita de Imagen 2.2:** `simscale_stress_concentrations.png`. Vista detallada (zoom) que resalta las zonas de máximo esfuerzo ($\sigma_{max}$). Identificar estas áreas permite validar el diseño de componentes críticos como el eje de transmisión y sus soportes de rodamiento, asegurando un Factor de Seguridad ($FS$) adecuado.

---

### 2.3. Análisis de Desplazamiento y Deformación Estructural

Además de la resistencia a la fluencia, la estructura no debe deformarse excesivamente para garantizar la correcta alineación del eje de rotación y el sellado del recipiente.

<p align="center">
  <img width="792" height="575" alt="Mapa de desplazamiento total" src="https://github.com/user-attachments/assets/449b0d67-0ed5-4791-8271-76f4166b902f">
> **Cita de Imagen 2.3:** `simscale_displacement.png`. Mapa de desplazamiento total de la estructura. Se observa un desplazamiento máximo calculado de **$0.1204\text{ mm}$** localizado en la cara inferior del recipiente por efecto de la carga estática. Esta deformación es insignificante respecto a las dimensiones del contenedor y se mantiene dentro de los límites operativos ($<2\text{ mm}$).

---

### 2.4. Calidad de la Malla y Convergencia

Para garantizar la precisión numérica en SimScale, se realizó un estudio de discretización y convergencia de malla, validando que el esfuerzo calculado sea independiente de la densidad de elementos.

<p align="center">
  <img width="742" height="317" alt="Visualización de la malla y convergencia" src="https://github.com/user-attachments/assets/58d67385-0424-4c2e-a222-c2ca44169df6">
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

---
# 3. Ensayos experimentales: pruebas de sensores y actuadores

## 3.1 Qué mide cada elemento del sistema
El sistema utiliza sensores para caracterizar las condiciones fisicoquímicas del compostaje aerobio y actuadores para controlar variables clave como la temperatura y la concentración de gases[1, 3]. En esta etapa se verificó el funcionamiento individual de los componentes electrónicos y su correcta integración con el microcontrolador ESP32[2, 4]. La Tabla 4 resume la función y el tipo de prueba realizada.

#### Tabla 4. Elementos probados en el TRL 3 para el monitoreo de compostaje.
| Elemento | Variable o función | Principio | Prueba realizada |
| :--- | :--- | :--- | :--- |
| **Sensor de temperatura (DS18B20)** | Temperatura del sustrato de compostaje | Termistor / Digital (OneWire) | Verificación de lectura en fases mesófila y termófila simulada[2] |
| **Sensor de humedad capacitivo (v1.2)** | Humedad relativa del sustrato (50% - 70%) | Capacitivo (variación dieléctrica) | Lectura en aire, sustrato seco y sustrato húmedo[3] |
| **Sensores de gases (SCD41 / MQ-135)** | Concentración de $\text{CO}_2$ y gases metabólicos ($\text{NH}_3$) | NDIR (SCD41) y semiconductor (MQ-135) | Prueba de respuesta ante emisión de gases y calibración base[4] |
| **Sensor de nivel (XKC-Y25-T12V)** | Presencia de lixiviados en la base | Capacitivo sin contacto | Detección de líquido a través de la pared del contenedor[5] |
| **Ventilador USB (8025 5V)** | Ventilación forzada y control de temperatura | Electromecánico (DC) | Activación por umbrales de temperatura y concentración de gases[1] |
| **Interruptor KCD1** | Control general de encendido y apagado | Contacto eléctrico mecánico | Interrupción y restablecimiento de la alimentación general[1] |[1,2,3,4,5]

## 3.2 Conversión de las señales en datos
El microcontrolador ESP32 DevKit V1 procesa las señales de los sensores mediante sus pines digitales y convertidores analógico-digitales (ADC) a 12 bits (valores de 0 a 4095)[2,3]. Las conversiones específicas para el control del compostaje son[1,4]:
- **Temperatura (DS18B20):** Utiliza el protocolo OneWire para entregar directamente valores en grados Celsius ($\text{°C}$), permitiendo identificar las etapas del compostaje (mesófila y termófila) para disparar la ventilación si se superan los límites operativos[2].
- **Humedad del sustrato (v1.2):** Entrega una tensión analógica inversamente proporcional al contenido de humedad. Se calibró mediante puntos de referencia extremos (seco y saturado) para mapear el porcentaje de humedad al rango óptimo del bioproceso (50–70%)[3].
- **Gases metabólicos (SCD41 / MQ-135):** El sensor SCD41 entrega mediciones directas de $\text{CO}_2$ en partes por millón (ppm) mediante comunicación I2C, mientras que el MQ-135 entrega una señal analógica relacionada con la concentración de compuestos volátiles y $\text{NH}_3$[4].
- **Nivel de lixiviados (XKC-Y25-T12V):** Actúa como un interruptor lógico digital (alto/bajo) que detecta la presencia de efluentes líquidos acumulados en el fondo del contenedor sin entrar en contacto directo con el líquido[5].
- **Ventilación Forzada:** El ventilador se acciona mediante modulación o conmutación digital a través de un transistor cuando los umbrales de temperatura o $\text{CO}_2$ superan los parámetros óptimos del compostaje aerobio[1,4].

## 3.3 Procedimiento de las pruebas
Las pruebas se realizaron sobre un banco experimental armado en protoboard, alimentado mediante una fuente regulada a 5 V DC, visualizando los datos en el monitor serial del IDE de Arduino[2,3]:
1. **Temperatura:** Se conectó el DS18B20 al pin digital configurado con resistencia *pull-up*. Se realizaron pruebas de respuesta térmica sumergiendo el sensor en agua a temperatura ambiente y agua ligeramente templada para simular el inicio de la fase mesófila[2].
2. **Humedad:** Se conectó el sensor capacitivo v1.2 al canal ADC del ESP32. Se realizaron tres mediciones independientes en aire libre, en sustrato seco y en sustrato con humedad controlada[3].
3. **Gases:** Se energizaron los módulos SCD41 y MQ-135 respetando su tiempo de calentamiento (*burn-in*). Se verificó la lectura de $\text{CO}_2$ en aire ambiente y se comprobó la variación de la señal ante la presencia de vapores orgánicos[4].
4. **Nivel de lixiviados:** Se adhirió el sensor XKC-Y25-T12V a la pared exterior de un recipiente de prueba transparente y se verificó el cambio de estado de su indicador LED al aproximar agua al nivel del sensor[5].
5. **Ventilador e Interruptor:** Se probó la interrupción de energía mediante el interruptor KCD1 y la respuesta del ventilador USB controlado por el ESP32 ante un comando de activación por umbral de temperatura[1,2].

## 3.4 Valores de referencia y criterio de aceptación
Los criterios de evaluación se definieron en función de la respuesta esperada de los sensores frente a los parámetros biológicos del compostaje aerobio[1,2].

#### Tabla 5. Valores de referencia y criterios de aceptación para el monitoreo de compostaje.
| Elemento | Prueba | Valor de referencia | Criterio de aceptación |
| :--- | :--- | :--- | :--- |
| **Sensor de temperatura** | Lectura térmica | Rangos mesófilo (20-35 °C) y termófila (35-65 °C)[2] | Lecturas estables y coherentes con el entorno en menos de 5 segundos[2] |
| **Sensor de humedad** | Pruebas en sustrato | Rango óptimo de compostaje (50% - 70%)[3] | Diferenciación clara entre los estados seco, óptimo y saturado[3] |
| **Sensores de gases** | Emisión de gases | Concentración base de $\text{CO}_2$ ambiental ($\approx 400$ ppm)[4] | Respuesta alícuota y detección de elevación de $\text{CO}_2$ y $\text{NH}_3$[4] |
| **Sensor de nivel** | Detección de líquidos | Presencia de líquido en el fondo del depósito[cite: 5] | Cambio de estado lógico (alto/bajo) inmediato al contacto virtual[5] |
| **Ventilador / Interruptor** | Ciclos de control | Respuesta a umbrales y corte de energía[1] | Activación correcta del actuador y corte físico verificado con multímetro[1] |[1,2,3,4,5]

## 3.5 Resultados de las pruebas
La Tabla 6 sintetiza los resultados experimentales obtenidos durante la validación de los componentes electrónicos del sistema CompostTech en la fase TRL 3[1,2,3,4,5].

#### Tabla 6. Resumen de las pruebas experimentales de sensores y actuadores.
| Elemento | Resultado | Lectura o evidencia | Estado |
| :--- | :--- | :--- | :--- |
| **Sensor de temperatura** | Lecturas térmicas correctas | Temperatura ambiente registrada: 23.5 °C; respuesta rápida al tacto[2] | Prueba funcional completada con éxito[2] |
| **Sensor de humedad** | Mapeo de tensión en sustrato | Aire: 3.12 V; Sustrato húmedo: 1.65 V[3] | Verificación analógica completada[3] |
| **Sensores de gases** | Estabilidad y respuesta en bus I2C/ADC | SCD41 estable en ~420 ppm de $\text{CO}_2$ en aire libre[4] | Calibración base realizada[4] |
| **Sensor de nivel** | Conmutación por proximidad | Encendido de LED indicador y cambio a nivel lógico alto[5] | Prueba funcional completada[5] |
| **Ventilador e Interruptor** | Control de energía y flujo de aire | Tres ciclos de encendido y corte de 5V verificados sin caídas anómalas[1] | Integración validada para prototipo[1] |[1,2,3,4,5]

## 3.6. Comportamiento, Pruebas y Calibración de Sensores en las Etapas del Compostaje

Para validar el funcionamiento del sistema en condiciones reales de operación (TRL 3), las pruebas experimentales consideran la respuesta de los sensores frente a la evolución natural de las **tres etapas del proceso de compostaje aerobio**[1,2,3]:

1. **Fase Mesófila (Temperatura inicial: 20 °C – 45 °C):**
   * **Sensores evaluados:** DS18B20 (Temperatura) y Humedad v1.2[2,3].
   * **Dinámica y calibración:** Al inicio del proceso, los microorganismos mesófilos descomponen los azúcares y aminoácidos solubles, generando un incremento gradual de la temperatura y un consumo activo de humedad[2,3]. En esta etapa se calibran los umbrales base del sensor de temperatura y se verifica que el sensor de humedad mantenga el registro dentro del rango óptimo (50% - 70%)[2,3]. El sensor de lixiviados (XKC-Y25) monitorea la posible liberación inicial de efluentes líquidos por compactación de la biomasa[5].

2. **Fase Termófila (Temperatura alta: 45 °C – 65 °C o más):**
   * **Sensores evaluados:** DS18B20, SCD41 / MQ-135 (Gases) y Actuador de Ventilación (Ventilador 8025)[1,2,4].
   * **Dinámica y calibración:** Es la etapa de mayor actividad microbiana y degradación de compuestos complejos (celulosa y lignina)[1,2]. Aquí el sensor de temperatura valida el cruce del umbral crítico ($>65\text{ °C}$), activando automáticamente el ventilador USB para forzar la aireación[1,2]. Simultáneamente, los sensores de gas registran los picos de emisión de $\text{CO}_2$ y gases metabólicos ($\text{NH}_3$), permitiendo calibrar la respuesta del sistema ante la acumulación de gases por alta actividad aerobia[4].

3. **Fase de Enfriamiento y Maduración (Estabilización a temperatura ambiente):**
   * **Sensores evaluados:** Conjunto completo (Temperatura, Humedad, Gases y Lixiviados)[2,3,4,5].
   * **Dinámica y calibración:** La temperatura desciende y se estabiliza cerca de los valores ambientales[2]. En esta etapa se comprueba la estabilidad a largo plazo de las lecturas del ESP32, asegurando que la disminución de la actividad microbiana se refleje en lecturas estables de $\text{CO}_2$ y una humedad residual controlada antes de dar por concluido el ciclo de prueba TRL 3[2,3,4].
   * 
## Referencias Bibliográficas

- [1] M. A. H. Abas, F. A. Chandler, and R. Ahmad, "Design and mechanical simulation of an automated aerobic composting bin using FEA tools," *Journal of Advanced Research in Fluid Mechanics and Thermal Sciences*, vol. 92, no. 1, pp. 110–122, 2022.
- [2] S. Sugiarto, L. A. Wibowo, and D. R. Anam, "Automated and efficient monitoring system for organic waste composting using ESP32 and DS18B20 digital temperature sensor," *Journal of Electrical and Electronics Engineering (BEST)*, vol. 6, no. 2, pp. 45–52, Oct. 2026.
- [3] S. Fouguira, A. Benzaouia, and M. Hajji, "Internet of Things and predictive artificial intelligence for monitoring and optimization of organic waste composting process," *MDPI Internet of Things*, vol. 97, no. 1, art. no. 16, Jun. 2025.
- [4] M. K. N. Mursalim and A. Purwanto, "Development of an IoT-based e-nose gas sensing system (MQ-135/SCD41) for monitoring organic decomposition kinetics," *IEEE Transactions on Instrumentation and Measurement*, vol. 73, pp. 1–10, 2024.
- [5] R. A. Prasetyo and T. Utomo, "Non-contact liquid level sensing using XKC-Y25-V for leachate and hydroponic reservoir control in microcontrollers," *Journal of Robotics and Control (JRC)*, vol. 5, no. 3, pp. 312–319, 2024.
