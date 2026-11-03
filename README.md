# Demo: Café La Esquina

Ejemplo sencillo para la sesión de visualización y storytelling 
Sirve para mostrar **cómo** se llega de unos datos a una decisión con ayuda de la IA 

## La situación
En octubre de 2026, Café La Esquina entregó un **cupón de 20% de descuento** a 100 de sus 200 clientes frecuentes, elegidos al azar. Los otros 100 no recibieron nada.

La dueña pregunta: **¿el cupón funcionó? ¿Lo repetimos en noviembre?**

## Cómo está organizado
| Carpeta | Para qué | Archivos |
|---|---|---|
| `1_setup/` | Configuración, una sola vez | `data/` (`clientes.csv` y `ventas.csv`), tablas, diccionario y cómo mantenerlo (`diccionario_datos.md`), validación, Genie (`04_genie.md`) y conector de Claude (`05_claude_conector.md`) |
| `2_interpretar/` | El problema: qué comunicar y qué números lo prueban | `problema.md`, `consultas.sql` |
| `3_graficar/` | Crear el dashboard que prueba la idea | `pregunta_directa.md`, `prompt.md` (el mismo para Genie y Claude), `opcion_genie.md`, `opcion_claude.md`, `chequeo.md` |
| `4_speech/` | Preparar el pitch de 2 minutos con el Scrollyteller de Claude | `speech.md` |

## 1. Setup: dejar todo listo en Databricks
Se hace una sola vez. Toma unos 10 minutos.

1. **Cuenta**: entra a [Databricks Free Edition](https://www.databricks.com/learn/free-edition) y crea tu cuenta (es gratis).
2. **Esquema y volumen**: aquí se crea el lugar donde vivirán los datos.
   - **Qué se crea**: en Unity Catalog todo se ordena en tres niveles, `catálogo.esquema.objeto`. Free Edition ya trae el catálogo `workspace`; nosotros creamos dentro el esquema **`demo_dashboard`** (mismo nombre que el repo) y, dentro del esquema, el volumen **`raw`**, que es la carpeta donde se suben los CSV.
   - **Cómo**:
     1. En el menú izquierdo, sección SQL, entra a **SQL Editor** y abre una pestaña nueva (**+**).
     2. Arriba, revisa que haya un **SQL warehouse** seleccionado (en Free Edition viene uno por defecto, *Serverless Starter Warehouse*).
     3. Abre `1_setup/01_crear_tablas.sql` y copia **solo la parte 1** (las dos líneas debajo de `-- Parte 1. Esquema y volumen`):
        ```sql
        CREATE SCHEMA IF NOT EXISTS workspace.demo_dashboard;
        CREATE VOLUME IF NOT EXISTS workspace.demo_dashboard.raw;
        ```
     4. Pégalas en el editor y haz clic en **Run all** (o Ctrl/Cmd + Shift + Enter).
   - **Cómo comprobarlo**: en **Catalog** → **My organization** → `workspace` debe aparecer `demo_dashboard`, y dentro, **Volumes** → `raw` (si no aparece, refresca el árbol). Como usa `IF NOT EXISTS`, se puede volver a correr sin problema.
3. **Subir los CSV al volumen**:
   1. En el menú izquierdo, entra a **Catalog** (no a *Workspace*).
   2. En el árbol, abre **My organization** → `workspace` → `demo_dashboard`.
   3. Dentro de `demo_dashboard` abre **Volumes** y haz clic en `raw`.
   4. A la derecha, botón **Upload to this volume** → arrastra `1_setup/data/clientes.csv` y `1_setup/data/ventas.csv` → **Upload**.
   5. Comprueba que los dos archivos aparecen en la lista del volumen.

   Si no ves **Volumes** → `raw` dentro de `demo_dashboard`, es que falta correr la parte 1 del script (paso 2).
   Ojo: una carpeta creada en *Workspace* no es un volumen y el script no la encuentra.
4. **Crear y cargar las tablas**: corre el resto de `1_setup/01_crear_tablas.sql`. Al final debe mostrar **200** clientes y **1534** ventas.
5. **Aplicar el diccionario**: corre `1_setup/02_aplicar_diccionario.sql`. Pone la descripción de cada tabla y columna en Unity Catalog, que es lo que la IA va a leer. Quién decide qué y cómo se actualiza: `1_setup/diccionario_datos.md`.
6. **Validar**: corre `1_setup/03_validar_diccionario.sql`. Debe dar **9 objetos revisados y 0 pendientes**. Si algo sale como `FALTA DESCRIPCIÓN`, revisa el paso 5.
7. **Genie**: sigue `1_setup/04_genie.md`.
8. **Claude**: sigue `1_setup/05_claude_conector.md` (conector sin token).

Si el paso 4 falla, lo más común es que los CSV no estén en `/Volumes/workspace/demo_dashboard/raw/`.
Para cambiar una descripción más adelante, sigue `1_setup/diccionario_datos.md`.

## 2. Interpretar: el problema
Antes de graficar, definimos qué comunicar, qué significa "funciona" y qué números lo prueban: `2_interpretar/problema.md`. 

## 3. Graficar: el dashboard que prueba la idea
1. **Pregunta directa** sin instrucciones (`3_graficar/pregunta_directa.md`): números correctos, conclusión apurada.
2. **El prompt** (`3_graficar/prompt.md`): rol, contexto, definiciones, criterio y pedido del dashboard. Es **el mismo** en las dos herramientas:
   - **Opción A: Genie** → `3_graficar/opcion_genie.md`
   - **Opción B: Claude Dashboards** → `3_graficar/opcion_claude.md`
3. **Chequeo** con las cinco preguntas: `3_graficar/chequeo.md`.

Sin Databricks también funciona: se suben los CSV de `1_setup/data/` a Claude o Gemini y se pega el mismo prompt.

## 4. Speech
Cómo preparar lo que vas a decir al presentar: el pitch de 2 minutos, armado con el formato **Scrollyteller** de Claude: `4_speech/speech.md`.

## Todo vive en el repo
Nada se configura "a mano" sin dejar rastro: la estructura, el diccionario y su validación están en `1_setup/`, la guía para mantener el diccionario en `1_setup/diccionario_datos.md`, y lo que se le pide a Genie y a Claude en `3_graficar/prompt.md`. Si algo cambia en Databricks, primero se cambia aquí.

## Estructura de un buen prompt
- **Rol**: quién es la IA en esta conversación.
- **Contexto**: el negocio, la pregunta y la decisión que hay que tomar.
- **Definiciones**: qué significa cada número (por ejemplo, qué es "venta").
- **Pedido**: qué queremos recibir (cálculo, gráfico, dashboard).
- **Control**: que muestre los cálculos y diga qué supuestos hizo.
