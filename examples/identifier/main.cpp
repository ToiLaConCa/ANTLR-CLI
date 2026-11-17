#include <iostream>
#include <string>
#include <vector>
#include "antlr4-runtime.h"
#include "CIdentifier.h"

using namespace antlr4;
using namespace std;

int main() {
    string input;
    cout << "Enter identifier: ";
    cin >> input;

    // Chuyen chuoi input thanh stream de ANTLR xu ly
    ANTLRInputStream inputStream(input);

    // Lexer sinh ra tu CIdentifier.g4 (lexer grammar -> class ten CIdentifier)
    CIdentifier lexer(&inputStream);

    // Luu cac token sinh ra tu lexer
    CommonTokenStream tokens(&lexer);
    tokens.fill();

    vector<Token*> allTokens = tokens.getTokens();

    // Hop le khi: dung 2 token (IDENTIFIER + EOF), token dau la IDENTIFIER,
    // va text cua no bang toan bo input.
    if (allTokens.size() != 2 ||
        allTokens[0]->getType() != CIdentifier::IDENTIFIER ||
        allTokens[0]->getText() != input) {
        cout << "Invalid identifier!" << endl;
    } else {
        cout << "Valid C++ identifier: " << allTokens[0]->getText() << endl;
    }

    return 0;
}
