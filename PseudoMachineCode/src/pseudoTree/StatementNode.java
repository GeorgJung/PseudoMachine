/**
 * 
 */
package pseudoTree;

/**
 * @author jung
 *
 */
public abstract class StatementNode extends Node {

	protected StatementNode (SourceLocator location) {
		super(location);
	}
	
	public abstract void execute() throws Exception;

}
