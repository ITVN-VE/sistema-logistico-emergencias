# Cómo escribir un ADR

Un **ADR** (*Architecture Decision Record*, registro de decisión de arquitectura) es un documento corto que explica una decisión técnica importante: qué problema había, qué opciones se consideraron, qué se eligió y por qué.

El código muestra *qué* se hizo, pero no *por qué*. El ADR responde al *por qué*, para que cualquier persona que se sume al equipo, o el propio equipo meses después, entienda la decisión sin tener que preguntar.

Los ADR del proyecto están en [`docs/adr/`](../adr/README.md).

## Cuándo escribir un ADR

Cuando la decisión:

- es difícil o costosa de cambiar después (el modelo de despliegue, la base de datos, el lenguaje, la autenticación);
- afecta a varias partes del sistema o a varias personas del equipo;
- tuvo alternativas razonables y alguien podría preguntar "¿por qué no usaron X?".

No hace falta un ADR para decisiones pequeñas o fáciles de revertir, como el nombre de una variable o una librería de uso puntual. Tampoco para explicar cómo funciona algo que no requirió elegir entre opciones: eso va en la documentación normal.

## Numeración y nombre del archivo

- Cada ADR tiene un número de cuatro cifras, en orden de creación: `0001`, `0002`, `0003`…
- El número indica el orden en que se escribió, no su importancia.
- El nombre del archivo es el número seguido del título en minúsculas, con guiones y sin tildes ni eñes: `0001-modelo-de-despliegue.md`.

## Estados

| Estado | Significado |
|---|---|
| **Propuesto** | Está escrito y en discusión. Todavía no se ha decidido. |
| **Aceptado** | Se aprobó y es la decisión vigente. |
| **Rechazado** | Se discutió y se descartó. Se conserva para que se sepa por qué. |
| **Obsoleto** | Ya no aplica, por ejemplo porque se eliminó esa parte del sistema. |
| **Reemplazado por ADR-NNNN** | Otro ADR posterior tomó una decisión distinta sobre el mismo tema. |

Un ADR puede quedarse en **Propuesto** mientras falte información para decidir, por ejemplo hasta terminar las entrevistas con centros de acopio. Eso no impide subirlo al repositorio: así el equipo lo conoce y puede comentarlo.

## Proceso

1. **Crear una rama.** Por ejemplo `adr/0003-tecnologia-de-la-aplicacion`.
2. **Copiar la plantilla.** Copiar [`plantilla.md`](../adr/plantilla.md) en `docs/adr/` con el siguiente número libre y el título de la decisión.
3. **Redactarlo.** Rellenar todas las secciones (ver abajo) y dejar el estado en **Propuesto**.
4. **Añadirlo al índice.** Agregar una fila en [`docs/adr/README.md`](../adr/README.md).
5. **Abrir un *pull request*.** Pedir revisión a las personas que deban opinar.
6. **Discutir en el PR.** Los comentarios y las dudas se resuelven en el propio PR, para que la discusión quede registrada. Si cambia la propuesta, se actualiza el documento.
7. **Decidir.** Cuando haya acuerdo, se cambia el estado a **Aceptado** o **Rechazado**, se indica la fecha de decisión, se actualiza el índice y se hace *merge*.
8. **Implementar.** El trabajo que se derive de la decisión se organiza en *issues* que enlazan al ADR.

## Cómo redactar cada sección

### Encabezado

Estado, fechas, autor, participantes y documentos relacionados. El título describe **la decisión que hay que tomar**, no la respuesta: "Modelo de despliegue", no "Usar una aplicación de escritorio".

### Contexto y problema

Explica la situación que obliga a decidir, con la información necesaria para que alguien que no participó lo entienda. Termina con **una pregunta concreta** que el ADR responde.

> Ejemplo ([ADR-0001](../adr/0001-modelo-de-despliegue.md)): *"¿dónde se ejecuta el sistema de inventario de un centro de acopio, y cómo trabajan con él varias personas a la vez?"*

Si hay temas relacionados que este ADR **no** decide, conviene decirlo en un apartado *Fuera del alcance de este ADR*, para que nadie espere encontrarlos ahí.

### Criterios de decisión

La lista de lo que importa para elegir, **ordenada de más a menos importante**. Se escribe antes que las opciones, para no elegir primero y justificar después. Cada criterio debe poder comprobarse en cada opción.

> Ejemplo: *"Funciona sin internet. El centro puede registrar, consultar y despachar insumos sin conexión, durante horas o días."*

### Opciones consideradas

Cada opción con una descripción breve, sus ventajas y sus inconvenientes. Al describir los inconvenientes, conviene indicar qué criterio incumple, por ejemplo *"(incumple el criterio 1)"*.

- Se presentan **todas las opciones razonables**, también las que se van a descartar, y de forma justa.
- Si varias opciones se comparan en varios criterios, se añade una **tabla de comparación** con ✅ (cumple), ⚠️ (cumple en parte o con condiciones) y ❌ (no cumple).

### Decisión

La opción elegida y por qué, mencionando los criterios que más pesaron. Mientras el estado sea **Propuesto**, aquí va la opción que se recomienda.

Un ADR decide **una sola cosa**. Si al redactarlo aparece otra decisión, se deja indicada para un ADR posterior. Por ejemplo, el ADR-0001 decide el modelo de despliegue y deja la tecnología concreta para otro ADR.

### Consecuencias

Qué cambia a partir de la decisión: lo positivo, lo negativo y los riesgos con su forma de mitigarlos. Ser honesto con lo negativo es lo que hace útil un ADR.

### Preguntas abiertas

Las dudas que quedan sin resolver y cómo se piensan resolver: entrevistas, pruebas o prototipos.

### Referencias

Enlaces a documentación, artículos o sistemas que respaldan la decisión, con una línea que diga por qué son relevantes.

## Reglas

- **Un ADR aceptado no se borra ni se reescribe.** Si la decisión cambia, se escribe un ADR nuevo que la reemplace, y en el antiguo se cambia el estado a **Reemplazado por ADR-NNNN**. Así queda la historia completa.
- **Mientras está en Propuesto, se puede modificar libremente.** Es un borrador en discusión.
- **Se pueden corregir** erratas o añadir enlaces sin cambiar el contenido de la decisión.
- **Un ADR por decisión.** Si un documento empieza a tratar varios temas, conviene dividirlo.
- **Corto y concreto.** Un ADR debería poder leerse en diez minutos.
- **Diagramas solo si ayudan.** Ver [cómo se hacen los diagramas](documentacion.md#diagramas).

## Errores frecuentes

- **Elegir la solución antes de escribir el ADR** y redactarlo solo para justificarla. Los criterios y las opciones van primero.
- **Mezclar varias decisiones** en un mismo ADR, por ejemplo el modelo de despliegue y la tecnología.
- **Incluir temas de otras etapas** del proyecto. Si algo corresponde a una etapa posterior, se menciona en *Fuera del alcance* y se decide cuando llegue el momento.
- **Ocultar los inconvenientes** de la opción elegida.
- **Dar por hecho lo que todavía hay que comprobar.** Si algo depende de una entrevista o de un prototipo, va en *Preguntas abiertas*.

## Referencias

- [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions), Michael Nygard (2011). Artículo que popularizó los ADR.
- [Markdown Architectural Decision Records (MADR)](https://adr.github.io/madr/). Una plantilla muy usada, en la que se inspira la de este proyecto.
- [ADR de Boxtribute](https://github.com/boxwise/boxtribute/tree/master/docs/adr). Ejemplos reales de un proyecto humanitario de código abierto.
