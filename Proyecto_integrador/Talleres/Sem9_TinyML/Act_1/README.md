#  Actividad 1: Detección de género (hombre / mujer) con TinyML

**Plataforma:** SenseCraft AI · **Hardware:** Seeed Studio XIAO ESP32S3 Sense (cámara integrada)
**Taller:** TinyML con XIAO ESP32S3 Sense, Universidad Peruana Cayetano Heredia
**Fecha de la práctica:** 13/10/2026
**Integrantes:** Juan · Moisés · Ruth · Leonela

---

## 1. Introducción

En esta actividad desarrollamos un sistema de **visión artificial en el borde (Edge AI / TinyML)**. Con la cámara del **XIAO ESP32S3 Sense** capturamos imágenes en tiempo real, y un modelo de detección de objetos las analiza **dentro del propio microcontrolador** para decidir si cada rostro corresponde a un **hombre (`male`)** o a una **mujer (`female`)**, mostrando además un **porcentaje de confianza**.

Además, configuramos una **salida por GPIO** para que el LED de la placa se encienda según la clase detectada, lo que une la inteligencia artificial con una acción física.

> **TinyML:** aprendizaje automático en dispositivos pequeños, con capacidad de procesar datos cerca del sensor.

### Hardware utilizado

| Característica | Detalle |
|---|---|
| Procesador | ESP32-S3 de doble núcleo, hasta **240 MHz** |
| Memoria | **8 MB PSRAM + 8 MB Flash** |
| Conectividad | Wi-Fi 2,4 GHz y Bluetooth LE 5.0 |
| Sensores | Cámara integrada y micrófono integrado |
| Periféricos | GPIO, LED, botones Reset y Boot |

---

## 2. Modelo utilizado

| Dato | Detalle |
|---|---|
| Plataforma | **SenseCraft AI**|
| Modelo | **"Detección de género"** (detección de objetos) |
| Clases | `male` (hombre) y `female` (mujer) |
| Dispositivo | XIAO ESP32S3 Sense |
| Ejecución | Local, en el microcontrolador (inferencia en tiempo real) |

---

## 3. ¿Para qué se hace y por qué es importante?

- **Para qué:** comprobar el flujo completo de un proyecto TinyML (conectar, cargar el modelo, probar, ajustar parámetros y activar salidas físicas).
- **Privacidad:** el procesamiento ocurre en el dispositivo y las imágenes no necesitan salir de él.
- **Baja latencia y bajo consumo:** no depende de internet ni de servidores.
- **Bajo costo:** una placa muy pequeña ejecuta IA de visión.
- **Aplicaciones reales:** conteo de personas, analítica de afluencia, control de acceso, kioskos inteligentes.
- **Aprendizaje:** permite entender cómo los parámetros de **confianza** e **IoU** afectan las detecciones.

---

## 4. Objetivos

### 🎯 Objetivo general
Implementar y evaluar un modelo de **detección de género (hombre/mujer)** en tiempo real con la cámara del **XIAO ESP32S3 Sense** y la plataforma **SenseCraft AI**.

### Objetivos específicos
- Conectar el XIAO ESP32S3 Sense a SenseCraft AI y ejecutar el modelo en el dispositivo.
- Subir el modelo y probarlo en vivo con la vista previa.
- Ajustar la **Confianza** y el **Umbral IoU** y analizar su efecto.
- Configurar una **acción por GPIO** (LED) según la clase detectada.
- Registrar los resultados (porcentajes y tiempos) e interpretarlos.

---

## 5. Pasos realizados

