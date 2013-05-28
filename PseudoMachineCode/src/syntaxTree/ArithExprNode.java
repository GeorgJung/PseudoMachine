/**
 * 
 */
package syntaxTree;

/**
 * @author Tarek Fouda
 *
 */
public class ArithExprNode extends ArithmeticExpressionNode {
	ArithmeticExpressionNode op1, op2;
	char operator;

	/**
	 * @param location location of the expression in the source
	 */
	protected MultiplicationNode(SourceLocator location) {
		super(location);
	}
	
	public ArithExprNode(SourceLocator location, ArithmeticExpressionNode a, ArithmeticExpressionNode b, char o) {
		super(location);
		op1 = a;
		op2 = b;
		operator = o;
	}

	@Override
	public int evaluate() throws Exception {
		switch (operator) {
		case '+': return op1.evaluate() + op2.evaluate();
		case '-': return op1.evaluate() - op2.evaluate();
		default: throw new Exception("unknown operator");
		}
	}

}
