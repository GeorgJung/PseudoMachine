package syntaxTree;

public abstract class BooleanExpressionNode extends Node {
	protected BooleanExpressionNode (SourceLocator location) {
		super(location);
	}

	/**
	 *
	 *  Evaluate the booleann result of an expression 
	 * 
	 */
	public abstract int evaluateBoolean() throws Exception;
}
