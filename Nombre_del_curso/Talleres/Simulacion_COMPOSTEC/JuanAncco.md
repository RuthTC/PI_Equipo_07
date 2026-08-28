# Análisis estructural de los soportes en SimScale

## Objetivo

Evaluar la resistencia mecánica de los soportes donde se coloca la placa o galleta, con el fin de comprobar su comportamiento cuando reciben una fuerza durante la colocación y manipulación de la placa.

---

## Modelo 3D

El modelo fue preparado en Onshape y posteriormente importado a SimScale para realizar el análisis estructural.

La zona de estudio corresponde principalmente a los soportes sobre los cuales se coloca la placa o galleta.

![Modelo 3D](<img width="607" height="362" alt="Captura de pantalla 2026-08-27 192421" src="https://github.com/user-attachments/assets/6bb97503-1814-49cf-9e9c-c4c6b66ee018" />)

---

## Tipo de simulación

Se realizó una simulación de tipo **Static Structural** en SimScale.

Este análisis permite estudiar los esfuerzos y deformaciones que se producen en una pieza cuando se aplica una carga estática.

---

## Material utilizado

El material considerado para la fabricación de la pieza es:

**PLA (Ácido Poliláctico)**

El PLA es un material comúnmente utilizado en impresión 3D y permite fabricar la estructura y sus soportes mediante manufactura aditiva.

---

## Condiciones de simulación

- **Software:** SimScale
- **Tipo de análisis:** Static Structural
- **Material:** PLA
- **Fuerza aplicada:** 10 N
- **Zona de aplicación:** Superficie de apoyo de la placa o galleta
- **Tipo de carga:** Fuerza estática
- **Restricción:** Se fijó la estructura para evitar desplazamientos del cuerpo durante la aplicación de la fuerza.

---

## Justificación de la fuerza aplicada

Se utilizó una fuerza de **10 N** como carga inicial de prueba para analizar el comportamiento de los soportes durante la colocación y manipulación de la placa.

La fuerza se puede relacionar con una masa mediante:

**F = m × g**

Considerando una masa aproximada de 1 kg:

**F = 1 kg × 9.81 m/s²**

**F = 9.81 N**

Por aproximación:

**F ≈ 10 N**

Por lo tanto, una fuerza de 10 N representa aproximadamente la fuerza producida por una masa de 1 kg bajo la acción de la gravedad.

Además, esta fuerza no representa únicamente el peso de la placa, sino también una posible fuerza adicional producida cuando una persona coloca, presiona o manipula la placa sobre los soportes.

Por esta razón se utilizó **10 N como una carga inicial de evaluación estructural**.

---

## Aplicación de la fuerza

La fuerza de **10 N** fue aplicada sobre la superficie del soporte donde se produce el contacto con la placa o galleta.

De esta manera se busca representar una situación en la cual el soporte recibe una carga durante la instalación o manipulación de la placa.

![Aplicación de fuerza](aplicacion_fuerza.png)

---

## Mallado

Para realizar el análisis, SimScale genera una malla sobre la geometría.

La malla divide el modelo en pequeños elementos sobre los cuales se realizan los cálculos estructurales.

Las zonas cercanas a los soportes son especialmente importantes, debido a que en estas regiones pueden aparecer mayores concentraciones de esfuerzo.

---

## Resultados analizados

Durante la simulación se observaron principalmente los siguientes parámetros:

- Esfuerzo de Von Mises.
- Deformación de la estructura.
- Distribución de esfuerzos.
- Zonas de concentración de esfuerzos.
- Comportamiento de los soportes bajo una carga de 10 N.

---

## Resultado de la simulación

La siguiente imagen muestra la distribución obtenida durante el análisis estructural realizado en SimScale.

![Resultado de SimScale](resultado_simscale.png)

Los colores permiten identificar las zonas que presentan diferentes niveles de esfuerzo o deformación.

Las regiones con valores mayores representan las zonas más críticas del modelo.

---

## Interpretación

El análisis permite observar cómo responde el soporte cuando recibe una fuerza de 10 N.

La zona de unión entre el soporte y la estructura principal es especialmente importante, debido a que normalmente en esta región se produce una mayor concentración de esfuerzos.

Los resultados obtenidos permiten determinar si el soporte mantiene su integridad estructural bajo la carga aplicada.

---

## Conclusión

Se realizó una simulación estructural estática en SimScale para evaluar los soportes donde se coloca la placa o galleta.

La pieza fue considerada de **PLA** y se aplicó una fuerza de **10 N**, equivalente aproximadamente a la fuerza ejercida por una masa de 1 kg.

Esta carga fue utilizada para representar no solamente el peso de la placa, sino también posibles fuerzas adicionales que pueden producirse durante su colocación o manipulación.

La simulación permitió observar la distribución de esfuerzos y deformaciones en la estructura, especialmente en las zonas donde los soportes se unen al cuerpo principal.

A partir de estos resultados se puede evaluar si el diseño actual es adecuado o si es necesario aumentar el espesor, modificar la geometría o reforzar los soportes para mejorar su resistencia.
