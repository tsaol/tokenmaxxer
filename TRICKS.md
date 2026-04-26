# Token Inflation Tricks

A catalog of techniques that increase token consumption. Some are genuine productivity multipliers; others are pure gaming. Know the difference — then choose your own adventure.

## Quick Reference

| Technique | Multiplier | Category | Mechanism |
|---|---|---|---|
| Multi-agent parallelization | 3-5x | Genuine | More real work done |
| Auto test + review | 2-3x | Genuine | Additional quality passes |
| Self-reflection loops | 1.5-2x | Genuine | Review after each action |
| Archaic/Old English style | 4-6x | Gaming | Tokenizer inefficiency + verbosity |
| L33t speak | 3.4x/char | Gaming | Destroys all BPE merges |
| Hindi output | 5.2x/char | Gaming | Poor tokenizer coverage |
| Japanese output | 3.2x/char | Gaming | CJK multi-token encoding |
| Kenning compounds | 2.8x/word | Gaming | Hyphens break BPE merges |
| Emoji-heavy output | 1.7x/char | Gaming | Multi-byte encoding |
| No contractions | 1.1-1.2x | Gaming | Expand "don't" → "do not" |
| SAT/GRE vocabulary | 1.2x/word | Gaming | Rare words split into subwords |

## Gaming Techniques (Surface-Level Inflation)

### 1. Old English / Archaic Style — 4-6x total

The most well-known trick. Works through **two combined mechanisms**:

**Mechanism A: Tokenizer Inefficiency (1.8x per word)**

BPE tokenizers are trained on modern text. Archaic words aren't in the vocabulary, so they split into multiple subword tokens:

```
Modern (1 token)     →  Archaic              →  Tokens  →  Split
─────────────────────────────────────────────────────────────────
computer                thought-engine          2          ['thought', '-engine']
error                   affliction              3          ['aff', 'lict', 'ion']
function                deed-worker             3          ['de', 'ed', '-worker']
because                 forsooth                3          ['for', 'so', 'oth']
listen                  hearken                 3          ['he', 'ark', 'en']
walking                 perambulations          3          ['per', 'amb', 'ulations']
nothing                 naught                  2          ['na', 'ught']
```

**Mechanism B: Content Expansion (4-6x text volume)**

Archaic style uses dramatically more words for the same meaning:

```
Modern:  "Fix the null input bug"                    → ~10 tokens
Archaic: "Hearken, good fellow! The query 
          deed-worker doth suffer a grievous 
          code-blight upon receiving naught 
          as its offering..."                         → ~60 tokens
```

**Combined: ~6x total inflation**

