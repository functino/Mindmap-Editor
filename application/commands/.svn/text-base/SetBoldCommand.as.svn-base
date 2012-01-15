package application.commands
{
	public class SetBoldCommand implements ICommand
	{
		var element;
		var bold;
		var undo_bold;
		
		public function SetBoldCommand(element, b)
		{
			bold = b;
			this.element = element;
		}
		
		public function execute()
		{
			undo_bold = element.getBold();
			element.setBold(this.bold);
		}
		
		public function undo()
		{
			element.setBold(undo_bold);
		}
	}
}