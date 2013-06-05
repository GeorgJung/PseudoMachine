grammar PseudoGrammar;

options {
  language = Java;
}

@header {
package parser;
import pseudoTree.*;
}

@lexer::header {
package parser;
}

@members {
/** For declaration of member variables of the parser class PseudoGrammarParser */
}

algorithm  : 'algorithm' ID ('inputs' declist)? ('outputs' declist)? ('localvar' declist)? 'begin' statement  'end' ;
index   :  '[' arithexpr ']';
indexing   : '[' value '...' value ']' ;
idlist  : ID ',' idlist  | ID ;
assign  : 'set' ID 'to' ID;
assignlist  : assign ',' assignlist | assign ;
decl  :  'number'ID (indexing)? | 'data' ID (indexing)? ;
declist : decl (',' declist)? ;

statement returns [StatementNode n] : ( c = conditional { n = $c.n; }
                                      | l = iterative { n = $l.n; }
                                      | r = read { n = null; } // TODO: placeholder
                                      | i = invocation { n = null; } // TODO: placeholder
                                      | p = print { n = null; } // TODO: placeholder
                                      | a = assignment { n = null; } ) // TODO: placeholder
                                      (';' s = statement {
                                          m = n.clone();
                                          n = new SequentialNode(new SourceLocator(), m, $s.n);
                                        } )? ;

assignment returns [StatementNode n] : 'set' ID (index)? 'to' ( e = arithexpr | dataexpr) { n = new AssignmentNode(new SourceLocator(), $ID.text, $e.n)} ; 
// Remember to write about the necessity of left-factorizing the mutually left-recursive setting of having the sequential as a control flow construct as theoretically sound. Rule: "sequential : statement  | morestatement ;"




alternative returns [StatementNode n]: 'else' s = statement 'endif' { n = s.n; } | 'endif' { n = null; };

conditional returns [StatementNode n]: 'if' c = condition 'then' s = statement a = alternative {
                                       n = new ConditionalNode(new SourceLocator(), $c.n, $s.n, $a.n);
                                     };

iterative returns [StatementNode n]: 'while' c = condition 'do' s = statement 'loop' {
                                     n = new IterativeNode(new SourceLocator(), $c.n, $s.n);
                                   };


print returns [StatementNode n] : 'print' (dataexpr | e = arithexpr) {n = new PrintNode(new SourceLocator(), $e.n);} 
                                                  | 'print' '"'ID'"' {System.out.println($ID.text);} ;
read : 'read' idlist;
invocation  : 'run' ID 'inputs' assignlist 'outputs' assignlist 'done';






condition returns [BooleanExpressionNode n] throws CloneNotSupportedException, Exception :
        e = disjunction { n = $e.n; } ;

disjunction returns [BooleanExpressionNode n] throws CloneNotSupportedException, Exception :
        e = conjunction { n = $e.n; }
        ( 'or ' b = disjunction {
            BooleanExpressionNode m = (BooleanExpressionNode) n.clone();
            n = new DisjunctionNode(new SourceLocator(), $e.n, $b.n);
            } )? ;

conjunction returns [BooleanExpressionNode n] throws CloneNotSupportedException, Exception :
        e = negation { n = $e.n; }
        ( 'and' b = negation {
            BooleanExpressionNode m = (BooleanExpressionNode) n.clone();
            n = new ConjunctionNode(new SourceLocator(), $e.n, $b.n);
            } )? ;

negation returns [BooleanExpressionNode n] throws CloneNotSupportedException, Exception :
        'not' e = atom {
          n = new NegationNode(new SourceLocator(), $e.n);
          }
      | e = atom { n = $e.n; } ;

atom returns [BooleanExpressionNode n] throws CloneNotSupportedException, Exception
     options { backtrack = true ; } :
        e = boolexpr { n = $e.n; }
      | '(' e = disjunction { n = $e.n; } ')' ;

boolexpr returns [BooleanExpressionNode n] throws CloneNotSupportedException, Exception :
        'true' { n = new BoolExprNode(new SourceLocator(), true); }
      | 'false' { n = new BoolExprNode(new SourceLocator(), false); }
      | op1 = arithexpr
        ( '=' op2 = arithexpr {
            n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,Node.CompOp.EQ);
            }
        | '<' op2 = arithexpr {
            n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,Node.CompOp.LT);
            }
        | '>' op2 = arithexpr {
            n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,Node.CompOp.GT);
            } 
        | '<=' op2 = arithexpr {
            n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,Node.CompOp.LEQ);
            }
        | '>='op2 = arithexpr {
            n = new BoolExprNode(new SourceLocator(),$op1.n, $op2.n,Node.CompOp.GEQ);
            } );

arithexpr returns [ArithmeticExpressionNode n] throws CloneNotSupportedException, Exception :
        e = multiplication { n = $e.n; } 
        ( '+' s = arithexpr {
            ArithmeticExpressionNode m = (ArithmeticExpressionNode) n.clone();
            n = new ArithExprNode(new SourceLocator(), m, s, Node.AddOp.PLUS);
            }
        | '-' s = arithexpr {
            ArithmeticExpressionNode m = (ArithmeticExpressionNode) n.clone();
            n = new ArithExprNode(new SourceLocator(), m, s, Node.AddOp.MINUS);
            } )? ;

multiplication returns [ArithmeticExpressionNode n] throws CloneNotSupportedException, Exception :
        e = negexp { n = $e.n; } 
        ( '*' f = multiplication {
            ArithmeticExpressionNode m = (ArithmeticExpressionNode) n.clone();
            n = new MultiplicationNode(new SourceLocator(), m, f, Node.MultOp.TIMES);
            }
        | '/' q = multiplication {
            ArithmeticExpressionNode m = (ArithmeticExpressionNode) n.clone();
            n = new MultiplicationNode(new SourceLocator(), m, q, Node.MultOp.DIV);
            } )? ;

negexp returns [ArithmeticExpressionNode n] throws Exception :
        '-' e = value { n = new NegExpNode (new SourceLocator(), $e.n); }
      | '(' e = arithexpr ')' { n = $e.n; }
      | e = value { n = $e.n; } ;

value returns [ArithmeticExpressionNode n] throws Exception :
        ID  { n = new ValueNode(new SourceLocator(), $ID.text); }(index)?
      | INTEGER { n = new ValueNode(new SourceLocator(), Integer.parseInt($INTEGER.text)); } ;

dataexpr : ' " '  ' " ';

INTEGER  :   ('1'..'9')('0'..'9')* ;
WS : (' ' | '\t' | '\r' | '\n' )+ { $channel=HIDDEN; } ;
ID : ('a'..'z' | 'A'..'Z')+ ;

