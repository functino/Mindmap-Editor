package application.models
{
	import application.views.*;
	public class Node
	{
		var mindmap;
		var active;
	 	var x;
	 	var y;
	 	//model attributes
		var color;
		var backgroundColor;
		var font;
		var fontSize;	 	
		var expand:Boolean;
		var belongsTo:Node;
		var hasMany:Array;
		var text:String;
		var size;
		var notes;
		
		var bold;
		var italic;
		var underline;
		
		var lineColor;
		var lineSize;
		
		var draggable:Boolean;
		
		var myNode:Node;


		
		var view:NodeView;
	
		public function Node(mindmap = null){
			this.active = false;
			this.mindmap = mindmap;
		 	this.color = "0x000000";
			this.font = "Trebuchet MS";
			this.backgroundColor = "0x529BFE";
			this.fontSize = 14;
			this.expand = true;
			this.belongsTo = null;
			this.hasMany = new Array();
			this.text = '...';
			this.x = 100;
			this.y = 100;
			this.draggable = true;
			this.size = 1;
			this.notes = new Array();
			this.lineSize = 1;
			this.lineColor = "0x000000";
			this.italic = false;
			this.bold = false;
			this.underline = false;
			this.view = new NodeView(this);
		}
		
		public function setMindmap(m)
		{
			this.mindmap = m;
		}
		
		public function getMindmap()
		{
			return this.mindmap;
		}
		
		public function setSize(s)
		{
			this.size = s;
		}
		
		public function getSize()
		{
			return this.size;
		}
		
	
		public function setExpand(e)
		{
			this.expand = e;
			this.notify();
		}
		
		public function getExpand()
		{
			return this.expand;
		}
		

		
		/**
		* Set the text of a node
		* @param String text 
		* @return void
		*/
		public function setText(text:String)
		{
			this.text = text;
			this.notify();
			trace('setText('+text);
		}
		
		/**
		* Get the Text of a node
		* @return String
		*/
		public function getText():String
		{
			return this.text;
		}
		
		/**
		* Set the background-color of the node
		* @param String
		* @return void
		*/
		public function setBackgroundColor(color)
		{
		 	this.backgroundColor = color;
			notify();
		}
		
		/**
		* return the background-color of the node
		* @return String
		*/
		public function getBackgroundColor()
		{
			return this.backgroundColor;
		}
		
		/**
		* Get the parent-node of this node
		*/
		public function getParent()
		{
			return this.belongsTo;
		}
		
		/**
		* Set the Parent-node of this node
		*/
		public function setParent(n)
		{
			this.belongsTo = n;
		}
		
		/** 
		* Returns the child-nodes of this node as an array
		* @return Array
		*/
		public function getChilds()
		{
			return this.hasMany;
		}
		
		
		public function setPosition(x,y)
		{
			this.x = x;
			this.y = y;
			notify();
		}
		
		public function setX(x)
		{
			this.x = x;
			notify();
		}
		
		public function getX()
		{
			return this.x;
		}
		
		public function setY(y)
		{
			this.y = y;
			notify();
		}
		
		public function getY()
		{
			return this.y;
		}
		
		
		/**
		* Set the text-color
		* @param String
		*/
		public function setColor(c)
		{
			this.color = c;			
			this.notify();
		}
		
		public function notify()
		{
			if(this.view != null)
			{
				view.notify();
			}
		}
		
		/**
		* Returns the text-color
		* @return String
		*/
		public function getColor()
		{
			return this.color;
		}
		
		/**
		* Set the font-size
		*/
		public function setFontSize(size)
		{
		 	this.fontSize = size;
			this.notify();
		}

		/**
		* Returns the font-size
		*/	
		public function getFontSize()
		{
			return this.fontSize;
		}
		
		/**
		* Set the line-color
		* @param String
		*/
		public function setLineColor(c)
		{
			this.lineColor = c;
		}
		
		/**
		* Returns the line-color
		* @return String
		*/
		public function getLineColor()
		{
			return this.lineColor;
		}
		
		/**
		* Set the line-size
		* @param String
		*/
		public function setLineSize(c)
		{
			this.lineSize = c;
		}
		
		/**
		* Returns the line-size
		* @return String
		*/
		public function getLineSize()
		{
			return this.lineSize;
		}
		
		
		/**
		* Add a child node to this node
		*/
		public function addNode(node)
		{
			var curNode = node.getParent();
			
			/*
			//check if this addition is valid
			if(curNode == this)
			{
				return false;
			} */
			
			if(curNode != null)
			{
				curNode.removeNode(node);
			}
			
			this.hasMany.push(node);
			node.setParent(this);
			this.expand = true;
			node.notify();
			notify();
			
		}

		
		/**
		* Remove a childnode from this node
		*/
		public function removeNode(node)
		{
		 	
		 	var tmp = new Array();
			for(var i in this.hasMany)
			{
				if(node != this.hasMany[i])
				{
					tmp.push(this.hasMany[i]);
				}
			}			
			
			this.hasMany = tmp;
		}
		
		
		
		public function deleteElement()
		{
			var parentNode = this.getParent();
		 	var childs = this.getChilds();
			parentNode.removeNode(this);

	 		//all childs of the removed node should be moved to the parent node of the removed one
			for(var i in childs)
			{
				parentNode.addNode(childs[i]);
			}
			var mindmap = this.getMindmap();
			mindmap.getRootNode().setActive(true);
			this.view.remove();
		}
		
		public function deleteBranch()
		{
			var parentNode = this.getParent();
			
		 	var childs = this.getChilds();
	 		//all childs of the removed node should be moved to the parent node of the removed one
			for(var i in childs)
			{
				__helperRemoveView(childs[i]);
	
			}
			
			parentNode.removeNode(this);
			var mindmap = this.getMindmap();
			mindmap.getRootNode().setActive(true);
			this.view.remove();
		}
		
		function __helperRemoveView(node)
		{
			var ch = node.getChilds();
				for(var j in ch)
				{
					__helperRemoveView(ch[j]);
				}
			node.view.remove();
		}
		
		public function setBold(b:Boolean):void
		{
			this.bold = b;					
			this.notify();
		}
	
		public function getBold():Boolean
		{
			return this.bold;
			this.notify();
		}
		
		public function setItalic(i:Boolean):void
		{
			this.italic = i;
			this.notify();
		}
	
		public function getItalic():Boolean
		{
			return this.italic;
		}
		
		public function setUnderline(u:Boolean):void
		{
			this.underline = u;					
			this.notify();
		}
	
		public function getUnderline():Boolean
		{
			return this.underline;
		}
		
		public function getFont()
		{
			return this.font;		
		}
	
		public function setFont(f)
		{
			this.font = f;
			this.notify();
		}
		
		public function setView(n:NodeView)
		{
			this.view = n;
		}
		
		public function getView()
		{
			//if there isn't a view create one
			if(this.view == null)
			{
				this.view = new NodeView(this);
			}
			
			return this.view;
		}

		
		public function remove()
		{
			this.getParent().removeNode(this);
			this.view.remove();
		}
		
		
		public function setActive(b)
		{
			this.active = b;
			this.notify();
		}
		public function getActive()
		{
			return this.active;
		}
	}
}