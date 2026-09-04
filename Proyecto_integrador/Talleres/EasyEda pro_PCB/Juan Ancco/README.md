# Diseño PCB - COMPOSTEC

En esta carpeta se encuentra el diseño de la PCB desarrollada para el proyecto COMPOSTEC.

La placa utiliza un ESP32 DevKit V1 como controlador principal y permite conectar los sensores que se usarán para el monitoreo del compostaje.

## Esquemático

En el esquemático se realizaron las conexiones del ESP32 con los siguientes sensores:

- Sensor de temperatura DS18B20
- 2 sensores capacitivos de humedad v1.2
- Sensor de gases MQ-135
- Sensor flotador vertical P45

También se agregaron las resistencias y capacitores necesarios para las señales de los sensores.

<img width="963" height="502" alt="planificacion" src="https://github.com/user-attachments/assets/abe68784-1ce6-4aac-8596-94b86e577d22" />


## Diseño de la PCB

Después de realizar el esquemático, los componentes fueron distribuidos en la placa y se realizaron las pistas correspondientes.

Se añadieron cuatro agujeros de montaje M3 para poder fijar la PCB dentro de la estructura del prototipo.

<img width="450" height="342" alt="2d" src="https://github.com/user-attachments/assets/d4b08da1-d094-43d8-9990-d19e07fbc3b8" />


## Vista 3D

La vista 3D permite comprobar la posición de los componentes y tener una referencia de cómo quedará físicamente la placa.

### Vista frontal

<img width="887" height="697" alt="3D" src="https://github.com/user-attachments/assets/d5ada6d0-79d4-407a-a1e7-3afc74f7efc3" />


### Vista posterior

<img width="760" height="593" alt="3Dvolteado" src="https://github.com/user-attachments/assets/2abfd2e1-be31-4af9-bc23-febec8e0a34e" />


## Archivo del proyecto

El archivo editable de EasyEDA Pro se encuentra en esta misma carpeta:

`diseño_pcb_completo.epro2`
