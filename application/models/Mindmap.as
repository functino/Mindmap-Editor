package application.models
{

 	import application.views.*;
	import application.commands.*;
	import application.I18n;
	import application.*;
	public class Mindmap
	{
		
		public var rootNode:Node;
		var id;
		public var view;
		
		var activeNode;

		public function Mindmap(){
			// automatically create the root-node
			this.rootNode = new Node(this);
			this.rootNode.setText(I18n.translate('loading_mindmap'));
			this.rootNode.setBackgroundColor('0xFF0000');
			this.rootNode.setX(200);
			this.rootNode.setY(200);
			this.activeNode = this.rootNode;
			this.view = new MindmapView(this);
			this.setActiveNode(this.rootNode);
		}
		
		public function setId(id)
		{
			this.id = id;
		}

		public function getRootNode()
		{
			return this.rootNode;
		}
		
		public function setActiveNode(n)
		{
			this.activeNode.setActive(false);
			this.activeNode = n;
			this.activeNode.setActive(true);
		}
		
		public function getActiveNode()
		{
			return this.activeNode;
		}
		
		
		
		
		
		
		
		public function createNode(type='default')
		{
			var parentNode;
			
			if(type=='child')
			{
				parentNode = this.getActiveNode();
			}
			else
			{
				parentNode = this.getActiveNode().getParent();
				if(parentNode == null)
				{
					parentNode = this.getActiveNode();
				}
			}
			var newNode = new Node(this);
			newNode.setX(20 + Number(parentNode.getX()));
			newNode.setY(20 + Number(parentNode.getY()));
			trace('newNode.x: ' + newNode.getX());
			var c = new CreateNodeCommand(this, newNode, parentNode);
			
			Invoker.getInstance().addCommand(c);
			
			return newNode;
		}
		
		public function toggleNodeBold()
		{
			var n = this.getActiveNode();
			var c = new SetBoldCommand(n, !n.getBold());
			Invoker.getInstance().addCommand(c);
		}
		
		public function toggleNodeItalic()
		{
			var n = this.getActiveNode();
			var c = new SetItalicCommand(n, !n.getItalic());
			Invoker.getInstance().addCommand(c);
		}
		
		public function toggleNodeUnderline()
		{
			var n = this.getActiveNode();
			var c = new SetUnderlineCommand(n, !n.getUnderline());
			Invoker.getInstance().addCommand(c);
		}
		
		public function deleteElement()
		{
			var node = this.getActiveNode();
			if(node != this.getRootNode())
			{
				var c = new RemoveNodeCommand(node);
				Invoker.getInstance().addCommand(c);
				//node.deleteElement();
				this.setActiveNode(this.getRootNode());
			}
		}
		
		public function expandLevel(level)
		{
			expandNode(this.rootNode, 0, level);
		}
		
		private function expandNode(node, cur_level, expand_level)
		{
			if(cur_level < expand_level)
			{
				node.setExpand(true);
			}
			else
			{
				node.setExpand(false);
			}
			var childNodes = node.getChilds();
			for(var i in childNodes)
			{
				expandNode(childNodes[i], cur_level+1, expand_level);
			}
		}
	}
}