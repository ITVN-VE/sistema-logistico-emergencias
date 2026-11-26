# ADR-0004: Red local del centro

- **Estado:** Propuesto
- **Fecha de creación:** 2026-11-26
- **Fecha de decisión:** pendiente
- **Fecha límite para decidir:** al terminar las entrevistas con centros de acopio y el prototipo de red
- **Autor:** Aureliano Aristizabal ([arstbltech](https://github.com/arstbltech))
- **Participantes:** pendiente
- **Relacionado con:** [ADR-0001: Modelo de despliegue](0001-modelo-de-despliegue.md); [ADR-0002: Continuidad del servidor local](0002-continuidad-del-servidor-local.md); [ADR-0003: Usuarios y acceso](0003-usuarios-y-acceso.md)

## Contexto y problema

Según el [ADR-0001](0001-modelo-de-despliegue.md), los teléfonos de los voluntarios se conectan al servidor local por Wi-Fi, sin internet. Según el [ADR-0002](0002-continuidad-del-servidor-local.md), la réplica recibe por esa misma red cada cambio que se registra.

Pero en los centros de acopio **no se puede contar con un router ni con ningún otro equipo de red**. Lo único seguro es la laptop del servidor y los teléfonos de los voluntarios. Eso plantea varios problemas:

- **Alguien tiene que crear la red Wi-Fi**: la laptop o un teléfono.
- **El alcance es limitado.** El Wi-Fi integrado de una laptop o de un teléfono llega a unos 10–25 m en interiores, con una o dos paredes de por medio. Las paredes de bloque o concreto, las estanterías metálicas, las neveras y el agua almacenada lo reducen aún más. En un depósito grande habrá rincones sin señal.
- **Hay un límite de dispositivos.** El punto de acceso de Windows suele admitir unos 8 dispositivos y el de un teléfono Android, entre 5 y 10. Hay que comprobar estas cifras en el prototipo.
- **Si la red depende de un equipo, cae con él.** Si la laptop crea la red y se apaga, no solo se pierde el servidor: también desaparece la red a la que estaban conectados los teléfonos y la réplica.
- **Sin HTTPS, lo que viaja por la red no va cifrado** entre el navegador y el servidor, incluido el PIN de los voluntarios ([ADR-0003](0003-usuarios-y-acceso.md)). Tener HTTPS en una red local sin internet es difícil (ver *Protección de la conexión*).

La cantidad de datos no es un problema: un registro ocupa alrededor de 1 KB y un centro con 5.000 movimientos al día genera unos 5 MB. Aun con señal débil, el Wi-Fi da más que suficiente. **Lo que limita es la cobertura, no la velocidad.**

**Pregunta que responde este ADR:** ¿cómo se monta la red del centro solo con la laptop y los teléfonos, cómo sigue funcionando el sistema donde no llega la señal y cómo se protege lo que viaja por ella?

### Fuera del alcance de este ADR

- **Equipos de red adicionales** (routers, repetidores, antenas). No se cuenta con ellos.
- **La conexión con el sistema central** por internet, que corresponde a la segunda etapa.
- **El protocolo detallado de la réplica** (registro de cambios, turnos), que ya define el [ADR-0002](0002-continuidad-del-servidor-local.md). Este ADR solo trata la red por la que viaja.

## Criterios de decisión

1. **Sin equipos adicionales.** Solo la laptop y los teléfonos.
2. **No se pierde ningún registro** aunque un teléfono quede fuera de alcance.
3. **Sin configurar nada en los teléfonos de los voluntarios**, más allá de conectarse al Wi-Fi, porque rotan con frecuencia.
4. **Fácil de montar** para alguien sin conocimientos técnicos.
5. **Sigue funcionando si falla un equipo**, en línea con el [ADR-0002](0002-continuidad-del-servidor-local.md).
6. **Protege el PIN y los datos** frente a alguien en el Wi-Fi o cerca del centro.
7. **Simplicidad.** Se puede implementar y mantener con un equipo pequeño.

## Opciones consideradas

Este ADR responde dos preguntas: **quién crea la red** y **cómo se protege la conexión**. Las opciones de cada una se comparan por separado.

### Quién crea la red

#### Opción A: La laptop crea la red

La laptop del servidor activa su punto de acceso Wi-Fi (en Windows, "Zona con cobertura inalámbrica móvil"; en Linux, el punto de acceso de NetworkManager). Los teléfonos y la réplica se conectan a ella.

- **Ventajas:**
  - Basta con un equipo (cumple el criterio 1).
  - La dirección del servidor es fija y conocida (en Windows, `192.168.137.1`), lo que simplifica el código QR de conexión.
  - Los teléfonos siempre ven al servidor: no hay aislamiento de clientes que lo impida (ver opción B).
  - La laptop suele tener más batería que un teléfono.
- **Inconvenientes:**
  - **Si la laptop falla, cae también la red** (riesgo para el criterio 5). La réplica tiene que crear una red nueva al tomar el relevo (ver *Funcionamiento propuesto*).
  - En Windows, el número de dispositivos es limitado (unos 8, a comprobar).
  - Windows pide elegir una conexión para compartir. Hay que comprobar si deja activar el punto de acceso **sin ninguna conexión a internet**.
  - En macOS, crear un punto de acceso sin una conexión de origen es difícil.

#### Opción B: Un teléfono crea la red

Un teléfono Android activa su punto de acceso y la laptop se conecta a él como un dispositivo más.

- **Ventajas:**
  - Si la laptop falla, la red sigue en pie, y la réplica y los teléfonos siguen conectados (cumple el criterio 5).
  - Algunos teléfonos admiten más dispositivos que el punto de acceso de Windows.
- **Inconvenientes:**
  - **El centro pasa a depender de dos equipos**: si el teléfono se queda sin batería o su dueño se va, se cae la red.
  - **Algunos teléfonos aíslan a los dispositivos conectados entre sí** (aislamiento de clientes), y entonces los voluntarios no ven a la laptop. Hay que comprobarlo modelo por modelo.
  - La dirección de la laptop la asigna el teléfono y puede cambiar.
  - Gasta mucha batería y datos del teléfono si tiene datos móviles activos.

#### Comparación

| Criterio | A. La laptop crea la red | B. Un teléfono crea la red |
|---|---|---|
| 1. Sin equipos adicionales | ✅ | ✅ |
| 4. Fácil de montar | ✅ | ⚠️ (dos equipos que coordinar) |
| 5. Sigue si falla un equipo | ⚠️ (la réplica crea la red de nuevo) | ⚠️ (depende del teléfono) |
| Dispositivos a la vez | ⚠️ Unos 8 en Windows | ⚠️ Entre 5 y 10, según el teléfono |
| 7. Simplicidad | ✅ | ⚠️ (aislamiento de clientes, dirección variable) |

### Protección de la conexión

La red Wi-Fi tiene contraseña (WPA2, o WPA3 si la laptop y los teléfonos lo admiten), lo que ya cifra lo que viaja por el aire frente a quien **no** conoce la contraseña. La pregunta es si además hace falta HTTPS entre el navegador y el servidor, para protegerse de quien **sí** la conoce.

#### Opción C: HTTP dentro de un Wi-Fi con contraseña

Los navegadores se conectan al servidor por HTTP, sin cifrado propio.

- **Ventajas:**
  - No hay que configurar nada en los teléfonos (cumple el criterio 3).
  - Es lo más sencillo (cumple el criterio 7).
- **Inconvenientes:**
  - Con WPA2, alguien que conoce la contraseña del Wi-Fi y captura el tráfico puede leer el PIN y la sesión de otro voluntario. WPA3 lo impide, pero no todos los equipos lo admiten (cumple solo en parte el criterio 6).
  - **Los navegadores limitan algunas funciones sin HTTPS**: el uso de la cámara desde la página y el funcionamiento sin conexión de las PWA (*service workers*). Guardar datos en el navegador (`localStorage`, IndexedDB) sí funciona.

#### Opción D: Certificado autofirmado

El servidor genera su propio certificado y los navegadores se conectan por HTTPS.

- **Ventajas:**
  - La conexión va cifrada.
- **Inconvenientes:**
  - **Cada navegador muestra una advertencia de seguridad a pantalla completa**, y hay que enseñar a los voluntarios a saltársela. Es justo el hábito que se aprovecha en los ataques reales (incumple los criterios 3 y 6).
  - Con un certificado no válido, los navegadores siguen sin permitir los *service workers*.

#### Opción E: Autoridad de certificación propia instalada en los teléfonos

Cada centro tiene su propia autoridad de certificación, y cada voluntario la instala en su teléfono para que el navegador confíe en el servidor.

- **Ventajas:**
  - HTTPS completo, sin advertencias.
- **Inconvenientes:**
  - **Instalar un certificado en Android o iOS requiere varios pasos en los ajustes**, en cada teléfono y con cada voluntario nuevo (incumple el criterio 3).
  - **Es peligroso para el voluntario**: si roban la laptop con la clave de esa autoridad, se podría interceptar el tráfico de cualquier sitio web en los teléfonos que la instalaron, incluido su banco (incumple el criterio 6).

#### Opción F: Dominio real con certificado válido

Como hace Plex, el proyecto tiene un dominio real cuyos nombres apuntan a la dirección local de cada servidor, y cada servidor obtiene un certificado válido para su nombre, por ejemplo de Let's Encrypt.

- **Ventajas:**
  - HTTPS completo, sin advertencias ni configuración en los teléfonos.
- **Inconvenientes:**
  - **Necesita internet**: los teléfonos tienen que consultar el dominio en internet y el certificado hay que renovarlo cada pocos meses (incumple el criterio 1 del [ADR-0001](0001-modelo-de-despliegue.md)).
  - Hace depender a cada centro de un dominio y un servicio que mantiene el proyecto.

#### Opción G: Aplicación nativa que reconoce el certificado del servidor

La aplicación instalada (la de la réplica y, más adelante, una aplicación Android para quien quiera instalarla) guarda la huella del certificado del servidor al vincularse con él, por ejemplo escaneando un código QR. Desde entonces solo acepta ese certificado (*certificate pinning*).

- **Ventajas:**
  - Conexión cifrada y autenticada, sin internet y sin advertencias.
- **Inconvenientes:**
  - Solo protege a quien instala la aplicación. Los voluntarios que usan el navegador siguen como en la opción C.
  - Exige desarrollar y distribuir una aplicación Android, y en iOS además una cuenta de desarrollador de Apple.

#### Comparación

| Criterio | C. HTTP en Wi-Fi con contraseña | D. Autofirmado | E. Autoridad propia | F. Dominio real | G. Aplicación con pinning |
|---|---|---|---|---|---|
| Sin internet | ✅ | ✅ | ✅ | ❌ | ✅ |
| 3. Sin configurar teléfonos | ✅ | ⚠️ (advertencia) | ❌ | ✅ | ⚠️ (instalar la aplicación) |
| 6. Protege PIN y datos | ⚠️ (con WPA2) | ⚠️ | ⚠️ (riesgo para el voluntario) | ✅ | ✅ |
| 7. Simplicidad | ✅ | ✅ | ❌ | ❌ | ⚠️ |

## Decisión

Se recomienda la **Opción A: la laptop crea la red**, con la **Opción B** como alternativa cuando haga falta conectar más dispositivos de los que admite la laptop.

Para la protección de la conexión se recomienda la **Opción C: HTTP dentro de un Wi-Fi con contraseña** para los navegadores en la primera etapa, y la **Opción G** desde el principio para la conexión entre el servidor y la réplica.

La opción A es la más sencilla de montar y la más predecible, y su principal problema (que la red cae con la laptop) ya lo resuelve la réplica del ADR-0002 si también sabe crear la red. Para la conexión, ninguna opción con HTTPS en el navegador funciona sin internet y sin configurar cada teléfono, que son condiciones del proyecto. Se acepta el riesgo de la opción C porque el Wi-Fi tiene contraseña y solo la conocen las personas del centro. En cambio, la réplica guarda el inventario completo y las claves de los usuarios, y como las dos puntas son la aplicación del proyecto, se puede cifrar sin ningún coste para los voluntarios.

### Funcionamiento propuesto

**Montar la red:**

- **La laptop crea la red al arrancar el servidor.** La aplicación activa el punto de acceso o, si el sistema operativo no lo permite, guía paso a paso para hacerlo. El nombre de la red y la contraseña se eligen al instalar y se guardan en la configuración del centro, que también recibe la réplica.
- **Banda de 2,4 GHz.** Es más lenta que la de 5 GHz, pero llega más lejos y atraviesa mejor las paredes, y la velocidad sobra. La aplicación la recomienda por defecto.
- **Dónde poner la laptop.** Al instalar, la aplicación da consejos: en el centro del local, en alto, lejos de estanterías metálicas, neveras y bidones de agua, y con las puertas abiertas.
- **Dos códigos QR para conectarse.** La pantalla del servidor muestra uno para unirse al Wi-Fi, que la cámara de Android y de iOS reconoce sin instalar nada, y otro con la dirección del sistema.
- **Si hay más voluntarios de los que admite la laptop**, se usa la opción B: un teléfono crea la red y la laptop se conecta a él. La aplicación avisa cuando se acerca al límite.
- **Calidad de la conexión.** El servidor muestra qué dispositivos están conectados y con qué calidad, para que el coordinador vea hasta dónde llega la red.

**Trabajar donde no llega la señal:**

- **Registros pendientes.** Si un voluntario registra algo fuera de alcance, el registro se guarda en el navegador del teléfono con el aviso **«Pendiente de enviar»** y se envía solo cuando vuelve la señal. Mientras tanto, la pestaña tiene que seguir abierta, porque sin HTTPS la página no puede volver a cargarse sin conexión.
- **Sin duplicados.** Cada registro lleva un identificador único generado en el teléfono. Si llega dos veces, por ejemplo porque se cortó la conexión antes de recibir la confirmación, el servidor lo reconoce y no lo duplica.
- **Dos horas.** Cada registro guarda cuándo se hizo según el teléfono y cuándo lo recibió el servidor, porque el reloj del teléfono puede estar mal.
- **Los registros que llegan tarde no se rechazan.** Reflejan algo que ya pasó físicamente. Si una salida que llega tarde deja existencias negativas, se acepta igual y se marca para que el coordinador la revise.
- **La réplica no frena a los voluntarios.** El [ADR-0002](0002-continuidad-del-servidor-local.md) establece que el servidor solo confirma un registro cuando la réplica ya lo tiene. Si la réplica no responde en un tiempo máximo, por ejemplo 2 segundos, el servidor confirma igual, muestra «Sin réplica» y la réplica se pone al día cuando mejore la señal.

**Cuando falla la laptop:**

- **La réplica también crea la red.** Al convertirse en servidor, la réplica activa su punto de acceso con **el mismo nombre de red y la misma contraseña**, así que los teléfonos se reconectan solos.
- Si la dirección del servidor cambia, los voluntarios escanean el nuevo código QR de dirección. Si la réplica es otra laptop con Windows, lo normal es que conserve la misma dirección.

**Protección:**

- **El Wi-Fi siempre tiene contraseña.** WPA3 si la laptop y los teléfonos lo admiten; si no, WPA2. Solo se da a las personas que trabajan en el centro, y se cambia si se sospecha que la conoce alguien que no debe.
- **Navegadores por HTTP** en la primera etapa.
- **Conexión entre servidor y réplica cifrada desde el principio.** Al vincular la réplica, el coordinador escanea un código QR del servidor que incluye la huella de su certificado. La réplica solo acepta ese certificado.
- **Más adelante**, una aplicación Android opcional con la misma protección (opción G).

## Consecuencias

- **Positivas:**
  - El centro solo necesita la laptop y los teléfonos que ya tiene.
  - Ningún registro se pierde por quedar fuera de alcance.
  - La réplica, que guarda todos los datos del centro, viaja cifrada desde el principio.
  - Los mismos mecanismos (identificadores únicos, registros que llegan tarde, ponerse al día) servirán en la segunda etapa para enviar los datos al sistema central, que también es una conexión que va y viene.
- **Negativas:**
  - **La cobertura es limitada**: en un local grande, parte del trabajo se hará fuera de alcance y se enviará después, así que el inventario del servidor puede ir unos minutos atrasado.
  - **El número de voluntarios conectados a la vez es limitado** por el punto de acceso de la laptop o del teléfono.
  - Con WPA2, quien conoce la contraseña del Wi-Fi podría leer el PIN de otro voluntario.
  - Cuando cambia el servidor, puede que los voluntarios tengan que volver a escanear el código QR de dirección.
- **Riesgos y cómo mitigarlos:**
  - **Un voluntario cierra la pestaña con registros pendientes:** avisar antes de cerrar y guardar los pendientes para enviarlos en cuanto la página vuelva a abrirse con señal.
  - **Alguien de fuera del centro conoce la contraseña del Wi-Fi:** cambiarla. Las cuentas siguen exigiendo PIN o contraseña ([ADR-0003](0003-usuarios-y-acceso.md)).
  - **Windows no deja activar el punto de acceso sin internet:** usar la opción B o Linux, según lo que muestre el prototipo.
  - **El teléfono que crea la red se queda sin batería** (opción B): elegir uno que pueda estar enchufado, y que el servidor avise cuando se pierde la conexión.

## Preguntas abiertas

Se resolverán en las entrevistas con centros de acopio y con un prototipo de red.

**En las entrevistas:**

- ¿Qué **tamaño** tiene el local? ¿Tiene **varios pisos** o edificios? ¿De qué son las **paredes**?
- ¿**Cuántos voluntarios registran a la vez**?
- ¿En qué zonas se trabaja más lejos de donde estaría la laptop?

**En el prototipo:**

- ¿Hasta dónde llega de verdad el punto de acceso de una laptop con Windows y de otra con Linux, medido con un teléfono barato?
- ¿Deja Windows activar el punto de acceso **sin ninguna conexión a internet**? ¿Lo puede activar la aplicación sola?
- ¿Cuántos dispositivos admite de verdad cada sistema y cada teléfono?
- ¿Qué teléfonos tienen **aislamiento de clientes** activado en su punto de acceso?
- ¿Admiten WPA3 los puntos de acceso de Windows y los teléfonos más comunes entre los voluntarios?
- En Android, ¿puede la aplicación crear el punto de acceso con el nombre y la contraseña del centro, o hay que hacerlo desde los ajustes? Esto importa si la réplica es un teléfono.
- ¿Puede un teléfono Android estar conectado al Wi-Fi de la laptop y a la vez compartirlo, para hacer de repetidor? Algunos modelos lo permiten.

## Referencias

- [ADR-0001: Modelo de despliegue](0001-modelo-de-despliegue.md), [ADR-0002: Continuidad del servidor local](0002-continuidad-del-servidor-local.md) y [ADR-0003: Usuarios y acceso](0003-usuarios-y-acceso.md).
- [Microsoft, *Use your Windows PC as a mobile hotspot*](https://support.microsoft.com/en-us/windows/use-your-windows-pc-as-a-mobile-hotspot-c89b0fad-72d5-41e8-f7ea-406ad9036b85). Cómo activar el punto de acceso de Windows y elegir la banda.
- [MDN, *Secure contexts*](https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts). Qué funciones del navegador exigen HTTPS.
- [ZXing, formato de código QR para redes Wi-Fi](https://github.com/zxing/zxing/wiki/Barcode-Contents#wi-fi-network-config-android-ios-11). El formato que reconocen las cámaras de Android e iOS.
- [Filippo Valsorda, *How Plex is doing HTTPS for all its users*](https://words.filippo.io/how-plex-is-doing-https-for-all-its-users/). Cómo Plex usa un dominio real para tener HTTPS en la red local (opción F).
- Martin Kleppmann, *Designing Data-Intensive Applications*, capítulo 5. Réplica a partir de un registro de cambios y cómo se pone al día una réplica nueva.
