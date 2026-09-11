# Equipo 06 - Proyecto Integrador 

**Carrera de Ingeniería Ambiental / Informática / Industrial**  
**Universidad Peruana Cayetano Heredia**

---

## 🌍 Descripción del Equipo

Somos el **Equipo 06** del curso de **Proyecto Integrador 2026-2**, conformado por estudiantes de las carreras de Ingeniería Ambiental, Informática e Industrial. Nuestro objetivo es aplicar metodologías de diseño e ingeniería para generar soluciones innovadoras con impacto social, tecnológico y ambiental.

Nos enfocamos en contribuir a los siguientes **Objetivos de Desarrollo Sostenible (ODS)**:

| **ODS 12: Producción y Consumo Responsables** | **ODS 13: Acción por el Clima** |
| :---: | :---: |
| <img src="Recursos _Imágenes/ODS12.png" width="300"> | <img src="Recursos _Imágenes/ODS 13.png" width="300"> |

| **ODS 11: Ciudades y Comunidades Sostenibles** | **ODS 9: Industria, Innovación e Infraestructura** |
| :---: | :---: |
| <img src="Recursos _Imágenes/ODS 11.png" width="300"> | <img src="Recursos _Imágenes/ods 9.jpg" width="300"> |

---

## 📷 Fotografía del Equipo

![Fotografía del Equipo](Recursos%20_Imágenes/WhatsApp%20Image%202026-08-18%20at%2010.24.00%20PM.jpeg)  
*Figura 1. Fotografía del equipo PI_Equipo_6*

---

## 👥 Integrantes del Equipo

| Foto | Nombre | Rol | Intereses |
| :---: | :--- | :--- | :--- |
| <img src="Recursos _Imágenes/Moises266.jpeg" width="100"> | **Junior Moisés Aliaga Cueva** | Diseñador/a | Diseño de prototipos, creatividad aplicada |
| <img src="Recursos _Imágenes/Alex.png" width="100"> | **Alex Jhosep Karol Coyllo Sotelo** | Programador/a | Programación, análisis de datos, simulación |
| <img src="Recursos _Imágenes/j ancco.jpg" width="100"> | **Juan Carlos Ancco Quispe** | Modelador/a | Programación, análisis de datos, simulación |
| <img src="Recursos _Imágenes/RuthTurpo.png" width="100"> | **Ruth Carina Turpo Cayo** | Responsable de investigación | Gestión ambiental, desarrollo comunitario |
| <img src="Recursos _Imágenes/aldana.jpg" width="100"> | **Leonela Angela Aldana Porras** | Encargado/a de documentación | Comunicación científica, redacción técnica |

---

### ¿Por qué este proyecto?

Elegimos abordar la gestión de **residuos orgánicos domésticos de origen exclusivamente vegetal** (restos de frutas, verduras, cáscaras y hojas), excluyendo restos de origen animal (carnes, grasas, huesos) u otros materiales aprovechables (papel o cartón). Este tipo de biomasa representa la mayor proporción de los desechos en los hogares urbanos y posee un alto potencial para la generación de compost de calidad. 
| | |
| :---: | :---: |
| <img src="Recursos _Imágenes/Comparativo1.1.png" width="300"> | <img src="Recursos _Imágenes/mapa 1.2.png" width="300"> |
| *Fig. 1. Porcentaje de distritos por sectores en grupos de clustering [4].* | *Fig. 2. Distribución espacial de los distritos de Lima Metropolitana según grupos de clustering [4].* |

Sin embargo, el proceso biológico de descomposición requiere un control riguroso de las condiciones ambientales. Actualmente, el mantenimiento de las composteras domésticas se realiza de forma manual e intuitiva, lo que dificulta determinar con exactitud el estado del proceso o el momento preciso en que se requiere hidratar o airear la mezcla. Con este proyecto buscamos automatizar el monitoreo y control de variables críticas, facilitando el manejo al usuario y garantizando las condiciones biológicas idóneas para obtener un abono orgánico estabilizado y de alta calidad.

---

### Problemática

En los entornos urbanos, el manejo inadecuado de los residuos orgánicos genera un impacto ambiental negativo considerable. En el ámbito doméstico, la falta de herramientas para monitorear las condiciones internas del compostaje dificulta mantener la actividad microbiana aeróbica idónea.

Esta problemática surge cuando los **residuos exclusivamente vegetales** pierden sus rangos óptimos de operación: **humedad (por debajo del 50%)** y **temperatura (rango mesofílico de 35°C a 45°C y termofílico de hasta 65°C)** [1]. La falta de aireación y el desequilibrio hídrico generan condiciones anaeróbicas que derivan en la emisión de malos olores y gases como dióxido de carbono ($CO_2$) y amoniaco ($NH_3$), indicadores directos de pérdidas de nitrógeno y una degradación ineficiente de la materia orgánica.

El mantenimiento convencional se basa en inspecciones esporádicas e intuitivas sin conocer el estado del núcleo de la biomasa vegetal. Esto provoca intervenciones erróneas (sobrehidratación o sequedad extrema). Diversos estudios demuestran que el monitoreo mediante sensores IoT optimiza la descomposición, reduce emisiones nocivas y asegura la calidad del producto final [2], [3]. La ausencia de un sistema accesible de monitoreo continuo provoca frustración en el usuario, el abandono de la práctica y la disposición final de estos residuos en vertederos, perdiendo la oportunidad de aplicar economía circular en los hogares.

---

### Objetivo

**Objetivo General:**  
Optimizar la gestión y el seguimiento del proceso de compostaje de residuos orgánicos domésticos vegetales mediante el monitoreo continuo de variables ambientales (temperatura, humedad y gases $CO_2$/$NH_3$) e integración de tecnología IoT, asegurando la viabilidad biológica del proceso, facilitando la toma de decisiones del usuario mediante una interfaz interactiva y automatizando acciones correctivas de hidratación.

