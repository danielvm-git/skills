#!/usr/bin/env bash
# Given a skill exists
# Verification: Ensure current workspace is a skill project
if [[ -f "SKILL.md" ]]; then
  exit 0
else
  echo "No SKILL.md found."
  exit 1
fi
