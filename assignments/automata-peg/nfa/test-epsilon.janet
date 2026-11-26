# Bonus self-check for task 2. Run from assignments/automata-peg: janet nfa/test-epsilon.janet

(import ../check :prefix "")
(import ../dfa/dfa)
(import ./nfa)

(defn- over
  "Wraps `pred` so that a word with a byte outside `alphabet` is rejected."
  [alphabet pred]
  (fn [w] (and (all |(index-of $ alphabet) w) (pred w))))

(def a-star-b-star?
  (over "ab" |(not (string/find "ba" $))))
(def a-plus-or-b-plus?
  (over "ab" |(and (not (empty? $)) (all (fn [c] (= c (first $))) $))))

(def examples
  [["a-star-b-star" |nfa/a-star-b-star a-star-b-star?]
   ["a-plus-or-b-plus" |nfa/a-plus-or-b-plus a-plus-or-b-plus?]])

(each [name automaton expected] examples
  (check (string name " is defined")
         (not (nil? (automaton))))
  (check (string name ": nfa-accepts? on all words up to length 8")
         (agrees |(nfa/nfa-accepts? (automaton) $) expected "ab" 8))
  (check (string name ": nfa-accepts? rejects bytes outside the alphabet")
         (is false (nfa/nfa-accepts? (automaton) "ac")))
  (def converted (protect (nfa/nfa->dfa (automaton))))
  (defn result []
    (if (converted 0) (converted 1) (error (converted 1))))
  (check (string name ": your dfa/accepts? on the nfa->dfa result, all words up to length 8")
         (agrees |(dfa/accepts? (result) $) expected "ab" 8))
  (check (string name ": the result is complete")
         (is true (dfa/complete? (result)))))

# The task 2 automata have no ε-transitions; they must still work.
(check "third-from-end-a still converts to 8 states"
       (is 8 (dfa/state-count (nfa/nfa->dfa nfa/third-from-end-a))))

(report)
