package syntaxTree;

import java.util.HashMap;

/**
 * 
 * @author jung
 *
 */
public class Node {
	static HashMap<String, Integer> memory = new HashMap<String, Integer> ();

	SourceLocator location;
	
	protected Node (SourceLocator location) {
		this.location = location;
	}
}
