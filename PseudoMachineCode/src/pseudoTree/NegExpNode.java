/**
 * 
 */
package pseudoTree;

/**
 * @author jung
 * 
 */
public class NegExpNode extends ArithmeticExpressionNode {
	ArithmeticExpressionNode expression;

	/**
	 * @param location
	 */
	protected NegExpNode(SourceLocator location) {
		super(location);
	}

	/**
	 * 
	 * @param location location in the source file
	 * @param expression expression needed to be negated
	 */
	public NegExpNode(SourceLocator location,
			ArithmeticExpressionNode expression) {
		super(location);
		this.expression = expression;
	}

	@Override
	public int evaluate() throws Exception {
		super.highlight();
		super.delay();
		return -expression.evaluate();
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		return new NegExpNode(location, expression);
	}
}
