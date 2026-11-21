# Sistema de inventario para emergencias nacionales

**Fase I: planteamiento del problema y propuesta**

*Iniciativa Tecnológica Venezolana para la Nación (ITVN) · Valencia, Carabobo*

## 1. Contexto

El 24 de junio de 2026, dos terremotos de magnitud 7,2 y 7,5, separados por apenas unos segundos, sacudieron el centro-norte de Venezuela. El segundo, con epicentro frente a la costa de La Guaira, al oeste de Catia La Mar, causó la mayor destrucción en el estado La Guaira, el antiguo estado Vargas, que ya en 1999 había vivido la tragedia de Vargas. La zona fue declarada zona de desastre y se decretó el estado de emergencia en el país.

La respuesta movilizó a todo el país. Organismos del Estado, agencias de Naciones Unidas, la Iglesia, las universidades y miles de ciudadanos abrieron centros de acopio en Caracas, en La Guaira y en otras regiones, y llegó ayuda internacional a través del puerto de La Guaira. Sin embargo, cada actor llevó sus propias cuentas y no existió una vista común de qué había en cada centro de acopio, qué necesitaba cada zona ni qué había llegado realmente a su destino. Dos meses después, muchos centros de acopio ya habían cerrado y el volumen de donaciones había disminuido considerablemente, mientras las necesidades de las zonas afectadas persistían[^1].

Esta movilización demostró la solidaridad del venezolano, pero también una carencia: no existe una herramienta común que permita a los centros de acopio llevar sus cuentas, coordinarse entre sí y rendir cuentas ante quienes donan.

## 2. Planteamiento del problema

Ante emergencias nacionales se ha evidenciado una incapacidad de respuesta a la hora de organizar los insumos y de coordinar correctamente su distribución. A continuación se enumeran algunos de los problemas más recurrentes:

1. Centros de acopio sin un sistema adecuado para llevar cuentas.
2. Centros de acopio que sí emplearon un sistema, pero cada uno usa uno distinto y, por lo general, improvisado, lo que dificulta después la lectura y la unificación de la información correspondiente.
3. Falta de información y de organización para la distribución de los insumos: no hay un sistema claro que permita ver realmente cuáles son las necesidades de cada centro de acopio, lo que genera desperdicio y deficiencia logística.
4. Falta de información y de rastreo sobre qué sucede con los insumos: es derecho de los donantes y de toda la sociedad civil estar al tanto de a dónde van y qué sucede con los insumos donados.
5. Falta de un sistema de seguimiento (*tracking*) para conocer la ubicación de los insumos.
6. Centros de acopio abiertos improvisadamente que generan desconfianza; debe haber una organización clara que garantice la transparencia en cada proceso.

## 3. Objetivos

### 3.1 Objetivo general

Desarrollar un sistema de código abierto que permita registrar, coordinar y dar seguimiento público a los insumos que los centros de acopio reciben y distribuyen durante emergencias nacionales.

### 3.2 Objetivos específicos

1. Proveer a los centros de acopio una herramienta de inventario sencilla, que puedan usar voluntarios sin formación técnica.
2. Unificar la información de los centros de acopio en un sistema central con un formato común.
3. Registrar y publicar las necesidades de cada centro de acopio y de cada zona afectada, para orientar las donaciones y reducir el desperdicio.
4. Dar seguimiento a cada envío desde su salida hasta la confirmación de su entrega, incluyendo el vehículo, el conductor, el contenido, el peso y el costo aproximado del traslado.
5. Publicar información agregada sobre inventarios, envíos y entregas, para garantizar la transparencia ante los donantes y la sociedad civil.
6. Validar el sistema con centros de acopio reales mediante pruebas piloto y simulacros.

## 4. Actores involucrados

El sistema debe responder a las necesidades de todos los que participan en la cadena de ayuda, no solo a las de los centros de acopio:

| Actor | Rol en la emergencia | Relación con el sistema |
|---|---|---|
| Centros de acopio (responsables y voluntarios) | Reciben, clasifican, almacenan y despachan los insumos. | Registran el inventario y los envíos. |
| Donantes (personas y empresas) | Aportan los insumos. | Consultan la información pública sobre el destino de lo donado. |
| Conductores voluntarios | Trasladan los insumos a las zonas afectadas. | Actualizan el estado del envío y su ubicación. |
| Comunidades y refugios receptores | Reciben los insumos y conocen sus propias necesidades. | Confirman las entregas y registran sus necesidades. |
| Instituciones de respuesta (Protección Civil, Cruz Roja Venezolana, ONG, agencias de Naciones Unidas) | Coordinan la respuesta oficial ante la emergencia. | Consultan la información y, si lo desean, se integran al sistema. |
| ITVN | Desarrolla y mantiene el sistema. | Gestiona el sistema central y la vinculación de los centros. |
| Sociedad civil | Da seguimiento a la respuesta ante la emergencia. | Consulta la información pública. |

