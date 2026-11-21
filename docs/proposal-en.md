# Inventory System for National Emergencies

**Phase I: Problem Statement and Proposal**

*Iniciativa Tecnológica Venezolana para la Nación (ITVN) · Valencia, Carabobo, Venezuela*

*This is the English translation of the original Spanish document ([planteamiento.md](planteamiento.md)). Throughout the text, **collection center** translates the Spanish **centro de acopio**: a place, usually set up by volunteers, where donated supplies are received, sorted and stored before being sent to the affected areas. ITVN stands for **Iniciativa Tecnológica Venezolana para la Nación** (Venezuelan Technology Initiative for the Nation).*

## 1. Context

On 24 June 2026, two earthquakes of magnitude 7.2 and 7.5, only seconds apart, struck north-central Venezuela. The second one, with its epicenter off the coast of La Guaira, west of Catia La Mar, caused the greatest destruction in the state of La Guaira, formerly known as Vargas, which had already suffered the Vargas tragedy in 1999. The area was declared a disaster zone, and a state of emergency was declared across the country.

The response mobilized the whole country. Government agencies, United Nations agencies, the Church, universities and thousands of citizens opened collection centers in Caracas, in La Guaira and in other regions, and international aid arrived through the port of La Guaira. However, each actor kept its own records, and there was no shared view of what each collection center had, what each area needed, or what had actually reached its destination. Two months later, many collection centers had already closed and donations had dropped considerably, while the needs of the affected areas persisted[^1].

This mobilization showed the solidarity of Venezuelans, but it also revealed a gap: there is no common tool that allows collection centers to keep their records, coordinate with each other and be accountable to those who donate.

## 2. Problem Statement

National emergencies have shown an inability to organize supplies and to properly coordinate their distribution. These are some of the most recurring problems:

1. Collection centers without a proper system to keep records.
2. Collection centers that did use a system, but each one uses a different and usually improvised one, which later makes it difficult to read and consolidate the information.
3. Lack of information and organization for the distribution of supplies: there is no clear system to see the actual needs of each collection center, which leads to waste and logistical shortcomings.
4. Lack of information and traceability about what happens to the supplies: donors and civil society as a whole have the right to know where donated supplies go and what happens to them.
5. Lack of a tracking system to know where the supplies are.
6. Collection centers opened in an improvised way that generate distrust; there must be a clear organization that guarantees transparency in every process.

## 3. Objectives

### 3.1 General objective

To develop an open-source system to record, coordinate and publicly track the supplies that collection centers receive and distribute during national emergencies.

### 3.2 Specific objectives

1. To provide collection centers with a simple inventory tool that volunteers without technical training can use.
2. To consolidate the information of all collection centers in a central system with a common format.
3. To record and publish the needs of each collection center and each affected area, in order to guide donations and reduce waste.
4. To track each shipment from its departure until its delivery is confirmed, including the vehicle, the driver, the contents, the weight and the approximate cost of the transport.
5. To publish aggregated information on inventories, shipments and deliveries, in order to guarantee transparency to donors and civil society.
6. To validate the system with real collection centers through pilot tests and emergency drills.

## 4. Stakeholders

The system must meet the needs of everyone involved in the aid chain, not only those of the collection centers:

| Stakeholder | Role in the emergency | Relationship with the system |
|---|---|---|
| Collection centers (coordinators and volunteers) | Receive, sort, store and dispatch the supplies. | Record the inventory and the shipments. |
| Donors (individuals and companies) | Provide the supplies. | Consult public information on where their donations went. |
| Volunteer drivers | Transport the supplies to the affected areas. | Update the status and location of the shipment. |
| Receiving communities and shelters | Receive the supplies and know their own needs. | Confirm deliveries and record their needs. |
| Response institutions (Civil Protection, Venezuelan Red Cross, NGOs, United Nations agencies) | Coordinate the official emergency response. | Consult the information and, if they wish, join the system. |
| ITVN | Develops and maintains the system. | Manages the central system and the onboarding of collection centers. |
| Civil society | Follows the emergency response. | Consults the public information. |

## 5. Proposal

### 5.1 Overview

In light of the above, we propose a logistics inventory system for national emergencies. It must include an inventory system that addresses all the problems arising from recording supplies, as well as those that arise when sorting supplies and planning logistics. The system will be open source and freely accessible.

### 5.2 System components

To broaden its reach, the proposal distinguishes three interconnected components:

The first component is the inventory management system that each collection center uses individually. The second is the central system, managed by ITVN, which consolidates the information and properly tracks, reads and publishes the inventory status of the collection centers.

The third component is the tracking system, closely linked to the inventory system. From the inventory system, the collection center must update the status of the supplies: whether they are still in stock or have been sent elsewhere. If they have been sent, it must state what is being sent and in which vehicle. The corresponding driver must update their status and location: any problem or delay, their location and, finally, the successful delivery.

| Component | Main function | User |
|---|---|---|
| Inventory system (node) | Recording, sorting and control of the supplies of each collection center. | Collection centers |
| ITVN central system | Consolidation, reading, tracking and publication of the inventory status of the collection centers. | ITVN |
| Tracking system | Status, location and delivery of supplies in transit. | Collection centers and drivers |

