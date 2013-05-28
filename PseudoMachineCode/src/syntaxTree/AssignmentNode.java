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
	public AssignmentNode(SourceLocator location, String id, ArithmeticExpressionNode a) throws Exception {
		super(location);
		memory.put(id, new Integer(a.evaluate()));
	}

}