## 5. Propuesta

### 5.1 Descripción general

Visto lo planteado, se propone un proyecto de sistema de inventario logístico para emergencias nacionales. Este debe contar con un sistema de inventario que aborde todos los problemas consecuentes del propio registro de insumos, así como todos los que surgen a la hora de clasificar y planificar la logística. El sistema será de código abierto y de libre acceso.

### 5.2 Componentes del sistema

Para que el sistema tenga un alcance mayor, la propuesta distingue tres componentes articulados entre sí:

El primer componente es el sistema de gestión de inventario que emplea individualmente cada centro de acopio. El segundo es el sistema central, gestionado por la ITVN, que se encarga de unificar la información y de llevar el correcto rastreo, lectura y publicación del estado del inventario de los centros de acopio.

El tercer componente es el sistema de seguimiento, estrechamente relacionado con el sistema de inventario. Desde este último, el centro de acopio debe actualizar el estado de los insumos: si siguen en inventario o si han sido enviados a otra parte. De ser enviados, se debe justificar qué se está enviando y en qué vehículo. El conductor correspondiente debe actualizar su estado y ubicación, es decir: si surge algún inconveniente o retraso, la ubicación y, finalmente, el correcto despacho.

| Componente | Función principal | Usuario |
|---|---|---|
| Sistema de inventario (nodo) | Registro, clasificación y control de los insumos de cada centro de acopio. | Centros de acopio |
| Sistema central ITVN | Unificación, lectura, rastreo y publicación del estado del inventario de los centros de acopio. | ITVN |
| Sistema de seguimiento | Estado, ubicación y despacho de los insumos en tránsito. | Centros de acopio y conductores |

### 5.3 Etapas de desarrollo

Aunque los tres componentes forman un solo sistema, en la práctica cada uno es un proyecto distinto, con sus propios usuarios y su propia complejidad. Por ello se desarrollarán de forma escalonada:

1. **Primera etapa: sistema de inventario para los centros de acopio.** Es la base de todo lo demás: sin un registro confiable en cada centro de acopio no hay información que unificar ni envíos que seguir. Previsiblemente se partirá de una solución de código abierto existente, adaptada al contexto venezolano, según los resultados de la fase de investigación. Esta etapa incluye ya un seguimiento básico de los envíos: qué se envió, cuándo salió, en qué estado se encuentra (en preparación, enviado o recibido) y qué llegó realmente a su destino.
2. **Segunda etapa: sistema central.** Reúne la información de todos los centros de acopio en un formato común y la hace pública: qué tiene cada centro, qué necesita cada centro y cada zona afectada, y qué se ha entregado. Es lo que permite a donantes y ciudadanos saber, por ejemplo, que un centro de acopio necesita agua mientras otro tiene excedentes.
3. **Tercera etapa: seguimiento del transporte.** Amplía el seguimiento básico de la primera etapa con la información del traslado: el conductor, el vehículo, los puntos de control del recorrido (la salida, los inconvenientes o retrasos y la llegada) y el costo aproximado. Se deja para una etapa posterior porque involucra a otros usuarios, los conductores voluntarios, y porque enfrenta condiciones más exigentes, como el uso en carretera y sin conexión, y riesgos propios, como la seguridad de los cargamentos.

### 5.4 Vinculación de los centros de acopio al sistema central

Para que el conjunto tenga utilidad de mayor alcance, todo centro de acopio que use el sistema de inventario deberá solicitar su unión al sistema central gestionado por la ITVN, la cual se encargará de gestionar la solicitud. Cada centro de acopio deberá aportar información de verificación de la persona encargada, solo así un centro de acopio que emplee el sistema de inventario se unirá al sistema central de la ITVN.

Estos datos se emplearán exclusivamente para verificar la identidad del responsable y como canal de contacto. En ningún caso se publicarán.

### 5.5 Relación con las instituciones existentes

El sistema busca complementar, no sustituir, el trabajo de las instituciones que ya participan en la respuesta ante emergencias, como Protección Civil, la Cruz Roja Venezolana, las organizaciones no gubernamentales y las agencias de Naciones Unidas. Se buscará establecer canales de coordinación con ellas y compartir la información pública en formatos abiertos y estándar, de modo que puedan aprovecharla sin depender del sistema.

## 6. Alcance

El sistema contempla:

