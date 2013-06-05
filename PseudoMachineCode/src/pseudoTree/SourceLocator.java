package pseudoTree;

public class SourceLocator {
	int startLine, endLine, startColumn, endColumn;
	
	public SourceLocator() {
		// TODO: eliminate empty constructor
	}

	public SourceLocator(int startLine, int startColumn, int endLine, int endColumn) {
		this.startLine = startLine;
		this.startColumn = startColumn;
		this.endLine = endLine;
		this.endColumn = endColumn;
	}
	
	public SourceLocator(SourceLocator original) {
		this.startLine = original.startLine;
		this.startColumn = original.startColumn;
		this.endLine = original.endLine;
		this.endColumn = original.endColumn;
	}
}
