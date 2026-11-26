# Task 2: answers

Answer in a few sentences each, in your own words.

1. Your representation: how do you write an NFA, and how is a DFA state named after a set of NFA states? Did you have to change task 1 for it?

   Answer:

2. An NFA with n states can need a DFA with up to 2ⁿ states. Why exactly 2ⁿ, and why is that an upper bound?

   Answer:

3. Why does `third-from-end-a` need all 8 states, so that no smaller DFA exists? Hint: what must the DFA remember about the last three symbols? Find two words that end in different states and a suffix that tells them apart.

   Answer:

4. Your construction builds only reachable subsets. For `third-from-end-a`, how many of the 16 subsets of {q0, q1, q2, q3} are never reached, and why do all reached ones contain q0?

   Answer:

5. Bonus only: what is the ε-closure, and where in `nfa-accepts?` and `nfa->dfa` did you have to apply it?

   Answer:

Sources and help used (if any):
