## Actividad 06: Mini proyecto IoT con ESP32, MQTT y Node-RED (Equipo 7)

### 1. Objetivo

Integrar en un solo sistema lo trabajado en el taller de IoT: un **ESP32** que mide temperatura y humedad con un sensor **DHT11**, publica los datos por **MQTT** a un broker **EMQX**, y un **dashboard en Node-RED** que los muestra en tiempo real y permite **encender y apagar un LED** de forma remota.

### 2. Materiales

- ESP32 Dev Kit (placa *ESP32 Dev Module*)
- Sensor DHT11
- LED con resistencia limitadora
- Protoboard y cables de conexión
- Laptop con Arduino IDE 2.3.10
- Celular con hotspot (red WiFi compartida por una compañera del equipo, Leonela)

### 3. Arquitectura y parámetros

```
DHT11 ──► ESP32 ──── WiFi / MQTT (1883) ────► Broker EMQX ────► Node-RED (equipo 7) ────► Dashboard
            ▲                                                          │
  LED ◄─────┘◄─────────── equipo07/actuadores/led ◄───────────────────┘  (switch ON/OFF)
```

| Parámetro | Valor |
|---|---|
| Broker MQTT | `mqtt.rcr-labs.com` |
| Puerto | `1883` (sin cifrado) |
| Usuario | `alumno` |
| Contraseña | `UPCH2026` |
| Client ID del ESP32 | `ESP32_Equipo07` |
| Tópico de publicación (sensor) | `equipo07/sensor/datos` |
| Tópico de suscripción (LED) | `equipo07/actuadores/led` |
| Node-RED del equipo | https://equipo7.rcr-labs.com/ |
| Dashboard | https://equipo7.rcr-labs.com/dashboard |

Formato del mensaje que publica el ESP32:

```json
{"dispositivo":"ESP32_Equipo07","temperatura":25.4,"humedad":69}
```

---

## 4. Desarrollo

### Parte A: Configuración de Node-RED

**Paso 1. Conexión de red mediante hotspot.**
La red de la universidad bloqueaba el acceso al dominio recién creado (lo marcaba como sospechoso), por lo que se trabajó con el hotspot del celular de una compañera del equipo. La laptop y el ESP32 se conectaron a esa red. En el caso del ESP32, el hotspot debe estar en la banda de **2.4 GHz**.

**Paso 2. Ingreso al Node-RED del equipo 7.**
Desde el navegador de la laptop se abrió https://equipo7.rcr-labs.com/, el servidor Node-RED asignado a nuestro equipo.

**Paso 3. Instalación de paquetes.**
Desde el menú de Node-RED, en *Manage palette → Install*, se instaló el paquete del dashboard `@flowfuse/node-red-dashboard` (Dashboard 2.0), necesario para los widgets `ui-gauge`, `ui-text` y `ui-switch` del flujo.
<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/imagen/descarga.png">


**Paso 4. Importación del flujo del profesor.**
Se importó el archivo `tallerIOT.json`, publicado en el aula virtual, desde *Menú (☰) → Import*. Este archivo contiene el flujo base del taller:

- Un nodo `mqtt in` que recibe los datos del sensor.
- Tres nodos `change` que extraen `temperatura`, `humedad` y `dispositivo` del JSON.
- Dos medidores (`ui-gauge`) para temperatura y humedad, y un texto (`ui-text`) para el dispositivo.
- Un interruptor (`ui-switch`, "Control LED") conectado a un nodo `mqtt out` que publica `ON` u `OFF`.

**Paso 5. Ajuste del broker y de los tópicos para el equipo 7.**
El archivo original usa los tópicos `taller/...`. Se modificaron para que correspondan a nuestro equipo:

| Nodo | Tópico original | Tópico del equipo 7 |
|---|---|---|
| `mqtt in` | `taller/sensor/datos` | `equipo07/sensor/datos` |
| `mqtt out` (Publicar Comandos) | `taller/actuadores/led` | `equipo07/actuadores/led` |

