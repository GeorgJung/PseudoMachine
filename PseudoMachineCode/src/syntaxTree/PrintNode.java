package syntaxTree;

public class PrintNode extends Node {
	ArithmeticExpressionNode n;
	protected PrintNode (SourceLocator location) {
		super(location);
	}

	/**
	 * 
	 * Prints value
	 * 
	 */
	protected PrintNode (SourceLocator location, ArithmeticExpressionNode n){
		super(location);
		this.n=n;
		System.out.println(n.evaluate());
		
	}
	
}
