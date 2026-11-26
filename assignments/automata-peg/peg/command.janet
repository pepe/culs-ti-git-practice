# Task 3: a command language parsed with a PEG.
# Self-check from assignments/automata-peg: janet peg/test.janet
#
# Write the grammar from the spec as rules of one PEG. Convert numbers,
# escapes and durations with captures inside the grammar, so that :main
# captures exactly one value: the finished dictionary.

(def grammar
  (peg/compile
    ~{:S (some " ")
      :_ (any " ")
      # TODO: the other rules from the spec.
      :main (error (constant "TODO: grammar"))}))

(defn parse
  "The command `line` as a dictionary, or nil when it is not a command."
  [line]
  (first (peg/match grammar line)))
