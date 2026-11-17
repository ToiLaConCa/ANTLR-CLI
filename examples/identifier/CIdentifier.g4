lexer grammar CIdentifier;

IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]* ;  // Quy tac dung cho dinh danh hop le
WS : [ \t\r\n]+ -> skip ;             // Bo qua khoang trang
