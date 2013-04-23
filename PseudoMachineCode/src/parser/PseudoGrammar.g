 grammar test;
 options {
  language = Java;
}
@header {
import java.util.HashMap;
}

@members {
/** Map variable name to Integer object holding value */
HashMap memory = new HashMap();
}


algorithm  : 'algorithm' ID ('inputs' declist)? ('outputs' declist)? ('localvar' declist)? 'begin' statement  'end' ;
index   :  '[' arithexpr ']';
indexing   : '[' valuee '...' valuee ']' ;
idlist  : ID ',' idlist  | ID ;
assign  : 'set' ID 'to' ID;
assignlist  : assign ',' assignlist | assign ;
decl  :  'number'ID (indexing)? | 'data' ID (indexing)? ;
declist : decl (',' declist)? ;
statement : conditional morestatement | iterative morestatement | read morestatement | invocation morestatement | print morestatement | assignment morestatement ;

assignment : 'set' ID (index)? 'to' (arithexpr | dataexpr) {memory.put($ID.text, new Integer($arithexpr.value));} ; 
morestatement : ';' statement | ; 
// Remember to write about the necessity of left-factorizing the mutually left-recursive setting of having the sequential as a control flow construct as theoretically sound. Rule: "sequential : statement  | morestatement ;"
alternative : 'else' statement 'endif' | 'endif' ;
conditional : 'if' condition 'then' statement alternative ;
iterative  : 'while' condition 'do' statement 'loop';
print : 'print' (dataexpr | arithexpr) {System.out.println($arithexpr.value);} | 'print' '"'ID'"' {System.out.println($ID.text);} ;
read : 'read' idlist;
invocation  : 'run' ID 'inputs' assignlist 'outputs' assignlist 'done';
condition : disjunction ;
disjunction : conjunction ( 'or ' disjunction )? ; // change all left-factorized alternatives back to question mark syntax (maybe except for morestatement)
conjunction  : negation ( 'and' negation  )? ;
negation : 'not' atom | atom ;
//atom options { backtrack = true ; } : boolexpr | '(' disjunction ')' ;
atom  : boolexpr | '(' disjunction ')' ;
boolexpr : arithexpr ('=' | '<>' | '<' | '>' | '<=' | '>=') arithexpr;
//morearithexpr returns [int value] : ('+' s=arithexpr {$value += $s.value;} | '-' s=arithexpr {$value -= $s.value;})  | ; 
arithexpr returns [int value] : e = multiplication {$value = $e.value;} (('+' s=arithexpr {$value += $s.value;} | '-' s=arithexpr {$value -= $s.value;}) )? ;

multiplication returns [int value]  : e=negexp {$value = $e.value;}  ( ('*' s=multiplication {$value *= $s.value;}| '/' s=multiplication {$value /= $s.value;} | '%' s=multiplication {$value %= $s.value;}))? ;

negexp returns [int value]:'-' valuee | '('arithexpr')' | e=valuee {$value = $e.value;}  ;
valuee returns [int value] : ID  {Integer v = (Integer)memory.get($ID.text);
                                   if ( v!=null ) $value = v.intValue();
                                     else System.err.println("undefined variable "+$ID.text); }(index)? | INTEGER {$value = Integer.parseInt($INTEGER.text);} ;
dataexpr : ' " '  ' " ';

INTEGER  :   ('1'..'9')('0'..'9')* ;
//NEWLINE: '\r'? '\n' ;
WS : (' ' | '\t' | '\r' | '\n' )+ { $channel=HIDDEN; } ;
//WS : [ \t\r\n]+ -> skip ;
ID : ('a'..'z' | 'A'..'Z')+ ;

