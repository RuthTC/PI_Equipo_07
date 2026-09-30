## Actividad 1: Lectura de un potenciómetro con ESP32

### Objetivo

Leer la señal del potenciómetro, promediar diez mediciones y convertir el resultado a un voltaje aproximado.

### Funcionamiento

El potenciómetro se conecta al pin GPIO 34 del ESP32. El programa toma diez lecturas, separadas por 10 milisegundos, y calcula su promedio para reducir las fluctuaciones.

Luego convierte el promedio a voltaje mediante:

**Voltaje = (ADC promedio × 3.3) / 4095**

El monitor serial muestra el ADC promedio y el voltaje calculado. El proceso se repite después de una pausa de 500 milisegundos.

### Evidencia

<img src="Imagen de WhatsApp 2026-09-29 a las 17:37:36.jpeg" alt="Evidencia de la actividad 1 con ESP32 y potenciómetro" width="600">

**Figura 1.** Evidencia de la lectura del potenciómetro, promediado de datos y conversión a voltaje aproximado.

## Actividad 2: Conexión del ESP32 a una red Wi-Fi

### Objetivo

Conectar el ESP32 a una red Wi-Fi creada desde un smartphone y mostrar la dirección IP asignada en el monitor serial.

### Funcionamiento

El programa utiliza la biblioteca `WiFi.h` para gestionar la conexión inalámbrica del ESP32.

En las variables `ssid` y `password` se configuran el nombre y la contraseña de la red. La función `WiFi.begin(ssid, password)` inicia la conexión al punto de acceso del smartphone.

Mientras el ESP32 intenta conectarse, el programa muestra un punto en el monitor serial cada 500 milisegundos. Cuando el estado cambia a `WL_CONNECTED`, muestra el mensaje **“¡Conectado al WiFi!”**.

Finalmente, `WiFi.localIP()` permite consultar y mostrar la dirección IP asignada al ESP32 dentro de la red.

La función `loop()` permanece vacía porque la conexión y la visualización de la dirección IP se realizan en `setup()`.

### Evidencia

<img src="Imagen de WhatsApp 2026-09-29 a las 17:54:19.jpeg" alt="Evidencia de conexión del ESP32 a la red Wi-Fi" width="600">

**Figura 2.** Evidencia de la actividad de conexión del ESP32 al hotspot del smartphone y visualización de la dirección IP en el monitor serial.

## Actividad 3: Monitoreo del potenciómetro en ThingSpeak

### Objetivo

Enviar las lecturas de un potenciómetro conectado al ESP32 a ThingSpeak para visualizar su variación mediante una gráfica.

### Funcionamiento

El programa utiliza las bibliotecas `WiFi.h` y `ThingSpeak.h` para conectar el ESP32 a Internet y transmitir los datos a la plataforma.

En `setup()`, el ESP32 se conecta al hotspot del smartphone y muestra la dirección IP asignada en el monitor serial. Después, `ThingSpeak.begin(client)` inicializa la comunicación con ThingSpeak.

En `loop()`, la función `analogRead(potPin)` lee el potenciómetro conectado al pin GPIO 34. El valor obtenido se muestra en el monitor serial y se asigna al **Field 1** del canal mediante `ThingSpeak.setField(1, valorPot)`.

La función `ThingSpeak.writeFields(channelID, writeAPIKey)` envía la lectura al canal configurado. Si devuelve el código HTTP **200**, el programa informa que el envío fue exitoso; de lo contrario, muestra el código de respuesta para identificar el problema.

El programa espera **20 segundos** antes de repetir la lectura y el envío. Al girar el potenciómetro, cambian los valores enviados y estos pueden visualizarse en la gráfica de ThingSpeak.

### Evidencia

<img src="Imagen de WhatsApp 2026-09-29 a las 18:53:07.jpeg" alt="Evidencia del monitoreo del potenciómetro en ThingSpeak" width="600">

