package application.views
{
	import application.commands.*;
	import application.*;
	import fl.controls.TextInput;
	import fl.controls.Button;
	import flash.text.TextFormat;
	import flash.text.*;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.events.FocusEvent;
	

	public class MindmapView extends MovieClip
	{
		var model;
		public var lines;
		var rootNodeView;
		public function MindmapView(model){
		 	this.model = model;

			this.lines = new MovieClip()//LineView();
			addChild(lines);
			
			this.rootNodeView = this.model.getRootNode().getView();
			this.drawChilds();
		}
		
		public function drawChilds()
		{
			addChild(this.rootNodeView);
			this.rootNodeView.drawChilds();
		}
		
		public function drawMap()
		{
			this.lines.graphics.clear();
			this.drawNode(this.rootNodeView);
		}
		
		public function drawNode(nodeView)
		{
			var childs = nodeView.model.getChilds();
			for(var i in childs)
			{
				var child = childs[i].getView();
				if(nodeView.visible== true && nodeView.model.getExpand())
				{
					child.visible = true;
					this.lines.graphics.lineStyle(child.model.getLineSize(), child.model.getLineColor(), 0.3, true);
					this.lines.graphics.moveTo(child.x + child.body.width/2, child.y + child.body.height/2);
					this.lines.graphics.lineTo(nodeView.x + nodeView.body.width/2, nodeView.y + nodeView.body.height/2);
				}
				else
				{
					child.visible = false;
				}
				this.drawNode(child);
			}
		}
		
		public function notify()
		{

		}	

	}
}