1. **Conexión:** conectamos el XIAO ESP32S3 Sense por USB a la laptop y, en SenseCraft AI → *Modelos* → pestaña **XIAO ESP32S3 Sense**, conectamos el dispositivo.
2. **Carga del modelo:** subimos el modelo **"Detección de género"** al dispositivo (*Subir modelo / Reemplazar el modelo en ejecución*).
3. **Prueba en tiempo real:** iniciamos la **Vista previa** apuntando la cámara a los integrantes del equipo.
4. **Ubicación de parámetros:** en la sección **Configuración** ajustamos la **Confianza (0–100)** y el **Umbral IoU (0–100)**. El valor principal usado fue **Confianza = 51** e **IoU = 60**. También probamos valores cercanos (46 y 50).
5. **Salida GPIO:** en *Salida → GPIO → Acciones de activación* configuramos que el **LED** se encienda al detectar una clase por encima de cierta confianza.
6. **Registro de resultados:** tomamos capturas de la vista previa y revisamos el *Registro del dispositivo* (`boxes` y `perf`).

---

## 6. Parámetros: ¿por qué usamos Confianza = 51 y un Umbral IoU adicional?

SenseCraft AI ofrece dos parámetros, ambos en una escala de **0 a 100**.

### 🔹 Confianza (valor usado: **51**)
Es el **porcentaje mínimo de seguridad** que debe tener el modelo para mostrar una detección. Si el modelo está menos seguro que ese valor, la detección **se descarta**.

**¿Por qué usamos la confianza?** Porque es lo que nos permite **controlar la calidad de las detecciones**: con un valor muy bajo el modelo marcaría rostros dudosos o falsos positivos, y con uno muy alto perdería detecciones reales.

**¿Por qué 51?** Tomamos **51 como umbral** porque está **justo por encima del 50 %**: el modelo solo acepta una detección cuando está **más seguro de que acierta que de que se equivoca**. Es un punto de equilibrio entre detectar a todas las personas y evitar resultados dudosos. Con este valor, todas nuestras detecciones lo superaron: la más baja fue **59 %** (Moisés) y la más alta superó el **90 %**.

### 🔹 Umbral IoU (valor usado: **60**), el umbral adicional
**IoU (Intersection over Union)** mide cuánto se **solapan dos cajas** de detección. El umbral IoU define a partir de qué solapamiento dos cajas se consideran **la misma detección**, y se conserva solo la de mayor confianza.

**¿Por qué lo usamos?** Para **evitar cajas duplicadas** sobre un mismo rostro. Con **IoU = 60**, si dos cajas se superponen más de un 60 %, se elimina la de menor confianza; así, cada persona queda marcada con **una sola caja**.

| Parámetro | Valor | Qué controla |
|---|---|---|
| **Confianza** | **51** | Cuán seguro debe estar el modelo para aceptar una detección |
| **Umbral IoU** | **60** | Cuánto solapamiento se permite entre cajas antes de eliminar duplicados |

---

## 7. Resultados

### 7.1 Configuración usada en las pruebas principales

| Parámetro | Valor |
|---|---|
| Confianza | **51** |
| Umbral IoU | **60** |
| Modo de inferencia | Tiempo real |

> 📸 **Evidencia de parámetros:** `![Configuración](imagenes/configuracion_51_60.png)`

### 7.2 Detecciones por integrante

| Integrante | Clase detectada | Confianza |
|---|---|---|
| **Juan** | `male` | **76 %** |
| **Moisés** | `male` | **59 %** |
| **Ruth** | `female` | **83 %** |
| **Leonela** | `female` | **83 %** |

*Orden en las capturas, de izquierda a derecha: Juan y Moisés; Ruth y Leonela.*

### 7.3 Otras capturas de la práctica

| Captura | Escena | Resultado |
|---|---|---|
| Ruth y Leonela (otro ángulo) | 2 mujeres | `female` **88 %** · `female` **89 %** |
| Persona sola | 1 mujer | `female` **83 %** |
| Grupo de 3 personas | 2 hombres y 1 mujer | `male` **79 %** · `male` **91 %** · `female` (porcentaje cortado en la captura) |

### 📊 Porcentajes promedio de confianza

