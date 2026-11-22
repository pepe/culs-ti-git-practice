# Janet basics: a two-state DFA

EIEC4E / INFOAN1 · Theoretical Informatics

Build a recogniser for binary strings with an even number of `1`s. This lab follows the lecture examples in order. Start in the Janet REPL, then apply the same ideas in [parity.janet](parity.janet).

## 1. Read and evaluate an expression

Run `janet` to open the REPL. Predict the result of `(+ 2 (* 3 4))`, then try it. In a call, the function comes first. In a script, use `print` to display a value.

## 2. Give the current state a name

```janet
(def start :even)
(var state start)
(set state :odd)
(= state :even)
```

Predict the result of the last line. `:even` and `:odd` are keywords used as state labels. Use `def` for the fixed start state, and `var` and `set` for the binding that changes as the input is read.

## 3. Look up one transition

```janet
(def sample-row {48 :even 49 :odd})
(get sample-row 49)
```

Predict the result. Now complete both rows of `transitions` in the starter file: a `0` preserves parity and a `1` flips it. Read `step` as a function from the current state and one byte to the next state. Its `if` reports a missing transition as invalid input.

## 4. Read the whole input

```janet
(each byte "01" (print byte))
```

Janet iterates over string bytes: ASCII `0` is `48` and ASCII `1` is `49`. The transition keys are numbers, not strings.

In `final-state`, start at `start`, use `each` to read the input, and use `set` and `step` to update the state. Return the final state. In `accepts?`, compare that final state with `:even`.

## 5. Predict, run, and commit

From the root of your fork's working copy:

```sh
janet labs/janet-dfa/parity.janet
```

The starter is deliberately incomplete. When your implementation is ready, predict and check:

| Input | Accepts? |
| --- | --- |
| `""` | `true` |
| `"0"` | `true` |
| `"1"` | `false` |
| `"101"` | `true` |
| `"1011"` | `false` |

Then temporarily add `(accepts? "10x")` at the bottom and run again. Expect an invalid-input error. Remove the temporary line before committing. Explain why the empty word accepts, and why reaching `:even` partway through an input is insufficient.

Use the same Git loop: edit, inspect, stage, review, commit and push. On GitHub, open your commit and show the table and runner.
