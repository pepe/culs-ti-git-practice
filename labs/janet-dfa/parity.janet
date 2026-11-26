# Run from the repository root: janet labs/janet-dfa/parity.janet
# Complete the transition rows, then the two functions marked TODO.

(def start :even)
(def transitions
  {:even {}  # TODO: one transition for byte 48 and one for byte 49
   :odd  {}})

(defn step [state byte]
  (def next-state (get (get transitions state) byte))
  (if (= next-state nil)
    (error "Invalid input byte or incomplete transition table")
    next-state))

(defn final-state [input]
  # TODO: use var, each, step and set, then return the final state.
  (error "Complete final-state"))

(defn accepts? [input]
  # TODO: compare the returned state with :even.
  (error "Complete accepts?"))

(assert (= true (accepts? "")) "empty input")
(assert (= true (accepts? "0")) "zero preserves even")
(assert (= false (accepts? "1")) "one flips to odd")
(assert (= true (accepts? "101")) "two ones")
(assert (= false (accepts? "1011")) "three ones")
(print "All five DFA checks passed.")
