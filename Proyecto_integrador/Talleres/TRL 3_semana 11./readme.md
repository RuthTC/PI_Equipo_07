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

### A. Ciencias de la Vida y Bioprocesos (Compostaje)
* **Evaluación de biomasa:** Ensayos preliminares con residuos orgánicos domésticos de origen vegetal (frutas, verduras, hojas y podas).
* **Control de rangos biológicos:** Validación analítica de los intervalos térmicos (fases mesófila de 20–35 °C y termófila de 35–65 °C) y de humedad óptima (50–70 %) para la actividad microbiana aerobia.
* **Seguimiento de efluentes:** Verificación de la generación y drenaje pasivo de lixiviados y de la dinámica de liberación de gases metabólicos (CO₂ y NH₃).

### B. Hardware e Ingeniería Mecatrónica
* **Adquisición de datos:** Ensayos de laboratorio con el microcontrolador ESP32 conectado via I2C, OneWire y entradas analógicas a los sensores de humedad, temperatura, gases y nivel de líquidos.
* **Actuación electromecánica:** Validación de la lógica de activación del ventilador de corriente continua (DC) ante sobrecalentamiento (>65 °C) o acumulación de gases.
* **Interfaz y telemetría:** Pruebas iniciales de despliegue de datos en la pantalla OLED local y envío preliminar de métricas hacia la plataforma IoT via Wi-Fi.

## 3. Indicadores de Logro y Evidencias Experimentales

| Indicador TRL 3 | Estado / Detalle en el Proyecto CompostTech |
| :--- | :--- |
| **Datos de ensayos experimentales** | Curvas de variación de temperatura y humedad en muestras de laboratorio durante ciclos de prueba cortos, verificando los umbrales de alerta (>65 °C para ventilación, <45 % para riego). |
| **Ensayos analíticos** | Evaluación de precisión y estabilidad de los sensores de gases (CO₂/NH₃) y de nivel de lixiviados bajo condiciones ambientales controladas de humedad y corrosión. |
| **Demo o prototipo inicial** | Prototipo básico de laboratorio que integra el ESP32 en circuito de prueba, pantalla OLED, sensores anclados y ventilador DC de extracción operando bajo el algoritmo de decisión. |

## 4. Conclusiones sobre la Viabilidad Tecnológica
* Se demostró experimentalmente que el algoritmo de decisión responde de forma oportuna ante variaciones en los parámetros del compostaje, clasificando las condiciones en estados (Óptimo, Advertencia e Intervención).
* Los ensayos confirman la factibilidad técnica de integrar el monitoreo multiparámetro con la extracción mecánica de gases, sentando las bases para el escalamiento hacia la integración en chasis IP65 (TRL 4).
