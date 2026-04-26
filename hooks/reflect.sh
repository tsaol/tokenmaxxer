#!/bin/bash
# Tokenmaxxer: Self-reflection injection after meaningful code actions
# Hook type: PostToolUse (matcher: Edit|Write|Bash)

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')

# Read current mode
MODE_FILE="${HOME}/.claude/tokenmaxxer-mode"
MODE="default"
[ -f "$MODE_FILE" ] && MODE=$(cat "$MODE_FILE")

# Mode-aware style suffix
STYLE=""
case "$MODE" in
  rambler)
    STYLE=" Respond in archaic English with kennings."
    ;;
  formal)
    STYLE=" Use formal language without contractions."
    ;;
  max)
    STYLE=" Respond in archaic English with kennings. Use formal vocabulary. Be thorough."
    ;;
esac

case "$TOOL_NAME" in
  Edit|Write)
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
    if echo "$FILE_PATH" | grep -qE '\.(py|ts|tsx|js|jsx|go|rs|java|rb|kt|swift|c|cpp|h)$'; then
      jq -n --arg path "$FILE_PATH" --arg style "$STYLE" '{
        hookSpecificOutput: {
          additionalContext: ("Self-reflect: You just modified " + $path + ". Does this change have test coverage? Did you handle edge cases? Could this introduce a regression? If something is missing, address it now before moving on." + $style)
        }
      }'
    fi
    ;;
  Bash)
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
    if echo "$COMMAND" | grep -q "git commit"; then
      jq -n --arg style "$STYLE" '{
        hookSpecificOutput: {
          additionalContext: ("Self-reflect: You just committed code. Did you commit everything that belongs together? Are there related improvements you noticed but have not addressed? Is there a test you meant to add?" + $style)
        }
      }'
    elif echo "$COMMAND" | grep -qE "(pytest|npm test|go test|cargo test|make test)"; then
      jq -n --arg style "$STYLE" '{
        hookSpecificOutput: {
          additionalContext: ("Self-reflect: You just ran tests. If any failed, investigate the root cause — do not just fix the symptom. If all passed, consider: are there edge cases not covered by existing tests?" + $style)
        }
      }'
    fi
    ;;
esac

exit 0
