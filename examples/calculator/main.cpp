#include <iostream>
#include <string>
#include "antlr4-runtime.h"
#include "CalculatorLexer.h"
#include "CalculatorParser.h"

using namespace antlr4;
using namespace std;

int main() {
    std::string input = "3 + 5 * (2 - 8)";

    // Tao luong du lieu tu chuoi input
    ANTLRInputStream inputStream(input);
    CalculatorLexer lexer(&inputStream);
    CommonTokenStream tokens(&lexer);
    CalculatorParser parser(&tokens);

    // Phan tich cu phap
    tree::ParseTree *tree = parser.expr();

    // In cay cu phap
    std::cout << "Parse tree: " << tree->toStringTree(&parser) << std::endl;

    return 0;
}
