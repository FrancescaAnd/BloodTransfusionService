 % IndiGolog translation of the blood transfusion domain
:- dynamic controller/1.
:- discontiguous
    fun_fluent/1,
    rel_fluent/1,
    proc/2,
    initially/2,
    causes_true/3,
    causes_false/3.

% There is nothing to do caching on (required because cache/1 is static)
cache(_) :- fail.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -------------------- PREDICATES ---------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Donors, patients, centers e hospitals
donor(donor1). donor(donor2). donor(donor3). donor(donor4).
patient(patient1). patient(patient2). patient(patient3). patient(patient4).
center(center1). center(center2).
hospital(hospital1). hospital(hospital2).
bloodgroup(a). bloodgroup(b). bloodgroup(ab). bloodgroup(o).
rhf(pos). rhf(neg).

% Compatibility (modeled as predicates)
abo_compatible(a, a). abo_compatible(a, o).
abo_compatible(b, b). abo_compatible(b, o).
abo_compatible(ab, a). abo_compatible(ab, b).
abo_compatible(ab, ab). abo_compatible(ab, o). abo_compatible(o, o).
rh_compatible(pos, pos). rh_compatible(neg, neg). rh_compatible(pos, neg).

% Blood groups 
has_bloodgroup(donor1, a). has_bloodgroup(donor2, o). 
has_bloodgroup(donor3, o). has_bloodgroup(donor4, o). 
has_bloodgroup(patient1, b). has_bloodgroup(patient2, a). 
has_bloodgroup(patient3, b). has_bloodgroup(patient4, o).

% Rh factor
has_rhf(donor1, pos). has_rhf(donor2, neg).
has_rhf(donor3, neg). has_rhf(donor4, pos).
has_rhf(patient1, neg). has_rhf(patient2, pos). 
has_rhf(patient3, pos). has_rhf(patient4, neg).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------------------- FLUENTS ------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Relational fluents
rel_fluent(donor_at(D, C)) :- donor(D), center(C).
rel_fluent(patient_at(P, H)) :- patient(P), hospital(H).
rel_fluent(eligible(D)) :- donor(D).
rel_fluent(donated(D)) :- donor(D).
rel_fluent(checked(D)) :- donor(D).
rel_fluent(needs_transfusion(P)) :- patient(P).
rel_fluent(urgent(P)) :- patient(P).
rel_fluent(some_exo).

% Functional fluents
fun_fluent(available_bags(BG, RH, L)) :- bloodgroup(BG), rhf(RH), (center(L) ; hospital(L)).
fun_fluent(donor_age(D)) :- donor(D).
fun_fluent(hemoglobin(D)) :- donor(D).
fun_fluent(max_pressure(D)) :- donor(D).
fun_fluent(min_pressure(D)) :- donor(D).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -------------------- INITIAL SITUATION -------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial situation 
initially(donor_at(donor1, center1), true).
initially(donor_at(donor2, center1), true).
initially(donor_at(donor3, center2), true).
initially(donor_at(donor4, center2), true).

initially(donor_age(donor1), 30).
initially(hemoglobin(donor1), 13.0).
initially(max_pressure(donor1), 120).
initially(min_pressure(donor1), 80).

initially(donor_age(donor2), 45).
initially(hemoglobin(donor2), 10).
initially(max_pressure(donor2), 110).
initially(min_pressure(donor2), 70).

initially(donor_age(donor3), 40).
initially(hemoglobin(donor3), 15.0).
initially(max_pressure(donor3), 120).
initially(min_pressure(donor3), 80).

initially(donor_age(donor4), 40).
initially(hemoglobin(donor4), 13.0).
initially(max_pressure(donor4), 110).
initially(min_pressure(donor4), 80).

initially(checked(D), false) :- donor(D), member(D, [donor1, donor2, donor3, donor4]).
initially(checked(D), true) :- donor(D), \+ initially(donor(D), false).

initially(eligible(D), false) :- donor(D), member(D, [donor1, donor2, donor3, donor4]).
initially(eligible(D), true) :- donor(D), \+ initially(donor(D), false).

initially(donated(D), false) :- donor(D), member(D, [donor1, donor2, donor3, donor4]).
initially(donated(D), true) :- donor(D), \+ initially(donor(D), false).

initially(patient_at(patient1, hospital1), true).
initially(patient_at(patient2, hospital1), true).
initially(patient_at(patient3, hospital2), true).
initially(patient_at(patient4, hospital2), true).

initially(needs_transfusion(P), true) :- patient(P), member(P, [patient1, patient2, patient3, patient4]).
initially(needs_transfusion(P), false) :- patient(P), \+ initially(patient(P), true).

initially(urgent(patient1), false).
initially(urgent(patient2), true).
initially(urgent(patient3), false).
initially(urgent(patient4), true).

