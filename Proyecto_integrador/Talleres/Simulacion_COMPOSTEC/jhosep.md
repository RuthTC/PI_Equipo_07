# Informe de simulación estructural de los soportes de la PCB

## 1. Introducción

Como parte del diseño de la carcasa electrónica de la compostera inteligente, se realizó una simulación estructural en SimScale para evaluar el comportamiento de los soportes internos destinados a sostener la placa PCB.

El modelo diseñado en Onshape no cuenta con nervaduras, relieves ni refuerzos adicionales alrededor de estos soportes. Los soportes están formados únicamente por postes cilíndricos integrados directamente a la base de la carcasa.

Por esta razón, la simulación busca comprobar si esta geometría simple es suficiente para resistir las fuerzas que pueden aparecer cuando la PCB es colocada, alineada, atornillada o manipulada durante el montaje y mantenimiento.

El análisis se realizó considerando la carcasa fabricada en PLA y se observó principalmente el esfuerzo equivalente de Von Mises.

---

## 2. Situación analizada

La situación representada corresponde al momento en el que una persona coloca o manipula la PCB dentro de la caja.

Durante este proceso puede ejercerse presión sobre la placa, por ejemplo al:

- colocarla sobre los soportes;
- alinearla con los agujeros;
- colocar o retirar tornillos;
- conectar cables;
- realizar mantenimiento.

Esta fuerza se transmite desde la PCB hacia las caras superiores de los cuatro postes.

Debido a que los postes no tienen refuerzos adicionales, una de las zonas de mayor interés es la unión entre cada poste y el fondo de la carcasa, ya que por esa zona se transmite la carga hacia el resto de la pieza.

---

## 3. Fuerza aplicada

Para la primera simulación se utilizó una fuerza total de:

**F = 10 N**

Este valor se tomó como una carga inicial para representar una presión manual moderada durante la manipulación de la placa.

Una fuerza de 10 N es aproximadamente equivalente a la fuerza que genera una masa cercana a 1 kg debido a la gravedad. Esto no significa que la PCB pese 1 kg, sino que se está representando una fuerza adicional que una persona podría ejercer al presionarla durante el montaje.

La fuerza se aplicó sobre las cuatro caras superiores de los soportes.

Si se considera de manera simplificada que la fuerza se reparte uniformemente entre los cuatro postes:

**10 N / 4 = 2.5 N por soporte**

Esta distribución sirve como una aproximación inicial para analizar el comportamiento de los soportes.

---

## 4. Configuración de la simulación

La prueba se realizó mediante un análisis estructural estático en SimScale.

| Parámetro | Configuración |
|---|---|
| Tipo de análisis | Static Structural |
| Material | PLA |
| Fuerza total | 10 N |
| Zona de aplicación | Caras superiores de los 4 soportes |
| Geometría de soportes | Postes cilíndricos sin refuerzos adicionales |
| Restricción | Fixed Support |
| Resultado analizado | Von Mises Stress |
| Malla | Refinada alrededor de los soportes |

Se realizó un refinamiento de malla en los postes porque son la zona principal de estudio y porque alrededor de los agujeros y de la unión con la base pueden aparecer concentraciones de esfuerzo.

---

## 5. Resultados obtenidos

El resultado mostrado en SimScale corresponde al esfuerzo equivalente de Von Mises.

La escala de colores permite identificar visualmente las zonas con mayor o menor esfuerzo:

- **Azul oscuro:** esfuerzo muy bajo.
- **Celeste:** esfuerzo bajo.
- **Verde:** esfuerzo mayor que en las zonas azules.
- **Amarillo, naranja o rojo:** zonas con esfuerzos más elevados.

En la simulación obtenida, casi toda la base de la carcasa aparece en color azul oscuro, mientras que alrededor de los cuatro soportes aparecen colores celestes y verdes.

Esto indica que los esfuerzos se concentran principalmente en los postes y en las zonas cercanas a su unión con la base.

