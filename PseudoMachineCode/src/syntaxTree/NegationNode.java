/**
 * 
 */
package syntaxTree;

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

	public NegationNode (SourceLocator location, BooleanExpressionNode e) {
		super(location);
		this.e = e;
	}

	@Override
	public boolean evaluateBoolean() throws Exception {
		return !e.evaluateBoolean();
	}
}
