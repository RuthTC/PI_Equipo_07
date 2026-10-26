[estado_del_arte_trl1_compostec.md](https://github.com/user-attachments/files/33986210/estado_del_arte_trl1_compostec.md)

# Estado del Arte de COMPOSTEC
**TRL 1 • Proyecto Integrador 2026-2 • Equipo 06**

El **Equipo 06**, integrado por estudiantes de Ingeniería Ambiental, Informática e Industrial, propone una compostera doméstica para aprovechar residuos vegetales. Este documento revisa artículos y documentos de patente que sustentan el monitoreo del compostaje e incorpora criterios iniciales para el manejo de lixiviados y el dimensionamiento para un hogar de cuatro integrantes.

---

## 1. Descripción de la propuesta

COMPOSTEC plantea integrar:
* **Sensores:** Temperatura, humedad del material y gases.
* **Procesamiento:** Microcontrolador ESP32.
* **Interfaz de usuario:** Pantalla de visualización para orientar las intervenciones manuales del usuario.

El diseño contempla **mezclado manual** mediante una manivela y perforaciones en la base para conducir eventuales lixiviados hacia una bandeja inferior extraíble.

* **Residuos admitidos:** Restos de frutas, verduras, cáscaras y material vegetal seco.
* **Residuos excluidos:** Carnes, grasas, huesos, papel y cartón.

---

## 2. Antecedentes basados en artículos

### Vrettos, Kazamias y Lekkas [1]
Desarrollaron un sistema de monitoreo de compostaje con tecnologías de código abierto. Integraron Arduino Mega, sensores de temperatura, humedad del aire, humedad del material y metano, además de comunicación GSM/GPRS hacia una base de datos y una aplicación web. Este antecedente sustenta la integración de sensores y el registro de variables. También permite diferenciar la humedad del sustrato de la humedad relativa del aire, distinción necesaria para orientar el aporte manual de agua en COMPOSTEC.

### Rajamuneeswaran y colaboradores [2]
Presentaron *Smart Compost Guardian*, un sistema que emplea Raspberry Pi y un sensor DHT11 para registrar temperatura y humedad, visualizar información en ThingSpeak y emitir alertas por SMS. Su aporte radica en vincular las mediciones con avisos que orienten al usuario. COMPOSTEC plantea complementar este enfoque con visualización local y recomendaciones para el manejo manual de la humedad; la medición de humedad del material requerirá un sensor específico y calibrado.

---

## 3. Antecedentes basados en patentes

### WO2021081597A1 — Ashley Jane Baxter [3]
* **Título:** *Compost monitoring device and system*  
Describe sensores de temperatura, humedad relativa y gases próximos al compost, transmisión inalámbrica y procesamiento de información para recomendar intervenciones. Es un antecedente del seguimiento de gases y la asistencia al usuario. Las mediciones del aire sobre el compost deben distinguirse de las mediciones directas del núcleo.

### US12189458B2 — Angelina Frances DiPaola y Michael Joseph DiPaola [4]
* **Título:** *Low-power composting monitor*  
Describe sensores, comunicación inalámbrica, batería recargable y estrategias de bajo consumo. Aporta criterios para evaluar la autonomía energética de COMPOSTEC, considerando el consumo conjunto de sensores, pantalla y microcontrolador. La revisión identifica antecedentes técnicos y no permite afirmar que la combinación propuesta sea inédita.

---

## 4. Manejo de humedad y lixiviados

Richard [5] explica que el exceso de humedad ocupa los poros necesarios para el movimiento del aire y puede favorecer condiciones anaeróbicas. Algunos materiales vegetales liberan agua durante su descomposición; incorporar materiales vegetales secos y gruesos ayuda a mejorar la porosidad. Por ello, el manejo de humedad debe considerar tanto el aporte manual de agua como las características de la mezcla.

COMPOSTEC incorpora perforaciones inferiores que permiten evacuar los líquidos hacia una bandeja extraíble. Se deberá comprobar que los soportes no interrumpan su trayectoria y que una rejilla retenga sólidos sin obstruir el drenaje. Esta función complementa el mezclado y la aireación. El objetivo será minimizar la generación de lixiviados y evitar su acumulación dentro del compartimento.

Los lixiviados no se considerarán automáticamente fertilizantes líquidos. La Universidad Estatal de Oregón [6] advierte que el agua que ha estado en contacto con el compost o las materias primas puede contaminar cuerpos de agua y representar riesgos ambientales. Su eventual aprovechamiento requerirá una evaluación específica; inicialmente, el prototipo se enfocará en recolectarlos y registrar su volumen.

---

## 5. Capacidad para cuatro integrantes

El MINAM [7] reporta una generación nacional promedio histórica de $0.56\text{ kg}$ de residuos domiciliarios por habitante al día para 2014–2019. Como aproximación inicial, un hogar de cuatro personas generaría $2.24\text{ kg}$ diarios de residuos totales. Este dato no es una medición actual de Lima y no representa directamente la carga vegetal aceptada por COMPOSTEC.

$$\text{Generación domiciliaria total} = 4\text{ personas} \times 0.56\text{ kg/persona/día} = 2.24\text{ kg/día}$$

$$\text{Carga vegetal diaria} = \text{generación domiciliaria total} \times \text{fracción vegetal aceptada}$$

La fracción vegetal deberá determinarse mediante una caracterización preliminar de al menos siete días, registrando la masa y el volumen de los residuos admitidos, sin compactarlos, y el material seco añadido. Los resultados permitirán establecer la carga diaria, el volumen útil y la necesidad de un recipiente adicional para maduración. No se asignará un porcentaje vegetal sin evidencia.

Las dimensiones exteriores del diseño, $200 \times 300 \times 350\text{ mm}$, definen una envolvente de $21\text{ L}$. Esta cifra no corresponde a la capacidad útil del compostaje, porque incluye soportes, bandeja y otros espacios. La suficiencia del prototipo para cuatro integrantes deberá comprobarse considerando el volumen interno real, la alimentación y el tiempo de permanencia.

---

## 6. Síntesis y sustento del TRL 1

Los antecedentes muestran que el monitoreo mediante sensores, las alertas y la comunicación inalámbrica ya cuentan con desarrollos previos [1]–[4]. COMPOSTEC propone su integración en un dispositivo doméstico para residuos vegetales, con seguimiento de la humedad, mezclado manual y recolección de lixiviados. En el TRL 1, esta revisión proporciona el fundamento documental para definir requisitos; todavía no acredita el funcionamiento del prototipo, la reducción del tiempo de compostaje ni la calidad sanitaria del producto final.

---

## 7. Referencias bibliográficas (Formato IEEE)

1. G. Vrettos, G. Kazamias y D. F. Lekkas, “Smart compost monitoring system using open source technologies,” en *Proc. 15th International Conference on Environmental Science and Technology*, Rodas, Grecia, 2017, documento CEST2017_01427. [En línea]. Disponible en: [https://cest2017.gnest.org/.../cest2017_01427_oral_paper.pdf](https://cest2017.gnest.org/sites/default/files/presentation_file_list/cest2017_01427_oral_paper.pdf)
2. G. Rajamuneeswaran, P. Hridhya, B. Sakthivel y N. Gayathri Bai, “Smart Compost Guardian: An IoT-based real-time compost monitoring and alert system,” *International Journal of Engineering Research & Technology*, NCITSETM-25, jun. 2025, doi: 10.17577/IJERTCONV13IS05027. Disponible en: [https://doi.org/10.17577/IJERTCONV13IS05027](https://doi.org/10.17577/IJERTCONV13IS05027)
3. A. J. Baxter, “Compost monitoring device and system,” solicitud internacional WO2021081597A1, 6 may. 2021. [En línea]. Disponible en: [https://patents.google.com/patent/WO2021081597A1/en](https://patents.google.com/patent/WO2021081597A1/en)
4. A. F. DiPaola y M. J. DiPaola, “Low-power composting monitor,” patente estadounidense US12189458B2, 7 ene. 2025. [En línea]. Disponible en: [https://patents.google.com/patent/US12189458B2/en](https://patents.google.com/patent/US12189458B2/en)
5. T. Richard, “Water,” Cornell Cooperative Extension, Operator’s Fact Sheet n.º 3. [En línea]. Disponible en: [https://www.compost.css.cornell.edu/Factsheets/FS3.html](https://www.compost.css.cornell.edu/Factsheets/FS3.html). [Consulta: 24 oct. 2026].
6. Oregon State University Extension Service, “Agricultural composting and water quality,” publicación EM 9053. [En línea]. Disponible en: [https://extension.oregonstate.edu/catalog/em-9053-agricultural-composting-water-quality](https://extension.oregonstate.edu/catalog/em-9053-agricultural-composting-water-quality). [Consulta: 24 oct. 2026].
7. Ministerio del Ambiente, “III. Fuerzas motrices y presiones,” Informe Nacional sobre el Estado del Ambiente 2014–2019. [En línea]. Disponible en: [https://sinia.minam.gob.pe/inea/informe/fuerzas-motrices-y-presiones/](https://sinia.minam.gob.pe/inea/informe/fuerzas-motrices-y-presiones/). [Consulta: 24 oct. 2026].
