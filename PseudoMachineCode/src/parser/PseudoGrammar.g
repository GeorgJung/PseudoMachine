grammar PseudoGrammar;

options {
  language = Java;
}

@header {
package parser;
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
statement returns [StatementNode n] : conditional morestatement | iterative morestatement | read morestatement | invocation morestatement | print morestatement | assignment morestatement { n = null; };

assignment returns [StatementNode n] : 'set' ID (index)? 'to' ( e = arithexpr | dataexpr) { n = new AssignmentNode(new SourceLocator(), $ID.text, $e.n)} ; 
morestatement : ';' statement | ; 
// Remember to write about the necessity of left-factorizing the mutually left-recursive setting of having the sequential as a control flow construct as theoretically sound. Rule: "sequential : statement  | morestatement ;"




alternative returns [StatementNode n]: 'else' s = statement 'endif' { n = s.n; } | 'endif' { n = null; };

conditional returns [StatementNode n]: 'if' c = condition 'then' s = statement a = alternative {
                                       n = new ConditionalNode(new SourceLocator(), $c.n, $s.n, $a.n);
                                     };





iterative  : 'while' condition 'do' statement 'loop';
print returns [StatementNode n] : 'print' (dataexpr | e = arithexpr) {n = new PrintNode(new SourceLocator(), $e.n);} 
                                                  | 'print' '"'ID'"' {System.out.println($ID.text);} ;
read : 'read' idlist;
invocation  : 'run' ID 'inputs' assignlist 'outputs' assignlist 'done';






condition returns [BooleanExpressionNode n] : e = disjunction { n = $e.n } ;

disjunction returns [BooleanExpressionNode n] : e = conjunction { n = $e.n; }
                                                ( 'or ' b = disjunction {
                                                  m = n.clone();
                                                  n = new DisjunctionNode(new SourceLocator, $e.n, $b.n);
                                                } )? ;

conjunction returns [BooleanExpressionNode n]  : e = negation { n = $e.n; }
                                                 ( 'and' b = negation {
                                                   m = n.clone();
                                                   n = new ConjunctionNode(new SourceLocator, $e.n, $b.n);
                                                 } )? ;

negation returns [BooleanExpressionNode n] : 'not' e = atom {
                                               n = new NegationNode(new SourceLocator(), $e.n);
                                             }
                                           | e = atom { n = $e.n; } ;

atom returns [BooleanExpressionNode n] options { backtrack = true ; } : e = boolexpr { n = $e.n; }
                                                                      | '(' e = disjunction { n = $e.n; } ')' ;

boolexpr returns [BooleanExpressionNode n] : op1 = arithexpr
                                                  ( '=' op2 = arithexpr {
                                                    n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,'=');
                                                  }
                                                  | '<' op2 = arithexpr {
                                                    n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,'<');
                                                  }
                                                  | '>' op2 = arithexpr {
                                                    n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,'>');
                                                  } 
                                                  | '<=' op2 = arithexpr {
                                                    n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,'l');
                                                  }
                                                  | '>='op2 = arithexpr {
                                                    n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,'g');
                                                  } );

arithexpr returns [ArithmeticExpressionNode n] : e = multiplication { n = $e.n; } 
                                                 ( '+' s = arithexpr {
                                                     m = n.clone();
                                                     n = new ArithExprNode(new SourceLocator(), m, s, '+');
                                                   }
                                                 | '-' s = arithexpr {
                                                     m = n.clone();
                                                     n = new ArithExprNode(new SourceLocator(), m, s, '-');
                                                   } )? ;

multiplication returns [ArithmeticExpressionNode n] : e = negexp { n = $e.n; } 
                                                      ( '*' f = multiplication {
                                                          m = n.clone() ;
                                                          n = new MultiplicationNode(new SourceLocator(), m, f, '*');
                                                        }
                                                      | '/' q = multiplication {
                                                          m = n.clone() ;
                                                          n = new MultiplicationNode(new SourceLocator(), m, q, '/');
                                                        } )? ;

negexp returns [ArithemticExpressionNode n]: '-' e = value { n = new NegExpNode (new SourceLocator(), $e.n); }
                                           | '(' e = arithexpr ')' { n = $e.n; }
                                           | e = value { n = $e.n; } ;

value returns [AritmeticExpressionNode n] : ID  { n = new ValueNode(new SourceLocator(), $ID.text); }(index)?
                                          | INTEGER { n = new ValueNode(new SourceLocator(), Integer.parseInt($INTEGER.text);} ;

dataexpr : ' " '  ' " ';

INTEGER  :   ('1'..'9')('0'..'9')* ;
WS : (' ' | '\t' | '\r' | '\n' )+ { $channel=HIDDEN; } ;
ID : ('a'..'z' | 'A'..'Z')+ ;

