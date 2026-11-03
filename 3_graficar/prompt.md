# El prompt (el mismo para Genie y para Claude)

Un solo texto, versionado aquí. Cambia **dónde** se pega, no **qué** se pega:
- **Genie**: ver `opcion_genie.md`.
- **Claude Dashboards**: ver `opcion_claude.md`.

Copia todo lo que está debajo de la línea.

---

**Rol**
Eres analista de datos de una cafetería pequeña. Explicas con números simples y en español.

**Contexto**
En octubre de 2026 dimos un cupón de 20% a 100 de nuestros 200 clientes, elegidos al azar. Los otros 100 no recibieron cupón. Los datos están en `workspace.demo_dashboard` (tablas `clientes` y `ventas`). La dueña debe decidir si **repite el cupón en noviembre**.

**Qué queremos comunicar**
Una recomendación de sí o no para noviembre, respaldada por un número.

**Definiciones (fichas de métrica)**
| Métrica | Definición | Fórmula |
|---|---|---|
| Venta neta | Lo que realmente cobramos | `monto - descuento` |
| Costo de insumos | Lo que nos cuesta preparar lo vendido. Supuesto del negocio: 40% del precio de lista | `0.40 * monto` |
| Margen | Lo que nos queda | `venta neta - costo de insumos` |
| Efecto del cupón | Diferencia entre el grupo con cupón y el grupo sin cupón (mismo tamaño) | `margen con cupón - margen sin cupón` |

**Criterio de decisión**
El cupón **funciona** solo si el margen del grupo con cupón es mayor que el del grupo sin cupón. Vender más no basta.
No confundas "ventas donde se usó el cupón" con "ventas que el cupón generó".

**Pedido: el dashboard**
Con esas definiciones y ese criterio, arma un dashboard de una sola página para decidir si repetimos el cupón. Compara el grupo que recibió el cupón con el que no (columna `recibio_cupon` de `clientes`).
1. Título: "Con el cupón vendimos más, pero ganamos menos".
2. Dos contadores: margen con cupón y margen sin cupón, en soles.
3. Un gráfico de barras agrupadas: venta neta y margen, por grupo.
4. Un texto pequeño: qué % de las ventas del grupo con cupón usó el cupón, aclarando que no son ventas nuevas.
Nada más. Sin tablas de detalle.

**Control**
Muestra los cálculos por grupo y lista los supuestos que usaste antes de armar el dashboard.
