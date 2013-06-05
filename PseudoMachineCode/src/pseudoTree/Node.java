/**
 * 
 */
package pseudoTree;

import java.util.HashMap;

/**
 * @author jung
 * 
 */
public abstract class Node implements Cloneable {
	SourceLocator location;
	static HashMap<String, Integer> numbers = new HashMap<String, Integer>();
	static HashMap<String, String> data = new HashMap<String, String>();
	
	public static enum AddOp { PLUS, MINUS };
	public static enum MultOp { TIMES, DIV };
	public static enum CompOp { EQ, GT, LT, GEQ, LEQ };

	public Node(SourceLocator location) {
		this.location = location;
	}

	public void highlight() {
		// TODO: Implement highlighting according to the given source location
	}

	public void delay() {
		// TODO: Implement a wait mechanism
	}

	public abstract Object clone() throws CloneNotSupportedException;
}
