/**
 * 
 */
package pseudoTree;

/**
 * @author jung
 * 
 */
public class NegationNode extends BooleanExpressionNode {
	BooleanExpressionNode e;

	/**
	 * @param location
	 */
	protected NegationNode(SourceLocator location) {
		super(location);
	}

	public NegationNode(SourceLocator location, BooleanExpressionNode e) {
		super(location);
		this.e = e;
	}

	@Override
	public boolean evaluateBoolean() throws Exception {
		super.highlight();
		super.delay();
		return !e.evaluateBoolean();
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		return new NegationNode(new SourceLocator(location),
				(BooleanExpressionNode) e.clone());
	}
}
