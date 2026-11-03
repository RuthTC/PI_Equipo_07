# CompostTech
## TRL 2 — Formulación conceptual de la propuesta tecnológica

### Información académica
* **Proyecto:** CompostTech (Monitor de Compostaje Doméstico Inteligente)
* **Curso:** Proyecto Integrador
* **Institución:** Universidad Peruana Cayetano Heredia
* **Periodo académico:** 2026-2
* **Integrantes (Equipo 07):**
  * Aliaga Cueva, Junior Moises
  * Aldana Porras, Leonela Angela
  * Ccoyllo, Alex 
  * Ancco, Juan
  * Turpo Cayo, Ruth turpo 

---

### Presentación
CompostTech es una propuesta tecnológica orientada al monitoreo continuo, regulación térmica y asistencia operativa del compostaje doméstico en entornos urbanos. El sistema contempla la integración de sensores de inserción en biomasa, acondicionamiento de señales en una placa de circuito impreso (PCB) personalizada basada en el microcontrolador ESP32, un mecanismo de extracción de aire forzado mediante un ventilador DC de 12 V, interfaces visuales locales (pantalla OLED con avatar dinámico de estados) y una aplicación móvil desarrollada en Flutter con gestión de usuarios mediante Firebase Authentication.

La presente propuesta se formula considerando los indicadores referenciales del nivel de madurez tecnológica TRL 2 (formulación del concepto de la tecnología e identificación de aplicaciones prácticas) establecidos en el Anexo 1 de la Directiva N.º 001-2022-CONCYTEC-P [1].

---

### 1. Artículos científicos relacionados con la propuesta tecnológica

#### 1.1. Dinámica fisicoquímica, fases térmicas y aireación en el compostaje
Román, Martínez y Pantoja [2] sistematizaron los parámetros críticos para la degradación aerobia de residuos orgánicos, estableciendo que la humedad debe mantenerse en un rango del 50 % al 70 % para evitar la inhibición biológica (por sequedad) o la generación de condiciones anaeróbicas (por saturación de poros). Asimismo, determinaron que durante la fase termófila la masa debe sostener temperaturas superiores a 55 °C por al menos tres días consecutivos para garantizar la sanitización frente a patógenos. Este estudio fundamenta los valores umbral del sistema de control de CompostTech, justificando la incorporación de la ventilación forzada y las recomendaciones manuales de volteo y adición de estructurante seco.

Complementariamente, Richard y Trautmann [3] modelaron el balance de materia y la tasa de humedad en reactores biológicos, demostrando que mezclas con alta concentración de restos de cocina (humedad del 80 % al 85 %) requieren una proporción aproximada de 3:1 en peso con material seco estructurante (humedad del 10 % al 15 %) para lograr un equilibrio inicial óptimo del 60 % al 65 %. Este antecedente proporciona el sustento del balance de carga de CompostTech para prototipos a escala de 10,08 L, donde se procesa una carga balanceada de 2,5 kg de mezcla húmeda por lote.

#### 1.2. Monitoreo embebido y proliferación de gases metabólicos
Vrettos, Kazamias y Lekkas [4] implementaron un sistema de adquisición para pilas de compostaje mediante controladores de código abierto y sensores de gases, demostrando que la liberación de compuestos volátiles y la alteración de la atmósfera interna anteceden a la aparición de olores nocivos y reflejan la transición hacia fases anaeróbicas. Este desarrollo respalda conceptualmente la inclusión de un sensor semiconductor (MQ-135) en CompostTech, no como un cromatógrafo selectivo de laboratorio, sino como un detector de proliferación general de gases metabólicos (CO₂, NH₃ y compuestos orgánicos volátiles) ubicado en una cámara periférica ventilada para accionar oportunamente el ventilador extractor.

Por su parte, Naser et al. [5] evaluaron redes de sensores integrados para el seguimiento abiótico en reactores de compostaje, reportando que los sensores sumergidos directamente en la biomasa deben poseer aislamiento galvánico o tecnología capacitiva sellada para evitar la corrosión electroquímica acelerada producida por los ácidos húmicos y el ambiente húmedo. Este análisis fundamenta la selección de sondas de temperatura blindadas en acero inoxidable (DS18B20) y sensores capacitivos anticorrosivos para el sustrato en CompostTech.

#### 1.3. Arquitectura IoT, microcontroladores y aplicaciones móviles
1.3. Arquitectura IoT, microcontroladores y algoritmos de aprendizaje automáticoRajamuneeswaran et al. [6] desarrollaron una estación de monitoreo basada en IoT orientada a la asistencia del usuario en tiempo real mediante alertas visuales y telemetría. Su trabajo demostró que la retroalimentación inmediata sobre variables físicas permite corregir oportunamente desviaciones en el proceso. En CompostTech, este principio se traslada a una doble interfaz: una visualización local en pantalla OLED empotrada con iconografía intuitiva (avatar dinámico) y una aplicación móvil desarrollada en Flutter, permitiendo al usuario registrar y supervisar el comportamiento de su reactor.Por su parte, Liu et al. [7] y Al-Fuqaha et al. [8] analizaron el procesamiento de datos sensoriales y sistemas de decisión en composteras inteligentes, concluyendo que la aplicación de histéresis en el control de actuadores evita conmutaciones erráticas y optimiza la estabilidad térmica del sistema. Este criterio se adopta en el firmware del ESP32 de CompostTech para regular el encendido del ventilador de 12 V sin sobrecargar la etapa de potencia comandada por el transistor 2N2222.   De manera complementaria, Lazrak et al. [21] evaluaron el empleo de modelos basados en inteligencia artificial y aprendizaje automático (machine learning) dentro de biorreactores interconectados, demostrando que la predicción de la dinámica de madurez y calidad del compost a partir de series temporales de temperatura, humedad y gases supera las limitaciones de las reglas estáticas de umbral fijo. Ello proporciona el sustento conceptual orientandolo hacia el entrenamiento de modelos de clasificación para inferir con precisión la fase biológica activa (mesófila, termófila, enfriamiento y maduración) y anticipar desbalances operativos antes de la emisión de olores molestos.

