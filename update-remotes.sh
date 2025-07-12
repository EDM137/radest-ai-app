#!/usr/bin/env bash
set -e

# 1) Find your radest-ai-app directory (up to 3 levels deep)
APP_DIR=$(find "$(pwd)" -maxdepth 3 -type d -iname "*radest-ai-app*" | head -n1)
if [ -z "$APP_DIR" ]; then
  echo "❌ Could not locate any 'radest-ai-app' folder."
  exit 1
fi
echo "→ Found app folder: $APP_DIR"

# 2) Grab its git origin URL
APP_URL=$(git -C "$APP_DIR" remote get-url origin)
if [ -z "$APP_URL" ]; then
  echo "❌ No 'origin' remote in $APP_DIR."
  exit 1
fi
echo "→ Using origin URL: $APP_URL"

# 3) Loop over every subfolder with a .git and reset its origin
for repo in */; do
  if [ -d "$repo/.git" ]; then
    echo "Updating $repo → $APP_URL"
    git -C "$repo" remote set-url origin "$APP_URL"
  fi
done

echo "✅ All local repos now point to $APP_URL"

