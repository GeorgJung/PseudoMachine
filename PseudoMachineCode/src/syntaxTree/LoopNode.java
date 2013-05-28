package syntaxTree;

public class LoopNode extends StatementNode {
    BoolExprNode condition;
    StatementNode body;

    public LoopNode (SourceLocator location){
    	super(location);
    }

    
    
    public LoopNode (SourceLocator location, BoolExprNode condition,StatementNode body ){
    	super(location);
    	this.condition = condition;
    	this.body=body;
    }
    @Override
    public void execute () throws Exception {
        while (condition.evaluateBoolean()) body.execute();
        return;
    }
}