#### 1.4. Síntesis de la aplicación de los antecedentes
La Tabla 1 consolida la relación directa entre la evidencia científica revisada y su aplicación conceptual en el diseño de CompostTech.

**Tabla 1.** *Relación entre los antecedentes científicos y su aplicación en CompostTech.*

| Fuente | Evidencia científica documentada | Aplicación conceptual en CompostTech |
| :--- | :--- | :--- |
| **Román et al. [2]** | Parámetros biológicos: humedad óptima (50 % - 70 %) y sanitización térmica (> 55 °C por ≥ 3 días). | Definir la lógica de estados del avatar y los umbrales de disparo para las alertas y la ventilación forzada. |
| **Richard y Trautmann [3]** | Ecuaciones de balance de humedad y relación volumétrica de estructurante en residuos orgánicos. | Sustentar el balance de carga por lote (2,5 kg) y la proporción 3:1 de residuos vegetales respecto a hojas secas. |
| **Vrettos et al. [4]** | Detección de gases de degradación para evaluar la condición aerobia de la biomasa. | Sustentar el uso del sensor MQ-135 en una cámara periférica para medir la proliferación global de gases. |
| **Naser et al. [5]** | Análisis de corrosión y vida útil de sensores en medios químicamente agresivos y húmedos. | Justificar la selección de sondas DS18B20 en acero inoxidable y sensores de humedad de tipo capacitivo. |
| **Rajamuneeswaran et al. [6]** | Monitoreo IoT y notificación al usuario para la gestión doméstica de residuos. | Diseñar la interfaz móvil en Flutter y el avatar interactivo para guiar intervenciones manuales de volteo y riego. |
| **Liu et al. [7], Al-Fuqaha et al. [8]** | Algoritmos de decisión basados en umbrales e histéresis para reactores de compostaje inteligentes. | Diseñar la lógica de control del firmware en el ESP32 para activar la etapa de potencia del ventilador de 12 V. |

*Nota.* Elaboración propia a partir de los antecedentes científicos revisados en los apartados 1.1, 1.2 y 1.3.

---

### 2. Análisis preliminar de patentabilidad y protección

#### 2.1. Criterios de evaluación
La Decisión 486 de la Comisión de la Comunidad Andina [9], en su Régimen Común sobre Propiedad Industrial, establece que una invención es patentable cuando cumple con los requisitos de novedad (artículo 16), nivel inventivo (artículo 18) y aplicación industrial (artículo 19). Asimismo, el artículo 81 contempla la protección como modelo de utilidad para toda nueva forma, configuración o disposición de elementos de algún artefacto o mecanismo que permita un mejor funcionamiento, utilización o fabricación, o que le proporcione una ventaja técnica que antes no tenía.

En este marco, el análisis de CompostTech evalúa si la integración de la instrumentación electrónica en una PCB dedicada, la cámara externa ventilada para gases, los soportes desacoplados del sistema de mezcla y la bandeja inferior de lixiviados para maceración constituyen características diferenciadoras o ventajas técnicas protegibles.

#### 2.2. Publicaciones de patentes relacionadas con la propuesta
Se realizó una búsqueda exploratoria en las bases de datos de Google Patents, Espacenet y Patentscope empleando términos asociados a reactores domésticos (*smart compost bin*, *composting monitor device*, *leachate collection*, *mixing aerator*). La Tabla 2 resume los antecedentes tecnológicos más representativos identificados.

**Tabla 2.** *Comparación de publicaciones de patentes relacionadas con CompostTech.*

| Documento | Tecnología descrita | Comparación con CompostTech |
| :--- | :--- | :--- |
| **WO2021081597A1 [10]** | Dispositivo y sistema de monitoreo de compostaje mediante sensores de temperatura, humedad y gases en espacio de cabeza con enlace inalámbrico. | Comparte el monitoreo multicriterio, pero su sensor de gases se ubica sobre la tapa de manera fija. CompostTech incorpora una cámara periférica ventilada para gases y sondas extraíbles desacopladas del eje mezclador. |
| **US12189458B2 [11]** | Monitor de compostaje de bajo consumo con sensores modulares de penetración e interfaz inalámbrica de telemetría. | Se enfoca en una sonda vertical para pilas abiertas. CompostTech es un biorreactor integral de sobremesa (10,08 L) impreso en PLA que incorpora un eje mezclador manual, falso fondo y recolección de lixiviados. |
| **US20210371348A1 [12]** | Compostador doméstico automatizado con cámara de trituración, agitación electromecánica motorizada y condensación térmica. | Utiliza motores eléctricos de alta potencia y consumo de red. CompostTech emplea volteo manual mediante manivela helicoidal para reducir costos, limitando la automatización al flujo de aire forzado. |
| **CN212832860U [13]** | Biorreactor de compostaje a pequeña escala con bandeja deslizable inferior para recolección de líquidos residuales y ventilación pasiva. | Protege la disposición mecánica del cajón de recolección, pero carece de instrumentación electrónica, lazo de control On-Off con histéresis y conectividad IoT para el usuario. |

