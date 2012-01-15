package application.commands
{
	public class SetParentNodeCommand implements ICommand
	{
		var parent;
		var child;
		var x;
		var y;

		var undo_parent;
		var undo_x;
		var undo_y;
		
		public function SetParentNodeCommand(parent, child, x=null, y=null)
		{

			this.parent = parent;
			this.child = child;
			if(x==null)
			{
				x = child.getX();
			}
			if(y==null)
			{
				y= child.getY();
			}
			this.x = x;
			this.y = y;
			
			this.undo_parent = child.getParent();
			this.undo_x = child.getX();
			this.undo_y = child.getY();
		}
		
		public function execute()
		{
			trace('SetParentNodeCommand::execute()');
			this.parent.addNode(child);
			child.setX(this.x);
			child.setY(this.y);
		}
		
		public function undo()
		{
			this.undo_parent.addNode(child);
			this.child.setX(this.undo_x);
			this.child.setY(this.undo_y);
		}
	}
}