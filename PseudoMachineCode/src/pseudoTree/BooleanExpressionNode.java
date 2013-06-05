package pseudoTree;

public abstract class BooleanExpressionNode extends Node {
	protected BooleanExpressionNode (SourceLocator location) {
		super(location);
	}

	/**
	 *
	 *  Evaluate the boolean result of an expression 
	 * 
	 */
	public abstract boolean evaluateBoolean() throws Exception;
}
