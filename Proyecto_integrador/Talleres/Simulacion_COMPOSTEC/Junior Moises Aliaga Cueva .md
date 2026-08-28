# Simulación Estructural del Soporte del Tornillo (Con contorno)

## 1. Introducción
Como parte del diseño del sistema de monitoreo para la compostera inteligente, se diseñó una carcasa para alojar el microcontrolador ESP32 y su circuito electrónico. Esta estructura fue modelada en **Onshape** e importada a **SimScale** para realizar una simulación estática estructural (*Static Structural*).

El objetivo es evaluar el comportamiento mecánico y la rigidez de los postes cilíndricos de fijación fabricados en termoplástico **ABS**, comprobando que la geometría resista las fuerzas combinadas de compresión axial y momento torsor generadas durante el roscado y apriete de un perno comercial de tamaño referencial M3 ($3\text{ mm}$).

---

## 2. Configuración y Fuerzas Aplicadas
Se configuró un análisis estático estructural estableciendo las siguientes condiciones de contorno y cargas aplicadas:

| Parámetro | Valor | Ubicación | Sustentación Técnica |
| :--- | :--- | :--- | :--- |
| **Material** | ABS | Toda la pieza | Termoplástico base ($E = 1.8\text{ GPa}$, $\nu = 0.35$, $\rho = 1200\text{ kg/m}^3$). |
| **Soporte Fijo (`Fixed Support`)** | $0\text{ DOF}$ | Base posterior exterior | Restricción total de desplazamiento de la carcasa contra la superficie de montaje. |
| **Compresión axial ($f_y$)** | `-350 N` | Cara anular superior (`face 87`) | Precarga axial ejercida por la cabeza del tornillo al hacer tope ($F = \frac{T}{K \cdot d}$). El signo negativo indica empuje hacia la base. |
| **Torque de apriete ($m_y$)** | `0.25 N·m` | Cara cilíndrica interior | Par de torsión aplicado durante el enrosque manual para evitar el barrido de rosca en ABS. |

![Configuración de Condiciones de Frontera y Fuerzas - Simulación Moises1](../../../Recursos_Imagenes/Moises1_Configuracion.png)

---

## 3. Resultados Obtenidos e Interpretación de Colores (Von Mises)

La simulación por elementos finitos generó el mapa cromático de esfuerzos equivalentes de Von Mises en la zona de fijación analizada:

![Vista de Planta del Soporte Cilíndrico - Simulación Moises2](../../../Recursos_Imagenes/Moises2_VistaPlanta_Esfuerzos.png)

![Vista Isométrica de la Concentración de Tensiones - Simulación Moises3](../../../Recursos_Imagenes/Moises3_VistaIsometrica.png)

* **Interpretación del Gradiente Cromático:** La escala de esfuerzos de Von Mises evidencia que la concentración de tensión se restringe de manera concéntrica al perímetro interno del orificio (zona roja con un valor máximo de $54.01\text{ Pa}$), disipándose progresivamente hacia tonos cian y azul a lo largo del cuerpo del cilindro y la base.
* **Comportamiento de la Zona de Soporte:** La carga axial y el momento torsor se transmiten de manera estable desde el poste hacia la base, confinando el esfuerzo en el área de contacto del perno sin generar inestabilidad, pandeo ni distorsiones geométricas en la columna cilíndrica.

---

## 4. Conclusiones
La simulación estática en SimScale valida que el soporte de ABS resiste eficazmente las cargas de montaje de un tornillo comercial referencial M3 ($-350\text{ N}$ de compresión axial y $0.25\text{ N}\cdot\text{m}$ de torque), concentrando los esfuerzos de Von Mises de forma concéntrica en el perímetro interno del orificio (máximo de $54.01\text{ Pa}$) y disipándolos gradualmente a lo largo del cilindro, lo que confirma un comportamiento mecánico estable que absorbe la fijación sin generar tensiones críticas en la estructura circundante.
