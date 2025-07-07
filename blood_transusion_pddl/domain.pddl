(define (domain blood-transfusion)
  (:requirements :adl :typing) 

  (:types
    object
    blood-carrier - object
    donor patient - blood-carrier
    location - object
    hospital center - location
    bloodgroup  - object
    rhf - object
  )

  (:predicates
    ;; locations
    (donor-at ?d - donor ?c - center)
    (patient-at ?p - patient ?h - hospital)

    ;; blood type properties
    (has-bloodgroup ?x - blood-carrier ?bg - bloodgroup)
    (has-rhf ?x - blood-carrier ?rh - rhf)

    ;; donor status
    (accepted ?d - donor)
    (rejected ?d - donor)
    (donated ?d - donor)

    ;; patient status
    (needs-transfusion ?p - patient)
    (urgent ?p - patient)
    (bag-assigned ?p - patient)

    ;; blood compatibility predicates 
    (rh-compatible ?prhf ?brhf - rhf)
    (abo-compatible ?pabo ?babo - bloodgroup)
  )

  (:functions
    ;; donor physical parameters
    (donor-age ?d - donor)
    (max-pressure ?d - donor)
    (min-pressure ?d - donor)
    (hemoglobin ?d - donor)

    ;; available blood units at a location
    (available-bags ?bg - bloodgroup ?rh - rhf ?l - location)
    (supplies ?bg - bloodgroup ?rh - rhf ?h - hospital)

    ;; distance and total cost
    (distance ?from - center ?to - hospital)
    (total-cost)
    (urgency-penalty)
  )

  ;; Actions for checking donor eligibility
  (:action accept
    :parameters (?d - donor)
    :precondition (and
      (>= (donor-age ?d) 18)
      (<= (donor-age ?d) 65)
      (>= (hemoglobin ?d) 12.5)
      (>= (max-pressure ?d) 90)
      (<= (max-pressure ?d) 140)
      (>= (min-pressure ?d) 60)
      (<= (min-pressure ?d) 90)
    )
    :effect (and
      (accepted ?d)
      (increase (total-cost) 400)
    )
  )
  
   (:action reject
    :parameters (?d - donor)
    :precondition (and (or
      (< (donor-age ?d) 18)
      (> (donor-age ?d) 65)
      (< (hemoglobin ?d) 12.5)
      (< (max-pressure ?d) 90)
      (> (max-pressure ?d) 140)
      (< (min-pressure ?d) 60)
      (> (min-pressure ?d) 90))
    )
    :effect (and
      (rejected ?d)
      (increase (total-cost) 500)
    )
  )
  
  ;; Action for donating blood
  (:action donate
    :parameters (?d - donor ?bg - bloodgroup ?rh - rhf ?c - center)
    :precondition (and
      (donor-at ?d ?c)
      (not (donated ?d))
      (accepted ?d)
      (has-bloodgroup ?d ?bg)
      (has-rhf ?d ?rh)
    )
    :effect (and
      (donated ?d)
      (increase (available-bags ?bg ?rh ?c) 1)
      (increase (total-cost) 200)
    )
  )

;; Action for performing transfusion
(:action transfuse
  :parameters (?p - patient ?h - hospital ?bg - bloodgroup ?rh - rhf ?pbg - bloodgroup ?prh - rhf)
  :precondition (and
    (not (urgent ?p))
    (patient-at ?p ?h)
    (needs-transfusion ?p)
    (has-bloodgroup ?p ?pbg)
    (has-rhf ?p ?prh)
    (abo-compatible ?pbg ?bg)
    (rh-compatible ?prh ?rh)
    (> (available-bags ?bg ?rh ?h) 0)
  )
  :effect (and
    (not (needs-transfusion ?p))
    (decrease (available-bags ?bg ?rh ?h) 1)
    (increase (urgency-penalty) 20)
    (increase (total-cost) 100)
   )
)

;; Action for performing transfusion
(:action transfuse-urgently-supply
  :parameters (?p - patient ?h - hospital ?bg - bloodgroup 
               ?rh - rhf ?pbg - bloodgroup ?prh - rhf)
  :precondition (and
    (urgent ?p)
    (patient-at ?p ?h)
    (needs-transfusion ?p)
    (has-bloodgroup ?p ?pbg)
    (has-rhf ?p ?prh)
    (abo-compatible ?pbg ?bg)
    (rh-compatible ?prh ?rh)
    (> (supplies ?bg ?rh ?h) 0)
    (<= (available-bags ?bg ?rh ?h) 0)
  )
  :effect (and
    (not (needs-transfusion ?p))
    (decrease (supplies ?bg ?rh ?h) 1)
    (increase (urgency-penalty) 0)
    (increase (total-cost) 100)
   )
)

;; Action for performing transfusion in emergency cases
(:action transfuse-urgently
  :parameters (?p - patient ?h - hospital ?bg - bloodgroup ?rh - rhf ?pbg - bloodgroup ?prh - rhf)
  :precondition (and
   (urgent ?p)
   (patient-at ?p ?h)
   (needs-transfusion ?p)
   (has-bloodgroup ?p ?pbg)
   (has-rhf ?p ?prh)
   (abo-compatible ?pbg ?bg)
   (rh-compatible ?prh ?rh)
   (> (available-bags ?bg ?rh ?h) 0)
 )
 :effect (and
   (not (needs-transfusion ?p))
   (decrease (available-bags ?bg ?rh ?h) 1)
   (increase (urgency-penalty) 0)
  )
)

;; Action for moving a blood bag from a center to an hospital
(:action moveto
  :parameters (?from - center ?to - hospital ?bg - bloodgroup ?rh - rhf ?p - patient)
  :precondition (and
    (> (available-bags ?bg ?rh ?from) 0)
    (patient-at ?p ?to)
    (not (bag-assigned ?p))
    (needs-transfusion ?p)
    (exists (?pbg - bloodgroup ?prh - rhf)
      (and
         (has-bloodgroup ?p ?pbg)
         (has-rhf ?p ?prh)
         (abo-compatible ?pbg ?bg)
         (rh-compatible ?prh ?rh)
       )
  ))
  :effect (and
    (bag-assigned ?p)
    (decrease (available-bags ?bg ?rh ?from) 1)
    (increase (available-bags ?bg ?rh ?to) 1)
    (increase (total-cost) (* 10 (distance ?from ?to)))
   )
  )
  
  
)







