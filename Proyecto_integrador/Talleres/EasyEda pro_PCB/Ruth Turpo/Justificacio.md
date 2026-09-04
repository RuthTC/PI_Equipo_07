# Justificación Técnica del Diseño Electrónico y Desarrollo EDA

## 1. Justificación Técnica del Diseño Electrónico

### 1.1. Justificación del Sensor de Lixiviados (Sonda de Humedad/Nivel de Líquidos)
La integración del sensor de lixiviados responde a la necesidad de monitorear y regular de manera automatizada el nivel de humedad presente en el proceso de compostaje. Dado que el exceso de líquido compromete la oxigenación de la materia orgánica y genera condiciones anaeróbicas destructivas, este sensor actúa como la unidad de entrada de datos para determinar cuándo el sistema debe activar la ventilación, drenaje o alerta de humidificación. Su inclusión en el circuito garantiza la captura de datos en tiempo real dentro de un medio químico reactivo, permitiendo al microcontrolador mantener los parámetros idóneos para acelerar la descomposición sin pudrición.

### 1.2. Justificación de la Bornera de Conexión (KF301-4P)
La incorporación de una bornera con terminal de tornillo tipo KF301-4P responde a criterios de mantenibilidad, modularidad y confiabilidad operativa. Dado que la sonda de medición opera en un ambiente corrosivo, húmedo y dinámico dentro de la compostera, la bornera permite conectar y desacoplar el cableado externo del sensor de lixiviados sin necesidad de desoldar componentes en placa. Esto facilita el reemplazo rápido de la sonda ante el desgaste por corrosión, simplifica las tareas de calibración periódica y garantiza una sujeción mecánica firme frente a tirones accidentales durante la manipulación del compost.

### 1.3. Justificación del Enrutamiento en Dos Capas (Top y Bottom Layer)
El diseño se implementó sobre un sustrato de dos capas para optimizar el espacio y garantizar la integridad de las señales eléctricas provenientes de la sonda de lixiviados. La distinción entre las pistas rojas (cara superior) y azules (cara inferior) responde a la necesidad de:
* **Evitar cruces e interferencias:** Desacopla las líneas de alimentación de las líneas de señal analógica/digital provenientes del sensor hacia el microcontrolador, evitando lecturas erróneas por ruido electromagnético.
* **Aprovechamiento de componentes Through-Hole (THT):** Permite utilizar la cara inferior para cerrar los lazos de tierra (GND) y desviar las líneas de señal hacia el ESP32 de forma limpia, maximizando el área útil de la placa.

---

## 2. Documentación del Desarrollo en EDA

### 2.1. Diagrama Esquemático del Sistema
![Esquemático PCB - Ruth](../../../Recursos_Im%C3%A1genes/P1.Schematic1%20Ruth.png)

**Descripción:** Representación del circuito lógico y conexionado eléctrico principal correspondiente al módulo de lectura de lixiviados. Muestra la interconexión entre el microcontrolador ESP32 DevKit V1, la etapa de acondicionamiento de señal para el sensor, la interfaz de comunicación RS-485 (MAX3485ESA) y los bornes de conexión KF301-4P.

### 2.2. Diseño de Pistas y Disposición en Placa (Layout PCB 2D)
![Layout PCB 2D - Ruth](../../../Recursos_Im%C3%A1genes/PCB_Ruth.png)

**Descripción:** Distribución física de componentes y ruteo bifaz de la placa de circuito impreso. Se evidencia la separación entre los planos de potencia y los trazos de señal del sensor de lixiviados (pistas rojas en cara superior y azules en inferior), garantizando una serigrafía clara para facilitar el ensamblado manual.

### 2.3. Prototipado y Validación Visual en 3D
![Vista 3D PCB - Ruth](../../../Recursos_Im%C3%A1genes/3D_Ruth.png)

**Descripción:** Renderizado tridimensional de la PCB dedicada al sensor de lixiviados para la verificación dimensional y de tolerancias físicas. Permite validar el espacio libre alrededor de la bornera para el ingreso de los cables del sensor, la accesibilidad al puerto USB del ESP32 y la coincidencia de los orificios de sujeción M3 con la estructura del contenedor.