- El registro y la clasificación de los insumos de cada centro de acopio.
- El registro de las necesidades de los centros de acopio y de las zonas afectadas.
- El registro de los envíos y su seguimiento hasta la confirmación de la entrega.
- La publicación de información agregada sobre inventarios, necesidades, envíos y entregas.

El sistema no contempla:

- La recaudación ni la gestión de donaciones en dinero.
- El registro de datos personales de las personas damnificadas.
- La sustitución de las funciones de las autoridades ni de las instituciones de respuesta.

## 7. Condiciones de operación

Una emergencia impone condiciones que el sistema debe tener en cuenta desde su diseño:

- **Conectividad nula o intermitente:** el sistema debe permitir registrar información sin conexión y sincronizarla cuando esta se recupere.
- **Cortes eléctricos:** los centros de acopio y los conductores pueden pasar horas sin electricidad, por lo que el sistema debe funcionar en teléfonos con poca batería y con un consumo mínimo.
- **Dispositivos de gama baja:** el sistema debe funcionar en teléfonos modestos y en navegadores comunes, sin requerir equipos especiales.
- **Usuarios sin formación técnica:** la interfaz debe ser clara, estar en español y poder usarse con una explicación de pocos minutos.
- **Alta rotación de voluntarios:** incorporar a una persona nueva debe ser rápido y sencillo.
- **Seguridad de los cargamentos:** un vehículo con insumos puede ser blanco de robos, por lo que su ubicación no debe ser pública mientras se encuentre en tránsito.

## 8. Información pública y protección de datos

La transparencia es uno de los fines del sistema, pero no toda la información puede ser pública. El criterio es publicar lo necesario para rendir cuentas y proteger todo lo que pueda poner en riesgo a las personas o a los insumos:

| Información pública | Información restringida |
|---|---|
| Inventario agregado de cada centro de acopio. | Datos personales de los responsables de los centros y de los conductores. |
| Necesidades de cada centro de acopio y de cada zona afectada. | Ubicación en tiempo real de los vehículos. |
| Estado de cada envío (en preparación, en tránsito, entregado). | Rutas detalladas mientras el envío se encuentra en tránsito. |
| Totales entregados por zona y por tipo de insumo. | Datos de contacto. |

Asimismo, el sistema solo recopilará los datos personales estrictamente necesarios para su funcionamiento.

## 9. Preguntas abiertas

Las siguientes preguntas no tienen todavía una respuesta y deberán resolverse durante la fase de investigación:

1. **Disponibilidad:** si el sistema central deja de estar disponible en plena emergencia, ¿cómo seguirán operando los centros de acopio?
2. **Confianza y gobernanza:** ¿quién supervisa la gestión del sistema central? ¿Cómo se garantiza ante los centros de acopio y la sociedad civil que los datos se usan correctamente?
3. **Arquitectura:** ¿conviene que cada centro de acopio tenga su propio sistema y lo sincronice con el central, o que todos los centros trabajen en una misma instancia compartida?
4. **Verificación:** ¿cómo se comprueba que un centro de acopio y su responsable son legítimos?
5. **Adopción:** ¿cómo se incorpora a los centros de acopio que ya trabajan con otras herramientas, como hojas de cálculo o aplicaciones de mensajería?

## 10. Plan de la fase de investigación

La siguiente fase tendrá como objetivo responder a las preguntas anteriores y especificar el sistema. Para ello se plantean las siguientes actividades:

1. **Entrevistas con centros de acopio:** conversar con al menos tres centros de acopio que hayan operado en emergencias reales, para conocer cómo registran, coordinan y distribuyen los insumos.
2. **Documentación de experiencias previas:** recopilar lo ocurrido en emergencias recientes para identificar fallas concretas en la distribución de los insumos.
3. **Acercamiento a instituciones de respuesta:** presentar el proyecto a las instituciones que trabajan en emergencias para conocer sus necesidades y explorar formas de coordinación.
4. **Prototipo y simulacro:** construir un prototipo y probarlo con un centro de acopio en un simulacro de emergencia.
5. **Especificación del sistema:** con los resultados anteriores, elaborar el documento de la Fase II con los flujos de trabajo, los requisitos y la arquitectura del sistema.

Este es el planteamiento general del sistema logístico para emergencias nacionales. Posteriormente, tras la fase de investigación, se especificará con mayor detalle y rigor el comportamiento del sistema. Por ahora, esta es una base de la cual partir y con la cual iniciar la investigación y planteamientos posteriores.

[^1]: «¿Cómo seguir ayudando a La Guaira a dos meses de los terremotos?», El Diario, 29 de agosto de 2026, <https://eldiario.com/2026/08/29/ayuda-la-guaira-terremotos/>.
