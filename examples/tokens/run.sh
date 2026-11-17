#!/usr/bin/env bash
# Vi du trong slide: Tokens.g4 + grun (TestRig), chay tren Linux.
# Tuong duong:  grun.bat + "grun Tokens tokens -tokens" tren Windows.
set -e
cd "$(dirname "$0")"
ANTLR_HOME="${ANTLR_HOME:-$HOME/antlr}"
JAR="$ANTLR_HOME/antlr-4.13.2-complete.jar"

echo "== Buoc 2: sinh code Java tu Tokens.g4 =="
java -jar "$JAR" Tokens.g4

echo "== Buoc 3: bien dich =="
javac -cp "$JAR:." Tokens*.java

echo "== Chay: grun Tokens tokens -tokens   (input: 34rt;) =="
# Tren Windows ket thuc input bang Ctrl+Z, tren Linux dung Ctrl+D (hoac pipe nhu duoi day)
printf '34rt;\n' | java -cp "$JAR:." org.antlr.v4.gui.TestRig Tokens tokens -tokens

echo
echo "Muon tu go input: chay  grun Tokens tokens -tokens  roi go chuoi, ket thuc bang Ctrl+D"
