# Task 2: NFA → DFA in Janet

A nondeterministic finite automaton may have several transitions, or none, for one state and one symbol. It accepts when *some* run ends in an accepting state. In this task you run NFAs directly, then turn them into DFAs with the subset construction. Complete [nfa.janet](nfa.janet).

## Required functions

| Function | Returns |
| --- | --- |
| `(nfa-accepts? nfa input)` | `true` when `nfa` accepts the string `input`, otherwise `false` |
| `(nfa->dfa nfa)` | an equivalent DFA in **your task 1 representation** |

Choose an NFA representation; it can differ from your DFA one. δ now gives a *set* of states.

`nfa-accepts?` reads the input once and keeps the set of states the NFA can be in, starting from {q₀}. Do not try every run separately. As in task 1, a byte outside Σ rejects.

`nfa->dfa` uses the subset construction:

- The DFA start state is the subset {q₀}.
- From a subset S on symbol `x`, the DFA goes to the union of δ(q, x) for all q in S.
- A subset is accepting when it contains an accepting NFA state.
- Build **only the subsets reachable from the start**. Begin with the start subset, keep a work list of new subsets, and stop when no new subset appears. Do not list all 2ⁿ subsets first.
- If the empty subset is reachable, it is an ordinary (dead) state. The result is then always complete.

The result must work with your own `accepts?`, `complete?` and `state-count` from [task 1](../dfa/README.md). The test calls them through `(import ../dfa/dfa)`, so you may need to change your task 1 representation if it cannot name a DFA state after a set of NFA states. Hint: Janet tuples with equal contents are equal table keys, while arrays are not. Sort a subset before using it as a key.

## Required automata

Build exactly these NFAs, because the test counts the states of the DFA your construction produces.

`third-from-end-a`: words over {`a`, `b`} whose third symbol from the end is `a`. Four states q0 to q3:

| | `a` | `b` |
| --- | --- | --- |
| → q0 | {q0, q1} | {q0} |
| q1 | {q2} | {q2} |
| q2 | {q3} | {q3} |
| q3 (accepting) | ∅ | ∅ |

The subset construction gives exactly **8** DFA states.

`ends-with-ab-nfa`: words over {`a`, `b`} that end with `ab`. Three states:

| | `a` | `b` |
| --- | --- | --- |
| → p0 | {p0, p1} | {p0} |
| p1 | ∅ | {p2} |
| p2 (accepting) | ∅ | ∅ |

The subset construction gives exactly **3** DFA states.

## Check

```sh
janet nfa/test.janet
```

The test compares `nfa-accepts?` and your `dfa/accepts?` on the converted DFA with the language, for every word up to length 8. It also checks the state count and that the result is complete.

Then answer the questions in [ANSWERS.md](ANSWERS.md).

## Bonus: ε-transitions

Extend your NFA representation with ε-transitions, which change state without reading a symbol. The same two functions must handle them:

- The **ε-closure** of a set S is S together with every state reachable from S by ε-transitions alone. Several ε steps can follow each other.
- `nfa-accepts?` starts in the ε-closure of {q₀}, and after every symbol takes the ε-closure again.
- `nfa->dfa` uses closed subsets: the start subset is the ε-closure of {q₀}, and each step is "move on `x`, then close".

How you write ε in your representation is up to you. Define two ε-NFAs over {`a`, `b`}, both using ε-transitions:

| Name | Language |
| --- | --- |
| `a-star-b-star` | a\*b\*: some `a`s, then some `b`s, either part possibly empty |
| `a-plus-or-b-plus` | a⁺ \| b⁺: one or more `a`s, or one or more `b`s |

```sh
janet nfa/test-epsilon.janet
```

This test does not count states, because the count depends on how you draw the NFA. It does check that `third-from-end-a` still converts to 8 states. Answer question 5 in [ANSWERS.md](ANSWERS.md).
