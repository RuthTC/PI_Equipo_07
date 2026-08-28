# Lista de Exigencias - Monitor de Compostaje Inteligente "CompostTech"

| **PROYECTO** | Monitor de Compostaje Inteligente - "CompostTech" | **FECHA** | 20/08/2026 |
| :--- | :--- | :--- | :--- |
| **CLIENTE** | UNIVERSIDAD PERUANA CAYETANO HEREDIA | **EDICIÓN** | Rev. 2 |
| **ELABORADO** | A.A, R.T, A.C, J.A, M.A | **REVISADO** | — |

---

## Tabla de Exigencias

| Fecha | D/E | Categoría / Descripción | Responsable |
| :---: | :---: | :--- | :---: |
| **20/08/26** | **E** | **Función Principal:** CompostTech monitorea y controla las condiciones del compostaje midiendo temperatura, humedad, pH y gases. El sistema compara las lecturas con rangos establecidos y, mediante una pantalla LCD, alerta al usuario para que corrija la condición, verificando el resultado posteriormente.<br><br>Adicionalmente, incluye una página web y una aplicación móvil como dashboard remoto para consultar en tiempo real el estado del compost, historial de mediciones y alertas. | A.A, R.T |
| **21/08/26** | **E** | **Geometría:** El dispositivo deberá presentar un diseño compacto, portátil y resistente a las condiciones propias de una compostera.<br>El prototipo estará compuesto por una unidad de control, sensores, sistema de alimentación y elementos de visualización o comunicación.<br>Como requerimiento de diseño, el dispositivo completo no deberá superar aproximadamente: **$0.40\text{ m} \times 0.30\text{ m}$ de base y $0.50\text{ m}$ de altura**.<br><br>• Los sensores deberán ubicarse de manera estratégica dentro de la compostera para obtener mediciones representativas sin interferir significativamente con el proceso de descomposición.<br>• La estructura deberá permitir retirar los sensores para realizar mantenimiento, limpieza o calibración. | A.A, R.T |
| **21/08/26** | **E** | **Cinemática:** El sistema tendrá un funcionamiento principalmente electrónico y no requerirá mecanismos de movimiento continuo.<br>Los sensores permanecerán ubicados en puntos determinados del compost y realizarán mediciones periódicas.<br>El usuario será responsable de las intervenciones físicas, como:<br>- Voltear el compost.<br>- Agregar agua.<br>- Incorporar material seco.<br>- Mezclar los residuos.<br>El dispositivo únicamente detectará las condiciones y comunicará al usuario cuándo se recomienda realizar estas acciones. | A.A, R.T |
| **22/08/26** | **E** | **Fuerzas:** El sistema no generará fuerzas mecánicas significativas sobre el compost, debido a que no contará con mecanismos automáticos de volteo ni sistemas de dosificación.<br>La estructura deberá soportar:<br>- Peso de los sensores.<br>- Peso del controlador.<br>- Elementos de protección.<br>- Sistema de alimentación.<br><br>• Los sensores deberán estar correctamente fijados para evitar desplazamientos o daños durante el volteo manual del compost. | A.A, R.T |
| **23/08/26** | **E** | **Condiciones Ambientales:** El sistema monitorea las condiciones internas del compost según rangos biológicos para descomposición aerobia eficiente [4]:<br>- **Temperatura:** fase mesófila $20-35^\circ\text{C}$; fase termófila $35-65^\circ\text{C}$. Alerta si permanece $<55^\circ\text{C}$ durante más de 3 días (sanitización).<br>- **Humedad:** óptima $50-70\%$. Alerta si $<45\%$ (inhibición microbiana) o $>70\%$ (anaerobiosis).<br>- **pH:** monitorear tendencia a la neutralidad ($\sim 7$). Alerta si $<5.5$ o $>8.5$. | A.A, R.T |
| **23/08/26** | **E** | **Energía:** El sistema deberá trabajar con *bajo consumo energético*, debido a que estará compuesto principalmente por sensores, un microcontrolador y un sistema de comunicación.<br>El prototipo podrá utilizar una fuente de alimentación de baja tensión o una batería recargable.<br>El consumo deberá mantenerse reducido mediante mediciones periódicas y modos de bajo consumo cuando el sistema no se encuentre realizando una lectura.<br><br>• Los componentes electrónicos deberán estar protegidos contra humedad y contacto directo con el material orgánico [2]. | A.A, R.T |
| **23/08/26** | **E** | **Materia:**<br>**Materia de ingreso:** El sistema estará destinado al monitoreo de residuos orgánicos biodegradables utilizados para producir compost, tales como restos de frutas, restos de verduras, hojas, residuos de poda, restos vegetales y otros residuos orgánicos adecuados.<br>**Materia de salida:** El proceso tendrá como producto final *compost estabilizado*, destinado potencialmente a utilizarse como acondicionador o enmienda del suelo.<br>*El sistema no modifica directamente la materia orgánica; únicamente monitorea las condiciones bajo las cuales ocurre su descomposición.* | A.A, R.T |
| **23/08/26** | **E** | **Señales (Información):** El sistema contará con señales de entrada y salida que permitan conocer el estado del proceso.<br><br>**Señales de entrada:**<br>- Señal de inicio / parada<br>- Señales de temperatura, humedad, pH y gases<br>- Señal de conexión (verifica comunicación con plataforma IoT)<br><br>**Señales de salida:**<br>- Señal de condición óptima<br>- Señal de humedad baja (recomienda agregar agua)<br>- Señal de humedad elevada (recomienda airear compost)<br>- Señal de temperatura / pH inadecuado<br>- Señal de alerta e informe de pérdida de comunicación [3]<br><br>**Control:** El ESP32 procesará datos mediante un algoritmo de decisión ($Medici\acute{o}n \rightarrow Procesamiento \rightarrow Comparaci\acute{o}n \rightarrow Clasificaci\acute{o}n \rightarrow Alerta$). Considerando valores instantáneos y tendencias en el tiempo [3]. | A.A, R.T |
| **24/08/26** | **E** | **Electrónico (Hardware):** Componentes de bajo costo y disponibles comercialmente:<br>- ESP32 (Controlador e IoT)<br>- Sensores: Temperatura, Humedad, pH, Gases<br>- Módulo de alimentación, Pantalla OLED/LCD, LEDs indicadores, Buzzer<br>- Caja protectora<br>Los datos podrán ser enviados mediante Wi-Fi a una plataforma IoT para su visualización remota [5]. | A.A, R.T |
| **22/08/26** | **E** | **Software:** Programa encargado de recibir, procesar, almacenar, comparar mediciones, analizar tendencias, generar alertas, mostrar estado y registrar historial.<br>Clasifica en 3 niveles: **Óptimas**, **Advertencia** e **Intervención** [5]. | A.A, R.T |
| **22/08/26** | **E** | **Comunicaciones:** Conexión directa y cableada entre ESP32 y sensores (I2C, OneWire, ADC). Conectividad Wi-Fi para transmisión IoT a la nube, dashboard web, app móvil y pantalla local OLED [8]. | A.A, R.T |
| **22/08/26** | **E** | **Seguridad:** Carcasa externa con protección **IP65** (protección total contra polvo y chorros de agua) [1]. Operación obligatoria a voltaje de seguridad bajo (5V - 12V DC) para eliminar riesgo eléctrico. | J.M |
| **22/08/26** | **E** | **Ergonomía:** Dimensiones y manejo basados en normas **ISO 7250-1:2017** (medidas antropométricas) [6] e **ISO 6385:2016** (principios ergonómicos) [7]. | B.M |
| **21/08/26** | **E** | **Fabricación:** Componentes comerciales nacionales (plazos importación 5-15 días) [9], [10]. Gabinete en polímeros resistentes. Sondas anticorrosivas y sin emisión de tóxicos (D.S. N° 007-98-SA art. 37) [10] con acabados bajo ISO 468 [11]. | B.M |
| **21/08/26** | **E** | **Control de Calidad:** Sensores calibrados con error máx: $\pm 5\%$ humedad, $\pm 1^\circ\text{C}$ temp, $\pm 0.2$ pH [12]. Ensayo de operación continua por 24 horas previo a ensamblaje final [13]. | J.M |
| **23/08/26** | **E** | **Montaje:** Ensamblaje modular no invasivo. Módulo externo fijado con abrazaderas/soportes; sensores introducidos mediante perforaciones selladas con empaquetaduras [9], [10]. | J.M |
| **22/08/26** | **E** | **Transporte:** Peso y tamaño reducidos para fácil traslado manual. Protección contra golpes/humedad y sin necesidad de equipos especiales. | M.P |
| **21/08/26** | **D** | **Uso:** Uso en entornos domésticos, educativos o de tratamiento de residuos. Resistencia a variaciones térmicas/humedad del compost. | M.P |
| **21/08/26** | **E** | **Mantenimiento:** Sensores de fácil acceso y extracción rápida sin desmontar el sistema completo. Módulos electrónicos aislados y reemplazables en caso de falla [10]. | J.M |
| **21/08/26** | **E** | **Costos:** Presupuesto estimado de **S/300 a S/400** (sensores, ESP32, pantalla, alimentación, contenedor e integración). Fácil reemplazo de piezas. | B.M |
| **24/08/26** | **E** | **Plazos:** Inicio: 18 de septiembre. Término: 3 de diciembre a las 8 a.m. Total de ~138 horas de trabajo. Control mediante diagrama de Gantt. | J.M |

