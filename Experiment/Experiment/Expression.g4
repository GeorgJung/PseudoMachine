//grammar Expression;

//r : A  ;

//A : P | P '+' A  ;
//P : S | S '*' P  ;
//S : ID  | '(' A ')' ;
//ID : [a-z]+ ;             // match lower-case identifiers
//WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

grammar Expression;


prog:   stat+ ;
                
stat:   expr NEWLINE {System.out.println($expr.value);} ;

expr returns [int value]  :   e=multExpr {$value = $e.value;} ('+' e=multExpr {$value += $e.value;} |   '-' e=multExpr {$value -= $e.value;} )* ;

multExpr returns [int value] :   e=atom {$value = $e.value;} ('*' e=atom {$value *= $e.value;})* ; 

atom returns [int value] :   INT {$value = Integer.parseInt($INT.text);} |   ID  |   '(' expr ')' {$value = $expr.value;} ;

ID : [a-z]+ ;
INT :   [0-9]+ ;
NEWLINE:'\r'? '\n' ;
WS : [ \t\r\n]+ -> skip ;