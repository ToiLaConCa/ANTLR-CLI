#!/usr/bin/env bash
# ==============================================================================
# ANTLR CLI - Universal Linux Installer (#toolbyphichxivnuk - Easier to use)
# Supports: Arch Linux, CachyOS, Fedora, Ubuntu, Debian, openSUSE, RHEL
# ==============================================================================

set -euo pipefail

KIT="$(cd "$(dirname "$0")" && pwd)"
ANTLR_HOME="${ANTLR_HOME:-$HOME/antlr}"
DEV="$ANTLR_HOME/antlr4-dev"
JAR_NAME="antlr-4.13.2-complete.jar"
SKIP_DEPS=0
BUILD_CPP=1

for arg in "$@"; do
    case "$arg" in
        --skip-deps) SKIP_DEPS=1 ;;
        --no-cpp|--java-only) BUILD_CPP=0 ;;
        --help|-h)
            echo "ANTLR CLI Installer (#toolbyphichxivnuk - Easier to use)"
            echo "Usage: bash install.sh [OPTIONS]"
            echo "Options:"
            echo "  --skip-deps    Skip automatic system package installation"
            echo "  --no-cpp       Install Java / TestRig CLI only (skip C++ runtime compilation)"
            exit 0
            ;;
    esac
done

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
PURPLE='\033[1;35m'
BOLD='\033[1m'
NC='\033[0m'

say() { printf "\n${CYAN}${BOLD}==> %s${NC}\n" "$*"; }
ok()  { printf "  ${GREEN}[✓] %s${NC}\n" "$*"; }
warn(){ printf "  ${YELLOW}[!] %s${NC}\n" "$*"; }
err() { printf "  ${RED}[✗] %s${NC}\n" "$*"; }

printf "%b\n" "${GREEN}${BOLD}
  █████╗ ███╗   ██╗████████╗██╗     ██████╗      ██████╗██╗     ██╗
 ██╔══██╗████╗  ██║╚══██╔══╝██║     ██╔══██╗    ██╔════╝██║     ██║
 ███████║██╔██╗ ██║   ██║   ██║     ██████╔╝    ██║     ██║     ██║
 ██╔══██║██║╚██╗██║   ██║   ██║     ██╔══██╗    ██║     ██║     ██║
 ██║  ██║██║ ╚████║   ██║   ███████╗██║  ██║    ╚██████╗███████╗██║
 ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝     ╚═════╝╚══════╝╚═╝
>> ANTLR CLI Universal Installer -- Easier to use!
>> Tag: #toolbyphichxivnuk
------------------------------------------------------------------${NC}"

# ------------------------------------------------------------------------------
# 1. Kiem tra phan mem can thiet & Tu dong cai dat (Multi-Distro Auto-Install)
# ------------------------------------------------------------------------------
say "Buoc 1: Kiem tra cac phan mem can thiet tren may"

REQUIRED_CMDS=("java" "javac" "g++" "cmake" "make" "git" "unzip")
MISSING_CMDS=()

for cmd in "${REQUIRED_CMDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        ok "$cmd da co: $(command -v "$cmd")"
    else
        warn "$cmd: CHUA CO"
        MISSING_CMDS+=("$cmd")
    fi
done

