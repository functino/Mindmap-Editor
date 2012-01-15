package application.commands
{
	public class SetColorCommand implements ICommand
	{
		var element;
		var color;
		var undo_color;
		
		public function SetColorCommand(element, color)
		{
			this.color = color;
			this.element = element;
		}
		
		public function execute()
		{
			undo_color = element.getColor();
			element.setColor(this.color);
		}
		
		public function undo()
		{
			element.setColor(undo_color);
		}
	}
}