| Clase | N.º de detecciones | Valores | Promedio |
|---|---|---|---|
| **`female`** | 5 | 83, 83, 88, 89, 83 | **85,2 %** |
| **`male`** | 4 | 76, 59, 79, 91 | **76,3 %** |
| **Global** | 9 | n/a | **≈ 81,2 %** |

- 🔝 **Máxima confianza:** **91 %** (`male`)
- 🔻 **Mínima confianza:** **59 %** (`male`, Moisés)

### ⏱️ Rendimiento del dispositivo

| Etapa | Tiempo típico |
|---|---|
| Preprocesamiento | **≈ 63 – 112 ms** (normalmente ≈ 80 ms) |
| **Inferencia** | **≈ 951 – 954 ms** |
| Postprocesamiento | **≈ 1 – 3 ms** |
| **Total por frame** | **≈ 1,04 s → ≈ 1 FPS** |

Formato del registro: `boxes: [[x, y, w, h, score, clase]]`, con clase **0 = male** y **1 = female**.

### 7.4 Acciones GPIO (LED)

| Objeto | Condición | Confianza | GPIO | Estado por defecto | Estado activo |
|---|---|---|---|---|---|
| `male` | Mayor que | **53 %** | LED | LED apagado | LED encendido |
| `female` | Mayor que | **42 %** | LED | LED apagado | LED encendido |

*MQTT no se inicializó: la práctica se ejecutó de forma local.*

---

## 8. 📷 Evidencias

### 8.1 Montaje y trabajo en el laboratorio
| | |
|---|---|
| <img width="1600" height="1200" alt="zsaf" src="https://github.com/user-attachments/assets/fe5565e8-6a72-42be-be08-21db1095cbc5" /> | <img width="1200" height="1600" alt="WhatsApp Image 2026-10-13 at 6 26 10 PM" src="https://github.com/user-attachments/assets/45d1ab9c-bf86-40e5-bc46-03ecf49c9983" /> |
| *Equipo trabajando en el laboratorio* | *XIAO ESP32S3 Sense con cámara montado sobre la pantalla* |

### 8.2 Configuración de parámetros
<p align="center">
  <img width="500" alt="Captura de pantalla 2026-10-13 225046" src="https://github.com/user-attachments/assets/f6d1dc5d-d03b-41fb-9a42-2c1fffc10b24" />
  <br>
  <em>Confianza = 51 · Umbral IoU = 60</em>
</p>

### 8.3 Detección de hombres: Juan y Moisés
<p align="center">
  <img width="600" alt="WhatsApp Image 2026-10-13 at 6 25 12 PM" src="https://github.com/user-attachments/assets/f78b7a25-0420-437a-ab71-584f12f06b45" />
  <br>
  <em>Izquierda: <b>Juan</b>, `male` 76 % · Derecha: <b>Moisés</b>, `male` 59 %</em>
</p>

### 8.4 Detección de mujeres: Ruth y Leonela
<p align="center">
  <img width="600" alt="WhatsApp Image 2026-10-13 at 6 25 13 PM" src="https://github.com/user-attachments/assets/4bd59348-1bc6-43f4-8cf3-25f272e5939e" />
  <br>
  <em>Izquierda: <b>Ruth</b>, `female` 83 % · Derecha: <b>Leonela</b>, `female` 83 %</em>
</p>

### 8.5 Otras pruebas
| | |
|---|---|
| <img width="1600" height="826" alt="WhatsApp Image 2026-10-13 at 6 25 13 PM" src="https://github.com/user-attachments/assets/9d94ce9d-ef2f-499f-9431-5e6ee48af72e" /> | <img width="1504" height="798" alt="WhatsApp Image 2026-10-13 at 6 25 32 PM" src="https://github.com/user-attachments/assets/4ab67d6a-06ef-4fcf-82b4-3e6a08bde626" /> |
| *Ruth 88 % · Leonela 89 %* | *Grupo mixto de 3 personas* |


