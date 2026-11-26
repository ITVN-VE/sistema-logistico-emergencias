# Centro y usuarios

Parte del [modelo de datos](README.md) del sistema de inventario: el centro de acopio que usa cada instalación y las personas que trabajan con el sistema. Sigue los [principios y convenciones](README.md#principios) comunes.

## Esquema

Estas tablas están definidas en el [esquema](esquema.dbml) del modelo de datos, en las secciones *Centro* y *Acceso*. Este documento explica cada campo; el esquema es la definición exacta. Para verlas como diagrama, ver [cómo ver el esquema](README.md#el-esquema).

## Centro

El centro de acopio que usa esta instalación. Hay uno por instalación.

| Campo | Tipo | Obligatorio | Descripción |
|---|---|---|---|
| `id` | UUID v7 | Sí | Identificador único del centro. Se genera al instalar. |
| `nombre` | Texto | Sí | Por ejemplo, "Centro de acopio Parroquia San Juan". No es único: puede haber dos centros con el mismo nombre. |
| `tipo` | Lista | Sí | Centro de acopio, albergue, punto de distribución u otro. Lista provisional, a confirmar en las entrevistas. |
| `organizacion` | Texto | No | Quién opera el centro: una parroquia, una ONG, un consejo comunal… En la segunda etapa podrá convertirse en una tabla propia. |
| `responsable_id` | Usuario | Sí | El contacto principal del centro. Debe ser un usuario con rol de coordinador. Al instalar es quien crea el centro, pero puede cambiar después. |
| `pais` | Código ISO 3166-1 | Sí | Siempre `VE` por ahora. No se muestra en la pantalla. |
| `entidad_federal` | Código ISO 3166-2 | Sí | Se elige de la [lista de entidades federales](#entidades-federales). |
| `municipio` | Texto | Sí | Por ahora, texto libre. Ver *Preguntas abiertas*. |
| `parroquia` | Texto | No | Por ahora, texto libre. |
| `direccion` | Texto | No | Dirección del centro. |
| `punto_referencia` | Texto | No | Por ejemplo, "frente a la panadería La Esquina". |
| `telefono` | Texto | No | Teléfono de contacto del centro, en formato internacional: `+582121234567`. |
| `situacion` | Lista | Sí | `activo`, `en_pausa` o `cerrado`. Un centro nunca se borra: se cierra. |
| `creado_en` | Fecha y hora (UTC) | Sí | Cuándo se registró el centro en el sistema. Se rellena sola. |
| `actualizado_en` | Fecha y hora (UTC) | Sí | Último cambio en los datos del centro. Se rellena sola. |

## Usuario

Cada persona que usa el sistema del centro: voluntarios y coordinadores. Cómo entran, cómo recuperan el acceso y qué puede hacer cada rol se explica en el [ADR-0003: Usuarios y acceso](../adr/0003-usuarios-y-acceso.md).

| Campo | Tipo | Obligatorio | Descripción |
|---|---|---|---|
| `id` | UUID v7 | Sí | Identificador único del usuario. |
| `nombre_completo` | Texto | Sí | Nombre y apellido. |
| `telefono` | Texto | Sí | Con él entra al sistema. Obligatorio y único, en formato internacional: `+584141234567`. |
| `correo` | Texto | No | Dato de contacto. Si se indica, es único. |
| `rol` | Lista | Sí | `voluntario` o `coordinador`. |
| `credencial_hash` | Texto | Sí | El PIN (voluntarios) o la contraseña (coordinadores), guardado con Argon2id. Nunca se guarda tal cual. |
| `requiere_cambio` | Sí o no | Sí | Si es sí, al entrar debe elegir un PIN o una contraseña nuevos. Se usa cuando un coordinador le asigna uno temporal. |
| `situacion` | Lista | Sí | `activo` o `desactivado`. Un usuario nunca se borra: se desactiva, y sus sesiones abiertas se cierran. |
| `intentos_fallidos` | Número | Sí | Intentos de entrada fallidos seguidos. Vuelve a cero al entrar bien. |
| `bloqueado_hasta` | Fecha y hora (UTC) | No | Si tiene valor, no puede entrar hasta esa hora. |
| `ultimo_acceso` | Fecha y hora (UTC) | No | La última vez que entró. |
| `creado_en` | Fecha y hora (UTC) | Sí | Se rellena sola. |
| `actualizado_en` | Fecha y hora (UTC) | Sí | Se rellena sola. |

No se guarda la fecha de nacimiento, la cédula ni otros datos personales que el sistema no necesita.

## Entidades federales

Lista fija incluida en la aplicación, con los códigos de la norma [ISO 3166-2:VE](https://www.iso.org/obp/ui/#iso:code:3166:VE): 23 estados, el Distrito Capital y las Dependencias Federales. El campo `entidad_federal` guarda el código.

| Código | Nombre |
|---|---|
| `VE-A` | Distrito Capital |
| `VE-B` | Anzoátegui |
| `VE-C` | Apure |
| `VE-D` | Aragua |
| `VE-E` | Barinas |
| `VE-F` | Bolívar |
| `VE-G` | Carabobo |
| `VE-H` | Cojedes |
| `VE-I` | Falcón |
| `VE-J` | Guárico |
| `VE-K` | Lara |
| `VE-L` | Mérida |
| `VE-M` | Miranda |
| `VE-N` | Monagas |
| `VE-O` | Nueva Esparta |
| `VE-P` | Portuguesa |
| `VE-R` | Sucre |
| `VE-S` | Táchira |
| `VE-T` | Trujillo |
| `VE-U` | Yaracuy |
| `VE-V` | Zulia |
| `VE-W` | Dependencias Federales |
| `VE-X` | La Guaira |
| `VE-Y` | Delta Amacuro |
| `VE-Z` | Amazonas |

La norma no usa el código `VE-Q`. `VE-X` corresponde al antiguo estado Vargas, que la norma renombró como La Guaira en 2020.

## Preguntas abiertas

- ¿Qué **tipos de centro** existen en la práctica? La lista actual es provisional.
- ¿Conviene usar desde ya los **códigos oficiales de municipios y parroquias** en lugar de texto libre? Harían más fiables las estadísticas por zona, pero obligan a incluir y mantener una lista de más de 300 municipios.