*Leyenda: **E** = Exigencia | **D** = Deseo*

---

## Referencias Bibliográficas

[1] R. Chaves-Arias, R. Campos-Rodríguez, and L. Brenes-Peralta, "Compostaje de residuos sólidos biodegradables del restaurante institucional del Tecnológico de Costa Rica," *Rev. Cienc. Ambientales*, vol. 33, no. 1, pp. 39–54, 2019, doi: 10.15359/rca.33-1.4.

[2] M. Lazrak, G. Ait Baddi, F. Achemchem, J. Ayour, S. Zaidouni, and B. Chebli, "AI-driven and sensor-based composting in a connected bioreactor: A novel framework for predicting maturity and quality dynamics," *Waste Manage. Bull.*, vol. 3, no. 4, Art. no. 100254, 2025, doi: 10.1016/j.wmb.2025.100254.

[3] S. G. V. Kameswari, A. Basavaraju, C. S. Kumar, and J. Bapat, "Compost monitoring system for kitchen waste management: Development, deployment and analysis," *IoT*, vol. 6, no. 4, Art. no. 64, 2025, doi: 10.3390/iot6040064.

[4] B. Liu, K. Zhang, Y. Wei, G. Ding, T. Xu, and L. Zhang, "Towards data-driven smart composting techniques and control systems," *Bioresour. Technol.*, vol. 440, Art. no. 133514, 2026, doi: 10.1016/j.biortech.2025.133514.

