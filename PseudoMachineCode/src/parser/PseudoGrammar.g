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

assignment returns [AssignmentNode n] : 'set' ID (index)? 'to' ( e = arithexpr | dataexpr) { n = new AssignmentNode(new SourceLocator(), $ID.text, $e.n)} ; 
morestatement : ';' statement | ; 
// Remember to write about the necessity of left-factorizing the mutually left-recursive setting of having the sequential as a control flow construct as theoretically sound. Rule: "sequential : statement  | morestatement ;"
alternative : 'else' statement 'endif' | 'endif' ;
conditional : 'if' condition 'then' statement alternative ;
iterative  : 'while' condition 'do' statement 'loop';
print returns [PrintNode n] : 'print' (dataexpr | e = arithexpr) {n = new PrintNode(new SourceLocator(), $e.n);} 
                                                  | 'print' '"'ID'"' {System.out.println($ID.text);} ;
read : 'read' idlist;
invocation  : 'run' ID 'inputs' assignlist 'outputs' assignlist 'done';
condition returns [BooleanExpressionNode n] : e = disjunction {n = $e.n} ;
disjunction returns [BooleanExpressionNode n] : e = conjunction  {$e.n;} ( 'or ' b = disjunction {n = $e.n || $b.n} )? ; // change all left-factorized alternatives back to question mark syntax (maybe except for morestatement)
conjunction returns [BooleanExpressionNode n]  : e =negation {n = $e.n;} ( 'and' b = negation {n = $e.n && $b.n} )? ;
negation returns [BooleanExpressionNode n] : e =boolexpr {n = $e.n;}  ;
//atom returns [BooleanExpressionNode n] options { backtrack = true ; } : boolexpr | '(' disjunction ')' ;
//atom  : boolexpr | '(' disjunction ')' ;
boolexpr returns [BooleanExpressionNode n] : op1=arithexpr ('=' op2 = arithexpr {
                                          n = new BooleanNode(new SourceLocator(),$op1.n, $op2.n,'=');
                                            }
                                            | '<' op2 = arithexpr  {
                                            n = new BooleanNode(new SourceLocator(),$op1.n, $op2.n,'<');
                                            }
                                            | '>' op2 = arithexpr{
                                            n = new BooleanNode(new SourceLocator(),$op1.n, $op2.n,'>');
                                            } 
                                            | '<=' op2 = arithexpr {
                                            n = new BooleanNode(new SourceLocator(),$op1.n, $op2.n,'<=');
                                            }
                                            | '>='op2 = arithexpr){
                                            n = new BooleanNode(new SourceLocator(),$op1.n, $op2.n,'>=');
                                            } ;
//morearithexpr returns [int concreteValue] : ('+' s=arithexpr {$concreteValue += $s.concreteValue;} | '-' s=arithexpr {$concreteValue -= $s.concreteValue;})  | ; 
arithexpr returns [ArithmeticExpressionNode n] : e = multiplication { n = $e.n;} 
                                              (('+' second_operand=arithexpr {
                                                  m = n.clone() ;
                                                  n = new ArithExprNode(new SourceLocator(), m, second_operand, '+');
                                              } | '-' s=arithexpr {
                                                  m = n.clone() ;
                                                  n = new ArithExprNode(new SourceLocator(), m, second_operand, '-');
                                                }) )? ;

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

