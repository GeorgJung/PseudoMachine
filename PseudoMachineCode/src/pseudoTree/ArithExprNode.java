/**
 * 
 */
package pseudoTree;

/**
 * @author jung
 * 
 */
public class ArithExprNode extends ArithmeticExpressionNode {
	ArithmeticExpressionNode op1, op2;
	AddOp operator;

	/**
	 * @param location
	 *            location of the expression in the source
	 */
	protected ArithExprNode(SourceLocator location) {
		super(location);
	}

	public ArithExprNode(SourceLocator location, ArithmeticExpressionNode a,
			ArithmeticExpressionNode b, AddOp o) {
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
		case PLUS:
			return op1.evaluate() + op2.evaluate();
		case MINUS:
			return op1.evaluate() - op2.evaluate();
			// TODO: Clean up error handling
		default:
			throw new Exception("unknown operator");
		}
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		return new ArithExprNode(new SourceLocator(location),
				(ArithmeticExpressionNode) op1.clone(),
				(ArithmeticExpressionNode) op2.clone(), operator);
	}
}
