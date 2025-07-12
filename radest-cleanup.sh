#!/bin/bash

echo "🧹 RADEST Cleanup Activated..."

# Safe zones
SAFE_DIRS=("$HOME/Downloads" "$HOME/.Trash" "$HOME/Library/Caches")

for dir in "${SAFE_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    echo "📁 Clearing: $dir"
    rm -rf "$dir"/*
  fi
done

# Scan for large non-critical files
echo "🔍 Scanning for large non-IP files..."

find ~ -type f -size +100M \
  ! -name "*RADEST*" \
  ! -name "*.sh" \
  ! -name "*.md" \
  ! -name "*.json" \
  ! -path "*/KINDRAai/*" \
  -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'

echo "✅ Initial cleanup complete. Use discretion before manually deleting flagged files."

