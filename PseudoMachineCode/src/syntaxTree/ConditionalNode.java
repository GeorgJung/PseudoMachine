/**
 * 
 */
package syntaxTree;

/**
 * @author Tarek
 * 
 */
public class ConditionalNode extends BooleanExpressionNode {
	BooleanExpressionNode n;
	

	/**
	 * @param location
	 */
	protected BooleanNode(SourceLocator location) {
		super(location);
	}

	/**
	 * 
	 * @param location
	 * @param expression
	 */
	public BooleanNode(SourceLocator location,
			ArithmeticExpressionNode op1, ArithmeticExpressionNode op1, chat operator ) {
		super(location);
		this.op1=op1;
		this.op2=op2;
		this.operator = operator;
	}

	@Override
	public boolean evaluateBoolean() throws Exception {
		switch (operator) {
		case '=': if(op1.evaluate() == op2.evaluate()){
               return true;
               } else {
            	   return false;
            	   }
		case '<':  if(op1.evaluate() < op2.evaluate()){
            return true;
            } else {
         	   return false;
         	   }
		case '>':  if(op1.evaluate() > op2.evaluate()){
            return true;
            } else {
         	   return false;
         	   }
		case '<=':  if(op1.evaluate() <= op2.evaluate()){
            return true;
            } else {
         	   return false;
         	   }
		case '>=':  if(op1.evaluate() >= op2.evaluate()){
            return true;
            } else {
         	   return false;
         	   }
		default: throw new Exception("unknown operator");
		}
	}
}
