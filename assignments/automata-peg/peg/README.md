# Task 3: a command language with a PEG

A parsing expression grammar (PEG) describes how to *read* a string: try this, and if it fails try that. Janet has PEGs built in (`peg/compile`, `peg/match`). In this task you parse a small command language for a to-do and time tracker, in the spirit of the console commands of a real work tracker. Complete [command.janet](command.janet).

## Required function

`(parse line)` returns `nil` when `line` is not a command, otherwise a dictionary (struct or table) as described below. Lists may be arrays or tuples.

All conversions happen **inside the grammar** with captures: `number`, `constant`, `group`, `/` (replace with a function), `%` (accumulate) and the like. Do not take the match apart afterwards with string functions. The skeleton's `parse` only takes the single value `:main` captures.

## The language

```text
add   TITLE TAGS [due DATE [at TIME]] [for DURATION]
start TITLE TAGS [at TIME]
stop  [at TIME]
done  ID
list  [today | week | all] TAGS
```

Parts in `[ ]` are optional, but when present they come **in this order**. Tokens are separated by one or more spaces, and the line may start and end with spaces. The whole line must match: anything left over means `nil`. Keywords are lowercase.

| Part | Syntax | Captured as |
| --- | --- | --- |
| TITLE | either `"…"` (see below), or bare words up to the first keyword `due`, `at`, `for` or the first tag | the title text, a string |
| TAGS | zero or more of `#` followed by `a`–`z`, `0`–`9` or `-` | `:tags`, a list of tag names without `#`, always present |
| DATE | `YYYY-MM-DD`, month `01`–`12`, day `01`–`31` | `:date {:year 2026 :month 12 :day 3}` |
| TIME | `HH:MM`, hours `00`–`23`, minutes `00`–`59` | `:time {:hour 9 :minute 15}` |
| DURATION | `NhMm`, `Nh` or `Mm`, N and M one or more digits | `:duration`, in minutes |
| ID | a positive integer without leading zeros | `:id`, a number |

**Quoted title:** at least one character between double quotes. Inside, `\"` is a quote and `\\` is a backslash. Any other backslash, and a bare `"`, make the line invalid.

**Bare title:** one or more words, where a word is a run of characters without spaces or `"` that does not start with `#` and is not one of the keywords `due`, `at`, `for`. Keep the bare title exactly as written, including multiple spaces between its words. The keyword `due` stops a bare title, while `duet` is just a word.

**Whole words:** a keyword, tag, date, time, duration, id, range word or closing quote must be followed by a space or the end of the line. So `address`, `list weekly`, `#ti#x`, and `"glued"#ti` are invalid.

Optional parts that are absent are **missing from the dictionary**, not `nil` values. Only `:tags` is always present, possibly empty.

## Examples

```janet
(parse `add "Read \"Sipser\" ch. 1" #ti #exam due 2026-12-03 at 14:30 for 1h30m`)
# {:command :add :title `Read "Sipser" ch. 1` :tags ["ti" "exam"]
#  :date {:year 2026 :month 12 :day 3} :time {:hour 14 :minute 30} :duration 90}

(parse "add Read about duet #music") # {:command :add :title "Read about duet" :tags ["music"]}
(parse "start Lab at 09:15")         # {:command :start :title "Lab" :tags [] :time {:hour 9 :minute 15}}
(parse "stop")                       # {:command :stop}
(parse "done 7")                     # {:command :done :id 7}
(parse "list week #ti")              # {:command :list :range :week :tags ["ti"]}

(parse "add Meet at noon")           # nil: `at` stops the title, and `noon` is no TIME
(parse "add Lab for 1h due 2026-12-03") # nil: wrong order
(parse "add Pay rent due 2026-02-31")   # a dictionary: the grammar checks syntax only
```

## What to watch for

- **Ordered choice.** `(+ a b)` tries `b` only if `a` fails, and never comes back to try `b` after `a` succeeded. Think about which alternative of DURATION to try first.
- **Whole words.** Write one rule for "the end of a word" and reuse it.
- **Full line.** End `:main` with `-1`, which matches only at the end of the input.
- Start small: make `stop` and `done 7` work end to end, then add the other commands.

## Check

```sh
janet peg/test.janet
```

The test parses a list of valid lines and compares the dictionaries, then checks that invalid lines give `nil`.

Then answer the questions in [ANSWERS.md](ANSWERS.md).
