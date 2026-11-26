# Task 1: DFA in Janet

A deterministic finite automaton is a 5-tuple (Q, Σ, δ, q₀, F). In this task you choose how to write one down in Janet, then write the functions that run it and four example automata. Complete [dfa.janet](dfa.janet).

The [parity lab](../../../labs/janet-dfa/README.md) shows one way to start: keywords for states, byte numbers as symbols, and nested tables for δ. That was a single, fixed automaton. Here, one automaton is a *value* that you pass to your functions, so it must carry everything they need: states, alphabet, start state, accepting states and transitions.

## Required functions

| Function | Returns |
| --- | --- |
| `(accepts? dfa input)` | `true` when `dfa` accepts the string `input`, otherwise `false` |
| `(complete? dfa)` | `true` when δ has a transition for every state and every symbol of Σ |
| `(state-count dfa)` | the number of states, \|Q\| |

The two predicates return exactly `true` or `false`, never `nil`. Watch out: `get`, `all` and `and` can give `nil`.

Read `input` byte by byte, as in the lab. A byte that is not in Σ makes `accepts?` return `false`: it is not an error. A missing transition in an incomplete automaton also means reject.

## Required automata

Each must use the **minimal** number of states for its language.

| Name | Σ | Language |
| --- | --- | --- |
| `even-as` | `a`, `b` | words with an even number of `a`s, the empty word included |
| `div-by-3` | `0`, `1` | binary numbers whose value is divisible by 3, read from the most significant bit. Leading zeros are allowed. The empty word counts as 0. |
| `ends-with-ab` | `a`, `b` | words that end with `ab` |
| `exactly-ab` | `a`, `b` | only the word `ab`. Leave out the dead state, so this automaton is **incomplete**. |

The first three are complete. Hint for `div-by-3`: if `w` has value `n`, then `w0` has value `2n` and `w1` has value `2n + 1`. What is the remainder of each modulo 3?

## Check

```sh
janet dfa/test.janet
```

The test reads every word up to length 8 over Σ, plus a few words that leave Σ, and compares your answers with a description of each language. It checks the state counts and `complete?` too.

Then answer the questions in [ANSWERS.md](ANSWERS.md).