En la configuración del nodo broker se verificó el servidor `mqtt.rcr-labs.com`, el puerto `1883` y, en la pestaña *Security*, el usuario y la contraseña entregados por el profesor.

**Paso 6. Despliegue y verificación.**
Con **Deploy** se publicó el flujo. Los nodos `mqtt in` y `mqtt out` mostraron el estado **"conectado"** en verde, lo que confirma que Node-RED se autenticó correctamente en el broker.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/imagen/Flujo%20nodered.jpeg">


---

### Parte B: Programación del ESP32 en Arduino IDE

**Paso 7. Preparación del entorno.**

1. Se instaló el soporte de placas ESP32 (paquete *esp32 by Espressif Systems*) desde el *Boards Manager*.
2. Se seleccionó la placa **ESP32 Dev Module** y el puerto **COM9**.
3. Se instalaron las librerías necesarias desde el *Library Manager*:
   - `PubSubClient` (cliente MQTT)
   - `ArduinoJson` (construcción del mensaje JSON)
   - `DHT sensor library` de Adafruit, versión 1.4.7 (lectura del DHT11)
4. El monitor serie se configuró a **115200 baudios**.

**Paso 8. Primera versión: datos simulados.**
Se cargó el código base entregado por el profesor, que conecta el ESP32 al WiFi y al broker, y publica cada 5 segundos un JSON con temperatura y humedad **generadas aleatoriamente**. Esto sirvió para validar toda la cadena de comunicación (ESP32 → broker → Node-RED) antes de conectar el sensor físico.

Las únicas líneas que cambian respecto a la versión final son las del bloque de lectura (ver Anexo B). En esta etapa se editó el WiFi (hotspot), el `CLIENT_ID` y los tópicos del equipo 7.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/imagen/Serie%20de%20monitores.jpeg">


**Paso 9. Montaje del circuito.**
Se armó el circuito en la protoboard:

- **DHT11:** pin de datos al **GPIO 4** del ESP32, más alimentación y tierra.
- **LED:** conectado al **GPIO 2** a través de una resistencia limitadora, y a tierra.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/imagen/Circuito%20f%C3%ADsico.jpeg">


**Paso 10. Segunda versión: lectura real del DHT11.**
Se reemplazó la simulación por la lectura real del sensor con `dht.readTemperature()` y `dht.readHumidity()`. Se agregó validación con `isnan()` para descartar lecturas fallidas, y el LED se inicializa apagado en `setup()`.

| Aspecto | Versión 1 (simulada) | Versión 2 (sensor real) |
|---|---|---|
| Origen de los datos | `random()` | DHT11 en GPIO 4 |
| Librería adicional | Ninguna | `DHT.h` (Adafruit) |
| Validación de lectura | No aplica | `isnan()` |
| Formato de los valores en el JSON | Texto con 2 decimales (`serialized`) | Números (`float`) |
| LED | `digitalWrite(2, ...)` | Constante `LED_PIN` y apagado inicial |

Código final completo en el **Anexo A**.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/imagen/CodigoFinal.jpeg">


**Paso 11. Prueba del dashboard y del control del LED.**
Con el ESP32 publicando, se abrió https://equipo7.rcr-labs.com/dashboard. Se verificó la visualización de los datos del sensor y, con el interruptor **Control LED**, el encendido y apagado del LED conectado al GPIO 2.

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/imagen/Tablero%20indicadores%20aleatorio.jpeg">

---

## 5. Resultados e interpretación

### 5.1 Flujo de Node-RED
Los nodos `mqtt in` (`equipo07/sensor/datos`) y `Publicar Comandos` aparecen como **conectado**. Esto indica que el servidor Node-RED del equipo 7 tiene una sesión activa y autenticada con el broker EMQX, tanto para recibir datos (suscripción) como para enviar comandos (publicación). El nodo `Switch LED` muestra el estado `on`, es decir, el último comando enviado fue encender el LED.

### 5.2 Monitor serie con datos simulados 

