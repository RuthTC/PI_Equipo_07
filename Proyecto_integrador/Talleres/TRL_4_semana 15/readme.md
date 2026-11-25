# VALIDACIÓN TECNOLÓGICA EN ENTORNO DE LABORATORIO – PRUEBAS DE BAJA FIDELIDAD — TRL 4

## Validación de componentes y prototipo funcional en entorno de laboratorio

> **Proyecto:** CompostTech (Monitor de Compostaje Doméstico Inteligente — Biorreactor doméstico compacto para compostaje aeróbico con sistema de mezclado manual seguro, monitoreo multisensorial IoT y toma de decisiones mediante inteligencia artificial).

| Campo | Información |
| :--- | :--- |
| **Curso** | Proyecto Integrador 2026-II |
| **Integrantes** | Jhunior Moieses Aliaga Cueva; Leonela Angela Aldana Porras; Juan Carlo Ancco Quispe; Alex Jhosep Ccoyllo Sotelo; Ruth Carina Turpo Cayo |
| **Ingenieros** | Umbert Lewis De La Cruz, María Rejas, Harry Rivera y Renzo Chan |
| **Fecha de actualización** | 24/11/2026 |
| **Institución** | Universidad Peruana Cayetano Heredia |
| **Tema** | TRL 4 de Monitor de Compostaje Doméstico Inteligente (CompostTech) |


---

## 1. Objetivo de la validación tecnológica

Validar a nivel de laboratorio y en un ambiente simulado de uso doméstico el funcionamiento integrado del prototipo funcional **«Compostech»** (biorreactor compacto para compostaje aeróbico asistido por IoT e Inteligencia Artificial). 

El propósito específico de esta etapa **TRL 4** es comprobar que los subsistemas mecánico, electrónico, de sensado y de software operan de manera conjunta y sincronizada sin interferencias físicas ni degradación de componentes, demostrando la capacidad del sistema para:
* Monitorear variables críticas en tiempo real (temperatura central, humedad estratificada, gases volátiles $CO_2$ / $NH_3$ y nivel de lixiviados).
* Ejecutar el control térmico y de aireación automatizado mediante histéresis.
* Clasificar las etapas del proceso mediante un modelo predictivo (*Random Forest*) para emitir alertas preventivas en una aplicación móvil.

---

## 2. Diseño del prototipo

El diseño del prototipo **«Compostech»** responde a una arquitectura modular compacta orientada a superar las limitaciones de las composteras pasivas (falta de control y malos olores) y de los compostadores eléctricos comerciales (alto consumo energético por resistencias y trituración).

* **Estructura y cámara de compostaje:** Cuerpo principal fabricado en ácido poliláctico (PLA) mediante impresión 3D (con proyección industrial a polipropileno copolímero, PP), conformado por dos mitades de `180 × 280 × 200 mm` unidas mediante bridas, pernos M3 y refuerzos de varillas de `14.74 MPa`. Incluye una tapa superior de `280 × 180 mm` y un fondo ranurado para drenaje gravitacional.
* **Sistema de aireación mecánica con zona de guarda:** Eje segmentado de `16 mm` acoplado a una manivela externa de `150-180 mm` de brazo y soportado por rodamientos sellados (`6003-2RS`), retenes y collarines. El eje incorpora paletas curvas mezcladoras dispuestas dejando un espacio central libre (*zona de guarda*), diseñado específicamente para evitar el choque mecánico y el cizallamiento de las sondas internas durante el volteo.
* **Protección contra condensación y gestión de lixiviados:** Carcasa lateral con ranuras inclinadas para alojar el sensor de gases, evitando el contacto directo con condensación ácida; bandeja inferior extraíble de `1,4 L` (`200 × 100 × 70 mm`) para recolección de lixiviados; soporte inclinado ergonómico para visualización local y caja electrónica estanca (`130 × 150 × 50 mm`).

---

## 3. Integración de componentes

En esta fase se consolidó la integración física, eléctrica y lógica de los cuatro subsistemas básicos del prototipo para garantizar su operación conjunta:

| Subsistema | Componentes Integrados | Interfaz y Función de Integración |
| :--- | :--- | :--- |
| **Mecánico y Estructural** | Cámara en PLA, eje segmentado (`15-16 mm`), paletas curvas, manivela (`150-180 mm`), rodamientos `6003-2RS` y bandeja inferior. | Permite el volteo manual (5–10 vueltas/ciclo) manteniendo la integridad física de las sondas internas gracias a la zona de guarda y drenando líquidos hacia la bandeja. |
| **Adquisición de Datos (Sensado)** | Sonda térmica `DS18B20` (núcleo), 2 sensores capacitivos de humedad `v1.2` (estrato superior e inferior), sensor de gases `MQ-135` (carcasa ranurada) y flotador magnético `P45` (bandeja). | Muestrean simultáneamente cada **4 segundos** las condiciones fisicoquímicas de la biomasa y el nivel de lixiviados sin exposición directa a condensación ni golpes mecánicos. |
| **Control y Actuación Local** | Microcontrolador `ESP32` en PCB FR-4, ventilador extractor de `12 V DC` y pantalla OLED I2C (`SSD1306`). | El ESP32 filtra las señales cada 4 s, ejecuta el lazo de control On-Off con histéresis térmica (encendido `≥ 58 °C` o pico de gases; apagado `< 55 °C`) para el extractor y actualiza métricas e íconos de estado en la pantalla OLED. |
| **Software e Inteligencia Artificial** | Firmware ESP32 (Wi-Fi), base de datos en `Firebase`, aplicación móvil en `Flutter` y modelo `Random Forest`. | Transmite los registros por Wi-Fi hacia la app, donde el algoritmo *Random Forest* clasifica el proceso en 4 estados (mesófila, termófila, enfriamiento o condición anómala/anaerobia) y dispara recomendaciones preventivas. |

