# Reporte de Actividades - Taller de Internet de las Cosas (IoT)

---

## 🛠️ Equipamiento y Herramientas Utilizadas
- **Microcontrolador:** ESP32 Dev Kit v1
- **Sensores/Actuadores:** Potenciómetro, Kit de sensores Keyestudio 48 en 1 (Sensor Ultrasónico HC-SR04, etc.), LED con resistencia
- **Entornos y Plataformas:** Arduino IDE, ThingSpeak
- **Protocolos e Infraestructura:** Wi-Fi (802.11 b/g/n), ADC de 12 bits, HTTP/REST API

---

## 📋 Desarrollo y Análisis de las Actividades (1 a 5)

---

### 🔹 Actividad 01: Lectura Analógica con Promediado y Conversión a Voltaje (ESP32)

#### **Descripción de la Actividad**
Se configuró una entrada analógica en el puerto GPIO del ESP32 para realizar lecturas filtradas mediante el método de promediado de 10 muestras continuas. Posteriormente, el valor promedio del convertidor analógico-digital (ADC) se escaló a su correspondiente valor de tensión en voltios.

#### **Código Fuente**
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
