# ADR-0005: Distribución y actualización de la aplicación

- **Estado:** Propuesto
- **Fecha de creación:** 2026-11-26
- **Fecha de decisión:** pendiente
- **Fecha límite para decidir:** antes de publicar la primera versión para centros piloto
- **Autor:** Aureliano Aristizabal ([arstbltech](https://github.com/arstbltech))
- **Participantes:** pendiente
- **Relacionado con:** [ADR-0001: Modelo de despliegue](0001-modelo-de-despliegue.md); [ADR-0002: Continuidad del servidor local](0002-continuidad-del-servidor-local.md); [ADR-0004: Red local del centro](0004-red-local-del-centro.md)

## Contexto y problema

Según el [ADR-0001](0001-modelo-de-despliegue.md), cada centro instala la aplicación con doble clic en una computadora, que funciona como servidor local. La réplica del [ADR-0002](0002-continuidad-del-servidor-local.md) también tiene la aplicación instalada. Los voluntarios, en cambio, usan el navegador: la interfaz se la sirve la laptop, así que **ellos nunca instalan ni actualizan nada**. Cuando se actualiza la laptop, todos ven la versión nueva la próxima vez que abren la página.

Hay que decidir cómo llega la aplicación a los centros y cómo se mantiene al día. La idea es que funcione como cualquier programa de toda la vida: se descarga de la web de la ITVN, hay versiones numeradas y la propia aplicación avisa cuando hay una nueva. Pero en este proyecto actualizar tiene riesgos propios:

- **Una actualización puede dañar los datos del centro** si cambia la base de datos y algo sale mal a mitad de camino.
- **Una actualización que interrumpe el trabajo** (por ejemplo, reiniciando el servidor mientras diez voluntarios registran) es justo lo que no puede pasar en una emergencia.
- **Una versión falsa llegaría a todos los centros a la vez.** El sistema de actualización es la puerta más peligrosa del proyecto.
- **El servidor y la réplica tienen que entenderse.** Si tienen versiones incompatibles, la copia podría corromperse.
- **Muchos centros pasan mucho tiempo sin internet** ([ADR-0001](0001-modelo-de-despliegue.md)), así que no se puede contar con que se actualicen solos.
- **Windows y Android desconfían de los programas que no vienen de una tienda** y muestran advertencias que asustan a quien no sabe de tecnología.

**Pregunta que responde este ADR:** ¿cómo se publica la aplicación, cómo se numeran sus versiones y cómo se actualiza un centro sin perder datos, sin interrumpir el trabajo y aunque no tenga internet?

### Fuera del alcance de este ADR

- **La tecnología concreta** con que se construye la aplicación (por ejemplo Tauri o Electron), que se decidirá en el ADR de tecnología. Este ADR sirve como criterio para ese: la tecnología elegida debe permitir actualizaciones firmadas.
- **El diseño de la web de la ITVN.** Aquí solo se decide qué debe ofrecer la página de descargas.
- **Las actualizaciones del sistema central**, que corresponde a la segunda etapa.

## Criterios de decisión

1. **Nunca se dañan ni se pierden los datos del centro** al actualizar.
2. **Solo se instalan versiones auténticas**, publicadas por el proyecto.
3. **No interrumpe el trabajo** del centro.
4. **Fácil para quien no sabe de tecnología**: descargar, instalar y actualizar sin tener que pensar.
5. **Funciona sin internet**, al menos como alternativa.
6. **Asequible y mantenible** por un equipo pequeño.

## Opciones consideradas

### Opción A: Solo descargas desde la web

La web de la ITVN publica los instaladores de cada versión. Para actualizar, alguien del centro tiene que enterarse de que hay una versión nueva, descargarla e instalarla encima.

- **Ventajas:**
  - Es lo más sencillo de construir (cumple el criterio 6).
  - Funciona igual con un pendrive (cumple el criterio 5).
- **Inconvenientes:**
  - **Casi nadie se entera de que hay una versión nueva**, así que los centros se quedan con versiones viejas y con errores ya corregidos (riesgo para el criterio 4).
  - Nada impide instalar una versión falsa descargada de otro sitio (incumple el criterio 2).
  - Nada impide instalar una versión vieja encima de datos nuevos.

### Opción B: Actualización automática y obligatoria

Como hace Chrome: la aplicación descarga e instala las versiones nuevas sola, sin preguntar.

- **Ventajas:**
  - Los centros con internet siempre están al día (cumple el criterio 4).
- **Inconvenientes:**
  - **Puede reiniciar el servidor en medio del trabajo** (incumple el criterio 3).
  - Una versión con un error grave llega a todos los centros antes de que nadie lo note.
  - No resuelve los centros sin internet (incumple el criterio 5).

### Opción C: Aviso dentro de la aplicación, con firma y vías sin internet

La aplicación busca versiones nuevas cuando hay internet, las descarga en segundo plano y avisa. Un coordinador decide cuándo instalarla. Cada versión está firmada por el proyecto, se hace una copia de los datos antes de instalar y también se puede actualizar desde un pendrive o desde otro equipo del centro.

- **Ventajas:**
  - Los centros se enteran solos de que hay una versión nueva (cumple el criterio 4).
  - El coordinador elige el momento (cumple el criterio 3).
  - La firma impide instalar versiones falsas, venga de donde venga el archivo (cumple el criterio 2).
  - La copia previa permite volver atrás si algo falla (cumple el criterio 1).
  - Funciona sin internet (cumple el criterio 5).
- **Inconvenientes:**
  - Es lo más complejo de construir: aviso, firma, copia previa, comprobación de versiones y actualización desde archivo. Gran parte la resuelven ya Tauri y Electron.
  - Depende de que alguien pulse «Actualizar».
  - Exige custodiar muy bien la clave de firma.

### Opción D: Tiendas de aplicaciones

La aplicación se publica en Microsoft Store, Google Play o Flathub, y cada tienda se encarga de instalarla y actualizarla.

- **Ventajas:**
  - La instalación y las actualizaciones son las que el usuario ya conoce, sin advertencias de seguridad (cumple el criterio 4).
- **Inconvenientes:**
  - **Necesita internet** y una cuenta en cada tienda, y no sirve para actualizar con un pendrive (incumple el criterio 5).
  - Cada versión pasa por la revisión de la tienda, que puede tardar días.
  - Las tiendas actualizan cuando quieren, no cuando el centro decide (riesgo para el criterio 3).
  - Hace depender al proyecto de terceros.

### Comparación

| Criterio | A. Solo descargas | B. Automática | C. Aviso con firma | D. Tiendas |
|---|---|---|---|---|
| 1. No daña los datos | ⚠️ | ⚠️ | ✅ (copia previa) | ⚠️ |
| 2. Solo versiones auténticas | ❌ | ✅ | ✅ | ✅ |
| 3. No interrumpe el trabajo | ✅ | ❌ | ✅ | ⚠️ |
| 4. Fácil | ⚠️ | ✅ | ✅ | ✅ |
| 5. Sin internet | ✅ | ❌ | ✅ | ❌ |
| 6. Asequible y mantenible | ✅ | ⚠️ | ⚠️ | ⚠️ |

## Decisión

Se recomienda la **Opción C: aviso dentro de la aplicación, con firma y vías sin internet**.

Es la única que protege los datos, no interrumpe el trabajo y funciona sin internet a la vez. Su complejidad se reduce porque las tecnologías candidatas ya traen actualizaciones firmadas. Google Play se valorará como canal adicional para Android (ver *Firma de código*), sin depender de él.

### Funcionamiento propuesto

#### Publicación

- **GitHub Releases es la fuente de cada versión.** Cada versión se crea a partir de una etiqueta en Git (por ejemplo `v1.4.0`). GitHub Actions compila los instaladores, los firma y los publica con las notas de la versión. Nadie compila un instalador a mano.
- **La web de la ITVN es la cara pública.** Una página de descargas muestra la última versión, con un botón por sistema operativo, y la lista de versiones anteriores. Lee los datos de GitHub Releases, para no mantener dos sitios.
- **Formatos:**
  - **Windows:** instalador `.exe`.
  - **Linux:** AppImage, un solo archivo que se ejecuta sin instalar y que se puede actualizar solo.
  - **Android:** `.apk`, cuando exista la aplicación Android ([ADR-0001](0001-modelo-de-despliegue.md)).
  - **macOS:** solo si las entrevistas muestran que hace falta (ver *Firma de código*).
- **Cada instalador se publica con su suma SHA-256**, para comprobar que no se modificó.
- **Las notas de la versión van en español** y en lenguaje simple: qué cambió y qué hay que saber.
- **Versiones de prueba.** Antes de publicar una versión para todos, se publica como versión de prueba para los centros piloto que quieran recibirlas.

#### Numeración

Se usa **versionado semántico** (`MAYOR.MENOR.PARCHE`), con este significado:

| Cambia | Cuándo | Ejemplo |
|---|---|---|
| **PARCHE** | Corrige errores, sin cambiar nada más | 1.4.0 → 1.4.1 |
| **MENOR** | Añade funciones y sigue siendo compatible con lo anterior | 1.4.1 → 1.5.0 |
| **MAYOR** | Rompe la compatibilidad: la réplica, otros centros o el sistema central necesitan la misma versión mayor | 1.5.0 → 2.0.0 |

Además del número visible, la aplicación lleva dos números internos:

- **Versión del formato de los datos.** Cada cambio en la base de datos es una *migración* numerada. Una versión nueva sabe convertir los datos de cualquier versión anterior, pero **nunca al revés**.
- **Versión del protocolo de la réplica.** El servidor y la réplica la comparan al conectarse.

#### Actualizar desde la aplicación

1. Al arrancar, y cada cierto tiempo si hay internet, la aplicación consulta un pequeño archivo publicado con cada versión que dice cuál es la última.
2. Si hay una nueva, **la descarga en segundo plano** y muestra un aviso discreto: «Hay una versión nueva (1.5.0). Ver novedades». Si corrige un problema de seguridad, el aviso lo dice.
3. **No se instala sola.** Un coordinador pulsa «Actualizar ahora», o se instala la próxima vez que se cierra la aplicación.
4. Antes de instalar, la aplicación **comprueba la firma** de la versión nueva. Si no es válida, no la instala.
5. Antes de cambiar nada, **hace una copia de seguridad automática** de los datos, como las del [ADR-0002](0002-continuidad-del-servidor-local.md).
6. Al arrancar la versión nueva, se aplican las migraciones de los datos. **Si una migración falla, la aplicación no arranca con datos a medias**: avisa y permite volver a la versión anterior con la copia.

#### Datos y versiones anteriores

- **No se puede instalar una versión anterior encima de datos de una versión más nueva**, porque no sabría leerlos. Para volver atrás, se restaura la copia que se hizo antes de actualizar.
- Solo la última versión recibe correcciones. Las anteriores siguen disponibles para descarga.

#### Servidor y réplica

- Al conectarse, el servidor y la réplica comparan la versión del protocolo. **Si no son compatibles, la réplica no copia nada** y el servidor muestra «Sin réplica: actualiza la réplica a la versión 1.5».
- **Primero se actualiza la réplica y después el servidor.** Una versión nueva entiende el protocolo de la anterior, pero no al revés. Cuando hay una versión nueva, la aplicación del servidor guía al coordinador en ese orden.

#### Actualizar sin internet

- **Desde un pendrive.** El coordinador elige «Actualizar desde archivo» y la aplicación comprueba la firma igual que si viniera de internet. Así cualquiera puede llevar la versión nueva en un pendrive sin riesgo de que la hayan modificado.
- **Desde otro equipo del centro.** Cuando el servidor tiene una versión nueva, se la ofrece a la réplica y sirve el `.apk` a los teléfonos por la red local ([ADR-0004](0004-red-local-del-centro.md)). Basta con que **un solo equipo** haya tenido internet un momento.

#### Firma de las actualizaciones

- **Cada versión se firma con una clave privada del proyecto**, y la aplicación solo instala lo que esté firmado con esa clave. El sistema de actualización de Tauri exige esta firma y no permite desactivarla. Electron tiene mecanismos parecidos, que en Windows y macOS se apoyan en la firma de código del sistema operativo.
- **La clave de firma es lo más valioso del proyecto.** Si se pierde, no se pueden publicar actualizaciones para las instalaciones existentes. Si la roban, alguien podría publicar actualizaciones falsas para todos los centros. Por eso:
  - se guarda cifrada y fuera de GitHub, salvo como secreto cifrado de GitHub Actions para firmar;
  - tiene una copia de respaldo en un lugar físico distinto;
  - la conocen muy pocas personas;
  - se prepara desde el principio un procedimiento para cambiarla: una versión firmada con la clave antigua que instala la clave nueva.

#### Firma de código del sistema operativo

Es otra firma, aparte de la anterior: la emite una autoridad reconocida y sirve para que Windows o Android no muestren advertencias.

- **Windows.** Un `.exe` sin firma de código muestra «Windows protegió su PC». Opciones:
  - **SignPath Foundation**, que firma gratis proyectos de código abierto. Exige una licencia de código abierto aprobada por OSI (la Apache 2.0 del proyecto lo es), compilaciones automáticas desde el repositorio, aprobación manual de cada versión y verificación en dos pasos para el equipo. El proyecto tiene que solicitarlo y SignPath decide si lo acepta.
  - Un certificado comercial, si SignPath no lo acepta.
  - Mientras tanto, la página de descargas explica la advertencia con capturas, paso a paso.
- **Android.** Google exigirá que las aplicaciones de Android sean de desarrolladores verificados. Empieza el 30 de septiembre de 2026 en Brasil, Indonesia, Singapur y Tailandia, y se extiende a todo el mundo en 2027. Después, instalar un `.apk` de un desarrollador no verificado exigirá un procedimiento avanzado, con una espera de 24 horas. Hay que crear una cuenta de desarrollador verificada (25 dólares para distribución completa) antes de publicar el `.apk`, y valorar publicarla también en Google Play.
- **macOS** exige una cuenta de desarrollador de Apple (99 dólares al año) para no mostrar bloqueos. Se deja para cuando haga falta.

## Consecuencias

- **Positivas:**
  - Los voluntarios nunca actualizan nada; solo el servidor y la réplica.
  - Ninguna actualización puede dejar al centro sin datos: siempre hay una copia previa.
  - El centro decide cuándo actualizar, y nunca se interrumpe el trabajo.
  - Un centro sin internet se puede actualizar con un pendrive o desde otro equipo, sin riesgo de instalar una versión modificada.
  - Las versiones son reproducibles: cada instalador sale de una etiqueta del repositorio, compilado por GitHub Actions.
- **Negativas:**
  - Hay que construir y probar el aviso, la copia previa, las migraciones, la comprobación de versiones y la actualización desde archivo.
  - Cada migración de datos tiene que probarse con datos de versiones anteriores antes de publicarla.
  - Algunos centros no actualizarán nunca si nadie pulsa «Actualizar».
  - La firma de código de Windows y la cuenta verificada de Android pueden tener un costo y dependen de que terceros acepten al proyecto.
- **Riesgos y cómo mitigarlos:**
  - **Roban la clave de firma:** guardarla como se indica arriba y tener preparado el procedimiento para cambiarla.
  - **Se pierde la clave de firma:** copia de respaldo en otro lugar físico. Sin ella, cada centro tendría que reinstalar a mano.
  - **Una migración daña los datos:** copia automática antes de actualizar, migraciones probadas con datos de prueba de cada versión anterior y versiones de prueba en centros piloto antes de publicarlas para todos.
  - **La advertencia de Windows asusta a los usuarios:** firma de código cuanto antes y, mientras tanto, explicarla en la página de descargas.
  - **Un centro se queda en una versión muy vieja:** el aviso de versión nueva se repite, y las migraciones saben convertir datos de cualquier versión anterior, así que se puede saltar de una versión vieja a la última directamente.
  - **GitHub deja de estar disponible:** la web de la ITVN puede guardar copia de los instaladores, y el pendrive sigue funcionando.

## Preguntas abiertas

Se resolverán con prototipos y al preparar la primera versión:

- ¿Acepta SignPath Foundation al proyecto? ¿Desde qué momento, si exige que ya exista una versión publicada?
- ¿Cómo aplica en Venezuela la verificación de desarrolladores de Android, y conviene publicar en Google Play?
- ¿Cada cuánto debe la aplicación buscar versiones nuevas?
- ¿Hace falta poder posponer una actualización de seguridad, o debe insistirse más?
- ¿Cuántos centros piloto aceptarían recibir versiones de prueba?

## Referencias

- [ADR-0001: Modelo de despliegue](0001-modelo-de-despliegue.md), [ADR-0002: Continuidad del servidor local](0002-continuidad-del-servidor-local.md) y [ADR-0004: Red local del centro](0004-red-local-del-centro.md).
- [Versionado semántico 2.0.0](https://semver.org/lang/es/). Qué significa cada número de una versión.
- [GitHub, *About releases*](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases). Publicación de versiones a partir de etiquetas.
- [Tauri, *Updater*](https://v2.tauri.app/plugin/updater/). Actualizaciones firmadas para Windows, Linux (AppImage) y macOS. La firma es obligatoria.
- [Electron, *Updating Applications*](https://www.electronjs.org/docs/latest/tutorial/updates). Los mecanismos de actualización de Electron.
- [SignPath Foundation](https://signpath.org/). Firma de código gratuita para proyectos de código abierto, y sus [condiciones](https://signpath.org/terms).
- [Android, *Developer verification*](https://developer.android.com/developer-verification). Requisito de desarrolladores verificados y su calendario.
