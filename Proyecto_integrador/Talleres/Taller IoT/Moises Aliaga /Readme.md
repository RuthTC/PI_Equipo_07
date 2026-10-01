# Taller de Internet de las Cosas (IoT) – Proyectos de Ingeniería

Ejercicios desarrollados con una **ESP32 Dev Kit 1** y el **Arduino IDE**.

---

## Ejercicio 1: Lectura de un potenciómetro con promediado y conversión a voltaje

### 1. Descripción de lo que hicimos

Conectamos un potenciómetro a la ESP32 y leímos su señal analógica por el pin **GPIO 34** (canal ADC1). Mejoramos el código base de la clase con dos cambios:

1. **Promediado:** en lugar de una sola lectura, tomamos **10 mediciones** (una cada 10 ms) y calculamos su promedio.
2. **Conversión a voltaje:** el valor del ADC (0 a 4095) se convierte a voltios (0 a 3.3 V).

Los resultados se muestran en el **Monitor Serie** a 115200 baudios, una línea cada 0.5 s. Probamos tres posiciones del potenciómetro: mínimo, máximo y una posición intermedia.

### 2. Código

```cpp
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

### 3. Evidencia del código y resultados

| **Código en el Arduino IDE** | **Potenciómetro en el mínimo** |
| :---: | :---: |
|<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P1.2.jpeg"> |<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P1.3.jpeg">|
| **Potenciómetro en posición intermedia** | **Potenciómetro en el máximo** |
| <img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P1.1.jpeg"> | <img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P1.4.jpeg"> |

### 4. Resultados y análisis

| Posición del potenciómetro | ADC promedio | Voltaje |
|---|---|---|
| Mínimo | 0.00 | 0.00 V |
| Intermedia | ≈ 2209 – 2222 | ≈ 1.78 – 1.79 V |
| Máximo | 4095.00 | 3.30 V |

**¿Qué significan estos valores?**

- **El ADC de la ESP32 tiene 12 bits**, es decir, 2¹² = 4096 niveles (de 0 a 4095). Un valor de **0** equivale a 0 V y un valor de **4095** equivale al voltaje de referencia, 3.3 V.
- **Verificación de la fórmula:** con un promedio de 2215, el voltaje es 2215 × 3.3 / 4095 ≈ **1.78 V**, que coincide con lo que muestra el monitor serie. Esto confirma que la conversión está bien hecha.
- **Posición intermedia:** el punto medio teórico sería ≈ 2048 (1.65 V). Obtuvimos ≈ 2215 (1.78 V), lo que indica que la perilla estaba un poco más allá de la mitad, cerca del 54 % del recorrido.
- **Estabilidad en los extremos:** en 0 y 4095 los valores no cambian entre lecturas porque el ADC llega a sus límites (se satura).
- **Pequeñas variaciones en la posición intermedia:** los valores oscilan entre 2209 y 2222 aunque la perilla no se mueva. Es **ruido eléctrico** normal del ADC de la ESP32. Gracias al promedio de 10 muestras, esa variación es de solo unas decenas de unidades; con una sola lectura sería mayor.
- **Observación:** el ADC de la ESP32 no es perfectamente lineal cerca de los extremos, por lo que un valor de 4095 puede indicar saturación más que un voltaje exactamente igual a 3.3 V. Para este ejercicio la aproximación es suficiente.

### 5. ¿Por qué es importante su aplicación?

- **Adquisición de datos:** este es el primer paso de cualquier sistema IoT. Los sensores (temperatura, luz, humedad, gas) entregan una señal analógica que el microcontrolador debe leer y convertir a un número.
- **Promediar reduce el ruido:** las lecturas de sensores reales fluctúan. Promediar da datos más estables y confiables antes de enviarlos a la nube o tomar decisiones automáticas.
- **Convertir a voltaje da significado físico:** un número como 2215 no dice nada por sí solo. En voltios se puede comparar con la hoja de datos de un sensor y calibrarlo, por ejemplo convertir voltaje a temperatura con un LM35.
- **Base para los siguientes ejercicios:** este mismo procedimiento se usa luego para enviar los valores a plataformas como Arduino Cloud, ThingSpeak y Ubidots.

### 6. Evidencia del montaje en protoboard

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/potenciometro.png">

**Conexiones:** VCC del potenciómetro a 3V3, GND a GND y la señal (SIG) al GPIO 34 de la ESP32.

---
## Ejercicio 2: Conexión de la ESP32 a una red WiFi y obtención de la IP

### 1. Descripción de lo que hicimos

Usamos la biblioteca **WiFi.h** para conectar la ESP32 a una red WiFi y mostrar en el Monitor Serie la **dirección IP** que la red le asigna. El programa intenta conectarse y, mientras no lo logra, imprime un punto (`.`) cada 0.5 s. Al conectarse, muestra el mensaje de confirmación y la IP.

Primero probamos con un **hotspot del smartphone** (red `Esp1212`), como pedía la actividad. Como no pudimos completar el ejercicio así, lo realizamos finalmente con la **red WiFi de la universidad** (`UPCH_CENTRAL`).

### 2. Código

```cpp
#include <WiFi.h>

