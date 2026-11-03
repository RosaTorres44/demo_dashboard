-- Café La Esquina · Paso 2 de 3: aplicar el diccionario
-- Lo gobierna el diccionario: el significado de cada tabla y columna.
-- Este archivo es la ÚNICA fuente de las descripciones. Para cambiar una,
-- se edita aquí, se corre, se valida con 03 y se hace commit
-- (ver diccionario_datos.md).

-- Esquema y volumen
COMMENT ON SCHEMA workspace.demo_dashboard IS
  'Demo Café La Esquina: cupón de 20% en octubre 2026';
COMMENT ON VOLUME workspace.demo_dashboard.raw IS
  'Archivos CSV originales';

-- Tabla clientes
COMMENT ON TABLE workspace.demo_dashboard.clientes IS
  'Los 200 clientes frecuentes. A 100 se les dio el cupón, elegidos al azar.';
ALTER TABLE workspace.demo_dashboard.clientes ALTER COLUMN cliente_id
  COMMENT 'Identificador del cliente (C001 a C200)';
ALTER TABLE workspace.demo_dashboard.clientes ALTER COLUMN recibio_cupon
  COMMENT 'sí / no: si el cliente recibió el cupón de 20% en octubre';

-- Tabla ventas
COMMENT ON TABLE workspace.demo_dashboard.ventas IS
  'Cada compra de octubre 2026. Lo cobrado realmente es monto - descuento.';
ALTER TABLE workspace.demo_dashboard.ventas ALTER COLUMN cliente_id
  COMMENT 'Cliente que compró';
ALTER TABLE workspace.demo_dashboard.ventas ALTER COLUMN fecha
  COMMENT 'Día de la compra';
ALTER TABLE workspace.demo_dashboard.ventas ALTER COLUMN monto
  COMMENT 'Precio de lista en soles, ANTES del descuento';
ALTER TABLE workspace.demo_dashboard.ventas ALTER COLUMN uso_cupon
  COMMENT 'sí / no: si en esta compra se usó el cupón';
ALTER TABLE workspace.demo_dashboard.ventas ALTER COLUMN descuento
  COMMENT 'Soles descontados por el cupón (0 si no se usó)';
