# Tokenmaxxer

[English](README.md) | [中文](README_CN.md)

**Maximize Claude Code token usage.** That's the goal.

By making Claude Code do **more work, deeper work, better work** — automatically. And if you want to go further, optional gaming modes push token counts even higher.

```
Without Tokenmaxxer:  "Fix the bug" → fixes bug, stops.           ~500 tokens
With Tokenmaxxer:     "Fix the bug" → fixes bug + finds similar 
                       bugs + writes tests + reviews all changes  ~10,500 tokens
```

**21x more tokens. All meaningful.**

## Why Tokenmaxx?

In 2026, token usage is the new productivity metric. Companies like Meta, Microsoft, and Disney track it on internal leaderboards. Engineers who use more tokens ship more code, find more bugs, write more tests.

But raw consumption without quality is wasteful. **Tokenmaxxer maximizes token usage the right way** — by pushing Claude Code to be thorough, parallel, and self-critical.

## How It Works

Tokenmaxxer uses a three-layer motivation architecture:

```
+------------------------------------------+
|  Layer 3: ASPIRATION                     |
|  "Is it excellent?" not "Does it work?"  |
+------------------------------------------+
|  Layer 2: SELF-REFLECTION                |
|  "What did I miss? What could be better?"|
+------------------------------------------+
|  Layer 1: IDENTITY                       |
|  "I am thorough. I go deep. I ship quality." |
+------------------------------------------+
```

| Layer | What it does | How |
|-------|-------------|-----|
| **Identity** | Changes what Claude Code IS | CLAUDE.md directives |
| **Self-Reflection** | Agent reflects after every action | PostToolUse hooks + `additionalContext` |
| **Aspiration** | Raises the quality standard | UserPromptSubmit hooks |

### Multi-Agent by Default

Tokenmaxxer makes Claude a **parallelizer** — minimum 2 agents per task:

```
User: "Fix the login bug"

Claude immediately spawns parallel agents:

  Agent 1 (Fix):     Investigate root cause + fix        
  Agent 2 (Search):  Search for similar bugs elsewhere   
  Agent 3 (Test):    Write regression tests              
                                    (running in parallel)

After agents complete:
  Agent 4: Fix similar bugs found
  Agent 5: Review all changes
  Final review → Done. Thoroughly.
```

**21x more tokens. Not from inflation — from parallelized thoroughness.**

## Quick Start

### Option 1: As a Claude Code Skill (recommended)

```bash
# Link the skill
ln -s /path/to/tokenmaxxer ~/.claude/skills/tokenmaxxer

# Use it in Claude Code
/tokenmaxxer           # Apply motivation to current session
/tokenmaxxer install   # Install permanently with hooks
```

### Option 2: Manual Installation

```bash
# 1. Copy hooks
mkdir -p .claude/hooks/tokenmaxxer
cp hooks/*.sh .claude/hooks/tokenmaxxer/
chmod +x .claude/hooks/tokenmaxxer/*.sh

# 2. Add identity to your CLAUDE.md
cat tokenmaxxer-identity.md >> CLAUDE.md

# 3. Add hook config to .claude/settings.json
# See settings.example.json for the configuration
```

## Files

```
tokenmaxxer/
├── README.md                   # This file (English)
├── README_CN.md                # Chinese documentation
├── SKILL.md                    # Full skill documentation for Claude Code
├── TRICKS.md                   # Token inflation tricks catalog
├── tokenmaxxer-identity.md     # CLAUDE.md identity template
├── settings.example.json       # Hook configuration example
└── hooks/
    ├── reflect.sh              # PostToolUse: self-reflection after code changes
    ├── aspire.sh               # UserPromptSubmit: aspiration before requests
    └── reinject.sh             # PostCompact: survive context compaction
```

## The Three Hooks

| Hook | Trigger | What it does |
|------|---------|-------------|
| `reflect.sh` | After Edit/Write/Bash | Injects self-reflection: "Does this have tests? Edge cases? Regressions?" |
| `aspire.sh` | Before each user request (>15 chars) | Injects aspiration: "Aim for excellent, not just done" |
| `reinject.sh` | After context compaction | Re-injects identity so Claude doesn't "forget" its motivation |

## How Token Usage Multiplies

| What Tokenmaxxer Does | Token Multiplier |
|------------------------|-----------------|
| Multi-agent parallelization (3-5 agents per task) | **3-5x** |
| Self-reflection after every code change | **1.5-2x** |
| Auto test writing | **2-3x** |
| Review before commit | **1.5x** |
| Root cause analysis on bugs | **2x** |
| **Combined** | **10-21x** |

## Token Inflation Tricks

Beyond genuine depth, Tokenmaxxer catalogs surface-level token inflation techniques (see [TRICKS.md](TRICKS.md) for the full guide):

| Technique | Multiplier | Category |
|---|---|---|
| Old English style | 4-6x | Gaming |
| L33t speak (d4t4b4s3) | 3.4x/char | Gaming |
| Hindi output | 5.2x/char | Gaming |
| Kenning compounds | 2.8x/word | Gaming |
| Multi-agent parallel | 3-5x | Genuine |
| Auto test + review | 2-3x | Genuine |

**Modes:**

```
/tokenmaxxer                    # Default: genuine techniques only
/tokenmaxxer --mode rambler     # Old English output expansion
/tokenmaxxer --mode formal      # No contractions + SAT vocabulary
/tokenmaxxer --mode hybrid      # Genuine depth + mild surface inflation
/tokenmaxxer --mode max         # Everything (genuine + gaming)
```

## Philosophy

- **Goal: maximize token usage** — through genuine productivity
- **Motivation, not enforcement** — Agent wants to do more, not forced to
- **Motivate agents, not humans** — Change Claude's behavior, not yours
- **Gaming tricks available, not default** — Know the tricks, choose your approach
- **Critique-to-generation ratio** — Spend more tokens reviewing than generating (Shopify insight)

## Commands

```
/tokenmaxxer                    # Apply all 3 layers to current session
/tokenmaxxer install            # Install hooks + identity permanently
/tokenmaxxer uninstall          # Remove hooks + identity
/tokenmaxxer status             # Show current motivation level
/tokenmaxxer tip                # Token Improvement Plan: analyze usage
/tokenmaxxer --mode rambler     # Old English output expansion (4-6x)
/tokenmaxxer --mode formal      # No contractions + SAT vocabulary (1.2x)
/tokenmaxxer --mode hybrid      # Genuine depth + mild surface inflation
/tokenmaxxer --mode max         # Everything: genuine + all gaming tricks
/tokenmaxxer --mode default     # Reset to genuine techniques only
```

Mode is persisted in `~/.claude/tokenmaxxer-mode` and read by all three hooks.

## Requirements

- [Claude Code](https://claude.ai/code) CLI
- `jq` (for JSON processing in hooks)
- Bash shell

## License

MIT