*Nota.* Elaboración propia a partir de las patentes analizadas en bases de datos internacionales [10]–[13].

#### 2.3. Evaluación preliminar de novedad, nivel inventivo y aplicación industrial
* **Novedad:** La configuración propuesta de CompostTech integra un biorreactor compacto de 10,08 L manufacturado en PLA, una manivela de mezclado helicoidal con zona central libre de paletas, soportes de riel deslizable para sondas de biomasa, una cámara periférica ventilada para el sensor MQ-135, una bandeja de recolección de lixiviados con sensor de nivel, una PCB personalizada de acondicionamiento basada en ESP32 con etapa de conmutación para ventilador de 12 V, y una arquitectura en la nube acoplada a una aplicación móvil en Flutter que incorpora un modelo de aprendizaje automático (machine learning) para la clasificación predictiva de las fases del compostaje y la generación dinámica de recomendaciones preventivas. Si bien existen antecedentes que abordan el monitoreo de variables abióticas o la aplicación de reglas estáticas de decisión en el estado del arte [10]–[13], la disposición funcional conjunta descrita y la sincronización entre el sensado multivariable, el control físico por hardware y la inferencia predictiva no se identificó de forma idéntica en las publicaciones de patentes examinadas. No obstante, al emplear principios de sensado conocidos, la novedad absoluta debe evaluarse con mayor profundidad en el estado de la técnica [9]–[13].
  
* **Nivel inventivo:** La simple integración de un microcontrolador con sensores comerciales de temperatura y humedad suele considerarse una solución previsible para un técnico en la materia. Sin embargo, CompostTech aporta características técnicas que superan dicha obviedad: por un lado, la disposición geométrica que previene el cizallamiento y destrucción de las sondas mediante una zona libre de paletas junto al aislamiento del sensor de gas en cámara periférica; y por otro, la sustitución de umbrales estáticos por un modelo de machine learning entrenado para predecir transiciones de fase biológica y anticipar desbalances antes de que ocurra la pudrición o la emisión de olores molestos [21]. Esta combinación de adaptabilidad mecánica y control predictivo proporciona un efecto técnico ventajoso frente a composteras tradicionales, aunque en esta etapa inicial se requiere consolidar los datos de entrenamiento para sustentar plenamente este requisito conforme al artículo 18 de la Decisión 486 [2], [7], [9], [21].
* **Aplicación industrial:** CompostTech presenta una clara aplicación en el sector de gestión y valorización doméstica de residuos sólidos orgánicos urbanos. Su arquitectura contempla componentes electrónicos, mecánicos y algoritmos digitales que pueden fabricarse, ensamblarse y desplegarse comercialmente para transformar residuos de cocina en abono seguro, cumpliendo cabalmente con el artículo 19 de la Decisión 486 [9].

#### 2.4. Posibles vías de protección
A partir del análisis realizado bajo la Decisión 486 de la Comunidad Andina [9], CompostTech contempla las siguientes vías de protección de propiedad intelectual:

* **Modelo de Utilidad (Vía prioritaria de hardware):** Conforme al artículo 81 de la Decisión 486 [9], la configuración tridimensional del biorreactor es protegible como modelo de utilidad ante la Dirección de Invenciones y Nuevas Tecnologías del INDECOPI. Esto ampara la ventaja técnica derivada de la disposición espacial: el chasis de sobremesa de 10,08 L con falso fondo ranurado, la cámara periférica exterior para gases, los rieles deslizables para sondas y la geometría del eje de manivela con espacio de guarda central que evita colisiones mecánicas.

* **Patente de Invención (Vía de método implementado por computadora):** Si bien los algoritmos matemáticos en sí no son patentables, la integración del modelo de machine learning como un método de control biotecnológico implementado por computadora —donde el modelo gobierna el encendido adaptativo del ventilador de 12 V y la emisión preventiva de alertas antes de la emisión de amoníaco— podría evaluarse como patente de invención si las pruebas empíricas demuestran una solución técnica no evidente frente a compostadores convencionales [9], [21].

* **Derecho de Autor (Software y Firmware):** El código fuente del firmware embebido en C++ para el ESP32, el código de la aplicación móvil multiplataforma desarrollada en Flutter y los scripts de entrenamiento del modelo de machine learning son susceptibles de registro inmediato como obras de software ante la Dirección de Derecho de Autor del INDECOPI [9].

---

### 3. Perfil o propuesta del proyecto

#### 3.1. Problema, propósito y alcance
En los hogares urbanos de Lima, más del 54 % de los residuos sólidos corresponden a materia orgánica putrescible [14]. La falta de herramientas accesibles para el control de la humedad y la aireación conduce comúnmente a la pudrición anaeróbica, malos olores y proliferación de vectores, desincentivando el compostaje doméstico.