---

## 4. Materiales y equipos

Para la fabricación del prototipo funcional y la ejecución de las pruebas de validación a nivel laboratorio se emplearon los siguientes recursos:

### Materiales de fabricación y electrónicos
* **Polímeros y sujeción:** Filamento PLA para impresión 3D de carcasa, soportes, paletas y bandeja; pernos y tuercas M3, varillas de refuerzo de `14.74 MPa`, eje de `15-16 mm`, rodamientos sellados `6003-2RS`, collarines y retenes de estanqueidad.
* **Electrónica y potencia:** Placa de circuito impreso (PCB FR-4), microcontrolador `ESP32`, sensor de temperatura sumergible `DS18B20` con vaina metálica, dos sensores capacitivos de humedad de suelo `v1.2`, sensor de calidad de aire/gases `MQ-135`, sensor de nivel tipo flotador magnético `P45`, pantalla OLED `SSD1306` (0.96" I2C), ventilador extractor axial de `12 V DC`, etapa de conmutación y fuente de alimentación regulada de `12 V / 5 V`.
* **Sustrato orgánico de prueba (ambiente simulado):** Residuos vegetales domésticos picados (cáscaras de frutas y verduras) mezclados con material estructurante seco rico en carbono (hojas secas, aserrín o cartón trozado) y agua para ajuste inicial de humedad.

### Equipos e instrumentos de laboratorio y software
* Impresora 3D FDM (manufactura de piezas estructurales y carcasas).
* Multímetro digital y fuente de alimentación DC de laboratorio (verificación de continuidad, voltajes y consumo del extractor de `12 V`).
* Termómetro e higrómetro patrón de referencia (contrastación de lecturas del `DS18B20` y sensores capacitivos).
* Balanza digital y probeta graduada (dosificación de sustrato húmedo/seco y verificación del volumen de lixiviados al `75 %` de los `1,4 L` de la bandeja).
* Computadora de desarrollo con entornos `Arduino IDE / PlatformIO`, `Flutter SDK`, consola de `Firebase` y entorno `Python` (entrenamiento y validación del modelo *Random Forest*).

---

## 5. Metodología y procedimiento experimental

La validación experimental de baja fidelidad se estructuró en cuatro fases secuenciales en entorno de laboratorio para verificar la trazabilidad de cada subsistema y su desempeño integrado:

1. **Verificación mecánico-estructural y de estanqueidad:**
   * Se ensambló la cámara principal, el eje segmentado con paletas curvas y la bandeja inferior.
   * Se cargó la cámara con una mezcla simulada de residuos orgánicos y material seco, ejecutando ciclos de volteo manual (`5 a 10 vueltas` con la manivela).
   * *Parámetro verificado:* Ausencia de colisión entre las paletas y las sondas ubicadas en la zona central de guarda, fluidez del torque manual en los rodamientos `6003-2RS` y drenaje efectivo hacia la bandeja sin fugas laterales.

2. **Calibración y trazabilidad de sensores en banco de pruebas:**
   * Se contrastaron las lecturas enviadas por el `ESP32` cada `4 segundos` frente a instrumentos patrón.
   * Se evaluó la respuesta de los sensores capacitivos `v1.2` en tres escenarios controlados de sustrato: condición seca (`< 45 %`), rango óptimo (`45 % – 70 %`) y saturación (`> 70 %`).
   * Se verificó la activación del flotador magnético `P45` llenando la bandeja de lixiviados hasta alcanzar el umbral del `75 %` de su capacidad total (`≈ 1,30 L` de `1,4 L`).

3. **Prueba del lazo de control térmico y extracción de gases (histéresis):**
   * Se sometió la sonda `DS18B20` a un incremento controlado de temperatura hasta alcanzar o superar los `58 °C`, y se expuso el sensor `MQ-135` (dentro de su carcasa con ranuras inclinadas) a vapores volátiles simulados.
   * *Parámetro verificado:* Encendido automático del extractor de `12 V DC` al cruzar el umbral superior (`≥ 58 °C` o pico de gas), mantenimiento de la extracción durante el descenso térmico y apagado automático estricto al descender por debajo de `55 °C`, corroborando además que la carcasa lateral impidiera la acumulación de condensación sobre el `MQ-135`.

4. **Prueba de integración IoT, visualización OLED y clasificación por IA:**
   * Se conectó el prototipo a una red Wi-Fi local y se registraron series temporales de datos en `Firebase` y en la interfaz móvil en `Flutter`.
   * Se inyectaron perfiles de datos correspondientes a las cuatro condiciones operativas (**fase mesófila**, **termófila `≥ 55 °C`**, **enfriamiento** y **condición anaerobia**) para verificar la actualización sincronizada entre la pantalla OLED local, la clasificación del modelo *Random Forest* y el despliegue de alertas preventivas en la app (volteo, riego, adición de material seco o vaciado de bandeja).

---

