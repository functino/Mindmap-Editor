package application.commands
{
	public class AutoLayoutCommand implements ICommand
	{
		var layouter
		var mindmap;
		
		var undoCoords;

		
		public function AutoLayoutCommand(mindmap, layouter)
		{
			this.layouter = layouter;
			this.mindmap = mindmap;
		}
		
		public function execute()
		{
			undoCoords = new Array();
			retrieveUndoValues(mindmap.getRootNode());
			trace(undoCoords);
			trace('AutoLayout::execute');
			this.layouter.layout(mindmap);
		}
		
		private function retrieveUndoValues(node)
		{
			var childNodes = node.getChilds();
			for(var i in childNodes)
			{
				undoCoords.push(new Array(childNodes[i].getX(), childNodes[i].getY()));
				retrieveUndoValues(childNodes[i]);
			}
		}
		
		private function resetValues(node)
		{
			var childNodes = node.getChilds();
			var coord;
			for(var i in childNodes)
			{
				var a:Array;

				coord = undoCoords.shift();
				childNodes[i].setX(coord[0]);
				childNodes[i].setY(coord[1]);
				resetValues(childNodes[i]);
			}
		}
		
		public function undo()
		{
			resetValues(mindmap.getRootNode());
		}
	}
}