initially(available_bags(a, pos, center1), 0).
initially(available_bags(a, neg, center1), 0).
initially(available_bags(b, pos, center1), 0).
initially(available_bags(b, neg, center1), 0).
initially(available_bags(ab, pos, center1), 0).
initially(available_bags(ab, neg, center1), 0).
initially(available_bags(o, pos, center1), 0).
initially(available_bags(o, neg, center1), 2).
initially(available_bags(a, pos, center2), 0).
initially(available_bags(a, neg, center2), 0).
initially(available_bags(b, pos, center2), 0).
initially(available_bags(b, neg, center2), 0).
initially(available_bags(ab, pos, center2), 0).
initially(available_bags(ab, neg, center2), 0).
initially(available_bags(o, pos, center2), 0).
initially(available_bags(o, neg, center2), 0).
initially(available_bags(a, pos, hospital1), 0).
initially(available_bags(a, neg, hospital1), 0).
initially(available_bags(b, pos, hospital1), 0).
initially(available_bags(b, neg, hospital1), 0).
initially(available_bags(ab, pos, hospital1), 0).
initially(available_bags(ab, neg, hospital1), 0).
initially(available_bags(o, pos, hospital1), 0).
initially(available_bags(o, neg, hospital1), 0).
initially(available_bags(a, pos, hospital2), 0).
initially(available_bags(a, neg, hospital2), 0).
initially(available_bags(b, pos, hospital2), 0).
initially(available_bags(b, neg, hospital2), 0).
initially(available_bags(ab, pos, hospital2), 0).
initially(available_bags(ab, neg, hospital2), 0).
initially(available_bags(o, pos, hospital2), 0).
initially(available_bags(o, neg, hospital2), 0).

% Exogeneous actions flag
initially(some_exo, false).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------- PRIMITIVE ACTIONS -------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check donors conditions
prim_action(check(D)) :- donor(D).
poss(check(D), (\+ donated(D), \+ eligible(D), \+ checked(D))).  
causes_true(check(D), eligible(D), (
    donor_age(D) >= 18,
    donor_age(D) =< 65,
    hemoglobin(D) >= 12,
    max_pressure(D) =< 180,
    min_pressure(D) >= 50,
    min_pressure(D) =< 90,
    max_pressure(D) >= 90)).
causes_true(check(D), checked(D), true).

causes_false(check(D), eligible(D), (
    donor_age(D) =< 18;
    donor_age(D) >= 65;
    hemoglobin(D) =< 12;
    max_pressure(D) >= 180;
    min_pressure(D) =< 50;
    min_pressure(D) >= 90;
    max_pressure(D) =< 90)).
    
% Donate blood
prim_action(donate(D, BG, RH, C)) :- donor(D), bloodgroup(BG), rhf(RH), center(C).
poss(donate(D, BG, RH, C), (
    donor_at(D, C),
    \+ donated(D),
    eligible(D),
    has_bloodgroup(D, BG),
    has_rhf(D, RH)
)).
causes_true(donate(D, _, _, _), donated(D), true).
causes_val(donate(_, BG, RH, C), available_bags(BG, RH, C), N, N is available_bags(BG, RH, C) + 1).

% Move blood to hospital
prim_action(moveto(C, H, BG, RH, P)) :- center(C), hospital(H), bloodgroup(BG), rhf(RH), patient(P).
poss(moveto(C, H, BG, RH, P), (
    available_bags(BG, RH, C) >= 1 ,
    patient_at(P, H),
    needs_transfusion(P),
    has_bloodgroup(P, PBG),
    has_rhf(P, PRH),
    abo_compatible(PBG, BG),
    rh_compatible(PRH, RH)
)).
causes_val(moveto(C, _, BG, RH, _), available_bags(BG, RH, C), N, N is available_bags(BG, RH, C) - 1).
causes_val(moveto(_, H, BG, RH, _), available_bags(BG, RH, H), N, N is available_bags(BG, RH, H) + 1).

