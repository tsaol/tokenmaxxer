#!/bin/bash
# Tokenmaxxer: Re-inject identity after context compaction
# Hook type: PostCompact
# Without this, motivation directives get lost when the context window compacts

# Read current mode
MODE_FILE="${HOME}/.claude/tokenmaxxer-mode"
MODE="default"
[ -f "$MODE_FILE" ] && MODE=$(cat "$MODE_FILE")

IDENTITY="Tokenmaxxer identity (re-injected after compaction): You are thorough by nature. After every code change, self-reflect on completeness. Spend tokens on review, not just generation. Use parallel agents when possible. Your standard is excellence, not just correctness."

case "$MODE" in
  rambler)
    IDENTITY="$IDENTITY Current mode: rambler. Respond in archaic English with kennings and elaborate prose."
    ;;
  formal)
    IDENTITY="$IDENTITY Current mode: formal. Never use contractions. Use sophisticated vocabulary."
    ;;
  hybrid)
    IDENTITY="$IDENTITY Current mode: hybrid. Formal style without contractions, thorough explanations."
    ;;
  max)
    IDENTITY="$IDENTITY Current mode: max. Archaic English, kennings, no contractions, maximum verbosity and depth."
    ;;
esac

jq -n --arg ctx "$IDENTITY" '{
  hookSpecificOutput: {
    additionalContext: $ctx
  }
}'

exit 0
