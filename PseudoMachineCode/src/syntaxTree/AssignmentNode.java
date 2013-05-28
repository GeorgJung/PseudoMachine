/**
 * 
 */
package syntaxTree;

/**
 * @author Tarek Samy
 *
 */
public class AssignmentNode extends Node {


	/**
	 * @param Assign a variable to an Identifier
	 */
	protected AssignmentNode(SourceLocator location, String id, ArithmeticExpressionNode a) {
		super(location);
		memory.put($ID.text, new Integer(a.evaluate());
	}

}
