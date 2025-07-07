# *Planning and Reasoning Project - Blood Trasfusion Service*
The **Blood Transfusion Service** project focuses on automating the coordination of blood donations and transfusions in a multi-hospital environment. 
The goal is to ensure **eligible donations** and **compatible blood delivery**, while minimizing transport costs 
and prioritizing **urgent transfusions**.

The overall system is inspired by real-world blood bank logistics, by considering **donor eligibility, hospital stocks, patient conditions**, and **transportation logistics**.
The project uses **PDDL** for high-level planning and **Situation Calculus with IndiGolog** for reactive and procedural reasoning.

## Table of Contents
1. [PDDL Domain](#1-domain)
2. [PDDL Problem Instances](#2-pddl-problem-instances)
3. [PDDL Planner and Heuristics](#3-pddl-planner-and-heuristics)
4. [IndiGolog Reasoning Tasks](#4-Indigolog-reasoning-tasks)
5. [Running the system](#5-running-the-system)



## 1. PDDL Domain 

### Domain Overview
The domain models the management of blood donations and transfusions between donors
and patients across various medical centers and hospitals.
- Donors and patients are associated with specific locations: donors are found at donation
**centers**, while patients are located in **hospitals**.


- Each individual (whether donor or patient) has a defined blood type, consisting of an
**ABO blood group** (A, B, AB, or 0) and an **Rh factor** (positive or negative).


- Donors are considered eligible for donating if they meet certain health criteria, such as
age range, blood pressure, and hemoglobin level; hence, with respect to these parameters, they are either **accepted** or **rejected** for the donation.
 

- Once a donor gives blood, it is marked as having donated and a **blood bag** with donor blood type is stored in the
center where the donor is.


- At each location (hospital or center), the system keeps track of how many blood bags for
each blood type and Rh factor are available.


- Compatibility rules exist between the blood bags and patient's blood types. For a
transfusion to be performed, both the ABO group and the Rh factor must be compatible.


- All available centers could provide to each hospital the necessary blood bags. The
system, however, tries to **minimize transportation costs** by choosing blood bags from the
center closest to the hospital’s request.


- Some patients are marked as **urgent**, since they need immediately the transfusion. Therefore, the system manages the assignment and
transfer of blood bags to give priority to such patients.

### Actions
The domain includes several actions to manage donor eligibility, blood donation, transport of
blood units, and transfusion to patients

- `accept`, `reject`: Evaluates donor eligibility
- `donate`: Performs donation and updates center stock.
- `moveto`: Transports blood bags from centers to hospitals.
- `transfuse`: Executes a transfusion if compatible blood is available in the hospital.
- `transfuse-urgently`: Executes a urgent transfusion if compatible blood is available in the hospital.
- `transfuse-urgently-supply`: Executes a urgent transfusion using the emergency supplies in the hospital.


## 2. PDDL Problem Instances

1. **Basic Scenario**: Two donors and two patients, three locations, same distances and no urgency cases 

   **Pb1.** Action cost minimization.


2. **Intermediate Scenarios**: Four donors and four patients, four locations, different distances 

   **Pb2.** **Transport cost minimization**.

   **Pb3.** Transport cost minimization + **urgent cases** (emergency supplies unavailable).

   **Pb4.** Transport cost minimization + urgent cases (**emergency supplies available**).


3. **Advanced Scenario**: More donors and patients, more locations.
   


## 3. PDDL Planner and Heuristics

The system uses **ENHSP-19** automated planning system, applying and evaluating the following configurations: `sat-hadd`, `opt-blind`, and `opt-hmax`.

For running the system, you have to download the All the ENHSP-19 folder and clone the .pddl files (domain and problems) inside the `dist-19` folder.
The general command to be executed is the following: 

```bash
java -Xmx16G -jar "enhsp-19.jar" -o <domain_file> -f <problem_file> -planner <configuration>
```

For instance:
```bash
java -Xmx16G -jar "enhsp-19.jar" -o domain.pddl -f problem4.pddl -planner opt-blind 
```

**Note:** `-Xmx16G` option is used to set the maximum heap size, for mitigating `OutOfMemoryError` issue.


## 4. IndiGolog Reasoning Tasks

The project extends beyond planning with **procedural and reactive reasoning** using IndiGolog. It supports real-time decision-making and handles **exogenous events** such as sudden donor unavailability or new emergency patients.




### Controllers 

- **Basic**: A deterministic algorithm to reach the goal, by serving all donors and patients.
- **Reactive Controller**: Interrupt-driven strategy to manage exogenous events: 
  - **Emergency** transfusions 
  - **Sudden unavailability** of already checked donors
  - **Abrupt changes** in healty conditions of donors

## 5. Running the System
For running the system, it is mandatory to copy the `blood_transfusion_pl` repository inside the Indigolog official folder as follows:
```graphql
    indigolog
    │── blood_transfusion_pl/         #project repository                 
    │   │── blood_transfusion.pl        
    │   └── main.pl  
    │── devices/                
    │── doc/                
    │── eval/                
    │── examples/                
    │── interpreters/                
    │── lib/                
    │── config.pl
    │── LICENCE                
    └── README.md                

```
Then, run the following command inside the `indigolog` folder:

```bash
swipl config.pl blood_transfusion_pl/main.pl
```
The legality task and projection task can be executed by running the following commands:

```bash
legality.
```

```bash
projection.
```

For running the controllers:
```bash
    main.
```
Then, select `basic` or `reactive` controller. For example:
```bash
   ?- main.
   Controllers available: [basic,reactive]
   1. basic
   2. reactive

   Select controller: 2.
```
