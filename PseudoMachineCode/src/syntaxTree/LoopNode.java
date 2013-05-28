public class LoopNode extends Node {
    BooleanNode condition;
    StatementNode body;

    public LoopNode (SourceLocator location){
    	super(location);
    }

    
    
    public LoopNode (SourceLocator location, BooleanNode condition,StatementNode body ){
    	super(location);
    	this.condition = condition;
    	this.body=body;
    }
    @Override
    public void execute () {
        while (condition.evaluateBoolean()) body.execute();
        return;
    }
}