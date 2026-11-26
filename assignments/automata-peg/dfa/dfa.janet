# Task 1: deterministic finite automata.
# Self-check from assignments/automata-peg: janet dfa/test.janet
#
# Choose your own representation of a DFA. The tests only call the three
# functions below and read the four example automata by name.

(defn accepts?
  ```
  True when `dfa` accepts the string `input`, false otherwise. A byte
  outside the alphabet, or a missing transition, rejects: never an error.
  ```
  [dfa input]
  (error "TODO: accepts?"))

(defn complete?
  "True when `dfa` has a transition for every state and every symbol of its alphabet."
  [dfa]
  (error "TODO: complete?"))

(defn state-count
  "The number of states of `dfa`."
  [dfa]
  (error "TODO: state-count"))

# Even number of `a`s, over {a, b}. Minimal and complete.
(def even-as nil) # TODO

# Binary numbers divisible by 3, over {0, 1}. Minimal and complete.
(def div-by-3 nil) # TODO

# Words that end with `ab`, over {a, b}. Minimal and complete.
(def ends-with-ab nil) # TODO

# Exactly the word `ab`, over {a, b}, with no dead state, so incomplete.
(def exactly-ab nil) # TODO
