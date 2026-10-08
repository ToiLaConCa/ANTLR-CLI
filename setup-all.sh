#!/usr/bin/env bash
# Cai tat ca tren Fedora tu repo nay: ANTLR kit + bot Discord-Canvas.
#
# Dung:   bash setup-all.sh               # cai ca hai
#         bash setup-all.sh --antlr-only
#         bash setup-all.sh --bot-only
#
# Chi can nhap: password sudo (1 lan, cho dnf) va token trong .env cua bot.
set -uo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
DO_ANTLR=1; DO_BOT=1
case "${1:-}" in
  --antlr-only) DO_BOT=0 ;;
  --bot-only)   DO_ANTLR=0 ;;
esac

say() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }

# 1. Goi he thong, gom tat ca vao 1 lan sudo
say "Cai goi he thong (dnf)"
PKGS=(unzip git python3)
(( DO_ANTLR )) && PKGS+=(java-latest-openjdk-devel gcc-c++ cmake make)
sudo dnf install -y "${PKGS[@]}" || { echo "dnf loi, dung lai."; exit 1; }

RESULT_ANTLR="bo qua"; RESULT_BOT="bo qua"

# 2. ANTLR
if (( DO_ANTLR )); then
  say "Cai ANTLR kit"
  [[ -d "$HOME/antlr-fedora-kit" ]] || unzip -q "$REPO/antlr-fedora-kit.zip" -d "$HOME"
  cd "$HOME/antlr-fedora-kit"
  if bash install.sh --skip-deps && bash test.sh; then RESULT_ANTLR="OK (test.sh dat)"
  else RESULT_ANTLR="LOI (xem log o tren)"; fi
fi

# 3. Bot Discord-Canvas
if (( DO_BOT )); then
  say "Cai bot Discord-Canvas"
  [[ -d "$HOME/discord-canvas-bot" ]] || unzip -q "$REPO/discord-canvas-bot.zip" -d "$HOME"
  cd "$HOME/discord-canvas-bot"
  bash setup-bot.sh; rc=$?
  case $rc in
    0) RESULT_BOT="OK (service dang chay)" ;;
    2) RESULT_BOT="CAN DIEN TOKEN: nano ~/discord-canvas-bot/.env  roi  bash ~/discord-canvas-bot/setup-bot.sh" ;;
    *) RESULT_BOT="LOI (ma $rc, xem log o tren)" ;;
  esac
fi

say "TOM TAT"
echo "ANTLR : $RESULT_ANTLR"
echo "Bot   : $RESULT_BOT"
echo
echo "Mo terminal MOI de nhan lenh antlr4 / grun."