if [[ ${#MISSING_CMDS[@]} -gt 0 && $SKIP_DEPS -eq 0 ]]; then
    say "Phat hien thieu goi: ${MISSING_CMDS[*]}. Tien hanh tu dong cai dat..."

    if command -v pacman >/dev/null 2>&1; then
        say "He dieu hanh: Arch Linux / CachyOS / Manjaro (dung pacman)"
        sudo pacman -S --needed --noconfirm jdk-openjdk cmake make gcc git unzip pkg-config
    elif command -v dnf >/dev/null 2>&1; then
        say "He dieu hanh: Fedora / RHEL (dung dnf)"
        sudo dnf install -y java-latest-openjdk-devel gcc-c++ cmake make git unzip
    elif command -v apt-get >/dev/null 2>&1; then
        say "He dieu hanh: Ubuntu / Debian / Linux Mint (dung apt)"
        sudo apt-get update
        sudo apt-get install -y default-jdk g++ cmake make git unzip pkg-config
    elif command -v zypper >/dev/null 2>&1; then
        say "He dieu hanh: openSUSE (dung zypper)"
        sudo zypper install -y java-devel gcc-c++ cmake make git unzip
    else
        err "Khong nhan dien duoc trinh quan ly goi he thong (pacman/dnf/apt/zypper)."
        echo "Vui long tu cai dat cac goi sau roi chay lai: ${MISSING_CMDS[*]}"
        exit 1
    fi
elif [[ ${#MISSING_CMDS[@]} -eq 0 ]]; then
    ok "Tat ca phan mem he thong can thiet da day du! (Bo qua cai goi)"
else
    warn "Chay voi che do --skip-deps, bo qua buoc cai dat goi he thong."
fi

# Kiem tra lai sau khi cai
for cmd in java javac; do
    command -v "$cmd" >/dev/null 2>&1 || { err "Loi: $cmd van chua san sang. Vui long kiem tra JDK."; exit 1; }
done

# ------------------------------------------------------------------------------
# 2. Cai dat ANTLR complete JAR vao ANTLR_HOME
# ------------------------------------------------------------------------------
say "Buoc 2: Cai dat ANTLR Complete JAR vao $ANTLR_HOME"
mkdir -p "$ANTLR_HOME"
if [[ -f "$KIT/jar/$JAR_NAME" ]]; then
    cp -f "$KIT/jar/$JAR_NAME" "$ANTLR_HOME/$JAR_NAME"
    ok "Da sao chep $JAR_NAME vao $ANTLR_HOME"
else
    err "Khong tim thay $KIT/jar/$JAR_NAME! Vui long kiem tra lai bo kit."
    exit 1
fi

# ------------------------------------------------------------------------------
# 3. Build & Install C++ Runtime (Neu can)
# ------------------------------------------------------------------------------
if [[ $BUILD_CPP -eq 1 ]]; then
    if [[ -d "$DEV/include/antlr4-runtime" && -f "$DEV/lib/libantlr4-runtime.a" ]]; then
        ok "C++ Runtime da duoc build va cai dat san tai $DEV (Bo qua build lai)"
    elif command -v cmake >/dev/null 2>&1 && command -v g++ >/dev/null 2>&1; then
        say "Buoc 3: Bien dich ANTLR C++ Runtime (Release mode)"
        BUILD_DIR="$(mktemp -d)"
        cmake -S "$KIT/runtime-cpp" -B "$BUILD_DIR" \
              -DCMAKE_BUILD_TYPE=Release \
              -DCMAKE_INSTALL_PREFIX="$DEV" \
              -DANTLR_BUILD_CPP_TESTS=OFF \
              -DDISABLE_WARNINGS=ON
        cmake --build "$BUILD_DIR" -j"$(nproc)"
        cmake --install "$BUILD_DIR"
        rm -rf "$BUILD_DIR"
        ok "C++ runtime da duoc cai dat vao $DEV"
    else
        warn "Thieu cmake hoac g++, bo qua build C++ runtime (--no-cpp mode)."
    fi
else
    ok "Bo qua build C++ Runtime theo yeu cau (--no-cpp)."
fi

# ------------------------------------------------------------------------------
# 4. Cai dat cac CLI wrappers (antlr4, grun, helpantlr, antlr-cli)
# ------------------------------------------------------------------------------
say "Buoc 4: Cai dat cac lenh CLI vao ~/.local/bin"
mkdir -p "$HOME/.local/bin"

install -m 755 "$KIT/bin/antlr4"    "$HOME/.local/bin/antlr4"
install -m 755 "$KIT/bin/grun"      "$HOME/.local/bin/grun"
install -m 755 "$KIT/bin/helpantlr" "$HOME/.local/bin/helpantlr"
ln -sf "$HOME/.local/bin/helpantlr" "$HOME/.local/bin/antlr-cli"

ok "Cai dat thanh cong cac lenh: antlr4, grun, helpantlr, antlr-cli"

# ------------------------------------------------------------------------------
# 5. Cau hinh Bien moi truong (Auto-config Environment)
# ------------------------------------------------------------------------------
say "Buoc 5: Thiet lap bien moi truong ANTLR_HOME, CLASSPATH, PATH"
mkdir -p "$HOME/.config/antlr"

cat > "$HOME/.config/antlr/env.sh" <<EOF
# ANTLR CLI Environment Configuration (#toolbyphichxivnuk - Easier to use)
export ANTLR_HOME="$ANTLR_HOME"
export CLASSPATH=".:\$ANTLR_HOME/$JAR_NAME:\${CLASSPATH:-}"
export PATH="\$HOME/.local/bin:\$PATH"
export CPLUS_INCLUDE_PATH="$DEV/include/antlr4-runtime:\${CPLUS_INCLUDE_PATH:-}"
export LIBRARY_PATH="$DEV/lib:\${LIBRARY_PATH:-}"
export LD_LIBRARY_PATH="$DEV/lib:\${LD_LIBRARY_PATH:-}"
EOF

cat > "$HOME/.config/antlr/env.fish" <<EOF
# ANTLR CLI Environment Configuration (fish)
set -gx ANTLR_HOME "$ANTLR_HOME"
set -gx CLASSPATH ".:\$ANTLR_HOME/$JAR_NAME"
fish_add_path \$HOME/.local/bin
set -gx CPLUS_INCLUDE_PATH "$DEV/include/antlr4-runtime"
set -gx LIBRARY_PATH "$DEV/lib"
set -gx LD_LIBRARY_PATH "$DEV/lib"
EOF

add_line() { # add_line <file> <line>
    mkdir -p "$(dirname "$1")"; touch "$1"
    grep -qxF "$2" "$1" || echo "$2" >> "$1"
}

add_line "$HOME/.bashrc" 'source "$HOME/.config/antlr/env.sh"'
[[ -f "$HOME/.zshrc" ]] && add_line "$HOME/.zshrc" 'source "$HOME/.config/antlr/env.sh"'

ok "Da tu dong ghi cau hinh vao ~/.bashrc va ~/.config/antlr/env.sh"

# ------------------------------------------------------------------------------
# 6. Hoan tat va Huong dan su dung
# ------------------------------------------------------------------------------
printf "\n${GREEN}${BOLD}==================================================================${NC}\n"
printf "${GREEN}${BOLD} [HOAN TAT] Cai dat ANTLR CLI thanh cong! (#toolbyphichxivnuk)${NC}\n"
printf "${GREEN}${BOLD}==================================================================${NC}\n"
echo
printf "  ${CYAN}1. Ap dung ngay vao terminal hien tai:${NC}\n"
printf "     ${BOLD}source ~/.config/antlr/env.sh${NC}\n\n"
printf "  ${CYAN}2. Xem huong dan su dung toan dien va bat dau ngay:${NC}\n"
printf "     ${BOLD}helpantlr${NC}   (hoac: ${BOLD}antlr4 -helpantlr${NC})\n\n"
printf "  ${CYAN}3. Tao file mau de test ngay lap tuc:${NC}\n"
printf "     ${BOLD}helpantlr --example${NC}\n"
echo "------------------------------------------------------------------"
