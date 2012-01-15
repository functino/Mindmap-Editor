package application.commands
{
	public class SetFontCommand implements ICommand
	{
		var element;
		var font;
		var undo_font;
		
		public function SetFontCommand(element, font)
		{
			this.font = font;
			this.element = element;
		}
		
		public function execute()
		{
			undo_font = element.getFont();
			element.setFont(this.font);
		}
		
		public function undo()
		{
			element.setFont(undo_font);
		}
	}
}