* **Objetivo general:** Formular conceptualmente un monitor y biorreactor de compostaje doméstico inteligente a escala funcional (10,08 L) que integre sensores abióticos, acondicionamiento electrónico en PCB dedicada, ventilación forzada y una aplicación móvil para guiar las intervenciones de volteo, riego y drenaje del usuario.
* **Alcance:** El sistema está diseñado para procesar una carga útil de hasta 2,8 kg de biomasa vegetal por lote (cáscaras, frutas y verduras picadas mezcladas con estructurante seco en proporción 3:1). Quedan excluidos del procesamiento carnes, grasas, lácteos y materiales celulósicos pesados. La recolección de lixiviados tiene como fin evitar la saturación hídrica del sustrato y advertir el llenado de la bandeja para su posterior maceración externa, sin realizar tratamientos químicos automatizados in situ.

### 3.2. Arquitectura funcional propuesta

CompostTech se organiza en cuatro elementos principales: cámara de compostaje con módulo mecánico, módulo de instrumentación y control (PCB personalizada), subsistema de ventilación forzada y plataforma móvil con modelo analítico. La cámara de compostaje integra los elementos estructurales y de mezcla manual, mientras que los sensores alojados en su interior se enlazan mediante conexiones cableadas con la PCB de control ubicada en una caja exterior protegida. Desde el microcontrolador, la información se procesa para regular el actuador de extracción y se sincroniza hacia la aplicación móvil a través de una conexión inalámbrica a internet para su procesamiento predictivo.

#### Tabla 3. Componentes y funciones de la arquitectura conceptual de CompostTech

| Elemento | Composición conceptual | Función prevista |
| :--- | :--- | :--- |
| **Cámara de compostaje y módulo mecánico** | Chasis de PLA ($180 \times 280 \times 200\text{ mm}$), manivela helicoidal con zona libre de paletas[cite: 6], rieles guía[cite: 6], falso fondo ranurado y bandeja inferior extraíble. | Contener 10,08 L brutos ($\approx 7,0\text{ L}$ útiles) de biomasa, permitir el volteo manual asistido sin colisionar con las sondas y conducir efluentes hacia la bandeja inferior[cite: 6]. |
| **Placa de integración y control (PCB)** | Microcontrolador ESP32 DevKit V1[cite: 6], entradas para dos sensores capacitivos (D34, D35)[cite: 6], divisor resistivo para MQ-135 (D32)[cite: 6], pull-up para DS18B20 (D4)[cite: 6] y filtro RC para flotador P45 (D5)[cite: 6]. | Acondicionar y digitalizar las señales de biomasa, ejecutar el lazo de control térmico con histéresis, gestionar la pantalla OLED (I2C) y coordinar el envío de telemetría[cite: 6]. |
| **Subsistema de ventilación y potencia** | Ventilador DC de 12 V, transistor BJT 2N2222 (Q1)[cite: 6], diodo flyback 1N5819 (D4)[cite: 6], resistencia de base de 1 kΩ (R7)[cite: 6] y bornera de alimentación independiente de 12 V[cite: 6]. | Realizar la extracción de aire forzado activada desde el pin D23 del ESP32 para regulación térmica ante elevaciones críticas y evacuación de gases viciados[cite: 6]. |
| **Plataforma móvil y modelo analítico** | Aplicación móvil en Flutter, servicio `FirebaseAuth` con gestión de UID único, almacenamiento local mediante `SharedPreferences` y modelo de Machine Learning. | Gestionar el acceso multiusuario por UID, desplegar el dashboard de telemetría con avatar interactivo de tres estados y clasificar predictivamente la fase biológica del compost para orientar intervenciones. |

*Nota.* Elaboración propia a partir del esquemático electrónico en EasyEDA y las especificaciones de diseño de CompostTech[cite: 6].

La selección de los componentes electrónicos se sustenta en la documentación técnica de sus fabricantes. Espressif Systems [15] documenta las características de cómputo y conectividad inalámbrica del ESP32 DevKit V1[cite: 6], Analog Devices [16] detalla el protocolo OneWire y la resolución térmica de la sonda digital sumergible DS18B20[cite: 6], Zhengzhou Winsen Electronics Technology [17] describe la respuesta analógica y sensibilidad del sensor de calidad de aire MQ-135[cite: 6], y ON Semiconductor [18] especifica las capacidades de conmutación de corriente del transistor NPN 2N2222 para cargas inductivas[cite: 6]. Asimismo, Solomon Systech [19] documenta el controlador SSD1306 para la pantalla OLED mediante bus I2C[cite: 6], mientras que las propiedades mecánicas y térmicas del polímero PLA empleado en la estructura se sustentan en los ensayos de Ho et al. [20].

La arquitectura electrónica se integra mediante una placa de circuito impreso (PCB) de dos capas desarrollada en EasyEDA Pro[cite: 8], cuyo ruteado separa deliberadamente las pistas de señal de los componentes de potencia y organiza conectores externos tipo 2510 para facilitar el desacoplamiento de las sondas durante labores de limpieza[cite: 6, 7]. Por su parte, la arquitectura de software articula la autenticación en la nube mediante Firebase con persistencia local indexada por UID, sirviendo como soporte para la alimentación de datos hacia el modelo de aprendizaje automático propuesto para la clasificación predictiva de fases [21]. Ambas configuraciones convergen para consolidar un sistema semi-autónomo capaz de articular el sensado físico con la toma de decisiones asistida.

