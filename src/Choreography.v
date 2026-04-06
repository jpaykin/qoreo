From Qoreo Require Quantum.

From Stdlib Require Lists.List.
Import List.ListNotations.
Open Scope list_scope.


Inductive insn {Actor : Set} : Type :=

| Send : Actor -> Quantum.expr -> Actor -> Quantum.var -> insn
| EPR : Actor -> Quantum.var -> Actor -> Quantum.var -> insn

| Let : Actor -> Quantum.var -> Quantum.expr -> insn
| LetBang : Actor -> Quantum.var -> Quantum.expr -> insn
| LetPair : Actor -> Quantum.var -> Quantum.var -> Quantum.expr -> insn.
Arguments insn Actor : clear implicits.

Definition expr Actor := list (insn Actor).

Definition actorsI {Actor} (I : insn Actor) : list Actor :=
    match I with
    | Send A _ B _ => [ A ; B ]
    | EPR A _ B _ => [A;B]
    | Let A _ _ => [A]
    | LetBang A _ _ => [A]
    | LetPair A _ _ _ => [A]
    end.

Definition actors {Actor} (e : expr Actor) : list Actor :=
    List.fold_right (fun I => List.app (actorsI I)) [] e.

(** Semantics **)
