package application.commands
{
	public class RemoveNodeCommand implements ICommand
	{
		var node;
		var childs;
		var parent;
		public function RemoveNodeCommand(node)
		{
			this.node = node;
			this.childs = new Array();
			this.parent = this.node.getParent();
			var c = this.node.getChilds();
			
			for(var i=0 in c)
			{
				this.childs.push(c[i]);
			}
		}
		
		public function execute()
		{
			trace('RemoveNodeCommand::execute()');
			this.node.deleteElement();
		}
		
		public function undo()
		{
			trace('RemvoeNodeCommand::undo()');
			this.parent.addNode(this.node);
			
			
			for(var i=0 in this.childs)
			{
				//this.parent.removeNode(this.childs[i]);
				this.node.addNode(this.childs[i]);
			}
		}
	}
}