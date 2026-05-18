#!/usr/bin/env bash
# And files should remain under 500 lines (Newspaper Metaphor)
FAILS=$(find . -maxdepth 2 -name "*.md" -o -name "*.sh" -o -name "*.java" | xargs wc -l | awk '$1 > 500 && $2 != "total" {print $2}')

if [[ -z "$FAILS" ]]; then
  exit 0
else
  echo "Files exceeding 500 lines: $FAILS"
  exit 1
fi
