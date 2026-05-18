#!/usr/bin/env bash
# audit-compliance.sh — Agentic Gherkin Compliance Harness (LLM-Judge Upgrade)

# --- Help Message ---
show_help() {
  cat <<EOF
Usage: bash scripts/audit-compliance.sh [feature-file] [options]

Options:
  --help            Show this help message
  --dry-run         Parse the feature file without starting the judge loop
  --scenario [name] Run only a specific scenario
  --judge [type]    Judge type: 'binary' (exit code, default) or 'gemini' (LLM-judged)
  --model [name]    Model name to use for judging

EOF
}

if [[ $# -eq 0 ]] || [[ "$1" == "--help" ]]; then
  show_help
  exit 0
fi

FEATURE_FILE="$1"
shift

DRY_RUN=false
SCENARIO_FILTER=""
JUDGE="binary"
MODEL=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --scenario)
      SCENARIO_FILTER="$2"
      shift 2
      ;;
    --judge)
      JUDGE="$2"
      shift 2
      ;;
    --model)
      MODEL="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done

if [[ -f "$FEATURE_FILE" ]]; then
  : # File exists, proceed
else
  echo "Error: Feature file not found: $FEATURE_FILE"
  exit 1
fi

# --- Audit Loop ---
REPORT_FILE="specs/audit/reports/audit-$(date +%Y%m%d-%H%M%S).md"
mkdir -p specs/audit/reports

echo "# Audit Report: $FEATURE_FILE" > "$REPORT_FILE"
echo "Date: $(date)" >> "$REPORT_FILE"
echo "Mode: Autonomous Verification (Judge: $JUDGE)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

TOTAL_PASS=0
TOTAL_FAIL=0

process_step() {
  local step="$1"
  local feature_name="$2"
  local scenario_name="$3"
  echo "    [STEP] $step"
  
  if [[ "$DRY_RUN" == "true" ]]; then
    return 0
  fi

  # Sanitize step name for file lookup: lowercase, kebab-case, remove special chars
  local sanitized_step
  sanitized_step=$(echo "$step" | sed 's/^(Given|When|Then|And|But) //' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')
  local step_script="specs/audit/steps/${sanitized_step}.sh"

  if [[ -f "$step_script" ]]; then
    echo "    [EXEC] Gathering evidence: $step_script"
    # Capture both stdout and stderr as evidence
    local evidence
    evidence=$(bash "$step_script" 2>&1)
    local exit_code=$?

    if [[ "$JUDGE" == "gemini" ]]; then
      echo "    [JUDGE] Sending evidence to Gemini..."
      
      # List of models to try in case of failure (Quota/Availability)
      local models=("gemini-1.5-flash" "gemini-1.5-flash-8b" "gemini-2.0-flash-exp" "gemini-1.5-pro" "gemini-2.0-flash-thinking-exp")
      
      # Use provided model first if specified
      if [[ -n "$MODEL" ]]; then
        models=("$MODEL" "${models[@]}")
      fi

      local model_output=""
      local success=false
      local last_error=""

      for m in "${models[@]}"; do
        echo "    [JUDGE] Attempting with model: $m"
        local model_flags="-m $m"
        
        # Build prompt
        local prompt="You are the Master Test Architect judging a compliance audit.
Benchmark Feature: $feature_name
Scenario: $scenario_name
Compliance Step: $step

Evidence gathered from the codebase:
---
$evidence
---

Based on the benchmark principles, does this evidence demonstrate compliance?
Respond strictly in the following format:
VERDICT: [PASS/FAIL]
RATIONALE: [One sentence explanation]"

        model_output=$(gemini $model_flags -p "$prompt" 2>&1)
        if [[ $? -eq 0 ]]; then
          success=true
          break
        else
          last_error=$model_output
          echo "    [WARN] Model $m failed. Trying next..."
        fi
      done

      if [[ "$success" == "true" ]]; then
        local verdict
        verdict=$(echo "$model_output" | grep "VERDICT:" | cut -d' ' -f2)
        local rationale
        rationale=$(echo "$model_output" | grep "RATIONALE:" | cut -d' ' -f2-)

        if [[ "$verdict" == "PASS" ]]; then
          echo "      Result: PASS (Model Verdict: $m)"
          echo "- [x] $step (PASS) - $rationale" >> "$REPORT_FILE"
          ((TOTAL_PASS++))
        else
          echo "      Result: FAIL (Model Verdict: $m)"
          echo "- [ ] $step (FAIL) - $rationale" >> "$REPORT_FILE"
          ((TOTAL_FAIL++))
        fi
      else
        echo "      Result: FAIL (All models failed)"
        echo "- [ ] $step (FAIL) - All models exhausted. Last error: $last_error" >> "$REPORT_FILE"
        ((TOTAL_FAIL++))
      fi
    else
      # Binary Judge (Legacy)
      if [[ $exit_code -eq 0 ]]; then
        echo "      Result: PASS"
        echo "- [x] $step (PASS)" >> "$REPORT_FILE"
        ((TOTAL_PASS++))
      else
        echo "      Result: FAIL"
        echo "- [ ] $step (FAIL) - $evidence" >> "$REPORT_FILE"
        ((TOTAL_FAIL++))
      fi
    fi
  else
    # Fallback for missing evidence
    echo "      Result: FAIL (Missing evidence: $step_script)"
    echo "- [ ] $step (FAIL) - No verification script found at $step_script" >> "$REPORT_FILE"
    ((TOTAL_FAIL++))
  fi
}

CURRENT_FEATURE=""
CURRENT_SCENARIO=""
IN_SCENARIO=false

exec 3< "$FEATURE_FILE"
while IFS= read -r line <&3; do
  line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  
  if [[ "$line" =~ ^Feature: ]]; then
    CURRENT_FEATURE="${line#Feature: }"
    echo "FEATURE: $CURRENT_FEATURE"
    echo "## Feature: $CURRENT_FEATURE" >> "$REPORT_FILE"
  elif [[ "$line" =~ ^Scenario: ]]; then
    CURRENT_SCENARIO="${line#Scenario: }"
    if [[ -n "$SCENARIO_FILTER" && "$CURRENT_SCENARIO" != "$SCENARIO_FILTER" ]]; then
      IN_SCENARIO=false
      continue
    fi
    IN_SCENARIO=true
    echo "  SCENARIO: $CURRENT_SCENARIO"
    echo "### Scenario: $CURRENT_SCENARIO" >> "$REPORT_FILE"
  elif [[ "$line" =~ ^(Given|When|Then|And|But)\  ]]; then
    if [[ "$IN_SCENARIO" == "true" ]]; then
      process_step "$line" "$CURRENT_FEATURE" "$CURRENT_SCENARIO"
    fi
  fi
done
exec 3<&-

echo ""
echo "Audit Summary:"
echo "  PASS: $TOTAL_PASS"
echo "  FAIL: $TOTAL_FAIL"
echo "Report saved to: $REPORT_FILE"
