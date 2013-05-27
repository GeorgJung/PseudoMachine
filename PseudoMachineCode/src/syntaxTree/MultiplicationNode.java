/**
 * 
 */
package syntaxTree;

/**
 * @author jung
 *
 */
public class MultiplicationNode extends ArithmeticExpressionNode {
	ArithmeticExpressionNode op1, op2;
	char operator;

	/**
	 * @param location
	 */
	protected MultiplicationNode(SourceLocator location) {
		super(location);
	}
	
	public MultiplicationNode(SourceLocator location, ArithmeticExpressionNode a, ArithmeticExpressionNode b, char o) {
		super(location);
		op1 = a;
		op2 = b;
		operator = o;
	}

	@Override
	public int evaluate() throws Exception {
		switch (operator) {
		case '*': return op1.evaluate() * op2.evaluate();
		case '/': return op1.evaluate() / op2.evaluate();
		default: throw new Exception("unknown operator");
		}
	}

}
