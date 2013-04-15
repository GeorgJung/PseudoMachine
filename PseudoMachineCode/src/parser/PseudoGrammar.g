grammar PseudoGrammar;

options {
  language = Java;
  backtrack = true;
}

algorithm  : 'algorithm' ID ('inputs' declist)? ('outputs' declist)? 'localvar' declist 'begin' statement;
index   :  '[' (INTEGER | statement) ']';
indexing   : '[' value '...' value ']' ;
idlist  : ID ',' idlist  | ID ;
assign  : 'set' ID 'to' ID;
assignlist  : assign ',' assignlist | assign ;
decl  :  'number'ID indexing | 'data' ID indexing ;
declist : decl ',' declist  | decl ;
statement : assignment  | conditional | iterative | print | read | invocation ;


assignment : 'set' ID index 'to' (arithexpr | dataexpr) ; 
//sequential : statement ';' statement;
conditional : 'if' condition 'then' statement 'else' statement 'endif' | 'if' condition 'then' statement 'endif';
iterative  : 'while' condition 'do' statement 'loop';
print : 'print' (dataexpr | arithexpr) ;
read : 'read' idlist;
invocation  : 'run' ID 'inputs' assignlist 'outputs' assignlist 'done';
condition : disjunction ;
disjunction : conjunction 'or' disjunction | conjunction;
conjunction  : negation 'and' conjunction | negation;
negation : 'not' atom | atom;
atom : boolexpr | '('disjunction ')' ;
boolexpr : arithexpr ('=' | '<>' | '<' | '>' | '<=' | '>=') arithexpr;
arithexpr : multiplication ('+' | '-') arithexpr | multiplication;
multiplication  : negexp ('*' | '/' | '%') multiplication | negexp;
negexp :'-' value | value | '('arithexpr')' ;
value : ID index | INTEGER ;
dataexpr : ' " '  ' " ';

INTEGER  :   ('1'..'9')('0'..'9')* ;
//NEWLINE: '\r'? '\n' ;
WS : (' ' | '\t' | '\r' | '\n' )+ { $channel=HIDDEN; } ;
ID : ('a'..'z')+ ;
