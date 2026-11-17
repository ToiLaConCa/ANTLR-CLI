grammar Calculator;

expr: expr ('*'|'/') expr     # MulDiv
    | expr ('+'|'-') expr     # AddSub
    | '(' expr ')'            # Parens
    | NUMBER                  # Number
    ;

NUMBER: [0-9]+;
WS: [ \t\r\n]+ -> skip;  // Bo qua khoang trang