- **WiFi:** el ESP32 se conectó a la red del hotspot y obtuvo la IP `172.20.10.3`, un rango típico de los hotspots de iPhone.
- **Primer intento MQTT fallido:** apareció `Falló. Código de error rc=-2`. En PubSubClient, `rc=-2` significa que no se pudo establecer la conexión de red con el broker en ese momento. Es un fallo transitorio habitual justo después de conectarse al hotspot.
- **Reconexión automática:** tras la espera de 5 segundos, el segundo intento salió `¡Conectado!` y el ESP32 quedó `Suscrito a: equipo07/actuadores/led`. Esto demuestra que la función `reconnect()` funciona como se diseñó.
- **Publicaciones:** los valores van cambiando de forma irregular (temperatura 25.60, 30.30 y 27.90 °C; humedad 60.90, 66.40 y 68.70 %). Todos están dentro de los rangos que genera el código (24 a 34 °C y 55 a 75 %), lo que confirma que son datos aleatorios, no mediciones.

### 5.3 Monitor serie con el sensor real 

- El tópico y el JSON son correctos: `{"dispositivo":"ESP32_Equipo07","temperatura":25.4,"humedad":69}`.
- La temperatura se mantiene estable en **25.40 °C** y la humedad baja suavemente de **69 % a 67 %**. Este comportamiento es el esperado en una medición real de un ambiente cerrado, a diferencia de los saltos bruscos de la versión simulada.
- Las lecturas no devolvieron errores `isnan`, por lo que el sensor y el cableado en el GPIO 4 funcionan correctamente.
- El DHT11 tiene una precisión nominal de aproximadamente ±2 °C y ±5 % de humedad relativa, por lo que sirve para monitoreo general pero no para mediciones de precisión.

### 5.4 Dashboard

- **Dispositivo:** `ESP32_Equipo07`, lo que confirma que los datos provienen de nuestra placa.
- **Temperatura 25.3 °C:** la aguja cae en la franja amarilla (20 a 30 °C).
- **Humedad 72 %:** la aguja cae en la franja roja (más de 50 %). Los colores son umbrales visuales configurados en el flujo, no una alarma real del sistema.
- **Control LED:** el interruptor aparece activado, lo que corresponde al comando `ON` publicado en `equipo07/actuadores/led`, que el ESP32 recibe y ejecuta con `digitalWrite(LED_PIN, HIGH)`.
- Los valores del dashboard (25.3 °C y 72 %) difieren ligeramente de los del monitor serie (25.4 °C y 67 a 69 %) porque las capturas corresponden a momentos distintos. La humedad del DHT11 cambia rápido con la cercanía de las manos o la respiración.

### 5.5 Gráfico de tendencias (Imagen 6)
 
El gráfico muestra la temperatura publicada en `equipo07/sensor/datos` entre aproximadamente las 7:38 y las 7:58, y se distinguen tres partes:
 
- **Tramo inicial (7:38 a 7:46):** la temperatura salta de forma brusca entre unos 24 y 34 °C de una lectura a la siguiente. Ese rango coincide exactamente con el que genera el código de datos simulados (24.0 a 33.9 °C), por lo que corresponde a la **primera etapa, con valores aleatorios**.
- **Línea recta descendente (7:46 a 7:56):** no es una medición. Es la unión que dibuja el gráfico entre el último dato y el siguiente cuando no llegaron mensajes, lo que corresponde al tiempo en que se detuvo el ESP32 y se cargó la versión con el DHT11.
- **Tramo final (desde 7:56):** los puntos aparecen estables en torno a 13 °C, ya sin las oscilaciones aleatorias, lo que es propio de un sensor real. 
La diferencia entre el tramo inicial (cambios bruscos sin relación física) y el tramo con sensor (valores estables) permite visualizar la diferencia entre datos simulados y mediciones reales. El gráfico de tendencias es útil en ingeniería porque permite detectar variaciones, picos y comportamientos anómalos que no se aprecian en un medidor que muestra solo el valor instantáneo.

 <img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/imagen/Tablero%20de%20grafica%20de%20tendencia.jpg">

## 6. Conclusiones