### 3.3. Secuencia prevista de operación e indicadores de control

CompostTech contempla una rutina de operación cíclica y semi-autónoma orientada al seguimiento continuo de la biomasa orgánica y la mitigación de condiciones anaeróbicas. La adquisición de datos se gestiona mediante el microcontrolador ESP32 DevKit V1, el cual ejecuta lecturas periódicas cada cuatro segundos a través de sus interfaces digitales y analógicas. Este intervalo temporal permite capturar de manera representativa la evolución de la temperatura en el núcleo mediante la sonda DS18B20 (OneWire), los niveles de humedad en los estratos superior e inferior a través de los sensores capacitivos (ADC), la concentración global de gases metabólicos en la cámara periférica mediante el sensor MQ-135 (ADC) y el estado binario del flotador magnético en la bandeja recolectora de lixiviados (GPIO).

Las señales analógicas y digitales adquiridas son sometidas a un preprocesamiento y filtrado digital en el microcontrolador para suprimir perturbaciones por ruido electromagnético o rebotes mecánicos, apoyado por la red RC física integrada en la PCB personalizada. Posteriormente, la información procesada se despliega de forma inmediata en la pantalla OLED de 0,96" mediante comunicación I2C, actualizando la iconografía dinámica del avatar local. En simultáneo, los registros se transmiten de forma inalámbrica mediante la conexión Wi-Fi hacia el entorno móvil desarrollado en Flutter, donde los datos se segmentan y almacenan localmente bajo el identificador único del usuario (UID) gestionado por `FirebaseAuth`, sirviendo a su vez como vector de entrada para el modelo de aprendizaje automático (*machine learning*).

El indicador principal de CompostTech corresponde al **Índice de Estado del Bioproceso (IEB)**, el cual clasifica la condición del compost en tres niveles operativos: óptimo (condiciones favorables), advertencia (desviaciones transitorias) e intervención crítica (riesgo inminente de putrefacción o emisión de olores). La determinación de este indicador y la activación de actuadores se fundamentan en reglas de decisión combinadas con un lazo de control On-Off con banda de histéresis:
- **Control térmico e integridad estructural:** Si la temperatura en el núcleo alcanza o supera los 58 °C, el microcontrolador activa automáticamente el ventilador de 12 V a través del transistor 2N2222 para forzar la extracción de calor. Esta ventilación se mantiene activa hasta que la temperatura desciende por debajo de los 55 °C, protegiendo tanto la microbiota benéfica del sobrecalentamiento como la estructura física del reactor, evitando alcanzar la temperatura de transición vítrea del polímero PLA (alrededor de los 60 °C).
- **Control de aireación y humedad:** Si los sensores capacitivos registran una humedad inferior al 45 %, el sistema genera una alerta visual de riego por déficit hídrico. Por el contrario, si la humedad sobrepasa el 70 % o el sensor MQ-135 detecta una proliferación elevada de gases volátiles (NH₃ y CO₂), el sistema activa el ventilador de extracción y emite una recomendación prioritaria para que el usuario accione la manivela helicoidal (entre 5 y 10 vueltas) e incorpore material vegetal seco estructurante en proporción 3:1.
- **Evacuación de lixiviados:** La activación del sensor flotador en la bandeja inferior notifica la saturación del compartimento (alcanzado el 75 % de su volumen útil), indicando la necesidad de escurrir los efluentes para su almacenamiento y posterior maceración externa, garantizando que el líquido no entre en contacto con la biomasa superior.

### 3.4. Representación del modelado tridimensional

Como parte de la formulación conceptual y validación geométrica de CompostTech, se desarrolló el modelo tridimensional del biorreactor mediante software CAD (Onshape) a escala funcional ($180 \times 280 \times 200\text{ mm}$, volumen total de $10,08\text{ L}$). Este diseño permite visualizar la distribución espacial de los componentes mecánicos, el recorrido del sistema de mezclado, los alojamientos de sensores y las cajas de protección electrónica, verificando la ausencia de interferencias antes de la manufactura aditiva en PLA.

El diseño estructural se compone de tres zonas principales:
1. **Cámara de mezclado y eje helicoidal:** En el interior de la cámara se ubica el eje central accionado por la manivela manual exterior, el cual incorpora paletas curvas distribuidas angularmente para descompactar y voltear la biomasa. La disposición de las paletas delimita una zona central de paso libre que evita impactos mecánicos contra las sondas de monitoreo insertadas en el sustrato.
2. **Caja electrónica y acoples externos:** En los laterales del chasis se aprecian los soportes atornillables para la caja electrónica estanca (destinada a alojar la PCB con el ESP32 y la etapa de conmutación), las rejillas para el flujo de ventilación forzada y la cámara periférica exterior diseñada para aislar el sensor semiconductor de gases de la condensación directa.
3. **Falso fondo y recolección de efluentes:** La parte inferior integra la transición hacia la base de drenaje pasivo que conduce los lixiviados hacia la bandeja colectora deslizable, asegurando que el líquido no sature la masa orgánica en degradación.

