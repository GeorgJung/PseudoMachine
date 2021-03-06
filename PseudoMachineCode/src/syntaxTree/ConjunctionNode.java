/**
 * 
 */
package syntaxTree;

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
		return op1.evaluateBoolean() && op2.evaluateBoolean();
	}

}
