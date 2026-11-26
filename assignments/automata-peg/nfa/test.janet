# Self-check for task 2. Run from assignments/automata-peg: janet nfa/test.janet

(import ../check :prefix "")
(import ../dfa/dfa)
(import ./nfa)

(defn- over
  "Wraps `pred` so that a word with a byte outside `alphabet` is rejected."
  [alphabet pred]
  (fn [w] (and (all |(index-of $ alphabet) w) (pred w))))

(def third-from-end-a?
  (over "ab" |(and (>= (length $) 3) (= (chr "a") (get $ (- (length $) 3))))))
(def ends-with-ab?
  (over "ab" |(string/has-suffix? "ab" $)))

(def examples
  [["third-from-end-a" |nfa/third-from-end-a third-from-end-a? 8]
   ["ends-with-ab-nfa" |nfa/ends-with-ab-nfa ends-with-ab? 3]])

(each [name automaton expected states] examples
  (check (string name " is defined")
         (not (nil? (automaton))))
  (check (string name ": nfa-accepts? on all words up to length 8")
         (agrees |(nfa/nfa-accepts? (automaton) $) expected "ab" 8))
  (each input ["c" "aab " "abx" "xab"]
    (check (string/format "%s: nfa-accepts? rejects %q, which leaves the alphabet" name input)
           (is false (nfa/nfa-accepts? (automaton) input))))
  (def converted (protect (nfa/nfa->dfa (automaton))))
  (defn result []
    (if (converted 0) (converted 1) (error (converted 1))))
  (check (string name ": your dfa/accepts? on the nfa->dfa result, all words up to length 8")
         (agrees |(dfa/accepts? (result) $) expected "ab" 8))
  (check (string name ": your dfa/accepts? on the result rejects bytes outside the alphabet")
         (is false (dfa/accepts? (result) "aab ")))
  (check (string name ": the result has exactly " states " reachable states")
         (is states (dfa/state-count (result))))
  (check (string name ": the result is complete")
         (is true (dfa/complete? (result)))))

(report)
