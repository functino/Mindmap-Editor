package application.commands
{
	public class SetUnderlineCommand implements ICommand
	{
		var element;
		var underline;
		var undo_underline;
		
		public function SetUnderlineCommand(element, u)
		{
			underline = u;
			this.element = element;
		}
		
		public function execute()
		{
			undo_underline = element.getUnderline();
			element.setUnderline(this.underline);
		}
		
		public function undo()
		{
			element.setUnderline(undo_underline);
		}
	}
}