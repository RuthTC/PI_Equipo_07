# Reporte de Actividades - Taller de Internet de las Cosas (IoT)
---

## Equipamiento y Herramientas Utilizadas
* **Microcontrolador:** ESP32 Dev Kit v1[cite: 1]
* **Sensores/Actuadores:** Potenciómetro, Kit de sensores Keystudio 48 en 1 (LM35, LDR, etc.), LED[cite: 1]
* **Entornos y Plataformas:** Arduino IDE / Cloud, Ubidots, ThingSpeak[cite: 1]
* **Protocolos e Infraestructura:** Wi-Fi (802.11 b/g/n), ADC de 12 bits, HTTP/REST, MQTT[cite: 1]

---

## 📋 Desarrollo y Análisis de las Actividades (1 a 5)

---

### 🔹 Actividad 01: Lectura Analógica con Promediado y Conversión a Voltaje (ESP32)

#### **Descripción de la Actividad**
Se configuró una entrada analógica en el puerto GPIO del ESP32 para realizar lecturas filtradas mediante el método de promediado de 10 muestras continuas. Posteriormente, el valor promedio del convertidor analógico-digital (ADC) se escaló a su correspondiente valor de tensión en voltios.
**Código Fuente**
```
int potPin = 34;

void setup() {
  Serial.begin(115200);
}

void loop() {

  int suma = 0;
  int muestras = 10;

  // Tomamos 10 mediciones
  for (int i = 0; i < muestras; i++) {
    suma = suma + analogRead(potPin);
    delay(10);
  }

  // Calculamos el promedio
  float promedio = suma / (float)muestras;

  // Convertimos ADC a voltaje
  float voltaje = promedio * 3.3 / 4095.0;

  Serial.print("ADC promedio: ");
  Serial.print(promedio);

  Serial.print(" | Voltaje: ");
  Serial.print(voltaje);
  Serial.println(" V");

  delay(500);
}
```
![Lectura Analógica con Promediado](img/p1.jpeg)

#### **Análisis Técnico y Explicación**
1. **Resolución del ADC:** El Convertidor Analógico a Digital (ADC) integrado en el ESP32 opera a una resolución por defecto de **12 bits**[cite: 1]. Esto significa que mapea el voltaje de entrada (0V a 3.3V) en un rango discreto de valores entre **0 y 4095** ($2^{12} - 1$)[cite: 1].
2. **Filtrado por Promediado (Suavizado):** Para atenuar las fluctuaciones de alta frecuencia causadas por interferencias electromagnéticas o ruido térmico, se captura un conjunto de $N$ muestras consecutivas y se calcula su media aritmética:
   $$\bar{X} = \frac{1}{N} \sum_{i=1}^{N} \text{ADC}_i$$
3. **Conversión a Voltaje:** Aplicando la relación de proporcionalidad directa para la referencia de tensión del ESP32 ($V_{\text{ref}} = 3.3\text{V}$):
   $$V_{\text{calculado}} = \left( \frac{\bar{X}}{4095} \right) \times 3.3\,\text{V}$$

#### **Conclusión/Resultado**
La técnica de promediado incrementa la precisión global del sistema de medición, estabilizando los datos presentados por el puerto serie antes de que sean procesados o transmitidos hacia la nube[cite: 1].

---

### 🔹 Actividad 02: Escaneo de Redes e Interconexión Wi-Fi mediante Hotspot

#### **Descripción de la Actividad**
Se utilizó la biblioteca `<WiFi.h>` para inicializar la interfaz de red del ESP32 en modo estación (STA), realizando la detección activa de Access Points (AP) cercanos y, posteriormente, estableciendo enlace con un punto de acceso móvil (*Smartphone Hotspot*) para obtener una IP local[cite: 1].

#### **Análisis Técnico y Explicación**
1. **Escaneo Wi-Fi:** Mediante el método `WiFi.scanNetworks()`, el microcontrolador rastrea los canales de la banda de 2.4 GHz[cite: 1]. Se extraen variables fundamentales de diagnóstico como:
   * **SSID:** Nombre del punto de acceso[cite: 1].
   * **RSSI (Received Signal Strength Indicator):** Indicador de potencia de señal expresado en dBm (valores cercanos a 0 representan mejor recepción)[cite: 1].
   * **Tipo de Cifrado:** Identificación del esquema de seguridad (WPA2, WEP, Open)[cite: 1].
2. **Gestión de Conexión:** La librería `<WiFi.h>` implementa el *stack* TCP/IP que gestiona el proceso de autenticación de cuatro vías (WPA2) y la solicitud de parámetros de red vía **DHCP**[cite: 1].
3. **Obtención de Dirección IP:** Tras autenticarse, el servidor DHCP asigna una dirección IP privada al ESP32[cite: 1]. Esta IP es verificada mediante `WiFi.localIP()` y desplegada en el Monitor Serie para confirmar la conectividad lógica dentro de la red[cite: 1].

