package application.commands
{
	public class RemoveBranchCommand implements ICommand
	{
		var node;
		var parent;
		public function RemoveBranchCommand(node)
		{
			this.node = node;
			this.parent = this.node.getParent();
		}
		
		public function execute()
		{
			trace('RemoveNodeCommand::execute()');
			this.node.deleteBranch();
		}
		
		public function undo()
		{
			trace('RemvoeNodeCommand::undo()');
			this.parent.addNode(this.node);
		}
	}
}