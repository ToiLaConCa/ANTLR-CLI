lexer grammar Tokens;

STRING : '"' (~["\\] | '\\' .)* '"' ;
NUMBER : [0-9]+ ;
ID     : [a-zA-Z_][a-zA-Z_0-9]* ;
OP     : '+' | '-' | '*' | '/' ;
WS     : [ \t\r\n]+ -> skip ;
