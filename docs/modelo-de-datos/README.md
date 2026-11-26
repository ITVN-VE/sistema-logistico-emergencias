# Modelo de datos

Esta carpeta describe qué información guarda cada parte del sistema y cómo se organiza. Hay un documento por cada parte del modelo, y todos siguen los principios y convenciones de esta página.

Las decisiones que tuvieron alternativas razonables se explican en los [ADR](../adr/README.md). Aquí se describe el resultado.

## El esquema

El archivo [`esquema.dbml`](esquema.dbml) define todas las tablas, sus campos, las listas de valores y las relaciones. Está escrito en [DBML](https://dbml.dbdiagram.io/docs/) (*Database Markup Language*), un lenguaje de texto para describir bases de datos.

- **Es la fuente del modelo.** Los documentos de esta carpeta explican el esquema en lenguaje sencillo, pero la definición exacta está en el esquema. Si cambia una tabla, se actualizan en el mismo *pull request* el esquema y el documento que la explica.
- **Para verlo como diagrama**, se copia el contenido del archivo y se pega en [dbdiagram.io](https://dbdiagram.io). Ahí se pueden mover las tablas y ver cómo se relacionan.
- Como es texto, en cada *pull request* se ve exactamente qué tabla o campo cambió.

## Documentos

| Documento | Qué describe | Sistema |
|---|---|---|
| [Centro y usuarios](centro-y-usuarios.md) | El centro de acopio, las personas que usan el sistema y la lista de entidades federales. | Inventario |

Para añadir uno nuevo, se crea un archivo en esta carpeta, con un nombre que diga qué parte del modelo describe, se agregan sus tablas al esquema y se añade una fila a esta tabla.

## Principios

- **El centro es autónomo.** Cada instalación crea su propio centro y es dueña de sus datos. No hace falta internet ni pedir permiso a nadie para empezar a trabajar ([ADR-0001](../adr/0001-modelo-de-despliegue.md)).
- **Una instalación, un centro.** Si un centro tiene varios galpones o salas, son ubicaciones dentro del mismo centro, no centros distintos.
- **El centro se vincula al sistema central; el sistema central no lo crea.** Cuando exista el sistema central (segunda etapa), cada centro solicitará unirse a él ([planteamiento](../planteamiento.md), sección 5.4), y el diseño no debe impedir que un centro se vincule también a otros sistemas, como el de la organización con la que trabaja. Esa vinculación se diseñará en su momento, en una tabla propia, sin cambiar las tablas existentes.
- **Identificadores únicos sin coordinación.** Todas las tablas usan como identificador un **UUID versión 7** ([RFC 9562](https://www.rfc-editor.org/rfc/rfc9562)): un número aleatorio que cada dispositivo genera solo, sin internet, y que en la práctica no se repite. Empieza por la fecha de creación, lo que mantiene los registros ordenados. Así, cuando los datos de muchos centros se unan en el sistema central, no habrá dos registros con el mismo identificador.
- **Nada se borra.** Los registros no se eliminan: se cambia su `situacion` (por ejemplo, un centro se *cierra* y un usuario se *desactiva*). Así se conserva la historia completa y cada acción sigue atribuida a quien la hizo.
- **Se guarda solo lo necesario.** Cada dato personal que no se guarda es un dato que no se puede filtrar. Antes de añadir un campo con información sobre personas, hay que poder explicar para qué se usa.
- **Códigos, no nombres.** Cuando un dato viene de una lista (el estado, el rol, la situación), se guarda su código y no el texto que se muestra. Así las estadísticas no dependen de cómo se escribió cada nombre.
- **Fechas en UTC.** Las fechas y horas se guardan en tiempo universal (UTC) y la pantalla las muestra en la hora de Venezuela (UTC−4).

## Convenciones

- Los nombres de tablas y campos van en español, en minúsculas, con guiones bajos y sin tildes ni eñes: `punto_referencia`, `actualizado_en`.
- Los campos que apuntan a otra tabla terminan en `_id`: `responsable_id`.
- Los tipos se describen de forma general (texto, número, fecha y hora). El tipo concreto depende de la base de datos que se elija.

## Pendiente de diseñar

- **Ubicaciones, productos, cajas y movimientos:** el inventario en sí. Se diseñarán a partir de las entrevistas, tomando como referencia el modelo de Boxtribute y sus limitaciones conocidas (por ejemplo, la falta de fecha de vencimiento y de registro de donaciones).
- **Registro de cambios:** la tabla con los cambios numerados y sus turnos que propone el [ADR-0002](../adr/0002-continuidad-del-servidor-local.md).
- **Sistema central:** su propio modelo, incluidas las vinculaciones con los centros. Segunda etapa.

## Preguntas abiertas

- ¿Deben las tablas llevar el identificador del centro (`centro_id`) para facilitar el envío de datos al sistema central, aunque cada instalación tenga un solo centro?
