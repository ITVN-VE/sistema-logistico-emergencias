# Cómo participar

Gracias por tu interés en el sistema logístico para emergencias. Este documento explica cómo está organizado el proyecto, por dónde empezar y cómo se trabaja en él.

## Estado del proyecto

El proyecto está en su **fase de investigación**. Todavía no hay código: el trabajo actual consiste en entender cómo operan los centros de acopio y en tomar las primeras decisiones de arquitectura.

## Formas de participar

- **Centros de acopio y voluntarios:** contar cómo registraron y distribuyeron los insumos en emergencias reales. Es la información más valiosa en esta fase.
- **Organizaciones que trabajan en emergencias:** compartir sus necesidades y explorar formas de coordinación.
- **Desarrolladores:** revisar y comentar las decisiones de arquitectura y, más adelante, construir el sistema.
- **Cualquier persona:** señalar errores, dudas o partes poco claras de la documentación.

Para cualquiera de ellas, abre un [*issue*](https://github.com/ITVN-VE/sistema-logistico-emergencias/issues) explicando quién eres y cómo te gustaría colaborar.

## Por dónde empezar

Lee los documentos en este orden:

1. [README](README.md): qué es el proyecto, en pocas líneas.
2. [Planteamiento del problema y propuesta](docs/planteamiento.md): el problema, los objetivos, el alcance y las preguntas abiertas.
3. [Decisiones de arquitectura](docs/adr/README.md): qué se ha decidido hasta ahora y por qué.
4. [Modelo de datos](docs/modelo-de-datos/README.md): qué información guarda el sistema y cómo se organiza.

## Cómo se trabaja

### Tareas e ideas

Todo trabajo empieza con un *issue*: una tarea, un error, una idea o una pregunta. Así queda registrado qué se va a hacer, quién lo hace y en qué estado está.

### Ramas

Nadie trabaja directamente en `main`. Cada cambio se hace en una rama propia, con un nombre que indica de qué trata:

| Prefijo | Para qué | Ejemplo |
|---|---|---|
| `adr/` | Una decisión de arquitectura | `adr/0006-tecnologia-de-la-aplicacion` |
| `docs/` | Cambios en la documentación | `docs/guia-de-entrevistas` |
| `feat/` | Una funcionalidad nueva | `feat/registro-de-cajas` |
| `fix/` | La corrección de un error | `fix/fecha-de-vencimiento` |

Los nombres van en minúsculas y con guiones, sin tildes ni eñes.

### Commits

El mensaje empieza con un prefijo que indica el tipo de cambio, en minúsculas y seguido de dos puntos, y después una descripción breve en español:

| Prefijo | Para qué | Ejemplo |
|---|---|---|
| `add:` | Añadir algo nuevo | `add: ADR-0006 tecnología de la aplicación` |
| `update:` | Modificar algo que ya existe | `update: preguntas abiertas del ADR-0001` |
| `fix:` | Corregir un error | `fix: enlace roto al planteamiento` |
| `remove:` | Eliminar algo | `remove: diagrama que ya no se usa` |

- Un commit por cada cambio lógico, no uno solo con todo.
- Si hace falta explicar el porqué, se deja una línea en blanco después del título y se explica debajo.

### Pull requests

1. Sube tu rama y abre un *pull request* (PR) hacia `main`.
2. En la descripción, explica **qué** cambia y **por qué**, y enlaza el *issue* relacionado.
3. Pide revisión a las personas que deban opinar.
4. Los comentarios se resuelven en el propio PR, para que la discusión quede registrada.
5. Cuando haya acuerdo, se hace *merge*.

## Documentación

Toda la documentación del proyecto sigue unas mismas normas:

- [Cómo se documenta el proyecto](docs/guias/documentacion.md): qué tipo de documento va en cada lugar, el estilo de redacción y cómo se hacen los diagramas.
- [Cómo escribir un ADR](docs/guias/adr.md): guía detallada para documentar una decisión de arquitectura, con su [plantilla](docs/adr/plantilla.md).

## Licencia

El proyecto se publica bajo la licencia [Apache-2.0](LICENSE). Al contribuir, aceptas que tu contribución se publique bajo esa misma licencia.
