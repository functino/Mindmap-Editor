package application.commands
{
	public class SetTextCommand implements ICommand
	{
		var element;
		var text;
		var undo_text;
		
		public function SetTextCommand(element, text)
		{
			trace('SetTextCommand(' + text + ')');
			this.text = text;
			this.element = element;
		}
		
		public function execute()
		{
			trace('execute SetTextCommand(' + text + ')');
			undo_text = element.getText();
			element.setText(this.text);
		}
		
		public function undo()
		{
			trace('undo SetTextCommand(' + text + ')');
			element.setText(undo_text);
		}
	}
}