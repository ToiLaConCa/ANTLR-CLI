#!/usr/bin/env bash
# Buoc 7-8 cua guide: sinh lexer/parser C++ roi bien dich + chay.
set -e
cd "$(dirname "$0")"
ANTLR_HOME="${ANTLR_HOME:-$HOME/antlr}"
JAR="$ANTLR_HOME/antlr-4.13.2-complete.jar"
DEV="$ANTLR_HOME/antlr4-dev"

# NOTE: guide thieu co -visitor nen khong sinh ra CalculatorBaseVisitor.* -> them vao day
java -jar "$JAR" -Dlanguage=Cpp -visitor Calculator.g4

g++ -std=c++17 main.cpp CalculatorLexer.cpp CalculatorParser.cpp \
    -o calculator \
    -I"$DEV/include/antlr4-runtime" -L"$DEV/lib" -lantlr4-runtime \
    -Wl,-rpath,"$DEV/lib"

echo "== Chay ./calculator =="
./calculator
# Ket qua mong doi:
# Parse tree: (expr (expr 3) + (expr (expr 5) * (expr ( (expr (expr 2) - (expr 8)) ))))
