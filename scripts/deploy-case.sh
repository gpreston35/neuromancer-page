#!/usr/bin/env bash
set -euo pipefail

APP_DIR="${APP_DIR:-/opt/neuromancer-page}"
WEB_DIR="${WEB_DIR:-/var/www/neuromancer-page}"
BRANCH="${BRANCH:-main}"
EXPECTED_TEXT="${EXPECTED_TEXT:-Brought to you by Neuromancer}"

cd "$APP_DIR"

echo "==> Updating repository"
git fetch origin "$BRANCH"
git checkout "$BRANCH"
git pull --ff-only origin "$BRANCH"

echo "==> Installing dependencies"
npm ci

echo "==> Building for server root"
npm run build:server

echo "==> Publishing build to $WEB_DIR"
sudo mkdir -p "$WEB_DIR"
sudo rsync -av --delete dist/ "$WEB_DIR"/

echo "==> Reloading Caddy"
sudo systemctl reload caddy

echo "==> Verifying local HTTP response"
curl -fsS http://localhost/ -o /tmp/neuromancer-case-index.html
grep -q '<div id="root"></div>' /tmp/neuromancer-case-index.html
asset_path="$(grep -o '/assets/[^" ]*\.js' /tmp/neuromancer-case-index.html | head -1)"
if [[ -z "$asset_path" ]]; then
  echo "Could not find built JS asset path in served HTML" >&2
  exit 1
fi
curl -fsS "http://localhost${asset_path}" -o /tmp/neuromancer-case-app.js
grep -q "$EXPECTED_TEXT" /tmp/neuromancer-case-app.js

echo "Deploy verified: $EXPECTED_TEXT"
