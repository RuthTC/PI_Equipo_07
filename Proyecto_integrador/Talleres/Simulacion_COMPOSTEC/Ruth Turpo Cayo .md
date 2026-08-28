# Informe de Simulación Estructural: Soporte para Módulo ESP32 (Perno M3)

## 1. Introducción
Como parte del diseño del sistema de control para la compostera inteligente, se diseñó un recinto (caja) independiente alojar el microcontrolador ESP32 y sus componentes electrónicos. Este módulo se acopla directamente a la pared exterior del contenedor principal mediante soportes cilíndricos y pernos M3 ($3\text{ mm}$).

Se realizó una simulación estructural en **SimScale** para evaluar la resistencia mecánica de estos postes de fijación integrados en plástico **ABS**, analizando si la geometría simple cilíndrica (sin nervaduras ni relieves de refuerzo) soporta las cargas reales de enroscado y apriete sin comprometer la integridad de la carcasa.

---

## 2. Configuración y Fuerzas Aplicadas
Se configuró un análisis estático estructural (*Static Structural*) con dos condiciones de contorno:

| Parámetro | Valor | Ubicación | Sustentación Técnica |
| :--- | :--- | :--- | :--- |
| **Material** | ABS | Toda la pieza | Termoplástico base de la carcasa electrónica |
| **Compresión ($f_z$)** | `-350 N` | Cara plana superior (Dona) | Precarga de apriete de la cabeza del tornillo ($F = \frac{T}{K \cdot D}$). Signo negativo indica empuje hacia dentro. |
| **Torque ($m_z$)** | `0.25 N·m` | Pared cilíndrica interna | Par de apriete máximo recomendado para roscar en ABS sin barrer la rosca. |

![Configuración de la Fuerza Remota en SimScale](../../../Recursos%20_Im%C3%A1genes/PI_parte%201.png)

---

## 3. Resultados Obtenidos e Interpretación de Colores (Von Mises)

El mapa cromático de esfuerzos equivalentes de Von Mises reflejó un comportamiento altamente localizado en el punto de anclaje del módulo:

![Vista de Planta de la Distribución de Esfuerzos](../../../Recursos%20_Im%C3%A1genes/PI_parte%202.png)

![Vista en Isométrico del Soporte Cilíndrico](../../../Recursos%20_Im%C3%A1genes/PI_parte%203.png)

* **Interpretación del Gradiente Cromático:** La escala de esfuerzos de Von Mises evidencia que la concentración de tensión se restringe de manera concéntrica al perímetro interno del orificio (zona roja/amarilla $\approx 50.09\text{ Pa}$), disipándose progresivamente hacia tonos cian y azul a lo largo del cuerpo del cilindro y la base.
* **Comportamiento del Resto del Cuerpo:** Toda la estructura circundante permanece en azul oscuro ($1.983 \times 10^{-7}\text{ Pa}$ a $\sim 10\text{ Pa}$), lo que confirma que el soporte absorbe eficientemente las cargas combinadas de compresión y torsión aplicadas únicamente en la zona del tornillo, sin transmitir ni generar concentraciones de tensiones críticas en el resto del alojamiento.

---

## 4. Evaluación del Diseño y Conclusión
Aunque la falta de relieves crea una unión lisa a $90^\circ$ que actúa como un concentrador de esfuerzos natural ante la torsión, el valor máximo alcanzado de **$50.09\text{ Pa}$** está extremadamente lejos del límite elástico del plástico ABS ($\approx 30\text{ a } 45\text{ MPa}$).

**Conclusión:** La geometría cilíndrica lisa actual **es estructuralmente segura y apta** para el acople del módulo exterior del ESP32, garantizando que la caja mantendrá la electrónica fija y protegida sin riesgo de fisura o rotura en los puntos de unión durante el ensamblaje.