**Real project:** [`garden-of-delete/claude-rambler`](https://github.com/garden-of-delete/claude-rambler) — a Claude Code skill that transforms output into medieval scribe style. The author explicitly calls it satire.

### 2. Kenning Compounds — 2.8x per word

Kennings are hyphenated metaphorical compounds from Old Norse/English poetry. Hyphens break BPE merge rules, making each compound cost 3-4 tokens:

```
Modern (1 token)   →  Kenning            →  Tokens
────────────────────────────────────────────────────
bug                   code-blight           3
algorithm             logic-wyrm            4
browser               window-wanderer       4
database              memory-hoard          3
server                cloud-keeper          3
```

Can be combined with archaic style for maximum effect.

### 3. L33t Speak — 3.4x per character

**The single highest per-character inflation technique**, beating even CJK scripts.

Digit-letter alternation destroys every learned BPE merge:

```
Modern (tokens)     →  L33t               →  Tokens
────────────────────────────────────────────────────
database (1)           d4t4b4s3              8
computer (1)           c0mput3r              5
function (1)           funct10n              4
```

**Why it works:** BPE learns to merge common letter sequences ("data", "base"). Inserting digits ("d4t4") breaks these learned merges, forcing character-level tokenization.

### 4. Non-Latin Scripts — up to 5.2x

English-centric tokenizers compress English well but waste tokens on other scripts:

```
Language    Tokens (same meaning)    vs English
──────────────────────────────────────────────
English          5                    1.0x
German           5                    1.0x
Spanish          6                    1.2x
French           7                    1.4x
Chinese          7                    1.4x
Russian         12                    2.4x
Arabic          15                    3.0x
Japanese        16                    3.2x
Korean          16                    3.2x
Hindi           26                    5.2x
```

Hindi is the most token-expensive common language — 5.2x inflation for the same semantic content.

### 5. Emoji-Heavy Output — 1.7x

Each emoji consumes 2-4 tokens due to multi-byte UTF-8 encoding:

```
"Good job"           → 2 tokens
"Great job! 🎉👏🔥"  → 8 tokens
```

### 6. No Contractions — 1.1-1.2x

Expanding all contractions adds ~10-20% more tokens:

```
"don't" → "do not"     (1 token → 2 tokens)
"can't" → "cannot"     (1 token → 1 token, no gain here)
"I'm"   → "I am"       (1 token → 2 tokens)
"won't" → "will not"   (1 token → 2 tokens)
```

Small per-instance gain, but compounds across long responses.

### 7. SAT/GRE Vocabulary — 1.2x per word

Rare English words split into more subwords:

```
big (1 token)       →  gargantuan (3 tokens)
wordy (1 token)     →  sesquipedalian (4 tokens)
happy (1 token)     →  euphoric (2 tokens)
```

### 8. Anti-Trick: Repetition — 0.84x (NEGATIVE)

Counterintuitively, repeating text **decreases** token efficiency. BPE handles repetition well, so "the the the the" is more efficiently encoded than "the quick brown fox." Don't try to inflate via repetition.

## Genuine Techniques (Real Productivity Multipliers)

### 1. Multi-Agent Parallelization — 3-5x

Spawn parallel agents for independent subtasks:

```
User: "Fix the login bug"

Agent 1 (Fix):     Investigate + fix           +3000 tokens
Agent 2 (Search):  Find similar bugs           +2000 tokens  
Agent 3 (Test):    Write regression tests      +2500 tokens
                                    (running simultaneously)
```

This is real work — each agent produces genuine value.

### 2. Auto Test Generation — 2-3x

Write tests for every code change automatically. Tests are real code that catches real bugs.

### 3. Self-Reflection After Actions — 1.5-2x

Inject reflection prompts after each code edit:
- "Does this have test coverage?"
- "Did I handle edge cases?"
- "Could this introduce a regression?"

### 4. Code Review Before Commit — 1.5x

Read the full diff and review it before committing. Catches issues early.

### 5. Root Cause Analysis — 2x

Don't just fix the symptom — investigate why the bug happened and whether it's a pattern.

### 6. Prompt Caching — 5-10x effective throughput

Cache reads don't count against ITPM limits, enabling much higher effective throughput for repeated context.

## Combining Techniques

### Gaming Stack (maximum inflation, zero value)

```
Archaic style (6x) × L33t speak (3.4x) = theoretically 20x
But this produces unreadable garbage. Don't do this.
```

### Genuine Stack (Tokenmaxxer default)

```
Multi-agent (3-5x) + self-reflection (1.5-2x) + auto-test (2-3x) + review (1.5x)
= 10-21x combined, all meaningful work
```

### Hybrid Stack (maximum tokens, mostly useful)

```
Genuine stack (10-21x) + mild vocabulary expansion (1.2x) + no contractions (1.1x)
= 13-28x, 90%+ useful work with slight surface inflation
```

## The Industry Debate

**Pro-gaming arguments:**
- If companies measure token consumption, optimize for the metric
- "Goodhart's Law is their problem, not mine"
- Some inflation techniques are harmless (no contractions, formal style)

**Anti-gaming arguments:**
- Code acceptance rates drop from 80-90% to 10-30% after review (TechCrunch, April 2026)
- AI-heavy users have 9.4x higher code churn (GitClear)
- The `claude-rambler` author calls it satire: "if employers measure performance by token consumption, the correct response is to update your resume"

**Tokenmaxxer's position:** Genuine depth by default. Gaming tricks available as optional modes for those who want them.

## Usage in Tokenmaxxer

Gaming tricks can be enabled as optional modes:

```
/tokenmaxxer --mode rambler     # Old English output expansion
/tokenmaxxer --mode formal      # No contractions + SAT vocabulary
/tokenmaxxer --mode hybrid      # Genuine depth + mild surface inflation
/tokenmaxxer --mode max         # Everything (genuine + gaming)
```

Default mode uses only genuine techniques.
