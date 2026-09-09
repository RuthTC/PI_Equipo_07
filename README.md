# Equipo 06 - Proyecto Integrador 

**Carrera de Ingeniería Ambiental / Informática / Industrial**

**Universidad Peruana Cayetano Heredia**

---

## 🌍 Descripción del Equipo

Somos el **Equipo 06** del curso de **Proyecto Integrador 2026-2**, conformado por estudiantes de la carrera de Ingeniería Ambiental / Informática / Industrial.
Nuestro objetivo es aplicar la metodología de diseño para generar soluciones innovadoras con impacto social, tecnológico y ambiental.

Nos interesa trabajar en los siguientes **Objetivos de Desarrollo Sostenible (ODS)**:

**ODS 12: Producción y Consumo Responsables**

<p align="left">
  <img src="Recursos _Imágenes/ODS12.png" width="400" alt="ODS 12 Producción y Consumo Responsables">
</p>

**ODS 13: Acción por el Clima**

<p align="left">
  <img src="Recursos _Imágenes/ODS 13.png" width="400" alt="ODS 13 Acción por el Clima">
</p>
**ODS 11: Ciudades y Comunidades Sostenibles**

<p align="left">
  <img src="Recursos _Imágenes/ODS 11.png" width="400" alt="ODS 11 Ciudades y Comunidades Sostenibles">
</p>


---

## 📷 Fotografía del Equipo

<p align="center">
  <img src="Recursos _Imágenes/WhatsApp Image 2026-08-18 at 10.24.00 PM.jpeg" width="100%" alt="Fotografía del Equipo">
  <br>
  <em>Figura 1. Fotografía del equipo PI_Equipo_6</em>
</p>

## 👥 Integrantes del Equipo

| Foto | Nombre | Rol | Intereses |
| :---: | :--- | :--- | :--- |
| <img src="Recursos _Imágenes/Moises266.jpeg" width="100"> | **Junior Moisés Aliaga Cueva** | Diseñador/a | Diseño de prototipos, creatividad aplicada |
| <img src="Recursos _Imágenes/Alex.png" width="100"> | **Alex Jhosep Karol Coyllo Sotelo** | Programador/a | Programación, análisis de datos, simulación |
| <img src="Recursos _Imágenes/j ancco.jpg" width="100"> | **Juan Carlos Ancco Quispe** | Modelador/a | Programación, análisis de datos, simulación |
| <img src="Recursos _Imágenes/RuthTurpo.png" width="100"> | **Ruth Carina Turpo Cayo** | Responsable de investigación | Gestión ambiental, desarrollo comunitario |
| <img src="Recursos _Imágenes/aldana.jpg" width="100"> | **Leonela Angela Aldana Porras** | Encargado/a de documentación | Comunicación científica, redacción técnica |

###  ¿Por qué este proyecto?
Elegimos trabajar con la gestión de residuos orgánicos domésticos y comunitarios porque representan una gran parte de los desechos urbanos y tienen un alto potencial de aprovechamiento a través del compostaje. Sin embargo, durante este proceso existe un problema que dificulta su éxito: el control de las variables ambientales. Actualmente, para conocer el estado del compost, las personas deben realizar revisiones manuales, lo que implica tiempo, esfuerzo y no siempre permite saber con precisión cuándo es realmente necesario intervenir para agregar agua o airear la mezcla.
Con este proyecto buscamos facilitar el trabajo de los usuarios, automatizar el cuidado y contribuir a mantener mejores condiciones para el proceso biológico, favoreciendo la obtención de un abono orgánico de alta calidad.

</p>

### Problematica
En los entornos urbanos, el manejo inadecuado de los residuos orgánicos genera una grave crisis ambiental. La falta de un monitoreo preciso de las condiciones internas de la compostera dificulta tomar las decisiones correctas para mantener la actividad microbiana.
Esta problemática se hace evidente cuando el compostaje pierde su rango óptimo de humedad (cayendo por debajo del 50%) o temperatura (entre 35°C y 65°C) [1]. Esta descompensación reduce drásticamente el oxígeno, generando condiciones anaeróbicas además de la consecuente emisión de gases dañinos y de malos olores.
Actualmente, el mantenimiento suele basarse en la intuición o revisiones esporádicas que no consideran el estado real del núcleo del compost. Esto provoca que se intervenga incorrectamente, ahogando la mezcla con exceso de agua o dejando que se seque por completo.
Diversos estudios señalan que un manejo oportuno del compostaje mediante sensores reduce la emisión de gases de efecto invernadero y asegura la viabilidad de la biomasa [2], [3]. En consecuencia, la falta de herramientas tecnológicas que permitan monitorear de manera precisa y continua la condición de los residuos genera frustración en los usuarios, abandono de la práctica y terminan tirando estos residuos en vez de aplicar economía circular.

</p>

### Objetivo 
Objetivo:
Como grupo, nuestro objetivo es optimizar la gestión y el cuidado del proceso de compostaje mediante el monitoreo continuo de variables ambientales (temperatura, humedad y gases) integrando tecnología IoT, con el fin de asegurar la viabilidad biológica del proceso, mejorar la toma de decisiones del usuario mediante un asistente virtual interactivo y automatizar acciones correctivas.

Objetivos específicos:
Medir y registrar cuantitativamente variables clave como la temperatura interna, la humedad y los niveles de gases (CO2/NH3) mediante sensores, enviando los datos a un microcontrolador ESP32 para evaluar el estado de la materia orgánica.

