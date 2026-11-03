-- Café La Esquina · Paso 3 de 3: validar el diccionario (control)
-- Comprueba que toda tabla y columna del esquema tenga descripción en
-- Unity Catalog. Si el modelador agrega una columna y nadie la documenta,
-- aparece aquí como FALTA DESCRIPCIÓN. En producción, esto no debería pasar.

-- 1. Resumen: debe dar 0 pendientes
SELECT COUNT(*) AS objetos_revisados,
       SUM(CASE WHEN descripcion IS NULL OR descripcion = '' THEN 1 ELSE 0 END) AS pendientes
FROM (
  SELECT comment AS descripcion FROM workspace.information_schema.tables
  WHERE table_schema = 'demo_dashboard'
  UNION ALL
  SELECT comment FROM workspace.information_schema.columns
  WHERE table_schema = 'demo_dashboard'
);

-- 2. Detalle por tabla y columna
SELECT c.table_name     AS tabla,
       c.column_name    AS columna,
       c.full_data_type AS tipo,
       c.is_nullable    AS acepta_nulos,
       c.comment        AS descripcion,
       CASE WHEN c.comment IS NULL OR c.comment = '' THEN 'FALTA DESCRIPCIÓN' ELSE 'ok' END AS estado
FROM workspace.information_schema.columns c
WHERE c.table_schema = 'demo_dashboard'
ORDER BY c.table_name, c.ordinal_position;

-- Resultado esperado: 9 objetos revisados (2 tablas + 7 columnas) y 0 pendientes.
