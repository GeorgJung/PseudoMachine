package pseudoTree;

public abstract class ArithmeticExpressionNode extends Node {
	protected ArithmeticExpressionNode (SourceLocator location) {
		super(location);
	}

	/**
	 * Evaluate the arithmetic expression at hand
	 * @return the current value of the expression depending on its
	 * variables and subexpressions
	 */
	public abstract int evaluate() throws Exception;
}