---

### 🔹 Actividad 03: Telemetría en Tiempo Real del Potenciómetro a la Nube (Arduino Cloud, ThingSpeak, Ubidots)

#### **Descripción de la Actividad**
Se programó el ESP32 para publicar periódicamente las lecturas procesadas del potenciómetro de forma simultánea o enrutada hacia tres plataformas de gestión IoT Middleware: **Arduino IoT Cloud**, **ThingSpeak** y **Ubidots**[cite: 1].

#### **Análisis Técnico y Explicación**
1. **Arquitectura Middleware:** La actividad conecta la capa de *Hardware* (ESP32) con la capa de *Aplicación* usando servidores intermedios en la nube[cite: 1].
2. **Mecanismo de Envío por Plataforma:**
   * **Arduino IoT Cloud:** Utiliza sincronización basada en variables con seguimiento de estado (*Device Property Synchronization*)[cite: 1].
   * **ThingSpeak:** Utiliza solicitudes HTTP POST o GET enviando la clave de API (*Write API Key*) y mapeando el valor analógico al `field1`[cite: 1].
   * **Ubidots:** Emplea payloads formateados en JSON a través de sockets o llamadas HTTP/MQTT enviando el token de autenticación para actualizar la variable definida[cite: 1].
3. **Frecuencia de Muestreo y Limitaciones:** Se implementó una temporización no bloqueante mediante `millis()` para respetar los límites de velocidad (*rate limits*) e intervalos mínimos de publicación de las APIs de las plataformas gratuitas[cite: 1].

---

### 🔹 Actividad 04: Monitoreo Múltiple con Sensores del Kit Keystudio (LM35 / LDR)

#### **Descripción de la Actividad**
Se sustituyó el potenciómetro por un sensor del kit Keystudio (como el sensor de temperatura analógico **LM35** o el fotorresistor **LDR**) para capturar variables físicas reales del entorno y transmitirlas en tiempo real a los dashboards de la nube[cite: 1].

#### **Análisis Técnico y Explicación**
1. **Acondicionamiento según el Sensor:**
   * **LM35:** Otorga una respuesta lineal de $10\,\text{mV}/^\circ\text{C}$. La temperatura se escala mediante:
     $$T (^\circ\text{C}) = \frac{V_{\text{medido}} (\text{mV})}{10\,\text{mV}/^\circ\text{C}}$$
   * **LDR (Fotorresistor):** Dispuesto en un divisor de tensión, donde la variación de luminiscencia modifica su resistencia interna y altera el voltaje entregado al pin del ADC[cite: 1].
2. **Comportamiento del Sistema IoT:** Se demostró la versatilidad de la arquitectura: la capa física del sistema puede intercambiarse (diferentes tipos de sensores) manteniendo la misma infraestructura de transmisión y visualización en el Middleware (dashboards)[cite: 1].

---

### 🔹 Actividad 05: Control Bidireccional Remoto de Actuador (LED) mediante Plataforma Web

#### **Descripción de la Actividad**
Se implementó un esquema de control descendente (*Cloud-to-Device*), permitiendo encender y apagar un LED físico conectado a un pin digital del ESP32 accionando un interruptor virtual (*Widget Switch*) en la plataforma web[cite: 1].

#### **Análisis Técnico y Explicación**
1. **Comunicación Bidireccional:** A diferencia de la telemetría (donde el dispositivo es emisor), aquí el ESP32 actúa como receptor/suscriptor de comandos generados en la nube[cite: 1].
2. **Consumo de Eventos y Callbacks:**
   * Cuando el usuario presiona el botón en la interfaz web, la plataforma actualiza el valor del estado (1 o 0) y lo envía al ESP32.
   * La biblioteca en el ESP32 ejecuta una función de interrupción por software (*Callback*) al detectar un cambio en el valor recibido.
   * La función procesa el cambio y ajusta el estado lógico del pin digital mediante `digitalWrite(LED_PIN, estado)`.
3. **Relevancia del Protocolo:** Se sienta la base de los sistemas de automatización y control distribuido, donde la latencia de red influye directamente en el tiempo de respuesta del actuador[cite: 1].

---

## 📌 Conclusiones del Taller
1. **Consolidación de Arquitecturas IoT:** Se integraron de manera funcional las capas de adquisición (sensores/ADC), comunicación (Wi-Fi/TCP/IP), procesamiento intermedio (Middleware) y capa de usuario (Dashboards/Nube)[cite: 1].
2. **Gestión de Datos Analógicos:** La aplicación de algoritmos básicos como el promediado resulta esencial para garantizar la fidelidad de las mediciones antes de ser publicadas en entornos de IoT[cite: 1].
3. **Flexibilidad de Control e Interacción:** El soporte bidireccional del ESP32 permite estructurar tanto redes de monitoreo de variables ambientales como sistemas de telecontrol e interacción remota en tiempo real[cite: 1].
