# The-Shakspere-Files
A generative cellular automaton that writes texts based on patterns it has learnt

 ![The Shakspere Files](https://github.com/user-attachments/assets/db1b6e0d-0a4d-4067-8d9c-a0419d6d1819)
 
### Background
This set of programs is based on an article in *Kosmos 1992*, the yearbook of the Swedish physical society [1]. The article is a kind of popular introduction to cellular automata. The authors are theoretical physicists and the following automaton is used as an example to show coherence length and entropy and it isn't entirely clear whether this automaton is an invention of the authors themselves or if it has been described elsewhere. They make general references to Martin Gardner's and Alexander Dewdney's columns in *Scientific American*, so it might have been described there.

Anyway, I was facinated by this idea and wrote my first implementation of the program around 1995 in Pascal which was basically a set of tools that could be used together with the text piping commands in Unix. Since the results for a coherence length of 6 seemed the most interesting, I wrote the programs for that length. I probably had a plan to generalise it to further lengths but I
never got around to doing that in Pascal. (In the current version, you can re-build with new
coherence lengths ...)

I present here a slightly updated version. I originally used the Pascal compiler that was available on the SUN Sparc Station that I used. I have now made sure that they run on Free Pascal. I have made some updates:

 1. All names have been changed to English. The original programs used a
    lot of Swedish in identifiers. I have aligned it with the
    fragment-stem-continuation terminology I use here. 
 2. General improvement of readability, i.e. variable names that are descriptive (and not just
    letters of the alphabet), some comments.
 3. Indentation aligned with my university Pascal textbook [2].
 4. For some reason (ignorance perchance (and the lack of a manual)) I didn't use `random` and 
    `randomize`, but  wrote my own random number generator. I removed that now.
 5. Reduced the amount of global variables and shadow-effects of functions.
 6. Turned some *magic numbers* into constants.
 7. Broke out common code into a new unit `stems_and_fragments.pas`.

### Usage
There are three programs. The first, `fragmentise`, analyses a text on STDIN and outputs all possible six-character combinations, fragments, found in the text onto STDOUT.

as, yo

s, you

, you 

 you k
 
you kn

ou kno

u know

 know,


know, 


This should be fed into the unix `sort` command. This will produce a long list of all found fragments sorted alphabetically, like

 was a
 
 was b
 
 was b


Then the second program, `make_statistics` produces statistics based on that and presents the fragments as a five character *stem* and the possible *continuations* and the count of each continuation in the original file.

The example above will be presented as

 was  a 1 b 2

This should be piped into in a file called 'stats'.

Everything in one line:

    cat <file> | ./fragmentise | sort | ./make_statistics > stats

The final step consists of running the program 'generate' that will create a new text based on the statistics in 'stats'. Once 'stats' has been produced, 'generate' can be run as many times as needed for the same statistics.

./generate

### Oh, and the name ...
... isn't misspelt. It's actually one of the spellings used by William Shakespeare himself. But this name probably indicates the rather high expectations I had on the output of the program. I don't remember how serious I was about this, but I do remember that I was somewhat disappointed by the rather mundane output. A friend, however, had more patience and tried it on all sorts of texts and found that it did generate raher amusing output when you feed short news items into it. The dry newspaper language causes a comic effect when you read the sometimes bizzare texts it produces. Anyway, the name fits, "it's not
exactly Shakespeare ..."


[1] K Lindgren and M Nordahl (1992), "Komplext men ganska enkelt", p 75 in *Kosmos 1992* (in Swedish).

[2] N Graham, "Introduction to Pascal", 2nd edition, Castle House Publications, 1983.
