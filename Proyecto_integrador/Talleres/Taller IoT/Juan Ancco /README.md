# Prácticas con ESP32 e IoT

En estas actividades trabajé con el ESP32 desde cosas básicas como leer un potenciómetro hasta enviar datos a ThingSpeak y controlar un LED. Al inicio varias cosas eran nuevas para mí, sobre todo el uso del ADC, la conexión WiFi y la forma en la que el ESP32 se comunica con una plataforma IoT, pero con cada práctica fui entendiendo mejor cómo se relacionan el hardware, el código y la nube.

## Actividad 01 - Lectura de un potenciómetro

En la primera actividad trabajé con un potenciómetro conectado al GPIO 34 del ESP32. La idea fue mejorar la lectura haciendo un promedio de varias mediciones y después convertir el valor obtenido por el ADC a voltaje.

Esto me ayudó a entender que el ESP32 no recibe directamente un valor en voltios, sino un valor digital entre 0 y 4095. Luego ese dato se puede convertir a un voltaje entre 0 V y 3.3 V.

Durante las pruebas pude ver diferentes casos. Cuando el potenciómetro estaba al mínimo, el ADC mostraba aproximadamente 0 y el voltaje era 0 V. Cuando estaba al máximo llegaba a 4095 y aproximadamente 3.3 V. También probé valores intermedios, donde obtuve alrededor de 1.78 V.

![ADC en valor máximo](evidencias/actividad1_adc_maximo.png)

![ADC en valor mínimo](evidencias/actividad1_adc_minimo.png)

![Lectura intermedia del potenciómetro](evidencias/actividad1_promedio_intermedio.png)

![Código de la actividad 01](evidencias/actividad1_codigo.png)

Con esta actividad aprendí mejor cómo funciona una entrada analógica y por qué es útil hacer varias mediciones y sacar un promedio antes de trabajar con el dato.

## Actividad 02 - Conexión WiFi con ESP32

En esta actividad aprendí a conectar el ESP32 a una red WiFi.

Al principio tuve algunos problemas porque el ESP32 se quedaba intentando conectarse y en el Monitor Serie solo aparecían puntos. Después de revisar el nombre de la red, la contraseña y reiniciar la placa, la conexión funcionó correctamente.

Una vez conectado, el ESP32 mostró en el Monitor Serie la dirección IP que recibió dentro de la red.

![ESP32 conectado al WiFi](evidencias/actividad2_wifi_ip.png)

Esta parte me ayudó a entender mejor para qué sirven el SSID, la contraseña y la dirección IP. También aprendí a usar el Monitor Serie para comprobar si el ESP32 realmente logró conectarse.

## Actividad 03 - Potenciómetro y ThingSpeak

En esta actividad usamos nuevamente el potenciómetro, pero esta vez el valor ya no se quedó solamente en el Monitor Serie.

El ESP32 se conectó al WiFi y empezó a enviar las lecturas del potenciómetro a ThingSpeak. Para poder hacerlo tuve que crear un canal, configurar un Field y utilizar el Channel ID junto con una Write API Key.

Una vez que todo estuvo configurado, los datos comenzaron a aparecer en una gráfica. Al mover el potenciómetro se podía ver cómo el valor subía o bajaba.

![Gráfica del potenciómetro en ThingSpeak](evidencias/actividad3_thingspeak_potenciometro.png)

Esta fue una de las actividades que más me ayudó a entender el concepto de IoT, porque pude ver cómo un componente físico conectado al ESP32 podía enviar información a Internet y visualizarse desde una plataforma web.

También aprendí que ThingSpeak necesita un pequeño intervalo entre cada envío de datos y que una respuesta correcta del servidor indica que el valor fue recibido.

## Actividad 04 - Sensor ultrasónico y ThingSpeak

Para esta actividad trabajamos con un sensor ultrasónico. La idea fue medir una distancia y enviar ese valor a ThingSpeak.

El sensor funciona enviando un pulso y esperando el tiempo que tarda en regresar. A partir de ese tiempo se calcula la distancia en centímetros.

Durante las pruebas obtuvimos diferentes valores, por ejemplo 6.45 cm, 8.80 cm y 14.34 cm. Después de cada medición, el ESP32 enviaba correctamente el dato a ThingSpeak.

![Lecturas del sensor ultrasónico](evidencias/actividad4_ultrasonico_serial.png)

Con esta actividad aprendí que no todos los sensores funcionan igual. En el caso del ultrasónico no se lee directamente un valor analógico, sino que se mide el tiempo que demora en regresar una señal.

También reforcé lo aprendido en la actividad anterior, porque nuevamente tuvimos que conectar el ESP32 al WiFi y enviar información hacia ThingSpeak.

## Actividad 05 - Control y monitoreo de un LED

En la última actividad trabajamos con un LED conectado al ESP32.

En este caso ya no estábamos trabajando con un sensor, sino con un actuador. El LED podía tener dos estados: encendido y apagado.

Para representar esos estados en ThingSpeak utilizamos:

- `1` para LED encendido.
- `0` para LED apagado.

En la gráfica se podía ver claramente cómo el valor cambiaba entre 1 y 0.

![Estado del LED en ThingSpeak](evidencias/actividad5_grafica_led.png)

También hicimos pruebas enviando los estados desde ThingSpeak.

![Estado 0 enviado a ThingSpeak](evidencias/actividad5_api_0.png)

![Estado 1 enviado a ThingSpeak](evidencias/actividad5_api_1.png)

Finalmente pudimos comprobar físicamente que el LED encendía correctamente en la protoboard.

![LED encendido en la protoboard](evidencias/actividad5_led_fisico.png)

Esta actividad me ayudó a entender mejor la diferencia entre monitorear información y controlar un dispositivo. En las actividades anteriores principalmente enviábamos datos desde el ESP32 hacia la nube, mientras que aquí ya trabajamos con el estado de una salida física.

## Lo que aprendí

Después de realizar las cinco actividades entendí mejor cómo se puede utilizar un ESP32 en un proyecto IoT.

Primero aprendí a leer información de una entrada analógica y convertirla a un valor más entendible. Luego aprendí a conectar el ESP32 a Internet y comprobar su dirección IP.

Después pasamos a enviar información a ThingSpeak, primero con un potenciómetro y luego con un sensor ultrasónico. Finalmente trabajamos con un LED, lo que me permitió entender la diferencia entre un sensor y un actuador.

También aprendí bastante resolviendo errores durante las prácticas, por ejemplo problemas al cargar el programa al ESP32, la conexión al WiFi, el uso del Monitor Serie, la instalación de la librería de ThingSpeak y la configuración del Channel ID y la API Key.

En general, estas prácticas me ayudaron a entender de una forma más práctica cómo se conectan entre sí los sensores, el ESP32, una red WiFi y una plataforma en la nube.
