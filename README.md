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

Elegimos abordar la gestión de **residuos orgánicos domésticos de origen exclusivamente vegetal** (restos de frutas, verduras y cáscaras), excluyendo restos de origen animal (carnes, grasas, huesos) u otros materiales aprovechables (papel o cartón). Este tipo de biomasa representa la mayor proporción de los desechos en los hogares urbanos y posee un alto potencial para la generación de compost de calidad [3].

Para fundamentar la viabilidad de una solución tecnológica adaptada al contexto local, se analizó la caracterización por sectores urbanos y la distribución territorial de los distritos de Lima Metropolitana, presentadas en la **Fig. 1** y la **Fig. 2** respectivamente.

| | |
| :---: | :---: |
| <img src="Recursos _Imágenes/Comparativo1.1.png" width="450"> | <img src="Recursos _Imágenes/mapa 1.2.png" width="350"> |
| *Fig. 1. Porcentaje de distritos por sectores en grupos de clustering [5].* | *Fig. 2. Distribución espacial de los distritos de Lima Metropolitana según grupos de clustering [5].* |

Como se observa en la **Fig. 1**, el Cono Sur y el Cono Centro agrupan la mayor concentración de distritos con alta generación de materia orgánica. Asimismo, la **Fig. 2** demuestra la extensión geográfica de esta problemática a nivel metropolitano. Estos datos justifican la necesidad de implementar **COMPOST-IoT** como un sistema modular y accesible, idóneo para su adopción en los hogares de estos sectores con alta densidad demográfica.

Sin embargo, el proceso biológico de descomposición requiere un control riguroso de las condiciones ambientales. Actualmente, el mantenimiento de las composteras domésticas se realiza de forma manual e intuitiva, lo que dificulta determinar con exactitud el estado del proceso o el momento preciso en que se requiere hidratar o airear la mezcla. Con este proyecto buscamos automatizar el monitoreo y control de variables críticas, facilitando el manejo al usuario y garantizando las condiciones biológicas idóneas para obtener un abono orgánico estabilizado y de alta calidad [6].

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

♻️ ODS 12 — Producción y consumo responsables

Meta 12.3 — Reducción de las pérdidas y desperdicios de alimentos
Meta 12.3 — Reducción de las pérdidas y desperdicios de alimentos. El proyecto CompostTech facilita la revalorización de los residuos orgánicos de cocina mediante un monitoreo en tiempo real, transformando los desechos vegetales en compost de alta calidad e impidiendo que terminen arrojados a la basura.

Meta 12.5 — Reducción de la generación de desechos mediante prevención, reciclaje y reutilización
Meta 12.5 — Reducción de la generación de desechos mediante prevención, reciclaje y reutilización. Al optimizar las condiciones biológicas del compostaje doméstico, el dispositivo evita que la biomasa orgánica termine en los rellenos sanitarios, promoviendo el reciclaje de nutrientes directo desde el hogar.

---

🏙️ ODS 11 — Ciudades y comunidades sostenibles

Meta 11.6 — Reducción del impacto ambiental negativo per cápita de las ciudades
Meta 11.6 — Reducción del impacto ambiental negativo per cápita de las ciudades. El sistema ofrece una alternativa tecnológica descentralizada y modular para que los hogares urbanos gestionen localmente sus propios residuos orgánicos, reduciendo el volumen de basura que debe ser transportado por la ciudad.

---

🌍 ODS 13 — Acción por el clima

Meta 13.3 — Mejora de la educación, la sensibilización y la capacidad humana e institucional respecto de la mitigación del cambio climático
Meta 13.3 — Mejora de la educación, la sensibilización y la capacidad humana e institucional respecto de la mitigación del cambio climático. El prototipo controla de forma automática el flujo de aire y alerta sobre la humedad del núcleo para evitar procesos anaeróbicos, previniendo la emisión de gases de efecto invernadero (como el metano y el amoniaco) durante la descomposición.

---

🏗️ ODS 9 — Industria, innovación e infraestructura

Meta 9.5 — Aumento de la investigación científica y mejora de la capacidad tecnológica
Meta 9.5 — Aumento de la investigación científica y mejora de la capacidad tecnológica. CompostTech integra sensores de bajo costo y microcontroladores IoT a un proceso biológico tradicional, demostrando cómo la innovación tecnológica de pequeña escala facilita el cuidado ambiental.

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

### Referencias Bibliográficas

[1] Senzemo, "Compost temperature measuring with IoT sensors," Senzemo IoT Solutions, 2025. [Online]. Available: https://senzemo.com/iot-compost-temperature-monitoring/. [Accessed: Sep. 10, 2026].

[2] A. Kumar and S. Sharma, "Smart Compost Guardian: An IOT-based real-time compost monitoring and alert system," *Int. J. Eng. Res. Technol.*, vol. 14, no. 4, pp. 112–118, Apr. 2025.

[3] M. Antoniou and P. Georgiou, "Smart compost monitoring system using open source technologies," in *Proc. 15th Int. Conf. Environ. Sci. Technol. (CEST2017)*, Rhodes, Greece, 2017, pp. 1–5.

[4] Naciones Unidas, "Objetivos de Desarrollo Sostenible," Desarrollo Sostenible. [Online]. Available: https://www.un.org/sustainabledevelopment/es/objetivos-de-desarrollo-sostenible/. [Accessed: Sep. 10, 2026].

[5] A. M. Yactayo-Flores, A. Huiman Cruz, and I. F. Reyes-Mandujano, "Agrupamiento de los distritos de la provincia de Lima, Perú, por similitud en los niveles de residuos sólidos (orgánicos e inorgánicos) domiciliarios aprovechables," *Rev. Kawsaypacha: Soc. Medio Ambiente*, no. 16, Art. no. D010, 2025, doi: 10.18800/kawsaypacha.202502.D010.

[6] Y. H. Huapaya Cruz, "Evaluación del compostaje a diferentes composiciones para aprovechar los residuos orgánicos domiciliarios de la ciudad de Puno para contribuir en contrarrestar el cambio climático," *Rev. Investig. Altoandinas*, vol. 26, no. 1, pp. 24–35, 2024, doi: 10.18271/ria.2024.577.