### 8.6 Registro del dispositivo
<img width="1600" height="1200" alt="WhatsApp Image 2026-10-13 at 6 24 44 PM" src="https://github.com/user-attachments/assets/62f13f4f-dc14-4776-bbb2-871758e671e3" />

### 8.7 Configuración de la acción GPIO (LED)
<img width="1600" height="685" alt="WhatsApp Image 2026-10-13 at 6 45 29 PM" src="https://github.com/user-attachments/assets/904ac9b8-74d2-4260-84a9-6e8552b6b0d5" />

---

## 9. Interpretación de los resultados

1. **El modelo funciona en tiempo real.** Detectó los rostros y asignó una clase a cada uno, siempre con una confianza **superior al umbral de 51**.
2. **Mejor desempeño en `female` (≈ 85 %) que en `male` (≈ 76 %).** Ruth y Leonela obtuvieron valores muy estables (83–89 %), mientras que en `male` hubo más variación (**59 % a 91 %**).
3. **La detección más baja (Moisés, 59 %)** puede explicarse por el ángulo del rostro, la iluminación del techo y la distancia a la cámara. Al estar cerca del umbral, un pequeño cambio puede hacer que se pierda la detección.
4. **Hay frames sin detección (`boxes: []`),** cuando la persona se mueve, gira el rostro o queda parcialmente tapada. Es normal en modelos TinyML.
5. **Efecto de los parámetros:** un umbral bajo detecta más pero con más incertidumbre; uno alto reduce falsos positivos pero puede perder personas. El IoU de 60 evita cajas duplicadas.
6. **Rendimiento:** ≈ 950 ms de inferencia (~1 FPS), suficiente para monitoreo o control, no para movimientos rápidos.
---

## 10. Importancia del desarrollo

- Demuestra que se puede ejecutar **IA de visión en un dispositivo de pocos recursos** con una plataforma *low-code*.
- Conecta la **percepción con la acción física** (cámara → modelo → GPIO/LED), base de los sistemas IoT inteligentes.
- Enseña a **ajustar y evaluar** un modelo (confianza, IoU, tiempos), habilidades clave en proyectos de Edge AI.
- Sirve de base para proyectos de **conteo de personas, analítica de afluencia o control de acceso**.

---

## 11. Conclusiones

1. Se **implementó con éxito** la detección de género en el XIAO ESP32S3 Sense con SenseCraft AI, con inferencia local y en tiempo real.
2. Con **Confianza = 51** e **IoU = 60**, el modelo alcanzó una **confianza promedio global de ≈ 81,2 %**: **85,2 % en `female`** y **76,3 % en `male`**, con un máximo de **91 %**.
3. El valor **51** funcionó como umbral de equilibrio: todas las detecciones lo superaron (la menor fue **59 %**) y se evitaron resultados dudosos.
4. El **IoU de 60** evitó cajas duplicadas, dejando una detección por persona.
5. El tiempo de inferencia fue **estable (≈ 950 ms, ~1 FPS)**.
6. Se configuraron **acciones GPIO** que encienden el LED según la clase detectada, integrando IA y hardware.
7. **Limitaciones:** muestra pequeña, sensibilidad a la luz y al ángulo, y clasificación en solo dos categorías según la apariencia facial. Estas predicciones **no deben usarse para tomar decisiones sobre personas**, y siempre se debe considerar el **consentimiento y la privacidad** al usar cámaras.
8. **Mejoras futuras:** probar más personas y condiciones de luz, entrenar un modelo propio, calcular métricas formales y enviar resultados por **MQTT/Wi-Fi**.

---

## 12. Referencias

- Guía oficial XIAO ESP32S3 Sense: <https://wiki.seeedstudio.com/XIAO_ESP32S3_Sense/>
- SenseCraft AI (Seeed Studio): <https://sensecraft.seeed.cc/ai/>