### 5.3 Development stages

Although the three components form a single system, in practice each one is a separate project, with its own users and its own complexity. They will therefore be developed in stages:

1. **First stage: inventory system for collection centers.** This is the foundation for everything else: without reliable records at each collection center, there is no information to consolidate and no shipments to track. It will most likely build on an existing open-source solution, adapted to the Venezuelan context, depending on the results of the research phase. This stage already includes basic shipment tracking: what was sent, when it left, its current status (being prepared, sent or received) and what actually reached its destination.
2. **Second stage: central system.** It brings together the information of all collection centers in a common format and makes it public: what each center has, what each center and each affected area needs, and what has been delivered. This is what allows donors and citizens to know, for example, that one collection center needs water while another has a surplus.
3. **Third stage: transport tracking.** It extends the basic tracking of the first stage with information about the journey: the driver, the vehicle, the checkpoints along the route (departure, problems or delays, and arrival) and the approximate cost. It is left for a later stage because it involves other users, the volunteer drivers, and because it faces tougher conditions, such as use on the road and without connectivity, as well as its own risks, such as the security of the cargo.

### 5.4 Joining the central system

For the whole system to have a wider impact, every collection center that uses the inventory system must apply to join the central system managed by ITVN, which will process the application. Each collection center must provide verification information about the person in charge; only then will it join the ITVN central system.

This information will be used exclusively to verify the identity of the person in charge and as a contact channel. It will never be made public.

### 5.5 Relationship with existing institutions

The system aims to complement, not replace, the work of the institutions already involved in emergency response, such as Civil Protection, the Venezuelan Red Cross, non-governmental organizations and United Nations agencies. We will seek to establish coordination channels with them and to share public information in open, standard formats, so that they can use it without depending on the system.

## 6. Scope

The system covers:

- Recording and sorting the supplies of each collection center.
- Recording the needs of collection centers and affected areas.
- Recording shipments and tracking them until delivery is confirmed.
- Publishing aggregated information on inventories, needs, shipments and deliveries.

The system does not cover:

- Raising or managing monetary donations.
- Recording personal data of people affected by the disaster.
- Replacing the functions of the authorities or of response institutions.

## 7. Operating conditions

An emergency imposes conditions that the system must take into account from its design:

- **No or intermittent connectivity:** the system must allow recording information offline and synchronizing it once the connection is restored.
- **Power outages:** collection centers and drivers may go hours without electricity, so the system must work on phones with low battery and with minimal power consumption.
- **Low-end devices:** the system must work on modest phones and common browsers, without requiring special equipment.
- **Users without technical training:** the interface must be clear, be in Spanish, and be usable after a few minutes of explanation.
- **High volunteer turnover:** onboarding a new person must be quick and simple.
- **Cargo security:** a vehicle carrying supplies can be a target for theft, so its location must not be public while it is in transit.

## 8. Public information and data protection

Transparency is one of the purposes of the system, but not all information can be public. The principle is to publish what is needed for accountability and to protect anything that could put people or supplies at risk:

| Public information | Restricted information |
|---|---|
| Aggregated inventory of each collection center. | Personal data of collection center coordinators and drivers. |
| Needs of each collection center and each affected area. | Real-time location of vehicles. |
| Status of each shipment (being prepared, in transit, delivered). | Detailed routes while the shipment is in transit. |
| Totals delivered by area and by type of supply. | Contact details. |

In addition, the system will only collect the personal data strictly necessary for its operation.

## 9. Open questions

The following questions have no answer yet and must be resolved during the research phase:

1. **Availability:** if the central system becomes unavailable in the middle of an emergency, how will collection centers keep operating?
2. **Trust and governance:** who oversees the management of the central system? How can collection centers and civil society be assured that the data is used properly?
3. **Architecture:** should each collection center have its own system and synchronize it with the central one, or should all centers work on a single shared instance?
4. **Verification:** how can we confirm that a collection center and the person in charge are legitimate?
5. **Adoption:** how can we bring in collection centers that already work with other tools, such as spreadsheets or messaging apps?

## 10. Research phase plan

The next phase will aim to answer the questions above and to specify the system. To that end, the following activities are planned:

1. **Interviews with collection centers:** talk with at least three collection centers that have operated in real emergencies, to learn how they record, coordinate and distribute supplies.
2. **Documentation of past experiences:** gather what happened in recent emergencies to identify specific failures in the distribution of supplies.
3. **Outreach to response institutions:** present the project to the institutions working in emergencies, to learn about their needs and explore ways to coordinate.
4. **Prototype and drill:** build a prototype and test it with a collection center in an emergency drill.
5. **System specification:** based on the results above, prepare the Phase II document with the workflows, requirements and architecture of the system.

This is the general proposal for the logistics system for national emergencies. After the research phase, the behavior of the system will be specified in greater detail and rigor. For now, this is a foundation from which to start the research and the subsequent proposals.

[^1]: *¿Cómo seguir ayudando a La Guaira a dos meses de los terremotos?* (in Spanish), El Diario, 29 August 2026, <https://eldiario.com/2026/08/29/ayuda-la-guaira-terremotos/>.