1. Se logró un sistema IoT completo y bidireccional: el ESP32 **envía** mediciones reales al broker y **recibe** comandos desde el dashboard para controlar un actuador.
2. Validar primero con datos simulados y luego con el sensor real permitió separar los problemas de comunicación (WiFi, MQTT, Node-RED) de los de hardware (sensor, cableado).
3. El protocolo **MQTT** es adecuado para IoT porque su modelo publicación/suscripción desacopla a los dispositivos de las aplicaciones: el ESP32 solo publica en un tópico y cualquier cliente (Node-RED, un celular, una base de datos) puede suscribirse sin modificar el dispositivo. Además, sus mensajes son ligeros y consumen poco ancho de banda y energía.
4. **Node-RED** permite construir dashboards y lógica de integración de forma visual, sin programar un servidor completo, lo que acelera el prototipado.

### Importancia en la ingeniería

La monitorización remota y el control a distancia con IoT se aplican en múltiples áreas de la ingeniería:

- **Ingeniería industrial y de procesos:** supervisión de temperatura, humedad y estado de máquinas en tiempo real, mantenimiento predictivo y reducción de paradas no planificadas.
- **Seguridad y salud en el trabajo y ergonomía:** monitoreo de condiciones ambientales (temperatura, humedad) en los puestos de trabajo para prevenir estrés térmico y generar alertas.
- **Ingeniería ambiental y agrícola:** estaciones de monitoreo de clima y suelo, y automatización del riego.
- **Ingeniería biomédica:** monitoreo remoto de variables y condiciones de almacenamiento de insumos sensibles.
- **Edificios y ciudades inteligentes:** control de climatización, iluminación y consumo energético.

En todos los casos, medir con sensores, transmitir con protocolos ligeros y visualizar en un dashboard permite **tomar decisiones basadas en datos**, reducir costos y mejorar la seguridad.

---

## 7. Limitaciones y mejoras posibles

- La conexión MQTT usa el puerto 1883 **sin cifrado**: usuario y contraseña viajan en texto plano. En un entorno real se debería usar TLS (puerto 8883).
- El DHT11 tiene precisión limitada; para aplicaciones exigentes conviene un DHT22 o un BME280.
- El estado del LED no se confirma de vuelta al dashboard. Se podría publicar un tópico de retroalimentación (por ejemplo `equipo07/actuadores/led/estado`).
- Los datos no se almacenan; se podría agregar una base de datos o un gráfico histórico en Node-RED.

---

## Anexo A: Código final del ESP32 (con DHT11 real)

> Las credenciales se ocultan en este documento. Reemplázalas por las tuyas antes de cargar el código.