const char* ssid = "UPCH_CENTRAL";
const char* password = "CAYETANO2022";

void setup() {
  Serial.begin(115200);

  Serial.println();
  Serial.print("Conectando a: ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("¡Conectado al WiFi!");

  Serial.print("Direccion IP: ");
  Serial.println(WiFi.localIP());
}

void loop() {

}
```

### 3. Evidencia del resultado en el Monitor Serie

> Captura de la **primera prueba**, con el hotspot del celular (`Esp1212`).

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/WhatsApp%20Image%202026-09-29%20at%2019.23.03.jpeg"> 

### 4. Resultados y análisis

**Salida obtenida en la captura:**

```
Conectando a: Esp1212
.....................................
¡Conectado al WiFi!
Direccion IP: 172.20.26.17
```

**Interpretación:**

- **Mensajes iniciales (`rst:0x1 (POWERON_RESET)`, `load:...`, `entry ...`):** es el registro de arranque que la ESP32 imprime al encenderse o reiniciarse. Indica que el procesador inició correctamente y cargó el programa.
- **`Conectando a: ...`:** la ESP32 llamó a `WiFi.begin()` e inició la búsqueda de la red indicada en `ssid`.
- **Los puntos (`.`):** cada uno es una vuelta del `while` (cada 0.5 s) en la que la conexión aún no estaba lista. Una fila larga de puntos significa que tardó unos segundos en conectarse.
- **`¡Conectado al WiFi!`:** `WiFi.status()` devolvió `WL_CONNECTED`, es decir, la red aceptó a la ESP32 y el programa salió del bucle.
- **`Direccion IP: 172.20.26.17`:** es la dirección que el servidor **DHCP** de la red le asignó a la ESP32. Es una **IP privada**, válida solo dentro de esa red local, y sirve para identificar la placa en ella. Con otra red (como `UPCH_CENTRAL`) la IP asignada será distinta.
- **`loop()` vacío:** la conexión solo se necesita una vez, por eso todo está en `setup()`.
- **Redes con restricciones:** una red institucional puede tener reglas más estrictas (filtros, autenticación) que un hotspot personal. Esto explica por qué puede variar el comportamiento entre una y otra.

### 5. ¿Por qué es importante su aplicación?

- **Es el requisito de todo proyecto IoT:** sin conexión a la red, la ESP32 no puede enviar datos a la nube ni recibir órdenes. Este ejercicio es la base de los siguientes (Arduino Cloud, ThingSpeak, Ubidots y MQTT).
- **Permite monitoreo y control remoto:** una vez conectada, la placa puede enviar lecturas de sensores a una base de datos o activar dispositivos desde internet.
- **La IP sirve para verificar y diagnosticar:** mostrarla confirma que la conexión funciona y ayuda a depurar problemas de red.
- **Aplicaciones reales:** domótica, riego automático, monitoreo ambiental y sistemas que consultan APIs web.

### 6. Evidencia del montaje

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/Wifi.png"> 

La ESP32 se alimenta y programa por cable USB. Este ejercicio no necesita sensores ni protoboard, solo la placa y la red WiFi. El LED rojo encendido indica que la placa está energizada.

---
## Ejercicio 3: Envío de datos del potenciómetro a la nube (ThingSpeak)

### 1. Descripción de lo que hicimos

Conectamos un potenciómetro a la ESP32 (pin **GPIO 34**) y enviamos su lectura a la plataforma **ThingSpeak** para verla en tiempo real en una gráfica. La ESP32 se conecta al WiFi y, cada 15 segundos, lee el potenciómetro y envía el valor al **Field 1** de un canal de ThingSpeak usando la biblioteca `ThingSpeak.h`. El monitor serie informa si el envío fue exitoso.

### 2. Código

```cpp
#include <WiFi.h>
#include <ThingSpeak.h>

// WiFi de tu celular
const char* ssid = "UPCH_CENTRAL";
const char* password = "CAYETANO2022";

// ThingSpeak
unsigned long channelID = 3515315;
const char* writeAPIKey = "9ZKDR2WSXD8JG3IM";

// Potenciometro
const int potPin = 34;

WiFiClient client;

void setup() {
  Serial.begin(115200);

  // Conectarse al WiFi
  WiFi.begin(ssid, password);

  Serial.print("Conectando al WiFi");

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi conectado");

  // Iniciar ThingSpeak
  ThingSpeak.begin(client);
}

void loop() {

  // Leer potenciometro
  int valorPot = analogRead(potPin);

  Serial.print("Valor potenciometro: ");
  Serial.println(valorPot);

  // Enviar valor al Field 1
  ThingSpeak.setField(1, valorPot);

  int respuesta = ThingSpeak.writeFields(channelID, writeAPIKey);

  if (respuesta == 200) {
    Serial.println("Dato enviado correctamente a ThingSpeak");
  } else {
    Serial.print("Error al enviar. Codigo: ");
    Serial.println(respuesta);
  }

  // ThingSpeak necesita esperar entre envios
  delay(15000);
}
```

### 3. Evidencia del resultado en ThingSpeak

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P.3.jpeg"> 

### 4. Resultados y análisis

La gráfica **"Potenciometro ESP32"** (Field 1) muestra **5 entradas** (*Entries: 5*), una cada ~15 segundos, entre las 19:31:45 y las 19:32:30 aproximadamente.

| Entrada | Valor aproximado (ADC) | Voltaje aproximado | Qué pasó con el potenciómetro |
|---|---|---|---|
| 1 | ≈ 2250 | ≈ 1.81 V | Posición intermedia |
| 2 | ≈ 2250 | ≈ 1.81 V | Sin moverlo |
| 3 | ≈ 2250 | ≈ 1.81 V | Sin moverlo |
| 4 | ≈ 4095 | ≈ 3.30 V | Girado hasta el máximo |
| 5 | ≈ 850 | ≈ 0.68 V | Girado hacia abajo, cerca del mínimo |

*Los valores se estimaron a partir de la gráfica. El voltaje se calcula con: voltaje = ADC × 3.3 / 4095.*

**Interpretación:**

- **Tres primeros puntos estables (≈ 2250):** el potenciómetro no se movió, por eso la línea es plana. Es un valor intermedio, similar al del Ejercicio 1.
- **Pico en ≈ 4095:** al girar la perilla al máximo, el ADC llegó a su límite (12 bits, 4095 = 3.3 V).
- **Caída a ≈ 850:** al girar en sentido contrario, el valor bajó a casi la cuarta parte de la escala.
- **Intervalo de 15 s entre puntos:** coincide con `delay(15000)`. La versión gratuita de ThingSpeak solo permite **una actualización cada 15 segundos**. Si se envía antes, el dato se rechaza (por ejemplo, con código `-401`).
- **Código `200`:** es la respuesta que indica que ThingSpeak recibió el dato. Por eso el programa imprime *"Dato enviado correctamente a ThingSpeak"* cuando todo va bien.
- **La gráfica cambia con el movimiento físico:** esto confirma que el flujo completo funciona: potenciómetro → ADC de la ESP32 → WiFi → internet → ThingSpeak.
- **Diferencia con el Ejercicio 1:** aquí se envía el valor crudo del ADC, sin promediado ni conversión a voltaje. El voltaje de la tabla es solo una referencia calculada.

### 5. ¿Por qué es importante su aplicación?

- **Monitoreo remoto en tiempo real:** permite ver desde cualquier lugar con internet lo que mide un sensor. Es la base de sistemas reales, como monitoreo de temperatura, humedad, nivel de agua o calidad del aire.
- **Almacenamiento e historial:** ThingSpeak guarda cada dato con su fecha y hora. Esto permite analizar tendencias y detectar comportamientos anómalos.
- **Visualización sin programar la interfaz:** la plataforma genera gráficas automáticamente, lo que acelera el desarrollo de prototipos IoT.
- **Conocimiento de límites de la nube:** este ejercicio muestra una restricción real de los servicios gratuitos (el intervalo mínimo de 15 s) y cómo se debe diseñar el programa para respetarla.
- **Base para los siguientes ejercicios:** el mismo esquema (leer, conectar y enviar) se repite con otros sensores y plataformas.

### 6. Evidencia del montaje en protoboard

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/potenciometro.png"> 

La ESP32 está montada en la protoboard y alimentada por USB. El potenciómetro se conecta con cables jumper de colores: 3V3, GND y la señal al GPIO 34. En la foto se gira la perilla con la mano, lo que hace variar los valores que aparecen en la gráfica.

---
## Ejercicio 4: Sensor ultrasónico HC-SR04 con ESP32 y envío de datos a ThingSpeak

### 1. Descripción de lo que hicimos

Conectamos un **sensor ultrasónico HC-SR04** del kit de sensores a la ESP32 para medir la **distancia a un objeto** y enviar esa medida a **ThingSpeak**. La ESP32 se conecta a una red WiFi, emite un pulso ultrasónico, mide el tiempo que tarda el eco en regresar, calcula la distancia en centímetros y la envía al **Field 1** del canal cada 20 segundos. El monitor serie muestra cada medición y si el envío fue exitoso.

### 2. Código

```cpp
#include <WiFi.h>
#include "ThingSpeak.h"

// ===== WIFI =====
const char* ssid = "iPhone";
const char* password = "leonela18";

// ===== THINGSPEAK =====
unsigned long channelID = 3515313;
const char* writeAPIKey = "IPJ4ESZWMBTPQAQI";

// ===== SENSOR ULTRASONICO =====
const int trigPin = 5;
const int echoPin = 18;

WiFiClient client;

void setup() {

  Serial.begin(115200);

  // Configurar pines del HC-SR04
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  // Conectar al WiFi
  WiFi.begin(ssid, password);

  Serial.print("Conectando al WiFi");

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi conectado");

  Serial.print("Direccion IP: ");
  Serial.println(WiFi.localIP());

  // Iniciar ThingSpeak
  ThingSpeak.begin(client);
}

void loop() {

  // Generar pulso ultrasónico
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);

  digitalWrite(trigPin, LOW);

  // Medir tiempo que demora en regresar el sonido
  long duracion = pulseIn(echoPin, HIGH, 30000);

  // Calcular distancia en centimetros
  float distancia = duracion * 0.0343 / 2;

  Serial.print("Distancia: ");
  Serial.print(distancia);
  Serial.println(" cm");

  // Enviar distancia a Field 1
  ThingSpeak.setField(1, distancia);

  int respuesta = ThingSpeak.writeFields(channelID, writeAPIKey);

  if (respuesta == 200) {
    Serial.println("Dato enviado correctamente a ThingSpeak");
  } else {
    Serial.print("Error al enviar. Codigo HTTP: ");
    Serial.println(respuesta);
  }

  // Esperar 20 segundos antes del siguiente envio
  delay(20000);
}
```

### 3. Evidencia del código y del resultado en el Monitor Serie

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/image.png"> 

### 4. Resultados y análisis

**Salida del monitor serie:**

```
Distancia: 6.45 cm
Dato enviado correctamente a ThingSpeak
Distancia: 8.80 cm
Dato enviado correctamente a ThingSpeak
Distancia: 14.34 cm
Dato enviado correctamente a ThingSpeak
```

**Interpretación:**

- **Conexión WiFi:** la ESP32 se conectó y recibió la IP `172.20.10.3`, una dirección privada asignada por el hotspot del smartphone.
- **Distancias medidas:** 6.45 cm → 8.80 cm → 14.34 cm. Los valores aumentan en cada lectura, lo que indica que el objeto se fue **alejando** del sensor entre mediciones.
- **Envío exitoso:** tras cada medición aparece *"Dato enviado correctamente a ThingSpeak"*. Esto significa que `writeFields()` devolvió el código **200**, es decir, ThingSpeak recibió y guardó el dato.
- **Intervalo de 20 s:** supera el mínimo de 15 s que exige ThingSpeak en su versión gratuita, por eso no hubo rechazos.

**Cómo funciona la medición:**

1. Se envía un pulso de 10 µs por el pin **Trig** (GPIO 5), que hace que el sensor emita una ráfaga de ultrasonido.
2. `pulseIn(echoPin, HIGH, 30000)` mide cuántos microsegundos permanece en alto el pin **Echo** (GPIO 18), que es el tiempo que tarda el sonido en ir al objeto y volver. El límite de 30 000 µs evita que el programa se quede esperando si no hay eco.
3. La distancia se calcula con `duracion × 0.0343 / 2`:
   - `0.0343` cm/µs es la velocidad del sonido (≈ 343 m/s).
   - Se divide entre 2 porque el sonido recorre el camino de **ida y vuelta**.
4. Si no regresa ningún eco, `pulseIn` devuelve 0 y la distancia resulta 0 cm; ese valor indica que no hubo una lectura válida.

### 5. ¿Por qué es importante su aplicación?

- **Medición de distancia sin contacto:** es la base de sistemas como sensores de estacionamiento, robots que evitan obstáculos y medición del nivel de líquidos en tanques.
- **Monitoreo remoto del mundo físico:** al enviar la distancia a la nube, se puede supervisar desde cualquier lugar y guardar un historial. Un ejemplo es saber cuándo un tanque o un contenedor de residuos está por llenarse.
- **Integra todo el flujo IoT:** sensor → microcontrolador → WiFi → plataforma en la nube. Es el mismo esquema del Ejercicio 3, ahora con un sensor digital en lugar de uno analógico.
- **Aprendizaje de señales de tiempo:** aquí la información está en el *tiempo* de un pulso, no en un voltaje. Esto muestra otra forma de adquirir datos con un microcontrolador.

### 6. Conexiones del montaje

| HC-SR04 | ESP32 |
|---|---|
| Trig | GPIO 5 |
| Echo | GPIO 18 |
| VCC y GND | Alimentación y tierra de la placa |

---
## Ejercicio 5: LED con ESP32 y registro de su estado en ThingSpeak

### 1. Descripción de lo que hicimos

Conectamos un **LED con su resistencia** a un pin digital de la ESP32 (**GPIO 2**) y lo integramos con la plataforma **ThingSpeak**. La ESP32 se conecta al WiFi y repite un ciclo:

1. Enciende el LED y envía el valor **1** al Field 1 del canal.
2. Espera 15 segundos.
3. Apaga el LED y envía el valor **0**.
4. Espera otros 15 segundos.

Así, la gráfica de ThingSpeak ("Estado LED") refleja en la nube si el LED está encendido o apagado. También probamos escribir valores en el canal de forma manual desde el navegador, usando la URL de la API de ThingSpeak.

### 2. Código

```cpp
#include <WiFi.h>
#include <ThingSpeak.h>

