# Git basics: Syncing your fork to the original repo
Before we start, be sure to update your branch, to sync with the original one, using these commands
```
git remote add upstream https://github.com/pepe/culs-ti-git-practice.git
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

All of this is a bit of a pain to type every class, so I suggest setting up an alias, so that you don't have to use so many commands. A good example of an alias like this, could be

```
git config --global alias.sync "!git checkout main && git fetch upstream && git merge upstream/main && git push origin main"
```

With this example, from now on, all you need to update your repo is the custom command git sync

# Janet basics: a two-state DFA
[Be sure to check the official Janet documentation](https://janet-lang.org/docs/index.html)

![Dammit Janet](https://github.com/pepe/culs-ti-git-practice/blob/main/labs/janet-dfa/assets/dammit-janet.gif)

EIEC4E / INFOAN1 · Theoretical Informatics · Seminar after Lecture 7

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

Then temporarily add `(accepts? "10x")` just above the final `print` line and run again. Expect an invalid-input error. Remove the temporary line before committing. Explain why the empty word accepts, and why reaching `:even` partway through an input is insufficient.

Use the same Git loop: edit, inspect, stage, review, commit and push. On GitHub, open your commit and show your partner the completed transition table and the two functions.
