# Git practice

EIEC4E / INFOAN1 · Theoretical Informatics · Seminar after Lecture 6

The practice repository for the seminar checkpoint in the [lecture deck](https://github.com/pepe/present-star/blob/master/presentations/Theoretical-Informatics.md).
Go once around the Git loop on your own copy:

```text
edit → inspect → stage → review → commit → push
```

## Get a copy you can write to

On GitHub choose **Fork**, then clone your fork:

```sh
git clone https://github.com/<your-account>/culs-ti-git-practice.git
cd culs-ti-git-practice
git remote -v
git branch --show-current
```

Expect the remote `origin` pointing at your fork, and the branch `main`.

## The checkpoint

1. Make one small edit to `CHECKPOINT.md`, as it asks.
2. Inspect it with `git status --short` and `git diff -- CHECKPOINT.md`.
3. Stage it with `git add CHECKPOINT.md` and read `git diff --cached -- CHECKPOINT.md`.
4. Commit it with a message that names the change, then `git push origin main`.
5. Open the commit on GitHub and show your partner the exact lines it contains.

## Next lab: Janet and a DFA

Follow [Janet basics: a two-state DFA](labs/janet-dfa/README.md), then use the same Git loop to share your tested implementation.

## Assignment: automata and PEG in Janet

The graded assignment goes from recognition (DFA) through construction (NFA → DFA) to parsing (PEG). Start with the [overview](assignments/automata-peg/README.md).
