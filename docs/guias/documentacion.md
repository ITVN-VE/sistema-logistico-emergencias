# Cómo se documenta el proyecto

Esta guía explica qué tipo de documento va en cada lugar y cómo se escribe, para que toda la documentación sea fácil de encontrar y de leer.

## Qué va en cada lugar

```
sistema-logistico-emergencias/
├── README.md                  ← qué es el proyecto, en pocas líneas
├── CONTRIBUTING.md            ← cómo participar y cómo se trabaja
├── LICENSE
└── docs/
    ├── planteamiento.md       ← el problema, los objetivos y el alcance
    ├── proposal-en.md         ← traducción al inglés del planteamiento
    ├── adr/                   ← decisiones de arquitectura
    │   ├── README.md          ← índice de todas las decisiones
    │   ├── plantilla.md
    │   └── 0001-….md
    ├── modelo-de-datos/       ← qué información guarda el sistema
    │   ├── README.md          ← principios, convenciones e índice
    │   └── centro-y-usuarios.md
    ├── diagramas/             ← imágenes de todos los documentos
    └── guias/                 ← cómo se trabaja en el proyecto
        ├── documentacion.md   ← esta guía
        └── adr.md             ← cómo escribir un ADR
```

| Tipo de documento | Dónde | Para qué | Cuándo se actualiza |
|---|---|---|---|
| **README** | Raíz del repositorio | Presentar el proyecto a quien llega por primera vez. | Cuando cambia el estado o el enfoque del proyecto. |
| **Guía de contribución** | `CONTRIBUTING.md` | Explicar cómo participar y cómo se trabaja. | Cuando cambia la forma de trabajar. |
| **Planteamiento** | `docs/planteamiento.md` | Explicar el problema, los objetivos, el alcance y las preguntas abiertas. | Al cerrar cada fase del proyecto. |
| **Decisiones de arquitectura (ADR)** | `docs/adr/` | Dejar por escrito por qué el sistema está hecho como está. | Una por cada decisión importante. |
| **Modelo de datos** | `docs/modelo-de-datos/` | Describir qué información guarda el sistema, en qué tablas y con qué campos. Un documento por cada parte del modelo. | Cada vez que se diseña o cambia una tabla. |
| **Guías** | `docs/guias/` | Explicar normas y procedimientos del proyecto. | Cuando cambia la norma. |
| **Tareas, errores e ideas** | *Issues* de GitHub | Saber qué hay que hacer, quién lo hace y en qué estado está. | Continuamente. |
| **Discusión de cada cambio** | *Pull requests* de GitHub | Revisar cada cambio antes de incorporarlo. | En cada cambio. |

Si un documento no encaja en ninguno de estos tipos, conviene proponerlo en un *issue* antes de crearlo.

## Formato

- Todos los documentos se escriben en **Markdown** (`.md`), que GitHub muestra con formato.
- Los nombres de archivo van en minúsculas, con guiones y sin tildes ni eñes: `continuidad-del-servidor-local.md`.
- Los enlaces entre documentos son **relativos**, por ejemplo `[ADR-0001](../adr/0001-modelo-de-despliegue.md)`, para que funcionen tanto en GitHub como en una copia local.

## Estilo de redacción

- **Idioma.** Los documentos se escriben en español. Las contribuciones a proyectos de terceros siguen el idioma y las normas de ese proyecto.
- **Claro y directo.** Frases cortas, una idea por párrafo. El lector debe entender el documento sin haber participado en la discusión.
- **Pensado para cualquiera.** Parte de la documentación la leerán coordinadores de centros de acopio y organizaciones, no solo desarrolladores. Si se usa un término técnico, se explica la primera vez.
- **Siglas.** La primera vez que aparece una sigla se escribe completa: "ADR (*Architecture Decision Record*, registro de decisión de arquitectura)".
- **Términos en otro idioma**, en cursiva: *pull request*, *split-brain*.
- **Fechas** en formato AAAA-MM-DD: 2026-11-24.
- **Tablas** para comparar opciones o resumir datos; **listas** para enumerar; **párrafos** para explicar.
- **Honestidad.** Se incluyen también los inconvenientes y los riesgos, no solo las ventajas.

## Diagramas

Solo se hace un diagrama cuando ayuda a entender algo que el texto no explica bien. Si basta con el texto o con una tabla, no hace falta.

Los diagramas de todos los documentos se guardan juntos:

```
docs/diagramas/
├── despliegue.png        ← las imágenes que se ven en los documentos
├── centro-y-usuarios.png
├── replica.png
└── fuentes/              ← lo necesario para editarlas
    ├── build.sh
    ├── estilo.tex
    ├── despliegue.tex
    ├── centro-y-usuarios.tex
    └── replica.tex
```

- Cada diagrama se hace en LaTeX con TikZ, en un archivo `.tex` dentro de `fuentes/`, con el mismo nombre que su imagen.
- Todos usan el estilo común de `estilo.tex` (colores, tipo de letra, iconos y tablas del modelo de datos), para que se vean iguales. El azul se usa para los servidores, la red local y las tablas, el naranja para las réplicas y el gris para lo inactivo, secundario o fijo.
- Para generar las imágenes se ejecuta `docs/diagramas/fuentes/build.sh`. Crea un `.png` por diagrama en `diagramas/`, con fondo blanco para que se lea también en el modo oscuro de GitHub. Para generar solo uno: `build.sh replica`.
- En el documento se enlaza el `.png` con una ruta relativa, por ejemplo desde un ADR: `![Descripción del diagrama](../diagramas/nombre.png)`. La descripción entre corchetes es obligatoria, porque es lo que leen los lectores de pantalla.
- Se suben al repositorio los `.tex` y los `.png`. La carpeta `fuentes/build/` se genera al compilar y no se sube.

Para compilar hace falta una distribución de LaTeX con los paquetes `tikz`, `standalone`, `FiraSans` y `fontawesome5` (por ejemplo, TeX Live completo), además de `latexmk` y `pdftoppm` (del paquete Poppler).