Este comportamiento tiene sentido, ya que la fuerza fue aplicada directamente sobre los soportes.

Según la escala observada en la simulación, el valor máximo mostrado es aproximadamente:

**1.133 Pa**

---

## 6. Interpretación de los resultados

La simulación muestra que la mayor parte de la carcasa prácticamente no recibe esfuerzo significativo durante esta prueba.

Los cambios de color se concentran alrededor de los cuatro soportes porque son los elementos que reciben directamente la fuerza aplicada.

Como el diseño no cuenta con nervaduras ni relieves de refuerzo, era importante comprobar especialmente el comportamiento de la unión entre cada poste y la base.

En los resultados no se observa una zona de color amarillo, naranja o rojo alrededor de los soportes. Esto indica que, para la carga de 10 N utilizada, el modelo no presenta una concentración elevada de esfuerzos.

Sin embargo, el valor máximo de aproximadamente 1.133 Pa es extremadamente bajo para un análisis estructural de una pieza de PLA. Por esta razón, antes de considerar este valor como definitivo, se recomienda revisar que:

- la fuerza esté correctamente configurada en Newtons;
- la fuerza esté dirigida hacia el fondo de la carcasa;
- las caras seleccionadas sean únicamente las superiores de los soportes;
- el Fixed Support represente correctamente la forma en que la carcasa estaría sujeta;
- las propiedades mecánicas del PLA estén correctamente configuradas.

Si la configuración es correcta, entonces la simulación indicaría que los soportes resisten sin inconvenientes una carga total de 10 N.

---

## 7. Evaluación del diseño

La finalidad de esta prueba no fue demostrar que los soportes cuentan con refuerzos especiales, sino comprobar si la geometría simple diseñada en Onshape es suficiente.

Los resultados obtenidos indican que, bajo una carga de 10 N, los postes no presentan una condición crítica.

La zona que debe seguir siendo observada en futuras pruebas es la unión entre cada poste y la base, porque al no existir nervaduras o refuerzos adicionales, esa zona sería una de las primeras en presentar mayores esfuerzos si la carga aumenta.

Para conocer mejor la capacidad de los soportes, se recomienda repetir la simulación aumentando progresivamente la fuerza:

| Prueba | Fuerza total |
|---|---:|
| 1 | 10 N |
| 2 | 20 N |
| 3 | 30 N |
| 4 | 40 N |
| 5 | 50 N |

Esto permitiría comparar los esfuerzos obtenidos y observar a partir de qué carga la geometría comienza a trabajar de forma más exigente.

---

## 8. Conclusión

La simulación estructural permitió evaluar los soportes cilíndricos de la PCB diseñados directamente sobre la base de la carcasa, sin utilizar nervaduras, relieves ni otros refuerzos adicionales.

Se aplicó una fuerza total de 10 N sobre las caras superiores de los cuatro postes para representar una posible presión durante el montaje o mantenimiento de la PCB.

Los resultados muestran que los esfuerzos aparecen principalmente alrededor de los soportes, mientras que el resto de la carcasa permanece con valores muy bajos.

Con la carga utilizada no se observa una condición crítica en los postes. Por ello, de manera inicial, la geometría simple utilizada puede considerarse suficiente para soportar una presión moderada durante la manipulación de la placa.

Como siguiente paso, sería conveniente aumentar progresivamente la fuerza para estimar con mayor claridad la capacidad máxima de los soportes y verificar si sería necesario agregar algún refuerzo adicional al diseño.

<img width="1113" height="812" alt="WhatsApp Image 2026-08-27 at 7 22 56 PM" src="https://github.com/user-attachments/assets/41033fdf-62db-4d85-a140-9bfb207fe7e0" />


<img width="398" height="302" alt="WhatsApp Image 2026-08-27 at 8 02 11 PM" src="https://github.com/user-attachments/assets/1489d0d8-578b-4a5f-9649-6195ee18871b" />





