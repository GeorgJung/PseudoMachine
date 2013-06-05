/**
 * 
 */
package pseudoTree;

/**
 * @author jung
 * 
 */
public class ConjunctionNode extends BooleanExpressionNode {
	BooleanExpressionNode op1, op2;

	/**
	 * @param location
	 */
	protected ConjunctionNode(SourceLocator location) {
		super(location);
	}

	public ConjunctionNode(SourceLocator location, BooleanExpressionNode op1,
			BooleanExpressionNode op2) {
		super(location);
		this.op1 = op1;
		this.op2 = op2;
	}

	@Override
	public boolean evaluateBoolean() throws Exception {
		super.highlight();
		super.delay();
		return op1.evaluateBoolean() && op2.evaluateBoolean();
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		return new ConjunctionNode(new SourceLocator(location),
				(BooleanExpressionNode) op1.clone(),
				(BooleanExpressionNode) op2.clone());
	}
}
