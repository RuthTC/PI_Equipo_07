# CompostTech PCB - Sistema de monitoreo de compostaje

## Descripción

Esta PCB fue diseñada para el proyecto CompostTech, un sistema IoT orientado al monitoreo de variables importantes durante el proceso de compostaje.

La placa integra el ESP32 como unidad principal de procesamiento y permite conectar diferentes sensores para obtener información del estado del compost, además de incluir conexiones para alimentación, visualización y control de ventilación.

## Diseño del sistema

La PCB fue desarrollada considerando una distribución organizada de los componentes:

- ESP32 como controlador principal.
- Sensores ubicados mediante conectores externos para facilitar su instalación y mantenimiento.
- Zona de alimentación separada para evitar interferencias.
- Conexión para ventilador de 12V mediante un circuito de control.
- Espacios de montaje para fijar la placa dentro de la estructura del proyecto.

## Componentes principales

### ESP32 DevKit V1

Es el microcontrolador encargado de recibir la información de los sensores, procesar los datos y enviar la información al sistema de monitoreo.

### Sensores

La placa cuenta con conectores para:

- Sensor de humedad superior.
- Sensor de humedad inferior.
- Sensor de gases MQ-135.
- Sensor de temperatura DS18B20.
- Sensor de nivel de lixiviados mediante flotador.

### Pantalla OLED

Se incorporó un conector para una pantalla OLED mediante comunicación I2C, utilizando los pines correspondientes del ESP32 para mostrar información del sistema.

### Control de ventilación

Se añadió una salida para un ventilador de 12V. 

El control se realiza mediante un transistor/MOSFET, permitiendo que el ESP32 pueda activar o desactivar la ventilación según las condiciones detectadas por los sensores.

## Alimentación

La PCB incluye entradas independientes para:

- Alimentación principal.
- Entrada de 12V.
- Salida de 3.3V.

Esto permite conectar diferentes módulos y mantener una distribución adecuada de energía dentro del sistema.

## Diseño PCB

Características del diseño:

- Placa con 4 agujeros de montaje.
- ESP32 colocado en la zona central para facilitar el conexionado.
- Sensores distribuidos alrededor de la placa.
- Componentes de potencia ubicados cerca de las conexiones correspondientes.
- Pistas organizadas para mejorar la fabricación y reducir cruces.

## Vista del diseño

### Esquemático

<img width="1027" height="592" alt="Captura de pantalla 2026-09-22 201958" src="https://github.com/user-attachments/assets/5046a2cc-3bf0-4f09-904a-ebbfd5a92926" />


### Diseño PCB

<img width="593" height="497" alt="Captura de pantalla 2026-09-22 201936" src="https://github.com/user-attachments/assets/e6948a0e-ff20-43c7-a009-ab475653eca9" />


<img width="620" height="522" alt="Captura de pantalla 2026-09-22 201943" src="https://github.com/user-attachments/assets/132e3d56-9069-42ce-8f69-0344f01f10be" />


### Vista 3D

<img width="1022" height="786" alt="Captura de pantalla 2026-09-22 202032" src="https://github.com/user-attachments/assets/836d9bd3-2826-4ef2-83d0-c9f998e34955" />

<img width="592" height="445" alt="Captura de pantalla 2026-09-22 202047" src="https://github.com/user-attachments/assets/2b119961-6ca7-4fe8-a84f-554937ba659a" />


## Verificación

Antes de la fabricación se realizó la revisión mediante la herramienta DRC de EasyEDA.

Resultado:

- Errores: 0
- Advertencias: 0

La placa quedó lista para generar los archivos Gerber y realizar la fabricación.

## Herramienta utilizada

- EasyEDA Pro
- ESP32 DevKit V1
- Diseño de PCB multicapa/señalado
- Exportación Gerber para fabricación

## Proyecto

**CompostTech**  
Proyecto Integrador - Sistema IoT para monitoreo de compostaje.
