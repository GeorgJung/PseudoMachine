/**
 * 
 */
package pseudoTree;

/**
 * @author jung
 * 
 */
public class MultiplicationNode extends ArithmeticExpressionNode {
	ArithmeticExpressionNode op1, op2;
	MultOp operator;

	/**
	 * @param location
	 *            location of the Expression in the source code
	 */
	protected MultiplicationNode(SourceLocator location) {
		super(location);
	}

	public MultiplicationNode(SourceLocator location,
			ArithmeticExpressionNode a, ArithmeticExpressionNode b, MultOp o) {
		super(location);
		op1 = a;
		op2 = b;
		operator = o;
	}

	@Override
	public int evaluate() throws Exception {
		super.highlight();
		super.delay();
		switch (operator) {
		case TIMES:
			return op1.evaluate() * op2.evaluate();
		case DIV:
			return op1.evaluate() / op2.evaluate();
			// TODO: Clean up error handling
		default:
			throw new Exception("unknown operator");
		}
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		return new MultiplicationNode(new SourceLocator(location),
				(ArithmeticExpressionNode) op1.clone(),
				(ArithmeticExpressionNode) op2.clone(), operator);
	}

}