![Modelo tridimensional de CompostTech](ruta_de_tu_imagen.png)

*Figura 1. Modelo tridimensional del biorreactor CompostTech desarrollado en CAD.*

*Nota.* Elaboración propia en Onshape. Se muestra la configuración volumétrica del biorreactor de 10,08 L a escala funcional, la disposición del eje con paletas de mezclado manual accionado por manivela exterior, los conductos de ventilación y el montaje exterior de los gabinetes electrónicos y de sensado.

### 3.5. Diseño electrónico y acondicionamiento en PCB de CompostTech

Para el sistema de control y adquisición de CompostTech se desarrolló un esquemático electrónico y el diseño de una placa de circuito impreso (PCB) personalizada de dos capas mediante EasyEDA Pro[cite: 5, 8]. Este subsistema tiene como finalidad acondicionar las señales provenientes de los sensores instalados en la biomasa y en la estructura, gestionar el accionamiento electromecánico de la ventilación forzada y distribuir los niveles de tensión requeridos por el microcontrolador y los periféricos.

#### Esquemático electrónico de CompostTech

El esquemático se organiza en cinco bloques funcionales principales: control y procesamiento, adquisición y acondicionamiento de señales, etapa de potencia y ventilación, interfaz de visualización y distribución de alimentación, como se presenta en la Figura 2[cite: 5].

* **Control y procesamiento:** La unidad central corresponde al microcontrolador ESP32 DevKit V1 (30 pines), encargado de digitalizar las lecturas analógicas, procesar la lógica de control con histéresis, gestionar la comunicación I2C y transmitir la información de telemetría[cite: 5].
* **Adquisición y acondicionamiento de señales:** El diseño contempla conectores tipo 2510 para enlazar los sensores abióticos[cite: 5]:
  - *Humedad en biomasa:* Dos conectores independientes (2510-3A) asignados a los niveles superior e inferior, enlazados a los canales de conversión analógica-digital D34 y D35 del microcontrolador[cite: 5].
  - *Gases en cámara periférica:* Conector (2510-4A) para el sensor semiconductor MQ-135, el cual incorpora un divisor resistivo de tensión formado por R1 (10 kΩ) y R3 (10 kΩ) que acopla el nivel de salida al rango seguro del pin ADC D32 (máximo 3,3 V)[cite: 5].
  - *Temperatura en núcleo:* Conector (2510-3A) para la sonda digital sumergible DS18B20, que implementa el bus OneWire en el pin D4 con su respectiva resistencia de elevación (*pull-up*) R2 (4,7 kΩ) conectada a la línea de 3,3 V[cite: 5].
  - *Nivel de lixiviados:* Conector (2510-2A) para el flotador magnético en la bandeja inferior, conectado al pin digital D5 a través de una red de filtrado pasivo antirrebote integrada por R4 (10 kΩ), R5 (1 kΩ) y el condensador de desacoplo C1 (100 nF)[cite: 5].
* **Etapa de potencia y ventilación:** Para accionar el ventilador extractor de 12 V DC se implementó un circuito de conmutación en emisor común basado en el transistor BJT NPN 2N2222 (Q1)[cite: 5]. La conmutación es gobernada desde el pin digital D23 del ESP32 a través de una resistencia de polarización de base R7 (1 kΩ)[cite: 5]. En paralelo con la bornera de conexión del ventilador (FAN_12V), se colocó el diodo Schottky 1N5819 (D4) en polarización inversa (*flyback*), protegiendo al semiconductor contra sobretensiones transitorias producidas por la inductancia del motor[cite: 5].
* **Interfaz de visualización:** Dispone de un conector hembra de 4 pines enlazado a las líneas de comunicación I2C del microcontrolador (SCL en el pin D22 y SDA en el pin D21), proporcionando alimentación de 3,3 V y referencia de tierra para el funcionamiento de la pantalla OLED local[cite: 5].
* **Bloque de alimentación:** La placa integra borneras de tornillo independientes para la entrada de batería/fuente lógica de 5 V (BATTERY/VIN), la entrada de alimentación externa de 12 V (12V_IN) para la etapa de extracción y una salida auxiliar regulada de 3,3 V (3V3_OUT), garantizando la separación de líneas de potencia y señal[cite: 5].

![Esquemático electrónico de CompostTech](ruta_de_tu_imagen_esquematico.png)

*Figura 2. Esquemático electrónico del sistema de monitoreo CompostTech.*[cite: 5]

*Nota.* Elaboración propia en EasyEDA Pro[cite: 5]. Se presentan los bloques funcionales de control (ESP32 DevKit V1), acondicionamiento de sensores (DS18B20, humedad dual, MQ-135 y flotador), etapa de conmutación para ventilador de 12 V, interfaz I2C para pantalla OLED y bornes de alimentación[cite: 5].

---

#### Diseño de la placa PCB ruteada de CompostTech

A partir del esquemático electrónico se elaboró el diseño de una placa de circuito impreso (PCB) personalizada de dos capas (Top y Bottom Layer), en la cual se distribuyeron las huellas de los componentes, las áreas de potencia y las pistas de interconexión eléctrica, como se muestra en la Figura 3[cite: 6, 8].

