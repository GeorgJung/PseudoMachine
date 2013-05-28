package syntaxTree;
/**
 * 
 * @author Samy
 *
 */
public class PrintNode extends Node {
	ArithmeticExpressionNode n;
	protected PrintNode (SourceLocator location) {
		super(location);
	}

	/**
	 * 
	 * Prints value
	 * @param location location in the source file
	 * @param the expression needed to be printed
	 * 
	 * 
	 */
	protected PrintNode (SourceLocator location, ArithmeticExpressionNode n){
		super(location);
		this.n=n;
		System.out.println(n.evaluate());
		
	}
	
}
