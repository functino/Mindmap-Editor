package application.commands
{
	public class SetBackgroundColorCommand implements ICommand
	{
		var element;
		var color;
		var undo_color;
		
		public function SetBackgroundColorCommand(element, color)
		{
			this.color = color;
			this.element = element;
		}
		
		public function execute()
		{
			undo_color = element.getBackgroundColor();
			element.setBackgroundColor(this.color);
		}
		
		public function undo()
		{
			element.setBackgroundColor(undo_color);
		}
	}
}