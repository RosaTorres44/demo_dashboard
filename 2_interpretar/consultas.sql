-- Café La Esquina · Consultas del dashboard
-- Cada consulta alimenta un elemento del dashboard. Se prueban ANTES de armarlo.
-- Supuesto del negocio (solo para esta demo): costo de insumos = 40% del monto de lista.

-- C1. Resultado por grupo → alimenta los 2 contadores y el gráfico de barras
-- Esperado: con cupón (sí) venta_neta 8368.80 y margen 4769.60
--           sin cupón (no) venta_neta 8331.50 y margen 4998.90
SELECT CASE c.recibio_cupon WHEN 'sí' THEN 'Con cupón' ELSE 'Sin cupón' END AS grupo,
       COUNT(*)                                   AS compras,
       SUM(v.monto)                               AS monto_lista,
       SUM(v.descuento)                           AS descuento,
       SUM(v.monto - v.descuento)                 AS venta_neta,
       SUM(0.40 * v.monto)                        AS costo_insumos,
       SUM(v.monto - v.descuento - 0.40 * v.monto) AS margen
FROM workspace.demo_dashboard.ventas v
JOIN workspace.demo_dashboard.clientes c ON c.cliente_id = v.cliente_id
GROUP BY 1
ORDER BY 1;

-- C2. El número que distrae → alimenta la nota pequeña
-- Esperado: 35.0 (% del monto del grupo con cupón en compras que usaron el cupón)
SELECT ROUND(100 * SUM(CASE WHEN v.uso_cupon = 'sí' THEN v.monto ELSE 0 END) / SUM(v.monto), 1)
         AS pct_ventas_con_cupon
FROM workspace.demo_dashboard.ventas v
JOIN workspace.demo_dashboard.clientes c ON c.cliente_id = v.cliente_id
WHERE c.recibio_cupon = 'sí';
