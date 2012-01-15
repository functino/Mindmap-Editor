package application.commands
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	import application.Configure;
	import application.*;
	import application.models.*;

	public class AutoNodeCommand implements ICommand
	{
		var activeNode;
		var newChildNodes;
		public function AutoNodeCommand(activeNode)
		{
			this.activeNode = activeNode;
			this.newChildNodes = new Array();
		}
		
		public function execute()
		{
			trace('autonode');

			//display the loadingContainer
			var loadingContainer = Configure.read('loadingContainer');
			loadingContainer.parent.addChild(loadingContainer);
			loadingContainer.visible = true;
			
			var request:URLRequest = new URLRequest(Configure.read('auto_node_url'));
			var variables:URLVariables = new URLVariables();
			variables.text = activeNode.getText();  
			variables.limit = 5;			
			request.data = variables;
			request.method = URLRequestMethod.POST;
			var loader = new URLLoader();
			
			try {
				loader.load(request);
			}
			catch (error:SecurityError)
			{
				trace("A SecurityError has occurred.");
			}
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(){trace('IOERROREVENT');
				loadingContainer.visible = false;																						   
																						   });
			loader.addEventListener(Event.COMPLETE, function(event:Event){
				loadingContainer.visible = false;
		try {
			trace(loader.data);
			var xml = new XML(loader.data);
			//xml = new XML("<xml><node>PHP License</node><node>Perl</node></xml>");
			trace(xml);
			var xmlnodes = xml.node;
			
			for(var i in xmlnodes)
			{
				var s:String = new String(xmlnodes[i]);
				if(s != "")
				{
					var newNode = new Node(activeNode.getMindmap());
					newChildNodes.push(newNode);
					var cnc = new CreateNodeCommand(activeNode.getMindmap(), newNode, activeNode);
					cnc.execute();
					newNode.setText(s);
				}
			}	
			var autoLayout2:IAutoLayout = new AutoLayoutGrand();
			var layoutCommand2 = new AutoLayoutCommand(activeNode.getMindmap(), autoLayout2);
			layoutCommand2.execute();
							trace('try');
						} catch (e:TypeError) {
							trace("Could not parse the XML file.");
						}
				});	










		}
		
		public function undo()
		{
			for(var i in newChildNodes)
			{
				newChildNodes[i].deleteElement();
			}
			newChildNodes = new Array();
		}
	}
}