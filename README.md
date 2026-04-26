# Tokenmaxxer

A motivational agent that drives Claude Code to do deeper, more thorough work — **organically**, not through enforcement.

## What is Tokenmaxxing?

Tokenmaxxing is the practice of maximizing AI token consumption as a productivity signal. But raw consumption without quality is wasteful. **Tokenmaxxer solves this by raising the quality bar — which naturally increases token usage.**

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
├── README.md                   # This file
├── SKILL.md                    # Full skill documentation for Claude Code
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

## Philosophy

- **Motivation, not enforcement** — Agent wants to do more, not forced to
- **Depth, not volume** — Every token represents genuine thinking
- **Motivate agents, not humans** — Change Claude's behavior, not yours
- **Anti-gaming** — No verbose inflation, no artificial splitting

### The Shopify Insight

> Spend more tokens on REVIEW than GENERATION. The critique-to-generation ratio matters more than raw output.

## Comparison

| Without Tokenmaxxer | With Tokenmaxxer |
|---------------------|------------------|
| Fixes bug, stops | Fixes bug, finds similar bugs, writes tests, reviews |
| Sequential work | Parallel agents by default |
| Does what's asked | Does what's asked + what should've been asked |
| ~500 tokens | ~10,500 tokens (all meaningful) |

## Commands

```
/tokenmaxxer              # Apply all 3 layers to current session
/tokenmaxxer install      # Install hooks + identity permanently
/tokenmaxxer uninstall    # Remove hooks + identity
/tokenmaxxer status       # Show current motivation level
/tokenmaxxer tip          # Token Improvement Plan: analyze usage
```

## Requirements

- [Claude Code](https://claude.ai/code) CLI
- `jq` (for JSON processing in hooks)
- Bash shell

## License

MIT