[5] L. Sugiarto, I. A. Saputra, and R. W. Abdullah, "Automated and efficient monitoring system for organic waste compost processing based on the Internet of Things (IoT)," *BEST J. Appl. Electr. Sci. Technol.*, vol. 8, no. 1, pp. 1–6, 2026, doi: 10.36456/7madhs96.

[6] *Degrees of Protection Provided by Enclosures (IP Code)*, IEC Standard 60529:1989+AMD1:1999+AMD2:2013, International Electrotechnical Commission, 2013.

[7] *Basic Human Body Measurements for Technological Design — Part 1: Body Measurement Definitions and Landmarks*, ISO Standard 7250-1:2017, International Organization for Standardization, 2017.

[8] *Ergonomics Principles in the Design of Work Systems*, ISO Standard 6385:2016, International Organization for Standardization, 2016.

[9] A. A. Stipniece, V. Vladinovskis, P. Daugulis, M. Zemite, L. Vitola, and L. Mezule, "Advantages and challenges of composting reactors for household use: Smart reactor concept," *Sustainability*, vol. 14, no. 16, Art. no. 10030, Aug. 2022, doi: 10.3390/su141610030.

[10] A. G. Naser, N. M. Nawi, M. R. Zakaria, M. S. M. Kassim, A. A. Mutalovich, and K. K. Katibi, "Design and implementation of an integrated sensor network for monitoring abiotic parameters during composting," *Sustainability*, vol. 17, no. 21, Art. no. 9780, Nov. 2025, doi: 10.3390/su17219780.

[11] *Surface Roughness — Parameters, Their Values and General Rules for Specifying Requirements*, ISO Standard 468:1982, International Organization for Standardization, 1982.

[12] M. A. Rengifo, C. A. Ramos, and J. E. Ortiz, "Diseño e implementación de un sistema de adquisición y monitoreo de variables físicas y químicas en pilas de compostaje," *Rev. Fac. Ing. Univ. Antioquia*, no. 88, pp. 45–55, 2018, doi: 10.17533/udea.redin.n88a06.

[13] D. C. Moreno, H. F. Velasco, and E. R. Peña, "Desarrollo y validación de una plataforma IoT de bajo costo para el monitoreo de variables ambientales agrícolas," *Inf. Tecnol.*, vol. 31, no. 5, pp. 113–122, 2020, doi: 10.4067/S0718-07642020000500113.
