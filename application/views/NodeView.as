package application.views
{
	import application.commands.*;
	import application.*;
	import application.models.*;
	import fl.controls.TextInput;
	import fl.controls.Button;
	import flash.text.TextFormat;
	import flash.text.*;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.filters.DropShadowFilter;
	import flash.events.FocusEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	

	public class NodeView extends MovieClip
	{
		var dropable;
		var model;
		var myTextInput:TextField;
		var expandButton:Button;
		public var body:MovieClip;
		var myNode = this;
		var line;
		
		var keyTimer;
		
		public function NodeView(model){
			this.dropable = true;
		 	this.model = model;
			model.setView(this);
			this.line = new MovieClip();
			addChild(line);
			this.expandButton = new Button();
			this.createExpandButton();
			this.createTextField();
			
			this.keyTimer = new Timer(300);
			
			this.createBody();
			addChild(this.body);
			
			body.addChild(this.myTextInput);
			
			if(Configure.read('editable'))
			{
				this.doubleClickEnabled = true;
				this.addEventListener(MouseEvent.CLICK, evDoubleClick);
				function evDoubleClick(e:MouseEvent):void
				{
					trace('HERE WE GO');
					if(e.ctrlKey)
					{
						if(model != model.getMindmap().getRootNode())
						{
							var c = new RemoveNodeCommand(model);
							Invoker.getInstance().addCommand(c);
							model.getMindmap().setActiveNode(model.getMindmap().getRootNode());
						}
					}
				}

				keyTimer.addEventListener(TimerEvent.TIMER, function(){
					trace('TimeUp');
					Invoker.getInstance().addCommand(new SetTextCommand(model, myTextInput.text));
					keyTimer.reset();
					keyTimer.stop();
				});
				
			}

		}
		
		
		public function notify()
		{
			this.drawBody();
			if(model.getChilds().length > 0)
			{
				this.expandButton.visible = true;
				this.expandButton.x = this.body.width - 5;// + this.expandButton.width/2;
				this.expandButton.y = this.body.height/2 - this.expandButton.height/2; //this.height/2;
				if(model.getExpand())
				{
					this.expandButton.label = '-';
				}
				else
				{
					this.expandButton.label = '+';
				}
			}
			else
			{
				this.expandButton.visible = false;
			}
			var format:TextFormat = new TextFormat();
            format.font = model.getFont();
            format.color = model.getColor();;
            format.bold = model.getBold();
			format.italic = model.getItalic();
			format.underline = model.getUnderline();
			format.size = model.getFontSize();
			this.myTextInput.defaultTextFormat = format;

			this.myTextInput.text = model.getText();
			this.x = model.getX();
			this.y = model.getY();
			this.drawBody();
			
			if(this.model.getActive())
			{
				var shadow:DropShadowFilter = new DropShadowFilter();
				shadow.distance = 4;
				shadow.angle = 70;
				this.body.filters = [shadow];
			}
			else
			{
				this.body.filters = null;
			}		
			
			var mindmap = this.model.getMindmap();
			if(mindmap != null)
			{
				mindmap.getRootNode().getView().drawChilds();
			}
		}	
		
		private function createTextField()
		{
			//create a new Input-TextField
			this.myTextInput = new TextField();
			this.myTextInput.type = TextFieldType.INPUT;
			this.myTextInput.autoSize = TextFieldAutoSize.LEFT;
			this.myTextInput.text = model.getText();
			this.myTextInput.selectable = false;


			//use a TextFormat-Object to style the text...
            var format:TextFormat = new TextFormat();
            format.font = "Trebuchet MS";
            format.color = model.getColor();
            format.bold = true;
			this.myTextInput.defaultTextFormat = format;


			if(Configure.read('editable'))
			{
				this.myTextInput.addEventListener(KeyboardEvent.KEY_DOWN, function(e){
					if(e.keyCode != Keyboard.DELETE)
					{
						//model.setText(myTextInput.text);
						if(model.getText() != myTextInput.text)
						{
							keyTimer.reset();
							keyTimer.start();
						}
						drawBody();
					}
					else
					{
						keyTimer.reset()
					}
				 });
			
				this.myTextInput.addEventListener(FocusEvent.FOCUS_OUT, 
					function(e){
						if(model.getText() != myTextInput.text && myTextInput.text != "")
						{
							Invoker.getInstance().addCommand(new SetTextCommand(model, myTextInput.text));
						}
					}
				);
			}
			else
			{
				this.myTextInput.mouseEnabled = false;
			}
		}
		
		
		
		
		
		
		
		
		
		private function createBody()
		{
			this.body = new MovieClip();
			this.drawBody();
			
			if(Configure.read('editable'))
			{
				this.body.addEventListener(MouseEvent.MOUSE_DOWN, evStartDrag);
				function evStartDrag(event:MouseEvent):void
				{
					myTextInput.setSelection(0, 100);
					myTextInput.stage.focus = myTextInput;
	
					var mindmap = myNode.model.getMindmap();
					mindmap.setActiveNode(myNode.model);
					if(mindmap.getRootNode() != myNode.model)
					{
						myNode.startDrag();
					}
					//bring it to the top
					myNode.parent.addChild(myNode);
					
				}
				
				this.body .addEventListener(MouseEvent.MOUSE_UP, evStopDrag);
				
				function evStopDrag(e:MouseEvent):void
				{
					//stop dragging the node on mouseUp
					myNode.stopDrag();
					myTextInput.setSelection(0, 100);
					
					
					var parentNode = null;
					//check where the node is dropped
					var myDropTarget = myNode.dropTarget;
					if(myDropTarget != null)
					{
						if(myDropTarget is NodeView)
						{
							trace('isMovieclip');
						}
						if(myDropTarget.parent != null && myDropTarget.parent is NodeView)
						{
							parentNode = myDropTarget.parent.model;
						}
						else if(myDropTarget.parent.parent != null && myDropTarget.parent.parent is NodeView)
						{
							parentNode = myDropTarget.parent.parent.model;
						}
					}
	
						//it's dropped over an other node - move it there
						if(parentNode != null)
						{
								
							var c = new SetParentNodeCommand(parentNode, myNode.model, myNode.x, myNode.y);
							Invoker.getInstance().addCommand(c);
						}
						else
						{
							if(myNode.x != model.getX() || myNode.y != model.getY())
							{
								var mc = new MoveCommand(model, myNode.x, myNode.y);
								Invoker.getInstance().addCommand(mc);
							}
						}
				}
			}
		}
		
		private function drawBody()
		{
			//draw an ellipse via the graphics-object 
			this.body.graphics.clear();
			var c = model.getBackgroundColor();
			
			this.body.graphics.beginFill(c);
			this.body.graphics.drawRoundRect(0,0, this.myTextInput.width + 8, this.myTextInput.height + 8, 40);
			
			this.myTextInput.x = (this.body.width - this.myTextInput.width) /2;
			this.myTextInput.y = (this.body.height - this.myTextInput.height) /2;
		}

		
		
		public function drawChilds()
		{
			
			var childs = this.model.getChilds();
			
			for(var i in childs)
			{
				var childView = childs[i].getView();
				this.parent.addChild(childView);
				childView.drawChilds();
			}
		}
		
		
		private function createExpandButton()
		{
            var formatButton:TextFormat = new TextFormat();
            formatButton.color = 0x000000;
            formatButton.size = 7;
			this.expandButton.label = '-';
            this.expandButton.setStyle("textFormat", formatButton);
			this.expandButton.width=12;
			this.expandButton.height=12;
			this.expandButton.setStyle('textPadding', 0);
			//add a click-Event-Listener to get the button to work
			this.expandButton.addEventListener('click', function(){
				if(model.getExpand())
				{
					model.setExpand(false);
				}
				else
				{
					model.setExpand(true);
				}
			});	
			
			addChild(expandButton);
		}
		
		
		
		public function remove()
		{
			this.parent.removeChild(this);
		}

		public function getWidth()
		{
			return this.body.width;
		}


		public function getHeight()
		{
			return this.body.height;
		}
	}
}