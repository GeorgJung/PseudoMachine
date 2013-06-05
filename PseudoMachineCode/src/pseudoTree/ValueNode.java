package pseudoTree;

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
	 * @throws Exception 
	 */
	public ValueNode(SourceLocator location, String id) throws Exception {
		super(location);
		isConstant = false;
		this.name = id;
		if (numbers.get(id)==null) throw new Exception("Variable " + id + "undeclared!");
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
		super.highlight();
		super.delay();
		if (!isConstant) {
			return (Integer) numbers.get(name);
		}
		return value;
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		try {
			return new ValueNode(new SourceLocator(location), new String(name));
		} catch (Exception e) {
			throw new CloneNotSupportedException("Internal error caused by undecleared variable!");
		}
	}
}
