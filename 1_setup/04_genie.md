# Paso 4. Crear el Genie Agent

Se hace una sola vez, después de validar el diccionario (`03_validar_diccionario.sql`).

1. En el menú izquierdo, sección SQL, entra a **Genie Agents** → botón azul **+ New**.
2. Selecciona las tablas `workspace.demo_dashboard.clientes` y `workspace.demo_dashboard.ventas` y créalo.
3. Genie propone un título y una descripción en inglés. Cambia el título a **Café La Esquina** (clic en el título) y, en **Configure → About**, acepta o edita la descripción.
4. **No toques la pestaña Instructions**: se llena con `3_graficar/prompt.md`, para que se vea la diferencia.
5. Prueba rápida en el chat: "¿cuántos clientes recibieron el cupón?". Probablemente responderá **100**.