% Transfuse
prim_action(transfuse(P, H, BG, RH, PBG, PRH)) :- patient(P), hospital(H), bloodgroup(BG), rhf(RH), bloodgroup(PBG), rhf(PRH).
poss(transfuse(P, H, BG, RH, PBG, PRH), (
    patient_at(P, H),
    needs_transfusion(P),
    has_bloodgroup(P, PBG),
    has_rhf(P, PRH),
    abo_compatible(PBG, BG),
    rh_compatible(PRH, RH),
    available_bags(BG, RH, H) >= 1
)).
causes_false(transfuse(P, _, _, _, _, _), needs_transfusion(P), true).
causes_val(transfuse(_, H, BG, RH, _, _), available_bags(BG, RH, H), N, N is available_bags(BG, RH, H) - 1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------- EXOGENOUS ACTIONS ------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A patient becomes urgent
exog_action(emergency(P)) :- patient(P).
poss(emergency(P), patient(P)).
causes_true(emergency(P), urgent(P), true).
causes_true(emergency(P), needs_transfusion(P), true).

% After checkings, a donor become unavailable for donation
exog_action(unavailable(D)) :- donor(D).
poss(unavailable(D), donor(D)).
causes_false(unavailable(D), eligible(D), true).

% The pressure of a donor change, compromising eligibility if out of ranges
exog_action(change_pressure(D, _, _)) :- donor(D).
poss(change_pressure(D, _, _), donor(D)).
causes_val(change_pressure(D, NewMax, _), max_pressure(D), N, N is NewMax).
causes_val(change_pressure(D, _, NewMin), min_pressure(D), N, N is NewMin).

initially(some_exo, false).
causes_true(emergency(_), some_exo, true).
causes_true(unavailable(_), some_exo, true).
causes_true(change_pressure(_, _, _), some_exo, true).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------------- TASKS --------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Legality task
proc(actions_legality, [check(donor1), donate(donor1, a, pos, center1), moveto(center1, hospital1, a, pos, patient2), transfuse(patient2,
hospital1, a, pos, a, pos)]).
legality :- indigolog(actions_legality).

% Projection task
proc(actions_seq, [check(donor1), donate(donor1, a, pos, center1), 
moveto(center1, hospital1, a, pos, patient2), transfuse(patient2,
hospital1, a, pos, a, pos)]).
proc(fcond, ?(neg(needs_transfusion(patient2)))).

projection :- indigolog([actions_seq, fcond]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------------- BASIC CONTROLLER ---------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----------------- Donation Procedures------------------- %
% Check eligibility of donor 
proc(checking(D), check(D)) :- donor(D).

% Recursive checking
proc(perform_checking([]), []).
proc(perform_checking([D|Ds]), [checking(D), perform_checking(Ds)]).

proc(check_all, Plan1) :-
    findall(D, donor(D), DonorList),
    proc(perform_checking(DonorList), Plan1).

% Perform donation
proc(perform_donation(D), [donate(D, _, _, _)]) :- donor(D).

% Helper primitive action
prim_action(reject_donor(_)).
poss(reject_donor(_), true).

% Recursive procedure which iterate over donors, performing donation if the donor is eligible
proc(perform_donations([]), []).
proc(perform_donations([D|Ds]), 
    [if(eligible(D), perform_donation(D), reject_donor(D)), perform_donations(Ds)]).

proc(donate_all, Plan2) :-
    findall(D, donor(D), DonorList),
    proc(perform_donations(DonorList), Plan2).


% ----------------- Transfusion Procedures ------------------ %
% move the blood from a center to the hospital and perform transfusion
proc(perform_transfusion(P), [moveto(_, H, BG, RH, P), transfuse(P, H, BG, RH, _, _)]) :- patient(P).

% Helper primitive actions 
prim_action(skip_patient(_)).
poss(skip_patient(_), true).
prim_action(already_transfused(_)).
poss(already_transfused(_), true).


% Recursive transfusion which iterate over patients, performing transfusion if patient is urgent
proc(perform_urgent_transfusions([]), []).
proc(perform_urgent_transfusions([P|Ps]),
    [if(urgent(P), perform_transfusion(P), skip_patient(P)), perform_urgent_transfusions(Ps)]).
    
% Recursive transfusion which iterate over patients, performing transfusion if patient has not yet been transfused
proc(perform_nourgent_transfusions([]), []).
proc(perform_nourgent_transfusions([P|Ps]), 
    [if(neg(needs_transfusion(P)), already_transfused(P), perform_transfusion(P)), perform_nourgent_transfusions(Ps)]).

proc(transfuse_all_urgent, Plan3) :-
    findall(P, patient(P), UrgentPatients),
    proc(perform_urgent_transfusions(UrgentPatients), Plan3).
    
proc(transfuse_all, Plan4) :-
    findall(P, patient(P), PatientList),
    proc(perform_nourgent_transfusions(PatientList), Plan4).


% ---------------- BASIC CONTROLLER ------------------- %
proc(control(basic), [check_all, donate_all, transfuse_all_urgent, transfuse_all]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------------- REACTIVE CONTROLLER ------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Handle emergency patient
proc(handle_emergency(P),
    if(urgent(P), perform_transfusion(P), skip_patient(P))).

% Handle unavailable donor
proc(handle_unavailable(D),
    reject_donor(D)):- donor(D).

% Handle change in blood pressure
proc(handle_pressure_change(D, _, _),
    []):- donor(D).

% Handle exogeneous actions    
proc(handle_event,
    [
        if(some_exo,
            nondet(
                exists(P, if(emergency(P), handle_emergency(P), [])),
                exists(D, if(unavailable(D), handle_unavailable(D), [])),
                exists(D, exists(NewMax, exists(NewMin,
                    if(change_pressure(D, NewMax, NewMin), handle_pressure_change(D, NewMax, NewMin), [])
                )))
            ),
            []
        )
    ]).

% ---------------- REACTIVE CONTROLLER ------------------- %
proc(control(reactive), [
    prioritized_interrupts([
        interrupt(some_exo, [
            if(some_exo, unset(some_exo), []),
            gexec(neg(some_exo), handle_event)
        ])
    ]),
    control(basic)
]).

actionNum(X, X).
