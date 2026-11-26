# Sistema logístico para emergencias

Sistema de código abierto para registrar, coordinar y dar seguimiento público a los insumos que los centros de acopio reciben y distribuyen durante emergencias en Venezuela.

Es un proyecto de la **ITVN** (Iniciativa Tecnológica Venezolana para la Nación).

> **Estado actual:** Fase I, planteamiento del problema y propuesta. Todavía no hay código: el proyecto está entrando en su fase de investigación.

*[English summary below](#english-summary)*

## El problema

Tras los terremotos del 24 de junio de 2026, que golpearon con especial fuerza al estado La Guaira, miles de ciudadanos, instituciones y organizaciones abrieron centros de acopio en todo el país. Pero cada uno llevó sus propias cuentas, y no existió una vista común de qué había en cada centro, qué necesitaba cada zona ni qué había llegado realmente a su destino.

No existe una herramienta común que permita a los centros de acopio llevar sus cuentas, coordinarse entre sí y rendir cuentas ante quienes donan.

## La propuesta

El sistema tiene tres componentes:

| Componente | Función principal | Usuario |
|---|---|---|
| Sistema de inventario | Registro, clasificación y control de los insumos de cada centro de acopio. | Centros de acopio |
| Sistema central | Unificación y publicación de la información de todos los centros: qué tiene cada uno, qué necesita y qué se ha entregado. | ITVN |
| Sistema de seguimiento | Estado, ubicación y entrega de los insumos en tránsito. | Centros de acopio y conductores |

Se desarrollarán por etapas:

1. **Sistema de inventario para los centros de acopio**, con un seguimiento básico de los envíos.
2. **Sistema central**, que unifica y publica la información.
3. **Seguimiento del transporte**: conductor, vehículo, puntos de control del recorrido y costo aproximado.

## Documentos

- [Planteamiento del problema y propuesta (español)](docs/planteamiento.md)
- [Problem statement and proposal (English)](docs/proposal-en.md)
- [Decisiones de arquitectura](docs/adr/README.md)
- [Modelo de datos](docs/modelo-de-datos/README.md)

## Base tecnológica

El sistema de inventario debe funcionar sin internet: cada centro de acopio lo instala en una computadora, que funciona como servidor local, y los voluntarios se conectan a ella desde el navegador de sus teléfonos por la red local. Esta propuesta se explica en el [ADR-0001: Modelo de despliegue](docs/adr/0001-modelo-de-despliegue.md).

Sistemas existentes como [Boxtribute](https://github.com/boxwise/boxtribute), desarrollado por Stichting Boxwise, se toman como referencia por su modelo de datos y su experiencia en ayuda humanitaria. La tecnología concreta se decidirá en un próximo ADR.

## Cómo participar

El proyecto busca centros de acopio que quieran contar su experiencia, desarrolladores y organizaciones que trabajen en emergencias. Lee la [guía para participar](CONTRIBUTING.md) o abre un *issue* en este repositorio.

## Licencia

[Apache-2.0](LICENSE)

---

## English summary

An open-source system to record, coordinate and publicly track the supplies that collection centers (*centros de acopio*) receive and distribute during emergencies in Venezuela. It is a project of **ITVN** (*Iniciativa Tecnológica Venezolana para la Nación*, Venezuelan Technology Initiative for the Nation).

After the earthquakes of 24 June 2026, which hit the state of La Guaira especially hard, thousands of citizens, institutions and organizations opened collection centers across the country. Each one kept its own records, and there was no shared view of what each center had, what each area needed, or what actually reached its destination.

The system has three components, developed in stages:

1. **An inventory system for collection centers**, including basic shipment tracking.
2. **A central system** that consolidates and publishes the information of all centers.
3. **Transport tracking**: driver, vehicle, route checkpoints and approximate cost.

The project is currently in Phase I (problem statement and proposal) and is starting its research phase. The inventory system must work without internet: each collection center installs it on a computer that acts as a local server, and volunteers connect to it from their phones' browsers over the local network. Existing systems such as [Boxtribute](https://github.com/boxwise/boxtribute) serve as a reference for the data model.

Read the full document: [Problem statement and proposal](docs/proposal-en.md).