En la sección central de la placa se ubican los zócalos destinados al microcontrolador ESP32 DevKit V1, permitiendo su montaje y desmontaje seguro[cite: 6, 7]. A la izquierda de la placa se agruparon las conexiones de los sensores analógicos de humedad y gases, manteniendo trayectorias de pista cortas hacia los pines ADC del controlador[cite: 6]. En el lateral derecho se colocaron las interfaces digitales para el sensor DS18B20, la pantalla OLED y el circuito del flotador, optimizando el ruteo de señales de baja frecuencia[cite: 6].

La etapa de conmutación de potencia (transistor 2N2222, diodo flyback 1N5819 y borneras de 12 V) se ubicó deliberadamente en la esquina superior derecha, aislada de las líneas de datos sensibles para mitigar interferencias electromagnéticas inducidas por el arranque del ventilador[cite: 6]. Asimismo, la placa cuenta con cuatro perforaciones metalizadas (MH1 a MH4) para tornillos M3 en los vértices, asegurando su fijación mecánica dentro de la caja de control de PLA adosada al biorreactor[cite: 5, 6].

El diseño fue verificado mediante la herramienta de Verificación de Reglas de Diseño (DRC) en EasyEDA Pro, registrando cero errores y cero advertencias antes de la generación de los archivos Gerber para su fabricación. Esta integración en PCB elimina el cableado suelto tradicional en prototipos de desarrollo, garantizando la estabilidad operativa del hardware y facilitando el mantenimiento modular del sistema.

![Diseño PCB ruteada de CompostTech](ruta_de_tu_imagen_pcb.png)

*Figura 3. Diseño de la placa de circuito impreso (PCB) personalizada de CompostTech.*[cite: 6, 8]

*Nota.* Elaboración propia en EasyEDA Pro[cite: 6, 8]. Se muestra la distribución espacial de los conectores perimetrales tipo 2510, el zócalo para el ESP32 DevKit V1, las pistas ruteadas en doble cara, la etapa de conmutación de 12 V y los puntos de montaje para su instalación física[cite: 6, 7, 8].

#### 3.6. Arquitectura del software y propuesta de interfaz de usuario
La aplicación móvil desarrollada en Flutter constituye el entorno de visualización y gestión remota del sistema:

* **Módulo de autenticación:** Implementado mediante `FirebaseAuth`, permite el registro e inicio de sesión de los usuarios tanto por credenciales directas (correo/contraseña) como a través del proveedor de identidad de Google. Cada cuenta queda unívocamente vinculada al identificador universal `UID` generado por el servicio de autenticación.
* **Persistencia local segmentada:** Los perfiles de usuario y parámetros de configuración se almacenan localmente en el dispositivo utilizando `SharedPreferences`, aislando la información de cada usuario mediante claves indexadas con su respectivo identificador (`compostech_profile_v1_${user.uid}`).
* **Panel de telemetría y avatar interactivo:** La pantalla principal presenta un panel con cuatro tarjetas de monitoreo en tiempo real (temperatura en °C, porcentaje de humedad del sustrato, estado de proliferación de gases y nivel de lixiviados en bandeja). La parte central exhibe el avatar ilustrado, cuya expresión gráfica y colorimetría alertan visualmente sobre intervenciones requeridas (riego, incorporación de estructurante seco, mezclado con manivela o vaciado de efluentes).

---
#### 3.6. Arquitectura del software y propuesta de interfaz de usuario

La aplicación móvil desarrollada en Flutter constituye el entorno de visualización, asistencia operativa y gestión remota del biorreactor CompostTech:

* **Módulo de autenticación y acceso:** Implementado mediante `FirebaseAuth`, permite el registro e inicio de sesión seguro de los usuarios a través de credenciales directas (correo electrónico y contraseña) o mediante el proveedor de identidad de Google. Cada cuenta queda vinculada al identificador universal `UID` generado por el servicio de autenticación, asegurando la trazabilidad y la privacidad de los registros.

![Interfaz de autenticación de CompostTech](ruta_imagen_login.png)

*Figura 4. Propuesta de interfaz del módulo de autenticación y acceso de CompostTech.*

*Nota.* Elaboración propia en Flutter. Representación de las pantallas de registro e inicio de sesión con soporte para correo/contraseña y autenticación mediante Google, gestionadas a través de `FirebaseAuth`.

* **Persistencia local segmentada:** Los perfiles de usuario y parámetros de configuración se almacenan localmente en el dispositivo utilizando `SharedPreferences`, aislando la información de cada cuenta mediante claves indexadas con su respectivo identificador (`compostech_profile_v1_${user.uid}`).
* **Panel de telemetría y avatar interactivo:** La pantalla principal (*Home*) despliega un panel organizado en cuatro tarjetas interactivas que presentan las lecturas en tiempo real: temperatura del núcleo (en °C), humedad del sustrato (en %), índice de proliferación de gases y estado del nivel de lixiviados en la bandeja inferior. En la sección central se ubica el avatar dinámico de tres estados, cuya expresión gráfica y colorimetría alertan visualmente sobre intervenciones requeridas (riego, incorporación de estructurante seco, mezclado manual con manivela o vaciado de efluentes para maceración).

![Interfaz principal y panel de telemetría de CompostTech](ruta_imagen_home.png)

*Figura 5. Propuesta de interfaz del panel principal (Home) y telemetría de CompostTech.*

