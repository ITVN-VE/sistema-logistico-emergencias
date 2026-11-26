# ADR-0003: Usuarios y acceso

- **Estado:** Propuesto
- **Fecha de creación:** 2026-11-25
- **Fecha de decisión:** pendiente
- **Fecha límite para decidir:** al terminar las entrevistas con centros de acopio de la fase de investigación
- **Autor:** Aureliano Aristizabal ([arstbltech](https://github.com/arstbltech))
- **Participantes:** pendiente
- **Relacionado con:** [ADR-0001: Modelo de despliegue](0001-modelo-de-despliegue.md); [ADR-0002: Continuidad del servidor local](0002-continuidad-del-servidor-local.md); [Modelo de datos](../modelo-de-datos/centro-y-usuarios.md)

## Contexto y problema

Según el [ADR-0001](0001-modelo-de-despliegue.md), cada centro de acopio tiene su propio servidor local y los voluntarios se conectan a él desde el navegador por la red local, sin internet. El sistema no puede depender de la ITVN ni de servicios externos para funcionar.

Varias personas usan el sistema de un mismo centro, y no todas deben poder hacer lo mismo. Además:

- Los voluntarios **rotan con frecuencia** y muchos no tienen formación técnica.
- **No hay internet**, así que no se puede enviar un correo o un SMS para verificar a una persona ni para recuperar una clave.
- En la ayuda humanitaria, uno de los riesgos más reales es el **desvío de insumos**: alguien saca algo y modifica el inventario para que no se note. Saber quién hizo cada cambio es una de las protecciones más útiles del sistema.
- Una lista de quiénes participan en la ayuda, con sus datos personales, puede ser **información sensible** si el equipo cae en malas manos.

El ADR-0001 ya indica, como mitigación de un riesgo, que cada persona entre con usuario y PIN. El ADR-0002 introduce el rol de coordinador y la hoja de recuperación. Este ADR concreta cómo funciona el acceso.

**Pregunta que responde este ADR:** ¿cómo se identifican las personas que usan el sistema de un centro de acopio, qué puede hacer cada una y cómo recuperan el acceso si lo pierden, sin internet?

### Fuera del alcance de este ADR

- **La protección de la conexión en la red local** (HTTPS). Sin ella, el PIN viaja sin cifrar por el Wi-Fi. Se decidirá en un ADR propio, porque afecta también al escaneo de códigos QR y a la instalación de la aplicación.
- **Las cuentas en el sistema central** y la verificación de los responsables de cada centro, que corresponden a la segunda etapa (planteamiento, sección 5.4).
- **La tecnología concreta** con que se implementa (lenguaje, librerías), que se decidirá en el ADR de tecnología de la aplicación.
- **La lista detallada de permisos** de cada rol, que se definirá al diseñar cada pantalla.

## Criterios de decisión

1. **Funciona sin internet y sin servicios externos.** Entrar, gestionar usuarios y recuperar el acceso se hace solo con el servidor del centro.
2. **Cada acción queda atribuida a una persona.** Se puede saber quién registró, movió o ajustó cada cosa.
3. **Fácil para voluntarios sin formación y que rotan.** Dar de alta a alguien y que empiece a trabajar lleva un minuto.
4. **El acceso se puede recuperar** sin internet, sin que eso abra una puerta a cualquiera.
5. **Se guardan los mínimos datos personales.**
6. **Resiste los abusos más probables:** probar PIN al azar, usar la cuenta de otro en un teléfono prestado o seguir entrando después de dejar el centro.
7. **Simplicidad.** Se puede implementar y mantener con un equipo pequeño.

## Opciones consideradas

### Opción A: Sin cuentas personales

Cualquiera conectado al Wi-Fi del centro usa el sistema, o todos comparten una misma clave del centro.

- **Ventajas:**
  - Es lo más sencillo de usar y de implementar.
- **Inconvenientes:**
  - **No se sabe quién hizo cada cambio** (incumple el criterio 2).
  - Para quitarle el acceso a una persona hay que cambiar la clave a todos.
  - No permite que unas personas puedan hacer más cosas que otras.

### Opción B: Proveedor de identidad externo o instalado aparte

Las personas entran con una cuenta de un servicio como Auth0 o Google, como en Boxtribute, o con un servidor de identidad instalado en el centro, como Keycloak.

- **Ventajas:**
  - Son sistemas maduros, con muchas funciones de seguridad ya resueltas.
- **Inconvenientes:**
  - **Auth0 y Google necesitan internet** (incumple el criterio 1) y hacen depender al centro de un tercero.
  - **Keycloak y similares son servidores pesados**, que hay que instalar y mantener aparte, lo que contradice la instalación con doble clic del ADR-0001 (incumple el criterio 7).
  - La recuperación de la clave suele depender del correo, que no funciona sin internet.

### Opción C: Cuentas locales con teléfono y PIN o contraseña

El servidor del centro guarda las cuentas en su propia base de datos. Cada persona entra con su número de teléfono y un PIN (voluntarios) o una contraseña (coordinadores). Los coordinadores crean las cuentas y recuperan el acceso de los demás.

- **Ventajas:**
  - Funciona sin internet y sin terceros (cumple el criterio 1).
  - Cada acción queda atribuida a una persona (cumple el criterio 2).
  - Dar de alta a un voluntario es escribir su nombre y su teléfono (cumple el criterio 3).
- **Inconvenientes:**
  - La seguridad de las claves queda en manos del proyecto: hay que guardarlas y protegerlas bien.
  - Sin internet, no se puede comprobar que el teléfono o el correo pertenecen de verdad a esa persona.
  - Si se pierde todo acceso de coordinador y la hoja de recuperación, no hay forma de recuperarlo (ver *Recuperación del acceso*).

### Opción D: Elegir el nombre de una lista, sin clave

La pantalla de entrada muestra la lista de personas del centro y cada una toca su nombre, como en algunas cajas registradoras.

- **Ventajas:**
  - Es lo más rápido para los voluntarios.
- **Inconvenientes:**
  - **Cualquiera puede actuar en nombre de otro** (incumple los criterios 2 y 6).
  - Muestra la lista de personas del centro a cualquiera conectado al Wi-Fi (riesgo para el criterio 5).

### Comparación

| Criterio | A. Sin cuentas | B. Proveedor externo | C. Cuentas locales | D. Lista de nombres |
|---|---|---|---|---|
| 1. Sin internet ni terceros | ✅ | ❌ | ✅ | ✅ |
| 2. Acciones atribuidas | ❌ | ✅ | ✅ | ❌ |
| 3. Fácil para voluntarios | ✅ | ⚠️ | ✅ | ✅ |
| 4. Recuperación sin internet | No aplica | ❌ | ✅ (con hoja de recuperación) | No aplica |
| 5. Mínimos datos personales | ✅ | ⚠️ | ✅ | ⚠️ |
| 6. Resiste abusos | ❌ | ✅ | ✅ (con bloqueo de intentos) | ❌ |
| 7. Simplicidad | ✅ | ❌ | ⚠️ | ✅ |

## Decisión

Se recomienda la **Opción C: cuentas locales con teléfono y PIN o contraseña**.

Es la única opción que funciona sin internet y a la vez permite saber quién hizo cada cambio, que son los dos criterios más importantes. Su principal coste es que la seguridad de las claves depende del propio sistema, lo que se aborda en las reglas de abajo.

### Funcionamiento propuesto

- **Primer coordinador.** Al instalar el sistema, quien lo instala crea la primera cuenta de coordinador y pasa a ser el responsable del centro. En ese momento se genera la hoja de recuperación del [ADR-0002](0002-continuidad-del-servidor-local.md), y la aplicación no continúa hasta que se imprime o se guarda.
- **Alta de usuarios.** Solo los coordinadores crean cuentas: nombre completo, teléfono, rol y, opcionalmente, correo. El sistema asigna un PIN temporal que la persona cambia la primera vez que entra.
- **Entrada con el teléfono.** El teléfono es **obligatorio** y es el identificador para entrar: todo el mundo tiene uno, lo recuerda y es único. Se guarda en formato internacional (`+584141234567`) para evitar duplicados. El correo es solo un dato de contacto opcional.
- **Roles:**
  - **Voluntario:** registra entradas y salidas de insumos, mueve cajas y consulta el inventario.
  - **Coordinador:** además, gestiona usuarios, hace ajustes de inventario, mantiene el catálogo de productos, restaura copias, prepara la réplica y hace el cambio de servidor del ADR-0002.
- **PIN y contraseñas:**
  - **Voluntarios:** PIN de 6 cifras.
  - **Coordinadores:** contraseña de al menos 15 caracteres, como recomienda NIST para contraseñas que son el único factor de acceso. Puede ser una frase fácil de recordar, como cuatro palabras seguidas. No se exigen mezclas de mayúsculas, números o símbolos, que NIST desaconseja, pero se rechazan las contraseñas más comunes.
  - Nunca se guardan tal cual: solo su resultado con **Argon2id**, el algoritmo que recomienda OWASP, con al menos sus parámetros mínimos.
- **Bloqueo por intentos fallidos.** Tras 5 intentos fallidos seguidos, la cuenta se bloquea unos minutos, cada vez más tiempo si se repite, y se avisa a los coordinadores. Con esto, adivinar un PIN de 6 cifras probando al azar llevaría años.
- **Sesiones.** Al entrar, el servidor abre una sesión para que la persona no tenga que escribir el PIN en cada pantalla. La sesión se cierra tras un tiempo sin uso, para que un teléfono prestado o abandonado no quede abierto. Un coordinador puede cerrar las sesiones de cualquier usuario.
- **Desactivar, no borrar.** Cuando alguien deja el centro, un coordinador desactiva su cuenta: no puede volver a entrar y sus sesiones se cierran, pero sus acciones pasadas siguen atribuidas a su nombre.
- **Registro de acciones.** Cada cambio en el inventario guarda quién lo hizo, usando el registro de cambios del ADR-0002. Nadie, ni siquiera un coordinador, puede borrar ese registro.
- **Datos personales mínimos.** De cada persona se guardan su nombre completo, su teléfono y, si quiere, su correo. No se piden la fecha de nacimiento, la cédula ni otros datos que el sistema no necesita ([modelo de datos](../modelo-de-datos/centro-y-usuarios.md)).

### Recuperación del acceso

Sin internet no hay "te enviamos un enlace". La recuperación se hace entre personas del propio centro:

| Quién perdió el acceso | Cómo se recupera |
|---|---|
| **Un voluntario** | Un coordinador le asigna un PIN temporal, y el voluntario lo cambia al entrar. |
| **Un coordinador** | Otro coordinador le asigna una contraseña temporal. Por eso se recomienda tener al menos dos coordinadores ([ADR-0002](0002-continuidad-del-servidor-local.md)). |
| **El único coordinador** | Se usa la **hoja de recuperación**. Cada uso queda registrado, y después se genera una hoja nueva. |
| **Nadie tiene acceso de coordinador ni la hoja** | **No se puede recuperar el acceso desde el propio sistema.** Si fuera posible, cualquiera que se llevara la computadora podría hacerlo también. |

En el último caso no se pierde el inventario y los voluntarios pueden seguir trabajando, pero nadie puede administrar el sistema (crear usuarios, restaurar copias, preparar la réplica) hasta que exista otra vía de verificación, como el sistema central de la segunda etapa ([ADR-0002](0002-continuidad-del-servidor-local.md), *Cuando exista el sistema central*). Para que esto no ocurra, la aplicación obliga a guardar la hoja al instalar y recuerda a menudo si el centro tiene un solo coordinador.

## Consecuencias

- **Positivas:**
  - Cada centro gestiona sus propias cuentas, sin depender de la ITVN ni de servicios externos.
  - Se sabe quién hizo cada cambio, lo que ayuda a detectar desvíos y errores.
  - Dar de alta y de baja a los voluntarios es rápido, lo que encaja con la alta rotación.
  - Las cuentas locales no impiden que, en la segunda etapa, el centro se vincule al sistema central: el centro se identifica ante el sistema central, y sus voluntarios no necesitan una cuenta allí.
- **Negativas:**
  - El proyecto es responsable de guardar y proteger bien las claves.
  - El teléfono y el correo no se verifican: el sistema confía en que el coordinador los escribe bien.
  - Un PIN de 6 cifras es más débil que una contraseña. Se acepta porque solo se usa dentro de la red local del centro y con bloqueo de intentos, a cambio de que los voluntarios puedan entrar con facilidad.
  - Si un centro pierde a la vez todo acceso de coordinador y la hoja de recuperación, queda sin poder administrar el sistema.
  - Como el teléfono es obligatorio, quien no tenga teléfono propio o no quiera dar su número no puede tener una cuenta.
- **Riesgos y cómo mitigarlos:**
  - **Alguien en el Wi-Fi del centro captura un PIN**, porque sin HTTPS viaja sin cifrar: usar un Wi-Fi con contraseña y decidir la protección de la conexión en su propio ADR.
  - **Roban o se pierde la computadora del servidor:** las claves no se pueden leer porque solo se guarda su resultado con Argon2id. Para proteger el resto de los datos, recomendar el cifrado de disco del sistema operativo y estudiar el cifrado de la base de datos en el ADR de tecnología.
  - **Un voluntario usa la cuenta de otro**, por ejemplo con un teléfono prestado y la sesión abierta: cerrar las sesiones tras un tiempo sin uso y explicar al dar de alta que cada cuenta es personal.
  - **Un coordinador abusa de su rol:** todas sus acciones quedan registradas y no puede borrarlas; con dos coordinadores, cada uno ve lo que hace el otro.
  - **Se pierde la hoja de recuperación o alguien la usa sin permiso:** se mitiga como indica el [ADR-0002](0002-continuidad-del-servidor-local.md).

## Preguntas abiertas

Se resolverán en las entrevistas con centros de acopio y con prototipos:

- ¿Cuántos voluntarios **no tienen teléfono propio** o no quieren dar su número? Sirve para saber a cuántas personas afecta que sea obligatorio.
- ¿Los voluntarios **comparten teléfonos**? ¿Con qué frecuencia?
- ¿Recuerdan sin problema un **PIN de 6 cifras**?
- ¿Cuánto tiempo sin uso debe pasar para **cerrar la sesión**?
- ¿Hace falta algún rol más, por ejemplo uno de **solo consulta** para una organización aliada?
- ¿Conviene que las cuentas de voluntarios temporales **caduquen solas** después de una fecha?
- ¿Qué acciones debe poder hacer un voluntario y cuáles solo un coordinador?

## Referencias

- [ADR-0001: Modelo de despliegue](0001-modelo-de-despliegue.md) y [ADR-0002: Continuidad del servidor local](0002-continuidad-del-servidor-local.md).
- [Modelo de datos: centro y usuarios](../modelo-de-datos/centro-y-usuarios.md). Tabla de usuarios.
- [NIST SP 800-63B, *Digital Identity Guidelines: Authentication*](https://pages.nist.gov/800-63-4/sp800-63b.html). Guía de referencia sobre contraseñas: longitud mínima, reglas de composición y bloqueo de intentos.
- [OWASP, *Password Storage Cheat Sheet*](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html). Recomienda Argon2id y sus parámetros mínimos.
- [Boxtribute](https://github.com/boxwise/boxtribute). Usa Auth0, un proveedor de identidad externo (opción B).
