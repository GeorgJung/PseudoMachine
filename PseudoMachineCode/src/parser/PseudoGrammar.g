 grammar PseudoGrammar;
@header {
import java.util.HashMap;
}

@members {
/** Map variable name to Integer object holding value */
HashMap memory = new HashMap();
}

options {
  language = Java;
  backtrack = true;
}

algorithm  : 'algorithm' ID ('inputs' declist)? ('outputs' declist)? ('localvar' declist)? 'begin' (statement ';')+ 'end' ;
index   :  '[' (INTEGER | statement) ']';
indexing   : '[' valuee '...' valuee ']' ;
idlist  : ID ',' idlist  | ID ;
assign  : 'set' ID 'to' ID;
assignlist  : assign ',' assignlist | assign ;
decl  :  'number'ID (indexing)? | 'data' ID (indexing)? ;
declist : decl ',' declist  | decl ;
statement : (assignment  | conditional | iterative | invocation | read | print ) ;

assignment : 'set' ID (index)? 'to' (arithexpr | dataexpr) {memory.put($ID.text, new Integer($arithexpr.value));} ; 
sequential : statement ';' statement;
conditional : 'if' condition 'then' statement 'else' statement 'endif' | 'if' condition 'then' statement 'endif';
iterative  : 'while' condition 'do' statement 'loop';
print : 'print' (dataexpr | arithexpr) {System.out.println($arithexpr.value);};
read : 'read' idlist;
invocation  : 'run' ID ('inputs' assignlist)? ('outputs' assignlist)? 'done';
condition : disjunction ;
disjunction : conjunction 'or' disjunction | conjunction;
conjunction  : negation 'and' conjunction | negation;
negation : 'not' atom | atom;
atom : boolexpr | '('disjunction ')' ;
boolexpr : arithexpr ('=' | '<>' | '<' | '>' | '<=' | '>=') arithexpr;
arithexpr returns [int value] : e = multiplication {$value = $e.value;} ('+' s=arithexpr {$value += $s.value;} | '-' s=arithexpr {$value -= $s.value;}) | e=multiplication  {$value = $e.value;};
multiplication returns [int value] : e=negexp {$value = $e.value;} ('*' s=multiplication {$value *= $s.value;}| '/' s=multiplication {$value /= $s.value;} | '%' s=multiplication {$value %= $s.value;}) | e=negexp {$value = $e.value;} ;



negexp returns [int value]:'-' valuee | '('arithexpr')' | e=valuee {$value = $e.value;}  ;
valuee returns [int value] : ID  {Integer v = (Integer)memory.get($ID.text);
                                   if ( v!=null ) $value = v.intValue();
                                     else System.err.println("undefined variable "+$ID.text); }(index)? | INTEGER {$value = Integer.parseInt($INTEGER.text);} ;
dataexpr : ' " '  ' " ';

INTEGER  :   ('1'..'9')('0'..'9')* ;
//NEWLINE: '\r'? '\n' ;
//WS : (' ' | '\t' | '\r' | '\n' )+ { $channel=HIDDEN; } ;
WS : (' ' | '\t' | '\r' | '\n' )+ { $setType(Token.SKIP); } ;
ID : ('a'..'z' | 'A'..'Z')+ ;
