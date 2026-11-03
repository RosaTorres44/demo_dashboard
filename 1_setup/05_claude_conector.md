# Paso 5. Conectar Claude con Databricks (sin token)

Se hace una sola vez. Claude se conecta a Databricks con el conector `system.ai.dbsql`: entras con tu cuenta de Databricks y no se pega ningún token en el chat. Funciona en Free Edition (probado el 3-nov-2026).

1. **Arma la URL del conector** con dos datos de Databricks:
   - **Host**: con Databricks abierto, copia de la barra de direcciones lo que va desde `https://` hasta `.cloud.databricks.com`.
   - **Workspace ID**: haz clic en tu ícono de usuario (círculo con tu inicial, arriba a la derecha); debajo del nombre del workspace sale **Workspace ID**. Cópialo con el ícono de copiar.
   - Júntalos así: `<host>/ai-gateway/mcp-services/system.ai.dbsql?o=<Workspace ID>`

2. En Claude ve a **Configuración → Conectores → Agregar conector personalizado**, pega la URL y en **OAuth Client ID** escribe `https://claude.ai/oauth/mcp-oauth-client-metadata`.
3. Haz clic en **Agregar** e inicia sesión con tu cuenta de Databricks.
4. **Prueba** en un chat nuevo, con el conector activo: "en databricks, `SELECT 1 AS result`". Debe devolver **1**.

Claude solo ve lo que tu usuario de Databricks puede ver (permisos de Unity Catalog).
