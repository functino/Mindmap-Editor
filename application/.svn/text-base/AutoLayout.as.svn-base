package application
{
	public class AutoLayout implements IAutoLayout
	{
		var mindmap;
		
		public function layout(m)
		{
			trace('AutoLayout::layout');			
			mindmap = m;
			var childNodes = m.getRootNode().getChilds();
			if(childNodes.length > 0)
			{
				var degree = 360/childNodes.length;
			}
			else
			{
				var degree = 360;
			}
			trace(degree);
			
			for(var i in childNodes)
			{
				var rad = 2*Math.PI * (i*degree)/360;
				childNodes[i].setX(Number(m.getRootNode().getX()) + m.getRootNode().getView().getWidth()/2 - childNodes[i].getView().getWidth()/2 + Math.cos(rad) * (150 + m.getRootNode().getView().getWidth()/2) );
				childNodes[i].setY(Number(m.getRootNode().getY()) + Math.sin(rad) * 100);
				
				this.layoutNode(childNodes[i], i*degree, 1);
			}
		}
		
		function layoutNode(n, parentDegree, depth)
		{
			var childNodes = n.getChilds();
			trace('depth: ' + depth);
			var margin = 150/depth;
			//winkel der für kindknoten erlaubt ist ...
			//je tiefer im bum desto kleiner - je mehr kindknoten desto größer
			var range = 90;
			if(childNodes.length > 5)
			{
				range = 120;
			}
			else if(childNodes.length >4)
			{
				range = 105;
			}
			else if (childNodes.length >3)
			{
				range = 100;
			}
			else if(childNodes.length > 2)
			{
				range = 70;
			}
			else
			{
				range = 30;
			}
			
			//range = range/depth;
			if(childNodes.length > 1)
			{
				var degreeInterval = range/(childNodes.length-1);
			}
			else
			{
				degreeInterval = range/2;
			}
				trace('degreeInterval: ' + degreeInterval);
			for(var i in childNodes)
			{
				var degree = i*degreeInterval + parentDegree + (360 - range/2);
				if(degree > 360)
				{
					degree = Math.abs(degree - 360);
				}
				var rad = 2*Math.PI * (degree)/360;
				childNodes[i].setX(Number(n.getX()) + n.getView().getWidth()/2 - childNodes[i].getView().getWidth()/2 + Math.cos(rad) * (margin + n.getView().getWidth()/2) );
				childNodes[i].setY(Number(n.getY()) + Math.sin(rad) * 100);
				
				this.layoutNode(childNodes[i], degree, depth+1);
			}
		}
	}
}