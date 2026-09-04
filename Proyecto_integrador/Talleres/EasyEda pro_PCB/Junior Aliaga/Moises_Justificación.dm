### 1. Justificación Técnica del Diseño Electrónico

#### 1.1. Justificación de la Bornera de Conexión (KF301-4P)
La incorporación de una bornera con terminal de tornillo tipo KF301-4P responde a criterios de mantenibilidad, modularidad y confiabilidad operativa. Dado que la sonda de medición opera en un ambiente corrosivo, húmedo y dinámico dentro de la compostera, la bornera permite conectar y desacoplar el cableado externo sin necesidad de desoldar componentes en placa. Esto facilita el reemplazo rápido de sondas averiadas, simplifica las tareas de calibración periódica y garantiza una sujeción mecánica firme frente a tirones accidentales durante el volteo o manipulación del compost.

#### 1.2. Justificación del Enrutamiento en Dos Capas (Pistas Rojas y Azules / Top y Bottom Layer)
El diseño se implementó sobre un sustrato de dos capas (Top y Bottom Layer) para optimizar el espacio y garantizar la integridad de las señales eléctricas. La distinción entre las pistas rojas (cara superior) y azules (cara inferior) responde a la necesidad de:
* **Evitar cruces y cortocircuitos:** Permite desacoplar las líneas de alimentación (VCC/GND) de las líneas de comunicación diferencial (A/B) y control lógico hacia el microcontrolador.
* **Aprovechamiento de componentes Through-Hole (THT):** Al utilizar conectores de orificio pasante (como los pines del ESP32 y la bornera), los taladros metalizados conectan ambas caras del sustrato. Esto permite desviar pistas críticas por la cara inferior (azul) para sortear componentes superficiales (como el transceptor SMD) y cerrar los lazos de tierra de forma limpia y directa, lo cual se refleja con precisión en el renderizado 3D para validación de montaje.

---

### 2. Documentación del Desarrollo en EDA

#### 2.1. Diagrama Esquemático del Sistema
![Diagrama Esquemático](Recursos%20_Imágenes/SCH_Schematic1_1-P1_2026-09-03(Moises1).png)
* **Descripción:** Representación del circuito lógico y conexionado eléctrico principal. Se define la arquitectura de control basada en el módulo ESP32 DevKit V1, la etapa de interfaz diferencial con el transceptor MAX3485ESA (comunicación RS-485 / Modbus industrial), la bornera de alimentación y datos KF301-4P, y los taladros de sujeción mecánica tipo M3.

#### 2.2. Diseño de Pistas y Disposición en Placa (Layout PCB 2D)
![Diseño PCB 2D](Recursos%20_Imágenes/PCB_PCB1_2026-09-03(Moises)1.png)
* **Descripción:** Distribución física de componentes y ruteo bifaz de la placa de circuito impreso. Muestra el trazado de pistas en la cara superior (rojo) e inferior (azul), la separación entre planos de señal y potencia, y la serigrafía de identificación para facilitar el ensamblaje de los componentes electrónicos y la orientación de los pines.

#### 2.3. Prototipado y Validación Visual en 3D
![Vista 3D de la PCB](Recursos%20_Imágenes/3D_PCB1_2026-09-03(Moises1).png)
* **Descripción:** Renderizado tridimensional de la PCB para la verificación dimensional y verificación de colisiones (*clearance*). Permite validar la altura de los conectores, la accesibilidad de los terminales de tornillo de la bornera para el ingreso de cables, la orientación del puerto USB del ESP32 y la correcta coincidencia de los agujeros de montaje con la carcasa del prototipo.
