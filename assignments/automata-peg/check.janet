# Shared helpers for the self-check tests. You do not need to change this file.
#
# A check passes when its expression is exactly `true`. A string result
# explains a failure, and an error counts as a failure rather than a crash,
# so an unfinished skeleton still runs every check.

(var- passed 0)
(var- failed 0)

(defn- record [name thunk]
  (def [ok result] (protect (thunk)))
  (if (and ok (= true result))
    (++ passed)
    (do
      (++ failed)
      (print "FAIL " name
             (cond
               (not ok) (string ": error: " result)
               (string? result) (string ": " result)
               (string ": got " (describe result))))))
  nil)

(defmacro check
  "Runs `expr` as the check named `name`."
  [name expr]
  ~(,record ,name (fn [] ,expr)))

(defn is
  "True when `got` equals `expected`, else a string showing both."
  [expected got]
  (if (deep= expected got)
    true
    (string/format "got %q, expected %q" got expected)))

(defn words
  "Every string over the bytes of `alphabet` up to `max-len` long, the empty one first."
  [alphabet max-len]
  (def out @[""])
  (var layer @[""])
  (repeat max-len
    (set layer (seq [w :in layer c :in alphabet] (string w (string/from-bytes c))))
    (array/concat out layer))
  out)

(defn agrees
  ```
  True when `(f w)` equals `(expected w)` for every string `w` over `alphabet`
  up to `max-len` long, else a string naming the first word that differs.
  ```
  [f expected alphabet max-len]
  (var verdict true)
  (each w (words alphabet max-len)
    (def got (f w))
    (unless (= got (expected w))
      (set verdict (string/format "on %q got %q, expected %q" w got (expected w)))
      (break)))
  verdict)

(defn report
  "Prints the totals and exits with status 1 when any check failed."
  []
  (print passed " passed, " failed " failed")
  (os/exit (if (zero? failed) 0 1)))
