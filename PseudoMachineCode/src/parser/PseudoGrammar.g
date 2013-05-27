 grammar PseudoGrammar;
 options {
  language = Java;
}
@header {
import java.util.HashMap; // TODO: get rid of this import
import syntaxTree.*;
}

@members {
/** Map variable name to Integer object holding concreteValue */
HashMap memory = new HashMap();
}


algorithm  : 'algorithm' ID ('inputs' declist)? ('outputs' declist)? ('localvar' declist)? 'begin' statement  'end' ;
index   :  '[' arithexpr ']';
indexing   : '[' value '...' value ']' ;
idlist  : ID ',' idlist  | ID ;
assign  : 'set' ID 'to' ID;
assignlist  : assign ',' assignlist | assign ;
decl  :  'number'ID (indexing)? | 'data' ID (indexing)? ;
declist : decl (',' declist)? ;
statement : conditional morestatement | iterative morestatement | read morestatement | invocation morestatement | print morestatement | assignment morestatement ;

assignment : 'set' ID (index)? 'to' (arithexpr | dataexpr) {memory.put($ID.text, new Integer($arithexpr.concreteValue));} ; 
morestatement : ';' statement | ; 
// Remember to write about the necessity of left-factorizing the mutually left-recursive setting of having the sequential as a control flow construct as theoretically sound. Rule: "sequential : statement  | morestatement ;"
alternative : 'else' statement 'endif' | 'endif' ;
conditional : 'if' condition 'then' statement alternative ;
iterative  : 'while' condition 'do' statement 'loop';
print : 'print' (dataexpr | arithexpr) {System.out.println($arithexpr.concreteValue);} | 'print' '"'ID'"' {System.out.println($ID.text);} ;
read : 'read' idlist;
invocation  : 'run' ID 'inputs' assignlist 'outputs' assignlist 'done';
condition : disjunction ;
disjunction : conjunction ( 'or ' disjunction )? ; // change all left-factorized alternatives back to question mark syntax (maybe except for morestatement)
conjunction  : negation ( 'and' negation  )? ;
negation : 'not' atom | atom ;
atom options { backtrack = true ; } : boolexpr | '(' disjunction ')' ;
//atom  : boolexpr | '(' disjunction ')' ;
boolexpr : arithexpr ('=' | '<>' | '<' | '>' | '<=' | '>=') arithexpr;
//morearithexpr returns [int concreteValue] : ('+' s=arithexpr {$concreteValue += $s.concreteValue;} | '-' s=arithexpr {$concreteValue -= $s.concreteValue;})  | ; 
arithexpr returns [int concreteValue] : e = multiplication {$concreteValue = $e.concreteValue;} (('+' s=arithexpr {$concreteValue += $s.concreteValue;} | '-' s=arithexpr {$concreteValue -= $s.concreteValue;}) )? ;

multiplication returns [ArithmeticExpressionNode n] : e = negexp { n = $e.n; } 
                                              ( ('*' f = multiplication {
                                                  m = n.clone() ;
                                                  n = new MultiplicationNode(new SourceLocator(), m, f, '*');
                                                }
                                            | '/' q = multiplication {
                                                  m = n.clone() ;
                                                  n = new MultiplicationNode(new SourceLocator(), m, q, '/');
                                                }))? ;

negexp returns [ArithemticExpressionNode n]: '-' e = value { n = new NegExpNode (new SourceLocator(), $e.n); }
                                            | '(' e = arithexpr ')' { n = $e.n; }
                                            | e = value { n = $e.n; } ;
value returns [AritmeticExpressionNode n] : ID  { n = new ValueNode(new SourceLocator(), $ID.text); }(index)?
                            | INTEGER { n = new ValueNode(new SourceLocator(), Integer.parseInt($INTEGER.text);} ;
dataexpr : ' " '  ' " ';

INTEGER  :   ('1'..'9')('0'..'9')* ;
//NEWLINE: '\r'? '\n' ;
WS : (' ' | '\t' | '\r' | '\n' )+ { $channel=HIDDEN; } ;
//WS : [ \t\r\n]+ -> skip ;
ID : ('a'..'z' | 'A'..'Z')+ ;

