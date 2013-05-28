/**
 * 
 */
package syntaxTree;

/**
 * @author jung
 * 
 */
public class ConditionalNode extends StatementNode {
	BooleanExpressionNode condition;
	StatementNode tBranch, fBranch;

	/**
	 * @param location
	 */
	protected ConditionalNode(SourceLocator location) {
		super(location);
	}

	public ConditionalNode(SourceLocator location,
			BooleanExpressionNode condition, StatementNode tBranch,
			StatementNode fBranch) {
		super(location);
		this.condition = condition;
		this.tBranch = tBranch;
		this.fBranch = fBranch;
	}

	@Override
	public void execute() throws Exception {
		if (condition.evaluateBoolean())
			tBranch.execute();
		else if (fBranch != null)
			fBranch.execute();
	}
}