*Nota.* Elaboración propia en Flutter. Representación del panel de monitoreo con las tarjetas de variables abióticas (temperatura, humedad, gases y lixiviados) y la visualización central del avatar interactivo para la asistencia al usuario.

---
### Referencias bibliográficas 

[1] Consejo Nacional de Ciencia, Tecnología e Innovación Tecnológica (CONCYTEC), *Directiva N.º 001-2022-CONCYTEC-P: Uso de la metodología Nivel de Madurez Tecnológica (TRL)*, Resolución de Presidencia N.º 020-2022-CONCYTEC-P, Lima, Perú, 2022.

[2] P. Román, M. M. Martínez y A. Pantoja, *Manual de compostaje del agricultor: Experiencias en América Latina*, Santiago de Chile: Organización de las Naciones Unidas para la Alimentación y la Agricultura (FAO), 2013, pp. 21–35, 65.

[3] T. L. Richard y N. M. Trautmann, "Moisture content and C:N ratio calculations in composting," Cornell Waste Management Institute, Cornell University, Ithaca, NY, Tech. Rep., 1996.

[4] G. Vrettos, G. Kazamias y D. F. Lekkas, "Smart compost monitoring system using open source technologies," en *Proc. 15th Int. Conf. Environ. Sci. Technol. (CEST2017)*, Rhodes, Greece, 2017, art. CEST2017_01427.

[5] A. G. Naser, N. M. Nawi, M. R. Zakaria, M. S. M. Kassim, A. A. Mutalovich y K. K. Katibi, "Design and implementation of an integrated sensor network for monitoring abiotic parameters during composting," *Sustainability*, vol. 17, n.º 21, art. 9780, nov. 2025, doi: 10.3390/su17219780.

[6] G. Rajamuneeswaran, P. Hridhya, B. Sakthivel y N. Gayathri Bai, "Smart Compost Guardian: An IoT-based real-time compost monitoring and alert system," *Int. J. Eng. Res. Technol.*, vol. 13, n.º 5, pp. 1–5, jun. 2025, doi: 10.17577/IJERTCONV13IS05027.

[7] B. Liu, K. Zhang, Y. Wei, G. Ding, T. Xu, L. Zhang y J. Li, "Towards data-driven smart composting techniques and control systems," *Bioresour. Technol.*, vol. 440, art. 133514, feb. 2026, doi: 10.1016/j.biortech.2025.133514.

[8] A. Al-Fuqaha et al., "Compost monitoring system for kitchen waste management: Development, deployment and analysis," *IoT*, vol. 6, n.º 4, art. 64, oct. 2025, doi: 10.3390/iot6040064.

[9] Comisión de la Comunidad Andina, *Decisión 486: Régimen Común sobre Propiedad Industrial*, Lima, Perú, 2000.

[10] A. J. Baxter, "Compost monitoring device and system," Solicitud de Patente Internacional WO 2021/081597 A1, 6 de mayo de 2021.

[11] A. F. DiPaola y M. J. DiPaola, "Low-power composting monitor," Patente EE. UU. US 12 189 458 B2, 7 de enero de 2025.

[12] J. S. T. Adams, "Automated food waste composter and method," Solicitud de Patente EE. UU. US 2021/0371348 A1, 2 de diciembre de 2021.

[13] L. Zhang, "Household aerobic composting device with leachate separation," Patente de Modelo de Utilidad China CN 212832860 U, 30 de marzo de 2021.

[14] Ministerio del Ambiente (MINAM), *Reporte de Generación y Composición de Residuos Sólidos Municipales – SIGERSOL*, Lima, Perú, 2023.

[15] Espressif Systems, *ESP32-WROOM-32D / ESP32-WROOM-32U Datasheet*, Versión 3.5, Shanghái, China, 2024.

[16] Analog Devices, *DS18B20: Programmable Resolution 1-Wire Digital Thermometer*, Datasheet 19-7487, Norwood, MA, EE. UU., 2019.

[17] Zhengzhou Winsen Electronics Technology Co., Ltd., *MQ135 Semiconductor Sensor for Air Quality Control*, Manual Ver. 1.4, Zhengzhou, China, 2015.

[18] ON Semiconductor, *2N2222A General Purpose Transistor NPN*, Semiconductor Component Industries, Phoenix, AZ, EE. UU., Datasheet 2N2222A/D, 2019.

[19] Solomon Systech Limited, *SSD1306: 128 x 64 Dot Matrix OLED/PLED Segment/Common Driver with Controller*, Rev. 1.1, Hong Kong, 2018.

[20] M. P. Ho, H. Wang, J. H. Lee, C. K. Ho, K. T. Lau, J. Leng y D. Hui, "Critical factors on manufacturing processes of natural fibre composites," *Composites Part B: Eng.*, vol. 43, n.º 8, pp. 3549–3562, dic. 2012, doi: 10.1016/j.compositesb.2011.10.001.

[21] M. Lazrak, G. Ait Baddi, F. Achemchem, J. Ayour, S. Zaidouni y B. Chebli, "AI-driven and sensor-based composting in a connected bioreactor: A novel framework for predicting maturity and quality dynamics," Waste Manage. Bull., vol. 3, n.º 4, art. 100254, dic. 2025.
