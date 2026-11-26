# Self-check for task 1. Run from assignments/automata-peg: janet dfa/test.janet

(import ../check :prefix "")
(import ./dfa)

(defn- over
  "Wraps `pred` so that a word with a byte outside `alphabet` is rejected."
  [alphabet pred]
  (fn [w] (and (all |(index-of $ alphabet) w) (pred w))))

(defn- count-of [byte w] (count |(= byte $) w))

(def even-as?
  (over "ab" |(even? (count-of (chr "a") $))))
(def div-by-3?
  (over "01" (fn [w] (zero? (reduce |(% (+ (* 2 $0) (- $1 (chr "0"))) 3) 0 w)))))
(def ends-with-ab?
  (over "ab" |(string/has-suffix? "ab" $)))
(def exactly-ab?
  |(= "ab" $))

(def examples
  [["even-as" |dfa/even-as even-as? "ab" 2 true]
   ["div-by-3" |dfa/div-by-3 div-by-3? "01" 3 true]
   ["ends-with-ab" |dfa/ends-with-ab ends-with-ab? "ab" 3 true]
   ["exactly-ab" |dfa/exactly-ab exactly-ab? "ab" 3 false]])

(each [name automaton expected alphabet states complete] examples
  (check (string name " is defined")
         (not (nil? (automaton))))
  (check (string name " accepts its language, all words up to length 8")
         (agrees |(dfa/accepts? (automaton) $) expected alphabet 8))
  (check (string name " has " states " states")
         (is states (dfa/state-count (automaton))))
  (check (string name (if complete " is complete" " is incomplete"))
         (is complete (dfa/complete? (automaton)))))

(def outside
  [["even-as" |dfa/even-as ["c" "aca" "a b" "bbx"]]
   ["div-by-3" |dfa/div-by-3 ["2" "0 " "11x" "0b11"]]
   ["ends-with-ab" |dfa/ends-with-ab ["cab" "abab " "a-ab" "AB"]]
   ["exactly-ab" |dfa/exactly-ab ["abc" "ab " "xab" "ab\n"]]])

(each [name automaton inputs] outside
  (each input inputs
    (check (string/format "%s rejects %q, which leaves the alphabet" name input)
           (is false (dfa/accepts? (automaton) input)))))

(report)
