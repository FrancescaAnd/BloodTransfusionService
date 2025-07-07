(define (problem blood-transfusion-example)
  (:domain blood-transfusion)
  
  (:objects
    donor1 donor2 donor3 donor4 donor5 donor6 donor7 donor8 - donor
    patient1 patient2 patient3 patient4 patient5 patient6 patient7 - patient
    center1 center2 center3 - center
    hospital1 hospital2 hospital3 - hospital
    A B AB O - bloodgroup
    pos neg - rhf
  )
  
  (:init
    ;; Location of donors
    (donor-at donor1 center1)
    (donor-at donor2 center1)
    (donor-at donor3 center1)
    (donor-at donor4 center2)
    (donor-at donor5 center2)
    (donor-at donor6 center3)
    (donor-at donor7 center3)
    (donor-at donor8 center3)
    
    
    ;; Donors physical parameters
    (= (donor-age donor1) 30)
    (= (donor-age donor2) 45)
    (= (donor-age donor3) 40)
    (= (donor-age donor4) 48)
    (= (donor-age donor5) 22)
    (= (donor-age donor6) 55)
    (= (donor-age donor7) 34)
    (= (donor-age donor8) 70) 
    
    (= (hemoglobin donor1) 13.0)
    (= (hemoglobin donor2) 14.0)
    (= (hemoglobin donor3) 15.0)
    (= (hemoglobin donor4) 13.0)
    (= (hemoglobin donor5) 10.0) 
    (= (hemoglobin donor6) 14.0)
    (= (hemoglobin donor7) 15.0)
    (= (hemoglobin donor8) 13.0)

    (= (max-pressure donor1) 190) 
    (= (min-pressure donor1) 80)
    (= (max-pressure donor2) 110)
    (= (min-pressure donor2) 70)
    (= (max-pressure donor3) 120)
    (= (min-pressure donor3) 80)
    (= (max-pressure donor4) 125)
    (= (min-pressure donor4) 88)
    (= (max-pressure donor5) 115)
    (= (min-pressure donor5) 67)
    (= (max-pressure donor6) 120)
    (= (min-pressure donor6) 76)
    (= (max-pressure donor7) 100)
    (= (min-pressure donor7) 85)
    (= (max-pressure donor8) 130)
    (= (min-pressure donor8) 70)
    
    ;; ABO blood group of donors
    (has-bloodgroup donor1 A)
    (has-bloodgroup donor2 O)
    (has-bloodgroup donor3 A)
    (has-bloodgroup donor4 B)
    (has-bloodgroup donor5 AB)
    (has-bloodgroup donor6 O)
    (has-bloodgroup donor7 AB)
    (has-bloodgroup donor8 A)
    
       
    ;; Rh factor of donors
    (has-rhf donor1 pos)
    (has-rhf donor2 neg)
    (has-rhf donor3 pos)
    (has-rhf donor4 pos)
    (has-rhf donor5 neg)
    (has-rhf donor6 pos)
    (has-rhf donor7 neg)
    (has-rhf donor8 neg)
        
    ;; Location of patient
    (patient-at patient1 hospital1)
    (patient-at patient2 hospital1)
    (patient-at patient3 hospital2)
    (patient-at patient4 hospital2)
    (patient-at patient5 hospital3)
    (patient-at patient6 hospital3)
    (patient-at patient7 hospital3)
        
   
    ;; Blood type and Rh factor of patient
    (has-bloodgroup patient1 O)
    (has-bloodgroup patient2 AB) 
    (has-bloodgroup patient3 B)
    (has-bloodgroup patient4 O)
    (has-bloodgroup patient5 A) 
    (has-bloodgroup patient6 AB)     
    (has-bloodgroup patient7 A)     
    (has-rhf patient1 pos)
    (has-rhf patient2 neg)
    (has-rhf patient3 neg)
    (has-rhf patient4 neg)
    (has-rhf patient5 neg)
    (has-rhf patient6 neg)
    (has-rhf patient7 pos)
    
    ;; Patient needs transfusion
    (needs-transfusion patient1)
    (needs-transfusion patient2)
    (needs-transfusion patient3)
    (needs-transfusion patient4)
    (needs-transfusion patient5)
    (needs-transfusion patient6)
    (needs-transfusion patient7)

    ;; Urgent transfusions
    (urgent patient1)
    (urgent patient4)
    (urgent patient7)
    
    ;; Avaiable bags in the centers
    (= (available-bags A pos center1) 0)
    (= (available-bags A neg center1) 0)
    (= (available-bags B pos center1) 0)
    (= (available-bags B neg center1) 0)
    (= (available-bags AB pos center1) 0)
    (= (available-bags AB neg center1) 0)
    (= (available-bags O pos center1) 0)
    (= (available-bags O neg center1) 0)
    
    (= (available-bags A pos center2) 0)
    (= (available-bags A neg center2) 0)
    (= (available-bags B pos center2) 0)
    (= (available-bags B neg center2) 0)
    (= (available-bags AB pos center2) 0)
    (= (available-bags AB neg center2) 0)
    (= (available-bags O pos center2) 0)
    (= (available-bags O neg center2) 0)
    
    (= (available-bags A pos center3) 0)
    (= (available-bags A neg center3) 1)
    (= (available-bags B pos center3) 0)
    (= (available-bags B neg center3) 0)
    (= (available-bags AB pos center3) 0)
    (= (available-bags AB neg center3) 0)
    (= (available-bags O pos center3) 0)
    (= (available-bags O neg center3) 0)

    
    ;; Avaiable bags in the hospitals
    (= (available-bags A pos hospital1) 0)
    (= (available-bags A neg hospital1) 0)
    (= (available-bags B pos hospital1) 0)
    (= (available-bags B neg hospital1) 1)
    (= (available-bags AB pos hospital1) 0)
    (= (available-bags AB neg hospital1) 0)
    (= (available-bags O pos hospital1) 0)
    (= (available-bags O neg hospital1) 0)
    
    (= (available-bags A pos hospital2) 0)
    (= (available-bags A neg hospital2) 0)
    (= (available-bags B pos hospital2) 0)
    (= (available-bags B neg hospital2) 1)
    (= (available-bags AB pos hospital2) 0)
    (= (available-bags AB neg hospital2) 0)
    (= (available-bags O pos hospital2) 0)
    (= (available-bags O neg hospital2) 0)
    
    (= (available-bags A pos hospital3) 0)
    (= (available-bags A neg hospital3) 1)
    (= (available-bags B pos hospital3) 0)
    (= (available-bags B neg hospital3) 0)
    (= (available-bags AB pos hospital3) 0)
    (= (available-bags AB neg hospital3) 1)
    (= (available-bags O pos hospital3) 0)
    (= (available-bags O neg hospital3) 0)
    
    
    ;; Hospitals supplies
    (= (supplies A pos hospital1) 0)
    (= (supplies A neg hospital1) 0)
    (= (supplies B pos hospital1) 0)
    (= (supplies B neg hospital1) 0)
    (= (supplies AB pos hospital1) 0)
    (= (supplies AB neg hospital1) 0)
    (= (supplies O pos hospital1) 0)
    (= (supplies O neg hospital1) 0)
    
    (= (supplies A pos hospital2) 0)
    (= (supplies A neg hospital2) 0)
    (= (supplies B pos hospital2) 0)
    (= (supplies B neg hospital2) 0)
    (= (supplies AB pos hospital2) 0)
    (= (supplies AB neg hospital2) 0)
    (= (supplies O pos hospital2) 0)
    (= (supplies O neg hospital2) 0)
    
    (= (supplies A pos hospital3) 0)
    (= (supplies A neg hospital3) 0)
    (= (supplies B pos hospital3) 0)
    (= (supplies B neg hospital3) 0)
    (= (supplies AB pos hospital3) 0)
    (= (supplies AB neg hospital3) 0)
    (= (supplies O pos hospital3) 0)
    (= (supplies O neg hospital3) 0)
    
     
    ;; Distances
    (= (distance center1 hospital1) 10)
    (= (distance center1 hospital2) 30)
    (= (distance center1 hospital3) 45)
    
    (= (distance center2 hospital1) 25)
    (= (distance center2 hospital2) 10)
    (= (distance center2 hospital3) 35)
    
    (= (distance center3 hospital1) 45)
    (= (distance center3 hospital2) 20)
    (= (distance center3 hospital3) 10)
    
    ;; Initialize total cost
    (= (total-cost) 0)
    (= (urgency-penalty) 0)

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
 )
)

(:metric minimize (+ (total-cost)(urgency-penalty)))
)


