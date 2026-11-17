#!/usr/bin/env bash
# Chay thu 3 vi du va so ket qua voi ket qua mong doi trong guide/slide.
set -uo pipefail
KIT="$(cd "$(dirname "$0")" && pwd)"
export ANTLR_HOME="${ANTLR_HOME:-$HOME/antlr}"
[[ -f "$HOME/.config/antlr/env.sh" ]] && source "$HOME/.config/antlr/env.sh"

# Chay tren ban sao tam de khong lam ban thu muc examples
WORK="$(mktemp -d)"; trap 'rm -rf "$WORK"' EXIT
cp -r "$KIT/examples" "$WORK/"
pass=0; fail=0
check() { # check <ten> <ket qua that> <chuoi mong doi>
  if grep -qF -- "$3" <<<"$2"; then echo "  [OK]   $1"; pass=$((pass+1));
  else echo "  [FAIL] $1"; echo "         can thay: $3"; echo "         nhan duoc: $2"; fail=$((fail+1)); fi
}

echo "1) Tokens + grun (slide)"
out=$(bash "$WORK/examples/tokens/run.sh" 2>&1)
check "loi token ';'"      "$out" "token recognition error at: ';'"
check "34 -> NUMBER"       "$out" "='34',<NUMBER>,1:0"
check "rt -> ID"           "$out" "='rt',<ID>,1:2"

echo "2) Calculator (C++ parser)"
out=$(bash "$WORK/examples/calculator/build.sh" 2>&1)
check "parse tree" "$out" "Parse tree: (expr (expr 3) + (expr (expr 5) * (expr ( (expr (expr 2) - (expr 8)) ))))"

echo "3) Identifier (C++ lexer)"
bash "$WORK/examples/identifier/build.sh" >/dev/null 2>&1
out=$(echo 34rt | "$WORK/examples/identifier/iden" 2>&1)
check "34rt khong hop le"    "$out" "Invalid identifier!"
out=$(echo my_var1 | "$WORK/examples/identifier/iden" 2>&1)
check "my_var1 hop le"       "$out" "Valid C++ identifier: my_var1"

echo; echo "Ket qua: $pass dat, $fail loi"
[[ $fail -eq 0 ]]
