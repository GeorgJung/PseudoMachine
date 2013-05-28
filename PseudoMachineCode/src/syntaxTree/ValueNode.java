package syntaxTree;

public class ValueNode extends ArithmeticExpressionNode {
	private boolean isConstant = true;
	private int value;
	private String name;

	protected ValueNode(SourceLocator location) {
		super(location);
	}

	/**
	 * Constructor for identifiers as atomic expressions
	 * @param location location of the identifier in the source
	 * @param id name of the identifier
	 */
	public ValueNode(SourceLocator location, String id) {
		super(location);
		isConstant = false;
		this.name = id;
	}
	
	/**
	 * Constructor for integer literals as atomic expressions
	 * @param location location of the identifier in the source
	 * @param value value of the integer literal
	 */
	public ValueNode(SourceLocator location, int value) {
		super(location);
		this.value = value;
	}

	@Override
	public int evaluate() {
		if (!isConstant) {
			return (Integer) memory.get(name);
		}
		return value;
	}
}
