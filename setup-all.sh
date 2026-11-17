#!/usr/bin/env bash
# ANTLR CLI - One-click Setup (#toolbyphichxivnuk - Easier to use)
# Cai dat tat ca dependencies va ANTLR CLI tren Arch, CachyOS, Fedora, Ubuntu, Debian.

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
echo "==> Dang khoi chay cai dat ANTLR CLI (#toolbyphichxivnuk)..."
cd "$REPO"
bash install.sh "$@"
bash test.sh
echo "==> Setup hoan tat! Go 'helpantlr' de xem huong dan."