**Objetivos Específicos:**
* **Medir y registrar** cuantitativamente la temperatura interna (hasta rango termofílico de 65°C), la humedad relativa de la biomasa y la concentración de gases ($CO_2$/$NH_3$) mediante un arreglo de sensores conectados a un microcontrolador ESP32 para determinar el estado de descomposición de los residuos vegetales.
* **Visualizar e interactuar** con el usuario a través de un módulo de visualización de datos (pantalla TFT/OLED) con interfaz gráfica, que exponga en tiempo real el estado del compost y solicite intervenciones manuales (como aireación o volteo) según las lecturas obtenidas.
* **Activar automáticamente** un sistema de riego integrado al detectar niveles de humedad inferiores al rango óptimo (<50%), garantizando la hidratación necesaria para la actividad microbiana sin requerir intervención manual constante.

---

### ODS en los que nos enfocamos

Este proyecto integra tecnología IoT para impulsar la gestión responsable de residuos de origen vegetal, alineándose con las metas de la Organización de las Naciones Unidas:

* **ODS 12: Producción y Consumo Responsables**
  * *Relación:* Contribuye directamente a las **Metas 12.3 y 12.5**. Al monitorear en tiempo real el compostaje de residuos vegetales domésticos, se asegura su correcta transformación en abono de alta calidad, reduciendo el volumen de biomasa orgánica que se destina a rellenos sanitarios.
* **ODS 11: Ciudades y Comunidades Sostenibles**
  * *Relación:* Se alinea con las **Metas 11.6 y 11.a** al proporcionar una alternativa tecnológica modular y escalable para la gestión descentralizada de residuos sólidos orgánicos en hogares y comunidades urbanas.
* **ODS 13: Acción por el Clima**
  * *Relación:* Impacta en la **Meta 13.3** al controlar los parámetros de aireación e humedad en la biomasa vegetal, evitando la descomposición anaeróbica y mitigando la generación descontrolada de gases de efecto invernadero (como metano y amoniaco).
* **ODS 9: Industria, Innovación e Infraestructura**
  * *Relación:* Vinculado a la **Meta 9.5**, al incorporar innovación tecnológica e IoT (microcontroladores y sensores) en procesos biológicos de pequeña escala, promoviendo el desarrollo de infraestructura limpia y soluciones sostenibles.

---

### Enfoque y Sustento

El aprovechamiento de residuos orgánicos domésticos de origen estrictamente vegetal (restos de frutas, verduras, cáscaras y hojas) es fundamental para la economía circular urbana. La descomposición de estos residuos depende de una adecuada relación de carbono/nitrógeno ($C/N$) y de un ambiente favorable para los microorganismos aeróbicos. Sin embargo, la falta de un control preciso de la temperatura y la humedad conduce frecuentemente a la pudrición de la mezcla, malos olores y el fracaso del compostaje casero.
  
El proyecto **COMPOST-IoT** aborda directamente esta problemática mediante un sistema de control y monitoreo ambiental continuo basado en microcontroladores, sensores y un módulo de visualización de datos.

**Aportes y beneficios del proyecto:**
* **Monitoreo especializado:** Control continuo de la biomasa vegetal en fases mesofílicas y termofílicas (soportando temperaturas de hasta 65°C).
* **Interpretación de gases:** Medición indirecta de $CO_2$ y $NH_3$ para evaluar la tasa de descomposición y la necesidad de ventilación/aireación del núcleo.
* **Automatización del riego:** Corrección automática de déficit de humedad para mantener la hidratación óptima de la materia vegetal en descomposición.
* **Interfaz de usuario:** Presentación clara y legible de las variables operativas en un módulo de visualización de datos, permitiendo tomar decisiones informadas sobre el mantenimiento.
* **Optimización del proceso:** Obtención de un abono orgánico maduro y libre de patógenos en menores tiempos, maximizando el aprovechamiento de recursos orgánicos en el hogar.

---

### Bibliografía

[1] Senzemo, "Compost Temperature Measuring with IoT Sensors," Senzemo IoT Solutions, 2025. [En línea]. Disponible en: https://senzemo.com/iot-compost-temperature-monitoring/ (accedido el 10 de sep. de 2026).

[2] A. Kumar y S. Sharma, "Smart Compost Guardian: An IOT-Based Real-Time Compost Monitoring and Alert System," Int. J. Eng. Res. Technol. (IJERT), vol. 14, no. 4, pp. 112-118, Abr. 2025.

[3] M. Antoniou y P. Georgiou, "Smart Compost Monitoring System using Open Source Technologies," en Proc. 15th Int. Conf. Environ. Sci. Technol. (CEST2017), Rodas, Grecia, 2017, pp. 1-5.

[4] Naciones Unidas, "Objetivos de Desarrollo Sostenible", Desarrollo Sostenible. [En línea]. Disponible en: https://www.un.org/sustainabledevelopment/es/objetivos-de-desarrollo-sostenible/ (accedido el 10 de sep. de 2026).

[5] J. A. Rodríguez-Gonzáles, C. A. M. Bendezú-Gonzales, y L. M. E. Rivas-Díaz, "Análisis de agrupamiento de los distritos de Lima Metropolitana según variables socioeconómicas y ambientales," *Revista Científica de la Universidad Científica del Sur*, vol. 5, no. 2, pp. 1-15, 2025. [En línea]. Disponible en: https://www.scielo.org.pe/scielo.php?script=sci_arttext&pid=S2709-36892025000200011. [Accedido: 10-Sep-2026].
