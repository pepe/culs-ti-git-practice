# Assignment: automata and PEG in Janet

EIEC4E / INFOAN1 · Theoretical Informatics · Graded assignment

Three connected tasks, from recognising a language to building a recogniser to parsing structured input:

| Task | Folder | You write |
| --- | --- | --- |
| 1. DFA | [`dfa/`](dfa/README.md) | `accepts?`, `complete?`, `state-count` and four example automata |
| 2. NFA → DFA | [`nfa/`](nfa/README.md) | `nfa-accepts?`, `nfa->dfa` (subset construction) and two example NFAs |
| Bonus: ε-NFA | [`nfa/`](nfa/README.md#bonus-ε-transitions) | ε-transitions in the same two functions |
| 3. PEG | [`peg/`](peg/README.md) | `parse` for a small command language |

Each folder has a spec (`README.md`), a skeleton to complete, a self-check test and `ANSWERS.md` with short theory questions.

You should already be able to finish [Janet basics: a two-state DFA](../../labs/janet-dfa/README.md).

## Rules

- Use Janet and its standard library only. Do not use `spork` or any other package.
- You choose how to represent automata. The tests only call the required functions and read the required definitions by name, so any sensible representation works. Keep the required names exactly as given.
- Task 2 builds on your own task 1: the DFA your `nfa->dfa` returns must run on your own `accepts?`.
- Do not change `check.janet` or the test files. You may add your own extra checks in separate files.
- Write the code and the answers yourself. If you used a source or discussed the task with someone, say so in `ANSWERS.md`.

## Check your work

From this folder, `assignments/automata-peg`:

```sh
janet dfa/test.janet
janet nfa/test.janet
janet nfa/test-epsilon.janet   # bonus only
janet peg/test.janet
```

Each test prints a `FAIL` line for every failed check, then the totals. The skeletons run but fail every check. That is the starting point.

The tests help you check your own work. They do not decide the grade. Passing them is necessary but not sufficient. The review also reads your code and your answers.

## Git workflow

Work in your fork of this repository, as in the checkpoint:

1. Fetch the assignment into your fork: on GitHub choose **Sync fork**, then run `git pull` locally.
2. Commit in small steps with messages that say what changed, for example `Add even-as DFA` or `Handle bytes outside the alphabet`. One task finished in a single huge commit is harder to review.
3. Push to `main` of your fork with `git push origin main`.
4. Submit the link to your fork. The deadline and where to send the link are announced in the seminar. Whatever is on `main` at the deadline is graded.

## Grading

Grading is a manual review of your code, commit history and answers.

| Part | Points | What the review looks at |
| --- | ---: | --- |
| 1. DFA | 30 | correct functions, clear representation, minimal example automata |
| 2. NFA → DFA | 30 | correct subset construction, only reachable subsets, reuse of task 1 |
| 3. PEG | 30 | grammar matches the spec, conversions done with captures, readable rules |
| `ANSWERS.md` (all tasks) | 10 | correct, short reasoning in your own words |
| Bonus: ε-transitions | +10 | ε-closure used in both functions |
| **Total** | **100 (+10)** | |
