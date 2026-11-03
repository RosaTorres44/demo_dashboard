# El problema: ¿repetimos el cupón?

Regla: **primero qué queremos comunicar, después el dashboard**. El dashboard existe para probar una idea; lo que no la prueba, se saca.

## La situación
En octubre de 2026, Café La Esquina entregó un **cupón de 20% de descuento** a 100 de sus 200 clientes frecuentes, elegidos al azar. Los otros 100 no recibieron nada.

## 1. Escribir el mensaje (antes de abrir cualquier herramienta)
- **Decisión**: ¿la dueña repite el cupón en noviembre?
- **Hallazgo en una frase**: "Con el cupón vendimos más, pero ganamos menos."
- **Pregunta de sí o no**: "¿Dejamos el cupón y probamos otra cosa en noviembre?"
- **Qué significa "funciona"**: el margen del grupo con cupón es mayor que el del grupo sin cupón.

## 2. Leer el diccionario
En **Catalog** → `workspace.demo_dashboard` → `ventas`, lee la descripción de cada columna. Ojo: `monto` es el precio **antes** del descuento. Si una columna no se entiende, se corrige el diccionario (ver `1_setup/diccionario_datos.md`), no el gráfico.

## 3. Elegir los números que prueban el mensaje
| Número | Para qué está | Definición |
|---|---|---|
| Margen con cupón vs sin cupón | Prueba "ganamos menos" | venta neta − 40% del monto |
| Venta neta por grupo | Prueba "vendimos más" (casi nada: +0.4%) | monto − descuento |
| % de ventas con cupón | Es el número que distrae; va en segundo plano | ventas que usaron el cupón / ventas del grupo |

Si un número no prueba ninguna parte del mensaje, no entra.

## 4. Probar las consultas
Corre `consultas.sql` en el **SQL Editor** de Databricks antes de graficar nada.

Deben dar: margen **S/4,769.6** con cupón y **S/4,998.9** sin cupón, venta neta **S/8,368.8** y **S/8,331.5**, y **35%** de ventas con cupón. Si no dan, no se sigue.
