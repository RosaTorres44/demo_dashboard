-- Café La Esquina · Paso 1 de 3: estructura y carga
-- Lo decide el modelador: tablas, tipos y reglas (PK/FK, NOT NULL, CHECK).
-- Los significados NO van aquí: van en 02_aplicar_diccionario.sql.
-- Antes de correr la parte 2: subir 1_setup/data/clientes.csv y 1_setup/data/ventas.csv al
-- volumen /Volumes/workspace/demo_dashboard/raw (ver README).

-- Parte 1. Esquema y volumen
CREATE SCHEMA IF NOT EXISTS workspace.demo_dashboard;
CREATE VOLUME IF NOT EXISTS workspace.demo_dashboard.raw;

-- Parte 2. Tablas (se recrean desde cero; primero la que tiene la FK)
DROP TABLE IF EXISTS workspace.demo_dashboard.ventas;
DROP TABLE IF EXISTS workspace.demo_dashboard.clientes;

CREATE TABLE workspace.demo_dashboard.clientes (
  cliente_id    STRING NOT NULL,
  recibio_cupon STRING NOT NULL,
  CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
ALTER TABLE workspace.demo_dashboard.clientes
  ADD CONSTRAINT chk_recibio_cupon CHECK (recibio_cupon IN ('sí', 'no'));

CREATE TABLE workspace.demo_dashboard.ventas (
  cliente_id STRING        NOT NULL,
  fecha      DATE          NOT NULL,
  monto      DECIMAL(10,2) NOT NULL,
  uso_cupon  STRING        NOT NULL,
  descuento  DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_ventas_clientes FOREIGN KEY (cliente_id)
    REFERENCES workspace.demo_dashboard.clientes (cliente_id)
);
ALTER TABLE workspace.demo_dashboard.ventas
  ADD CONSTRAINT chk_uso_cupon CHECK (uso_cupon IN ('sí', 'no'));
ALTER TABLE workspace.demo_dashboard.ventas
  ADD CONSTRAINT chk_montos CHECK (monto > 0 AND descuento >= 0 AND descuento <= monto);

-- Parte 3. Carga desde el volumen
INSERT INTO workspace.demo_dashboard.clientes
SELECT CAST(cliente_id AS STRING), CAST(recibio_cupon AS STRING)
FROM read_files('/Volumes/workspace/demo_dashboard/raw/clientes.csv',
                format => 'csv', header => true);

INSERT INTO workspace.demo_dashboard.ventas
SELECT CAST(cliente_id AS STRING),
       CAST(fecha AS DATE),
       CAST(monto AS DECIMAL(10,2)),
       CAST(uso_cupon AS STRING),
       CAST(descuento AS DECIMAL(10,2))
FROM read_files('/Volumes/workspace/demo_dashboard/raw/ventas.csv',
                format => 'csv', header => true);

-- Parte 4. Verificación de carga: debe dar 200 clientes y 1534 ventas
SELECT 'clientes' AS tabla, COUNT(*) AS filas FROM workspace.demo_dashboard.clientes
UNION ALL
SELECT 'ventas', COUNT(*) FROM workspace.demo_dashboard.ventas;
