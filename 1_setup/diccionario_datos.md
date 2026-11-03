# Diccionario de datos: cómo se mantiene

El diccionario de esta demo **vive en Unity Catalog**, como la descripción (`COMMENT`) de cada tabla y columna. Ahí lo leen Genie, Claude Dashboards y cualquier persona que explore el catálogo.

Los textos se definen en un solo lugar, versionado en git: `1_setup/02_aplicar_diccionario.sql`. No se escriben a mano en la interfaz de Databricks, porque lo que se cambia a mano no queda registrado y se pierde la próxima vez que se recrean las tablas.

## Quién decide qué
| Qué | Lo decide | Dónde vive |
|---|---|---|
| Estructura: tablas, tipos, PK/FK, `NOT NULL`, `CHECK` | El modelador | `1_setup/01_crear_tablas.sql` |
| Significado: qué es cada tabla y columna | El diccionario | `1_setup/02_aplicar_diccionario.sql` |
| Control: que nada quede sin significado | Ambos | `1_setup/03_validar_diccionario.sql` |

La estructura la decide el modelador y el significado lo gobierna el diccionario. Ambos deben conversar, y es un control que debemos asegurar en producción.

## Paso a paso para cambiar o agregar una descripción
1. Abre `1_setup/02_aplicar_diccionario.sql` y edita (o agrega) la línea de la tabla o columna.
2. Córrelo en el SQL Editor de Databricks.
3. Corre `1_setup/03_validar_diccionario.sql`. Debe dar **0 pendientes**.
4. Revisa en **Catalog** que la descripción se vea bien.
5. Haz commit con un mensaje que diga qué cambió y por qué, por ejemplo: `diccionario: aclara que monto es antes del descuento`.

## Cuando el modelador agrega una columna
1. El modelador la agrega en `1_setup/01_crear_tablas.sql`.
2. **En el mismo cambio**, se agrega su descripción en `1_setup/02_aplicar_diccionario.sql`.
3. Se corren los tres scripts en orden y la validación debe dar 0 pendientes.
4. Si la validación muestra `FALTA DESCRIPCIÓN`, el cambio no está listo para producción.

## Buenas descripciones
- Dicen qué es y en qué unidad (soles, fecha, sí/no).
- Avisan las trampas: por ejemplo, "monto es ANTES del descuento".
- Las escribe alguien que conoce el negocio, no solo quien construyó la tabla.
