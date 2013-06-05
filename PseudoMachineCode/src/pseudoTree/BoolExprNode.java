/**
 * 
 */
package pseudoTree;

/**
 * @author jung
 * 
 */
public class BoolExprNode extends BooleanExpressionNode {
	ArithmeticExpressionNode op1, op2;
	CompOp operator;
	boolean isConstant = false;
	boolean value;

	/**
	 * @param location
	 *            location of the expression in the source
	 */
	protected BoolExprNode(SourceLocator location) {
		super(location);
	}

	public BoolExprNode(SourceLocator location, boolean value) {
		super(location);
		this.value = value;
		isConstant = true;
	}

	/**
	 * 
	 * @param location
	 *            location of the expression in the source file
	 * @param expression
	 *            is the first operand
	 * @param expression
	 *            is the second operand
	 * @param operator
	 *            is the comparing operator
	 */
	public BoolExprNode(SourceLocator location, ArithmeticExpressionNode op1,
			ArithmeticExpressionNode op2, CompOp operator) {
		super(location);
		this.op1 = op1;
		this.op2 = op2;
		this.operator = operator;
	}

	@Override
	public boolean evaluateBoolean() throws Exception {
		super.highlight();
		super.delay();
		if (isConstant)
			return value;
		switch (operator) {
		case EQ:
			return op1.evaluate() == op2.evaluate();
		case LT:
			return op1.evaluate() < op2.evaluate();
		case GT:
			return op1.evaluate() > op2.evaluate();
		case LEQ:
			return op1.evaluate() <= op2.evaluate();
		case GEQ:
			return op1.evaluate() >= op2.evaluate();
			// TODO: Clean up error handling
		default:
			throw new Exception("unknown operator");
		}
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		if (isConstant)
			return new BoolExprNode(new SourceLocator(location), value);
		return new BoolExprNode(new SourceLocator(location),
				(ArithmeticExpressionNode) op1.clone(),
				(ArithmeticExpressionNode) op2.clone(), operator);

	}
}