// WiFi
const char* ssid = "UPCH_CENTRAL";
const char* password = "CAYETANO2022";

// ThingSpeak
unsigned long channelID = 3515333;
const char* writeAPIKey = "X1K1GND8ESF7SSJQ";

// LED
const int ledPin = 2;

WiFiClient client;

void setup() {
  Serial.begin(115200);

  pinMode(ledPin, OUTPUT);

  WiFi.begin(ssid, password);

  Serial.print("Conectando al WiFi");

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi conectado");

  ThingSpeak.begin(client);
}

void loop() {

  // LED encendido
  digitalWrite(ledPin, HIGH);
  Serial.println("LED ENCENDIDO");

  ThingSpeak.setField(1, 1);

  int respuesta = ThingSpeak.writeFields(channelID, writeAPIKey);

  if (respuesta == 200) {
    Serial.println("Dato enviado correctamente a ThingSpeak");
  } else {
    Serial.print("Error al enviar. Codigo: ");
    Serial.println(respuesta);
  }

  delay(15000);

  // LED apagado
  digitalWrite(ledPin, LOW);
  Serial.println("LED APAGADO");

  ThingSpeak.setField(1, 0);

  respuesta = ThingSpeak.writeFields(channelID, writeAPIKey);

  if (respuesta == 200) {
    Serial.println("Dato enviado correctamente a ThingSpeak");
  } else {
    Serial.print("Error al enviar. Codigo: ");
    Serial.println(respuesta);
  }

  delay(15000);
}
```

### 3. Evidencia del resultado en ThingSpeak

**Gráfica "LED ESP32" (Field 1: Estado LED):**


<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P5.1.jpeg"> 

**Pruebas manuales con la API desde el navegador:**

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P5.2.jpeg"> 

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P5.3.jpeg"> 

### 4. Resultados y análisis

**Gráfica del estado del LED:**

- El eje vertical muestra solo dos valores: **1.00 (LED encendido)** y **0.00 (LED apagado)**.
- Al inicio se ven puntos en 1.00 separados por un tiempo largo: corresponden a envíos previos, durante las pruebas.
- Desde aproximadamente las 19:53:30 la gráfica alterna **0 → 1 → 0 → 1 → 0** con un punto cada ~15 segundos. Esto coincide con el programa: un cambio de estado por cada `delay(15000)`.
- El intervalo de 15 s no es arbitrario: es el tiempo mínimo entre actualizaciones que permite ThingSpeak en su versión gratuita.

**Pruebas con la URL de la API** (`api.thingspeak.com/update?api_key=...&field1=0` y `...&field1=1`):

- Son peticiones HTTP que escriben un valor en el Field 1 del canal sin usar la ESP32.
- La página mostró `0` como respuesta en ambos casos. Cuando ThingSpeak acepta un dato, responde con el número de entrada; un `0` indica que **la actualización no fue registrada**, normalmente porque no habían pasado 15 s desde la anterior.

**Foto del circuito:**

- El LED se ve **encendido (rojo)**, conectado en serie con una **resistencia** para limitar la corriente. Esto confirma que el pin digital está entregando `HIGH` en ese momento.

**Alcance del ejercicio:**

- En este código, el LED lo controla la **propia ESP32** (`digitalWrite`) y ThingSpeak solo **registra y muestra** su estado. El flujo de datos es **ESP32 → nube**.
- El control remoto completo (nube → ESP32) requiere que la placa **lea** el canal y actúe según el valor recibido. Este código no lo implementa.

### 5. ¿Por qué es importante su aplicación?

- **Introduce los actuadores en IoT:** hasta ahora se leían sensores. Aquí se maneja una salida digital, base para controlar relés, motores, bombas o luces.
- **Retroalimentación del estado:** publicar el estado del LED en la nube permite saber desde cualquier lugar si un dispositivo está encendido o apagado. Es lo que se usa para supervisar equipos de forma remota.
- **Historial de eventos:** la gráfica guarda cuándo cambió el estado, útil para auditar el funcionamiento de un equipo.
- **Uso correcto de un pin digital con LED:** la resistencia protege tanto al LED como al pin de la ESP32.
- **Camino hacia el control remoto:** el mismo esquema (ESP32 + WiFi + plataforma) sirve para pasar de *monitorear* a *controlar* dispositivos desde internet, por ejemplo con MQTT o leyendo un campo de ThingSpeak.

### 6. Evidencia del montaje en protoboard

<img src="https://github.com/RuthTC/PI_Equipo_07/blob/main/Proyecto_integrador/Talleres/Taller%20IoT/Moises%20Aliaga%20/imagen/P5.jpeg"> 

LED con resistencia montado en la protoboard y conectado con cables jumper a la ESP32 (señal al GPIO 2 y retorno a GND). En la foto, el LED está encendido.

---
