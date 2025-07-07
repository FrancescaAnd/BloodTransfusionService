 (define (problem blood-transfusion-example)
  (:domain blood-transfusion)
  
  (:objects
    donor1 donor2 - donor
    patient1 patient2 - patient
    center1 - center
    hospital1 hospital2 - hospital
    A B AB O - bloodgroup
    pos neg - rhf
  )
  
  (:init
    ;; Locations of donors
    (donor-at donor1 center1)
    (donor-at donor2 center1)

    ;; Donors physical parameters
    (= (donor-age donor1) 30)
    (= (donor-age donor2) 45)
    (= (hemoglobin donor1) 13.0)
    (= (hemoglobin donor2) 10.0)
    (= (max-pressure donor1) 120)
    (= (min-pressure donor1) 80)
    (= (max-pressure donor2) 190)
    (= (min-pressure donor2) 70)
    
    ;; ABO blood group of donors
    (has-bloodgroup donor1 A)
    (has-bloodgroup donor2 AB)
    
    ;; Rh factor of donors
    (has-rhf donor1 neg)
    (has-rhf donor2 pos)
        
    ;; Location of patient
    (patient-at patient1 hospital1)
    (patient-at patient2 hospital2)
        
    ;; Blood type and Rh factor of patient
    (has-bloodgroup patient1 B)
    (has-rhf patient1 pos)
    (has-bloodgroup patient2 AB)
    (has-rhf patient2 neg)
    
    ;; Patient needs transfusion
    (needs-transfusion patient1)
    (needs-transfusion patient2)
   
    ;; Avaiable bags in the centers
    (= (available-bags A pos center1) 0)
    (= (available-bags A neg center1) 0)
    (= (available-bags B pos center1) 0)
    (= (available-bags B neg center1) 0)
    (= (available-bags AB pos center1) 0)
    (= (available-bags AB neg center1) 0)
    (= (available-bags O pos center1) 0)
    (= (available-bags O neg center1) 0)
    
  
    ;; Avaiable bags in the hospitals
    (= (available-bags A pos hospital1) 0)
    (= (available-bags A neg hospital1) 0)
    (= (available-bags B pos hospital1) 0)
    (= (available-bags B neg hospital1) 0)
    (= (available-bags AB pos hospital1) 0)
    (= (available-bags AB neg hospital1) 0)
    (= (available-bags O pos hospital1) 1)
    (= (available-bags O neg hospital1) 0)
    
    (= (available-bags A pos hospital2) 0)
    (= (available-bags A neg hospital2) 0)
    (= (available-bags B pos hospital2) 0)
    (= (available-bags B neg hospital2) 0)
    (= (available-bags AB pos hospital2) 0)
    (= (available-bags AB neg hospital2) 0)
    (= (available-bags O pos hospital2) 0)
    (= (available-bags O neg hospital2) 0)
    
      
    ;; Distances (same in this instance)
    (= (distance center1 hospital1) 100)
    (= (distance center1 hospital2) 100)
    
    ;; Initialize total cost
    (= (total-cost) 0)
    
    ;; Blood compatibility facts
    (abo-compatible A A)
    (abo-compatible A O)
    (abo-compatible O O)
    (abo-compatible B B)
    (abo-compatible B O)

    (abo-compatible AB A)
    (abo-compatible AB B)
    (abo-compatible AB AB)
    (abo-compatible AB O)
    
    (rh-compatible pos pos)
    (rh-compatible neg neg)
    (rh-compatible pos neg) 
 )
  
  
(:goal
  (and
    (forall (?p - patient)
      (not (needs-transfusion ?p))
    )
    (forall (?d - donor)
      (or
        (and (accepted ?d) (donated ?d) (not (rejected ?d)))
        (and (not (accepted ?d)) (rejected ?d))
    )
   )
 ))

(:metric minimize (total-cost))
)
