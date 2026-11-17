#!/usr/bin/env bash
# Example 1 cua guide: bo nhan dien identifier bang ANTLR + C++.
set -e
cd "$(dirname "$0")"
ANTLR_HOME="${ANTLR_HOME:-$HOME/antlr}"
JAR="$ANTLR_HOME/antlr-4.13.2-complete.jar"
DEV="$ANTLR_HOME/antlr4-dev"

java -jar "$JAR" -Dlanguage=Cpp CIdentifier.g4

g++ -std=c++17 main.cpp CIdentifier.cpp \
    -o iden \
    -I"$DEV/include/antlr4-runtime" -L"$DEV/lib" -lantlr4-runtime \
    -Wl,-rpath,"$DEV/lib"

echo "Da build xong. Chay thu:"
echo "  echo 34rt | ./iden     # -> Invalid identifier!"
echo "  echo my_var1 | ./iden  # -> Valid C++ identifier: my_var1"
