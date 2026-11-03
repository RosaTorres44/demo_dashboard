# Speech: preparar lo que vas a decir (pitch de 2 minutos)

El dashboard prueba la idea; el speech la cuenta. Aquí preparas qué decir al presentar tu lámina,  una lámina, dos minutos, una decisión. **Primero la conclusión, después el porqué.**

## La estructura (lámina 14)
| Tiempo | Momento | Qué dices | Ejemplo del café |
|---|---|---|---|
| 0:00 – 0:15 | 1. La conclusión | Qué pasó y qué proponemos, en una frase | "Con el cupón vendimos más, pero ganamos menos. Proponemos no repetirlo en noviembre." |
| 0:15 – 0:45 | 2. El porqué | El número que lo prueba, con su definición | "El grupo con cupón vendió apenas 0.4% más, pero su margen bajó de S/4,999 a S/4,770." |
| 0:45 – 1:15 | 3. Qué significa | Qué pasa si no hacemos nada | "Si repetimos el cupón, regalamos descuento a clientes que igual iban a comprar." |
| 1:15 – 1:45 | 4. La acción | Quién decide, qué, cuándo y qué pasa si no funciona | "Probemos en noviembre otra cosa, por ejemplo un combo, y medimos el margen igual que ahora." |
| 1:45 – 2:00 | 5. La pregunta | Una pregunta de sí o no | "¿Dejamos el cupón y probamos otra cosa en noviembre?" |

Si te cortan en el minuto 1, el comité ya escuchó qué hacer.

## Herramienta: Scrollyteller de Claude
El formato **Scrollyteller** de Claude arma una historia que se lee bajando la página, paso a paso. Lo usamos para ordenar el speech con los mismos datos del dashboard.

1. En Claude escribe **/** y elige **Dashboard**.
2. A la derecha, cambia el formato a **Scrollyteller**.
3. En **¿De dónde vienen tus números?**, elige **Usar un conector → Databricks** (el mismo conector de `1_setup/05_claude_conector.md`).
4. En **Escribe un mensaje…** pega completo `3_graficar/prompt.md` y, debajo, el pedido de abajo.
5. Revisa que los números coincidan con `2_interpretar/problema.md` y que cada sección responda a un momento de la tabla.

### Pedido para el Scrollyteller
> Con esas definiciones y ese criterio, arma un scrollyteller de 5 secciones para un pitch de 2 minutos ante la dueña:
> 1. **La conclusión** (15 s): qué pasó y qué proponemos, en una frase.
> 2. **El porqué** (30 s): el número que lo prueba, con un solo gráfico.
> 3. **Qué significa** (30 s): qué pasa si no hacemos nada.
> 4. **La acción** (30 s): qué proponemos, cuándo y qué pasa si no funciona.
> 5. **La pregunta** (15 s): una pregunta de sí o no.
> En cada sección, escribe debajo el texto que diría en voz alta (máximo 2 frases). Usa solo los números de las consultas, sin inventar.

El texto de cada sección es tu **borrador** de speech: ajústalo con tus palabras. Guarda el pedido que usaste: también se evalúa el prompt.


## Chequeo del speech
- [ ] ¿La primera frase ya dice qué hacer?
- [ ] ¿Cada número que dices está en la lámina y tiene su definición?
- [ ] ¿La acción dice quién, qué, cuándo y qué pasa si no funciona?
- [ ] ¿Termina en una pregunta de sí o no?
