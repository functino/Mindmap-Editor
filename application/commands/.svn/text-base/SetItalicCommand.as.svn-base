package application.commands
{
	public class SetItalicCommand implements ICommand
	{
		var element;
		var italic;
		var undo_italic;
		
		public function SetItalicCommand(element, i)
		{
			italic = i;
			this.element = element;
		}
		
		public function execute()
		{
			undo_italic = element.getItalic();
			element.setItalic(this.italic);
		}
		
		public function undo()
		{
			element.setItalic(undo_italic);
		}
	}
}