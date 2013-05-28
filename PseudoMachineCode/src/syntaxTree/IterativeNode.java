/**
 * 
 */
package syntaxTree;

/**
 * @author jung
 * 
 */
public class IterativeNode extends StatementNode {
	BooleanExpressionNode condition;
	StatementNode body;

	/**
	 * @param location
	 */
	protected IterativeNode(SourceLocator location) {
		super(location);
	}

	public IterativeNode(SourceLocator location,
			BooleanExpressionNode condition, StatementNode body) {
		super(location);
		this.condition = condition;
		this.body = body;
	}

	@Override
	public void execute() throws Exception {
		while (condition.evaluateBoolean()) body.execute();
	}
}