**Figura 3.** Evidencia de la actividad de envío de lecturas del potenciómetro desde el ESP32 a ThingSpeak.

## Actividad 4: Monitoreo de distancia con un sensor ultrasónico y ThingSpeak

### Objetivo

Medir la distancia a un objeto mediante el sensor ultrasónico HC-SR04 conectado al ESP32 y enviar las mediciones a ThingSpeak para su visualización.

### Funcionamiento

El programa utiliza las bibliotecas `WiFi.h` y `ThingSpeak.h` para conectar el ESP32 a la red Wi-Fi y transmitir las mediciones a la plataforma.

El sensor HC-SR04 utiliza dos pines:

- **Trig, conectado al GPIO 5:** activa la emisión del pulso ultrasónico.
- **Echo, conectado al GPIO 18:** permite medir el tiempo de recorrido del sonido.

En `setup()`, se configuran los pines, se establece la conexión Wi-Fi y se inicializa la comunicación con ThingSpeak.

En `loop()`, el ESP32 genera un pulso de 10 microsegundos en Trig. Después, `pulseIn(echoPin, HIGH, 30000)` mide la duración del pulso recibido en Echo, con un tiempo máximo de espera de 30 000 microsegundos.

La distancia se calcula mediante:

**Distancia (cm) = duración (µs) × 0.0343 / 2**

El valor **0.0343 cm/µs** representa la velocidad aproximada del sonido. Se divide entre dos porque el sonido recorre el trayecto de ida hasta el objeto y de regreso al sensor.

La distancia se muestra en el monitor serial y se envía al **Field 1** de ThingSpeak. Si la respuesta es **200**, el programa confirma que el envío fue exitoso; de lo contrario, muestra el código de respuesta.

El programa espera **20 segundos** antes de repetir la medición y el envío.

### Consideración sobre las lecturas

Si no se recibe un eco dentro del tiempo de espera, `pulseIn()` devuelve cero y el código calcula una distancia de 0 cm. Ese valor debe interpretarse como una medición sin eco válido.

### Evidencia

<img src="Imagen de WhatsApp 2026-09-29 a las 19:11:02.jpeg" alt="Evidencia del monitoreo de distancia con HC-SR04 y ThingSpeak" width="600">

**Figura 4.** Evidencia de la actividad de medición de distancia con el sensor HC-SR04 y envío de datos desde el ESP32 a ThingSpeak.

## Actividad 5: Control de un LED desde ThingSpeak

### Objetivo

Controlar el encendido y apagado de un LED conectado al ESP32 mediante comandos enviados desde ThingSpeak.

### Funcionamiento

Se utiliza el **Field 1** de un canal de ThingSpeak para registrar el estado solicitado del LED:

- **1:** comando para encender el LED.
- **0:** comando para apagar el LED.

Desde el navegador se envía una solicitud a la API de ThingSpeak con el valor correspondiente. El ESP32 debe consultar ese valor y establecer el estado del pin digital conectado al LED.

### Evidencias

<img src="Imagen de WhatsApp 2026-09-29 a las 19:33:07.jpeg" alt="Envío del valor 1 a ThingSpeak" width="600">

**Figura 5.** Envío del valor 1 al Field 1, correspondiente al comando de encendido.

<img src="Imagen de WhatsApp 2026-09-29 a las 19:33:09.jpeg" alt="Envío del valor 0 a ThingSpeak" width="600">

**Figura 6.** Envío del valor 0 al Field 1, correspondiente al comando de apagado.

<img src="Imagen de WhatsApp 2026-09-29 a las 19:33:10.jpeg" alt="Configuración de la API de ThingSpeak" width="600">

**Figura 7.** Configuración de las claves y solicitudes de la API del canal de ThingSpeak.

### Alcance de las evidencias

Las capturas muestran el envío de los comandos a ThingSpeak. Para evidenciar la respuesta física del LED, se puede complementar con una fotografía o un video de su encendido y apagado.