```cpp
#include <WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#include <DHT.h>

// ================= WIFI =================
const char* WIFI_SSID = "iPhone";
const char* WIFI_PASS = "xxxxxxxx";   // contraseña del hotspot

// ================= MQTT =================
const char* MQTT_SERVER = "mqtt.rcr-labs.com";
const int MQTT_PORT = 1883;

const char* MQTT_USER = "alumno";
const char* MQTT_PASSWORD = "xxxxxxxx";   // credencial entregada por el profesor

const char* CLIENT_ID = "ESP32_Equipo07";

// ================= TOPICS EQUIPO 7 =================
const char* TOPIC_PUB = "equipo07/sensor/datos";
const char* TOPIC_SUB = "equipo07/actuadores/led";

// ================= DHT11 =================
#define DHTPIN 4
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);

// ================= LED =================
#define LED_PIN 2

// ================= MQTT =================
WiFiClient espClient;
PubSubClient client(espClient);

unsigned long ultimoEnvio = 0;
const long intervaloEnvio = 5000;


// ==================================================
// CONEXIÓN WIFI
// ==================================================
void setupWiFi() {

  delay(10);

  Serial.println();
  Serial.print("Conectando a WiFi: ");
  Serial.println(WIFI_SSID);

  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASS);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi conectado");
  Serial.print("IP del ESP32: ");
  Serial.println(WiFi.localIP());
}


// ==================================================
// RECIBIR MENSAJES MQTT
// ==================================================
void callback(char* topic, byte* payload, unsigned int length) {

  Serial.print("Mensaje recibido [");
  Serial.print(topic);
  Serial.print("]: ");

  String mensaje = "";

  for (unsigned int i = 0; i < length; i++) {
    mensaje += (char)payload[i];
  }

  Serial.println(mensaje);

  // CONTROL DEL LED
  if (String(topic) == TOPIC_SUB) {

    if (mensaje == "ON") {

      digitalWrite(LED_PIN, HIGH);
      Serial.println("LED ENCENDIDO");

    } else if (mensaje == "OFF") {

      digitalWrite(LED_PIN, LOW);
      Serial.println("LED APAGADO");
    }
  }
}


// ==================================================
// CONEXIÓN MQTT
// ==================================================
void reconnect() {

  while (!client.connected()) {

    Serial.print("Conectando al broker MQTT... ");

    if (client.connect(CLIENT_ID, MQTT_USER, MQTT_PASSWORD)) {

      Serial.println("CONECTADO");

      client.subscribe(TOPIC_SUB);

      Serial.print("Suscrito a: ");
      Serial.println(TOPIC_SUB);

    } else {

      Serial.print("ERROR rc=");
      Serial.println(client.state());

      Serial.println("Reintentando en 5 segundos...");
      delay(5000);
    }
  }
}


// ==================================================
// SETUP
// ==================================================
void setup() {

  Serial.begin(115200);

  // Iniciar DHT11
  dht.begin();

  // LED
  pinMode(LED_PIN, OUTPUT);
  digitalWrite(LED_PIN, LOW);

  // WiFi
  setupWiFi();

  // MQTT
  client.setServer(MQTT_SERVER, MQTT_PORT);
  client.setCallback(callback);

  Serial.println("Sistema iniciado");
}


// ==================================================
// LOOP
// ==================================================
void loop() {

  if (!client.connected()) {
    reconnect();
  }

  client.loop();

  unsigned long ahora = millis();

  if (ahora - ultimoEnvio >= intervaloEnvio) {

    ultimoEnvio = ahora;

    // ==============================================
    // LEER DHT11 REAL
    // ==============================================

    float temperatura = dht.readTemperature();
    float humedad = dht.readHumidity();

    // Verificar lectura
    if (isnan(temperatura) || isnan(humedad)) {

      Serial.println("ERROR: No se pudo leer el DHT11");
      return;
    }

    // Mostrar valores reales
    Serial.println("-----------------------------");

    Serial.print("Temperatura: ");
    Serial.print(temperatura);
    Serial.println(" °C");

    Serial.print("Humedad: ");
    Serial.print(humedad);
    Serial.println(" %");


    // ==============================================
    // CREAR JSON
    // ==============================================

    StaticJsonDocument<200> doc;

    doc["dispositivo"] = CLIENT_ID;
    doc["temperatura"] = temperatura;
    doc["humedad"] = humedad;

    char jsonBuffer[256];

    serializeJson(doc, jsonBuffer);


    // ==============================================
    // ENVIAR A NODE-RED POR MQTT
    // ==============================================

    Serial.print("Publicando en: ");
    Serial.println(TOPIC_PUB);

    Serial.print("JSON: ");
    Serial.println(jsonBuffer);

    client.publish(TOPIC_PUB, jsonBuffer);
  }
}
```

## Anexo B: Bloque que cambia en la versión con datos simulados

La versión inicial (datos aleatorios) es idéntica a la final, salvo por no incluir `#include <DHT.h>`, la definición del DHT11 ni `dht.begin()`, y porque dentro del `loop()` reemplaza la lectura real por este bloque:

```cpp
    // Simulación de lectura de sensores
    float tempSimulada = 24.0 + (random(0, 100) / 10.0);
    float humSimulada  = 55.0 + (random(0, 200) / 10.0);

    // Creación del documento JSON
    StaticJsonDocument<200> doc;
    doc["dispositivo"] = CLIENT_ID;
    doc["temperatura"] = serialized(String(tempSimulada, 2));
    doc["humedad"]     = serialized(String(humSimulada, 2));
```
