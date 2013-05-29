/**
 * 
 */
package syntaxTree;

/**
 * @author jung
 * 
 */
public class SequentialNode extends StatementNode {
	StatementNode s1, s2;

	/**
	 * @param location
	 */
	protected SequentialNode(SourceLocator location) {
		super(location);
	}

	public SequentialNode(SourceLocator location, StatementNode s1,
			StatementNode s2) {
		super(location);
		this.s1 = s1;
		this.s2 = s2;
	}

	@Override
	public void execute() throws Exception {
		s1.execute();
		s2.execute();
	}
}
