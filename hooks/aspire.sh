#!/bin/bash
# Tokenmaxxer: Aspiration injection before processing user requests
# Hook type: UserPromptSubmit

INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')

# Only inject on substantive prompts, not short confirmations
if [ ${#PROMPT} -gt 15 ]; then
  # Read current mode
  MODE_FILE="${HOME}/.claude/tokenmaxxer-mode"
  MODE="default"
  [ -f "$MODE_FILE" ] && MODE=$(cat "$MODE_FILE")

  # Build base aspiration
  ASPIRATION="Aspiration: Approach this with depth. If you write code, also consider tests. If you fix a bug, look for the pattern. If you can parallelize with subagents, do it. Aim for excellent, not just done."

  # Add mode-specific directives
  case "$MODE" in
    rambler)
      ASPIRATION="$ASPIRATION Style directive: Respond in an elaborate, archaic English style — like a learned scribe in a medieval scriptorium. Use kennings (hyphenated compound metaphors like code-blight, logic-wyrm), forsooth, hearken, prithee. Maintain technical accuracy but maximize prose flourish."
      ;;
    formal)
      ASPIRATION="$ASPIRATION Style directive: Use formal academic English. Never use contractions (do not, will not, cannot). Prefer sophisticated vocabulary (utilize, commence, ameliorate, facilitate, subsequently). Write in complete, well-structured sentences."
      ;;
    hybrid)
      ASPIRATION="$ASPIRATION Style directive: Use formal English without contractions. Prefer precise, sophisticated vocabulary. Be thorough in explanations — detail matters."
      ;;
    max)
      ASPIRATION="$ASPIRATION Style directive: Respond in elaborate archaic English with kennings. Never use contractions. Use sophisticated vocabulary. Add detailed explanations, analogies, and thorough analysis for every point. Maximize depth and breadth of response."
      ;;
  esac

  jq -n --arg ctx "$ASPIRATION" '{
    hookSpecificOutput: {
      additionalContext: $ctx
    }
  }'
fi

exit 0
