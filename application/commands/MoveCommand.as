package application.commands
{
	public class MoveCommand implements ICommand
	{
		var element;
		var x;
		var y;

		var undo_x;
		var undo_y;
		
		public function MoveCommand(element, x, y)
		{
			this.x = x;
			this.y = y;
			this.element = element;
		}
		
		public function execute()
		{
			trace('MoveCommand::execute');
			undo_x = element.getX();
			undo_y = element.getY();
			element.setPosition(x, y);
		}
		
		public function undo()
		{
			element.setPosition(undo_x, undo_y);
		}
		
		
		
	}
}