Interactuar con el usuario a través de una pantalla interactiva (TFT/OLED) que muestre un asistente virtual, indicando visualmente el estado del compost y solicitando acciones manuales como la aireación.

Activar automáticamente un sistema de riego integrado cuando los niveles de humedad desciendan por debajo del rango óptimo, garantizando la continuidad del proceso sin intervención manual constante.


</p>

### ODS en los que nos enfocamos
Los Objetivos de Desarrollo Sostenible (ODS) son una iniciativa de la Organización de las Naciones Unidas orientada a abordar los principales desafíos globales. Este proyecto se alinea con estos objetivos al integrar tecnología avanzada en la gestión responsable de residuos:

ODS 12: Producción y Consumo Responsables

Definición: Garantizar modalidades de consumo y producción sostenibles.

Relación: El proyecto contribuye directamente a las Metas 12.3 y 12.5. Al monitorear en tiempo real el estado del compostaje, se asegura la correcta transformación de los residuos en abono aprovechable, reduciendo drásticamente la cantidad de desechos orgánicos que terminan en los vertederos.

ODS 11: Ciudades y Comunidades Sostenibles

Definición: Lograr que las ciudades sean más inclusivas, seguras, resilientes y sostenibles.

Relación: El proyecto contribuye a las Metas 11.6 y 11.a brindando una alternativa tecnológica, accesible y escalable que puede aplicarse a nivel local en hogares, escuelas y comunidades para mejorar la gestión de los residuos sólidos urbanos.

ODS 13: Acción por el Clima

Definición: Adoptar medidas urgentes para combatir el cambio climático y sus efectos.

Relación: Se relaciona con la Meta 13.3 al promover conocimientos y prácticas tecnológicas que optimizan el compostaje, mitigando la emisión de gases nocivos (como el metano) generados por la descomposición anaeróbica descontrolada.

ODS 9: Industria, Innovación e Infraestructura
Definición: Construir infraestructuras resilientes, promover una industrialización inclusiva y sostenible y fomentar la innovación.

Relación: El proyecto se relaciona directamente con el ODS 9, especialmente con la Meta 9.5, al incorporar innovación tecnológica en el proceso de compostaje. Mediante el uso de sensores y sistemas de monitoreo en tiempo real, es posible controlar variables como la temperatura, humedad y otras condiciones necesarias para optimizar la descomposición de los residuos orgánicos. Esta propuesta integra tecnología e innovación para desarrollar un sistema de compostaje más eficiente, accesible y escalable, demostrando cómo las soluciones tecnológicas pueden contribuir a una gestión sostenible de los residuos y al aprovechamiento de los recursos.

</p>

### Enfoque y sustento
El aprovechamiento de residuos orgánicos de origen vegetal, como restos de frutas, verduras, cáscaras de papa y hojas, es uno de los pilares para impulsar una economía circular urbana. Sin embargo, en el compostaje doméstico y comunitario de este tipo de residuos surge un problema constante: actualmente, no se monitorea adecuadamente la condición interna de la biomasa, lo que puede provocar que se intervenga demasiado tarde, generando malos olores, exceso de humedad o incluso que el proceso de compostaje se pudra y fracase.

Frente a esta problemática, el proyecto COMPOST-IoT propone analizar y monitorear de manera precisa el proceso de compostaje de restos de frutas, verduras, cáscaras de papa y hojas, mediante un sistema equipado con microcontroladores, sensores ambientales y un asistente virtual que permitan conocer exactamente el estado de la compostera. De esta manera, se podrán tomar decisiones oportunas e incluso automatizar determinadas acciones de corrección, como el riego, basándose en datos reales obtenidos durante el proceso.

El sistema permitirá controlar las condiciones de los residuos vegetales en descomposición, especialmente los niveles de temperatura y humedad, para favorecer la transformación adecuada de las cáscaras y restos de frutas, verduras y papa, así como de las hojas, hasta obtener un abono aprovechable.

Con este proyecto se logrará:

Optimizar el tiempo invertido en el cuidado y mantenimiento de las composteras que procesan residuos de frutas, verduras, papa y hojas.
Mejorar la calidad del abono resultante, asegurando condiciones adecuadas de temperatura y humedad durante la descomposición de estos residuos vegetales.
Reducir el riesgo de malos olores y del deterioro del proceso ocasionado por un exceso de humedad o un manejo inadecuado de los residuos.
Tomar decisiones de riego y aireación basadas en datos objetivos, mediante alertas visuales claras y gamificadas que indiquen el estado de los residuos dentro de la compostera.
Promover el aprovechamiento sostenible de residuos orgánicos vegetales, específicamente restos de frutas, verduras, cáscaras de papa y hojas, transformándolos en abono mediante un proceso moderno, automatizado y responsable.
Impulsar la innovación tecnológica aplicada al compostaje, utilizando sensores y herramientas IoT para mejorar el aprovechamiento de estos residuos y contribuir a una gestión más eficiente de los residuos orgánicos.
</p>


### Bibliografia 
[1] Senzemo, "Compost Temperature Measuring with IoT Sensors," Senzemo IoT Solutions, 2025.

[2] A. Kumar y S. Sharma, "Smart Compost Guardian: An IOT-Based Real-Time Compost Monitoring and Alert System," Int. J. Eng. Res. Technol. (IJERT), vol. 14, no. 4, pp. 112-118, Abr. 2025.

[3] M. Antoniou y P. Georgiou, "Smart Compost Monitoring System using Open Source Technologies," en Proc. 15th Int. Conf. Environ. Sci. Technol. (CEST2017), Rodas, Grecia, 2017, pp. 1-5.
