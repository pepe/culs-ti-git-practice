# Task 2: from NFA to DFA.
# Self-check from assignments/automata-peg: janet nfa/test.janet
# Bonus self-check: janet nfa/test-epsilon.janet
#
# Choose your own representation of an NFA. `nfa->dfa` returns a DFA in
# your own task 1 representation, so it runs on the functions imported here.

(import ../dfa/dfa)

(defn nfa-accepts?
  ```
  True when `nfa` accepts the string `input`, false otherwise. Track the
  set of states the NFA can be in. A byte outside the alphabet rejects.
  ```
  [nfa input]
  (error "TODO: nfa-accepts?"))

(defn nfa->dfa
  ```
  The DFA that the subset construction builds from `nfa`: one state for
  each subset of NFA states reachable from the start, and no others.
  ```
  [nfa]
  (error "TODO: nfa->dfa"))

# Words whose third symbol from the end is `a`, over {a, b}. The 4-state
# NFA from the spec: q0 loops on a and b, guesses the `a`, counts two more.
(def third-from-end-a nil) # TODO

# Words that end with `ab`, over {a, b}. The 3-state NFA from the spec.
(def ends-with-ab-nfa nil) # TODO

# Bonus: ε-NFAs for a*b* and for a+ | b+, over {a, b}.
(def a-star-b-star nil) # TODO (bonus)
(def a-plus-or-b-plus nil) # TODO (bonus)
