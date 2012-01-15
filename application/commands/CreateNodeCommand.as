package application.commands
{
	public class CreateNodeCommand implements ICommand
	{
		var mindmap;
		var node;
		var activeNode;
		
		public function CreateNodeCommand(mindmap, node, parent = null)
		{
			this.mindmap = mindmap;
			this.node = node;
			if(parent==null)
			{
				this.activeNode = mindmap.getActiveNode();
			}
			else
			{
				this.activeNode = parent;
			}
		}
		
		public function execute()
		{
			trace('CreateNodeCommand::execute()');
			this.activeNode.addNode(this.node);
		}
		
		public function undo()
		{
			this.node.remove();
		}
	}
}